import pandas as pd
from matplotlib import pyplot
import matplotlib.dates as md
import datetime as dt


def ema(period, samples, curr):
    alpha = 2 / (period + 1)
    base = 1 - alpha
    numerator = 0.0
    denominator = 0.0

    for i in range(period + 1):
        if curr - i >= 0:
            x = base ** i
            denominator += x
            x *= samples[curr - i]
            numerator += x

    return numerator / denominator


def macd(samples, curr):
    return ema(12, samples, curr) - ema(26, samples, curr)


def signal(macd_values, curr):
    return ema(9, macd_values, curr)


if __name__ == '__main__':
    csv_names = ['CDR.csv', 'OPL.csv', 'PEO.csv']
    names = ['CD Project Red', 'Orange Polska SA', 'Bank Pekao SA']
    path = 'data/' + csv_names[0]
    data = pd.read_csv(path, delimiter=',')
    samples = data["Zamkniecie"].values[::-1]
    dates = data["Data"].values[::-1]

    macd_values = []
    signal_values = []
    a = []

    for i in range(1000):
        a.append(dates[i])

    for i in range(1000):
        macd_values.append(macd(samples, i))
    for i in range(1000):
        signal_values.append(signal(macd_values, i))

    x = [dt.datetime.strptime(d, '%Y-%m-%d').date() for d in a]

    pyplot.figure()
    pyplot.gca().xaxis.set_major_formatter(md.DateFormatter('%Y-%m-%d'))
    pyplot.gca().xaxis.set_major_locator(md.DayLocator(interval=120))
    pyplot.plot(x[35::], samples[35::], label="Ceny zamknięcia dla " + names[0], color='green')
    pyplot.gcf().autofmt_xdate()
    pyplot.legend()
    pyplot.grid(True)
    pyplot.ylabel('Wartość składowych ')
    pyplot.xlabel('Data (yyyy-mm-dd)')
    pyplot.title('Ceny zamknięcia dla ' + names[0])

    pyplot.gca().xaxis.set_major_formatter(md.DateFormatter('%Y-%m-%d'))
    pyplot.gca().xaxis.set_major_locator(md.DayLocator(interval=120))
    pyplot.plot(x[35::], macd_values[35::], label='MACD', color='blue')
    pyplot.plot(x[35::], signal_values[35::], label="SIGNAL", color='red')
    pyplot.gcf().autofmt_xdate()
    pyplot.legend()
    pyplot.grid(True)
    pyplot.ylabel('Wartość składowych ')
    pyplot.xlabel('Data (yyyy-mm-dd)')
    pyplot.title('Wskaźnik MACD dla ' + names[0])

    pyplot.show()
