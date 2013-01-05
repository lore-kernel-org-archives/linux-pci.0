Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <50E81FD2.1010008@openvz.org>
Date: Sat, 05 Jan 2013 16:42:58 +0400
From: Konstantin Khlebnikov <khlebnikov@openvz.org>
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	e1000-devel@lists.sourceforge.net
Subject: Re: [REGRESSION 3.8-r1] broken pci irq/pm state for e1000e device
References: <50E32C52.4000008@openvz.org> <50E32E71.7080000@openvz.org>
In-Reply-To: <50E32E71.7080000@openvz.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Konstantin Khlebnikov wrote:
> Konstantin Khlebnikov wrote:
>> Seems like it's unrelated to e1000e driver itself, because I tried to
>> revert all it's changes down to 3.6 one by one and it does not help.

Ouch, 3.6 also affected, seems like I was more lucky at that time and
bug never showed up.

root@zurg:/sys/bus/pci/devices# uname -a
Linux zurg 3.6.0-zurg #571 SMP Mon Oct 1 14:24:25 MSK 2012 x86_64 GNU/Linux

root@zurg:/sys/bus/pci/devices# cat 0000\:00\:19.0/enable ; modprobe e1000e ; sleep 2 ; rmmod e1000e ; cat 0000\:00\:19.0/enable
4294967293
4294967292

So, this bug actually in e1000e driver. Add their mail-list into CC.

But core code should at least print some warnings...

>>
>> Looks like regression somewhere in pci-bus irq or power-management.
>> because I see underflow of counter pci_dev->enable_cnt:
>>
>> root@zurg:/sys/bus/pci/devices# cat 0000\:00\:19.0/enable ; modprobe e1000e ; sleep 2 ; rmmod e1000e ; cat 0000\:00\:19.0/enable
>> 4294967288
>> 4294967287
>>
>> without sleep in the middle it does not work
>
> Hmm, 3.7 also affected. This is not good.
>
> root@zurg:/sys/bus/pci/devices# cat 0000\:00\:19.0/enable
> 4294967293
> root@zurg:/sys/bus/pci/devices# uname -a
> Linux zurg 3.7.1-zurg #631 SMP Sat Dec 29 11:54:15 MSK 2012 x86_64 GNU/Linux
>
>>
>> my kernel config in attachment
>> hardware: lenovo thinkpad x220
>>
>> root@zurg:/sys/bus/pci/devices# uname -a
>> Linux zurg 3.8.0-rc1-zurg-00091-g4a490b7 #632 SMP Tue Jan 1 20:02:31 MSK 2013 x86_64 GNU/Linux
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at http://www.tux.org/lkml/

