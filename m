Return-Path: <linux-pci-owner@vger.kernel.org>
MIME-Version: 1.0
Reply-To: pricardofc@gmail.com
In-Reply-To: <CAH9N0t8PGNd74HJxzQLCfo0nu-ko5WVJdKi3u0JMS4Zbgb3RQg@mail.gmail.com>
References: <CAH9N0t8PGNd74HJxzQLCfo0nu-ko5WVJdKi3u0JMS4Zbgb3RQg@mail.gmail.com>
From: Paulo Ricardo Carvalho <pricardofc@gmail.com>
Date: Sun, 2 Apr 2017 00:45:07 +0100
Message-ID: <CAH9N0t8FDYvbceRCnNahBiP8-=C+YappPzRd8UU6GY=zRVZfMw@mail.gmail.com>
Subject: Two read DMAs simultaneous using same interrupt give completion
 timeout reported by AER
To: Linux-pci@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,
Im using a pcie board to read data from 2 dma chancelas at lhe same time.
Both DMAs use lhe same interrupt service routine but have separeted
read functions.
2 device file nodes are used for each dma.
so i have 2 applications running to read from one and other dma channel.
the interrupt routine reads na fpga register to know what dma rise the
interrupt to wake up
the corresponding waitqueue.
when i have only one dma at a time everything goes ok but when both
are working at same time i get completion timeout error reported by
AER and data from both dmas loose a lot of packets.
im using both fedora and scientific Linux. kernels are 4.1 and 3.10 RT
respectively and behavior is the same.
does anybody know what am i missing?
Thx,
Ricardo
