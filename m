Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <50E32E71.7080000@openvz.org>
Date: Tue, 01 Jan 2013 22:44:01 +0400
From: Konstantin Khlebnikov <khlebnikov@openvz.org>
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [REGRESSION 3.8-r1] broken pci irq/pm state for e1000e device
References: <50E32C52.4000008@openvz.org>
In-Reply-To: <50E32C52.4000008@openvz.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Konstantin Khlebnikov wrote:
> Seems like it's unrelated to e1000e driver itself, because I tried to
> revert all it's changes down to 3.6 one by one and it does not help.
>
> Looks like regression somewhere in pci-bus irq or power-management.
> because I see underflow of counter pci_dev->enable_cnt:
>
> root@zurg:/sys/bus/pci/devices# cat 0000\:00\:19.0/enable ; modprobe e1000e ; sleep 2 ; rmmod e1000e ; cat 0000\:00\:19.0/enable
> 4294967288
> 4294967287
>
> without sleep in the middle it does not work

Hmm, 3.7 also affected. This is not good.

root@zurg:/sys/bus/pci/devices# cat 0000\:00\:19.0/enable
4294967293
root@zurg:/sys/bus/pci/devices# uname -a
Linux zurg 3.7.1-zurg #631 SMP Sat Dec 29 11:54:15 MSK 2012 x86_64 GNU/Linux

>
> my kernel config in attachment
> hardware: lenovo thinkpad x220
>
> root@zurg:/sys/bus/pci/devices# uname -a
> Linux zurg 3.8.0-rc1-zurg-00091-g4a490b7 #632 SMP Tue Jan 1 20:02:31 MSK 2013 x86_64 GNU/Linux
>
