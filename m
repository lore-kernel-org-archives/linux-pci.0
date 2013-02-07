Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bk0-f43.google.com ([209.85.214.43]:58621 "EHLO
	mail-bk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1160999Ab3BGSak (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 7 Feb 2013 13:30:40 -0500
Received: by mail-bk0-f43.google.com with SMTP id jm19so1312232bkc.2
        for <linux-pci@vger.kernel.org>; Thu, 07 Feb 2013 10:30:38 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20130207183743.5c97d8b8@skate>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<1359399397-29729-20-git-send-email-thomas.petazzoni@free-electrons.com>
	<20130129132204.GA23886@arm.com>
	<20130207153750.0fef1192@skate>
	<20130207155117.GA19666@arm.com>
	<20130207171904.70270598@skate>
	<20130207174040.3a345770@skate>
	<20130207165347.GA31995@arm.com>
	<20130207181418.3753b007@skate>
	<20130207172934.GA2811@arm.com>
	<20130207183743.5c97d8b8@skate>
Date: Thu, 7 Feb 2013 18:30:38 +0000
Message-ID: <CAPcvp5EC=e8TbX9s88hF9uKMzTc6655k9=mgdEc0szP_phhbXQ@mail.gmail.com>
Subject: Re: [PATCH v2 19/27] pci: PCIe driver for Marvell Armada 370/XP systems
From: Andrew Murray <amurray@embedded-bits.co.uk>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Andrew Murray <andrew.murray@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Maen Suleiman <maen@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Eran Ben-Avi <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 7 February 2013 17:37, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:
> Dear Andrew Murray,
>
> On Thu, 7 Feb 2013 17:29:34 +0000, Andrew Murray wrote:
>
>> > So if I ignore the bus number, how could the PCI code find what is the
>> > matching interrupt?
>>
>> Apologies if I've missed information about your hardware in the other
>> discussion (I've tried to keep up) - does your hardware raise a single host
>> interrupt for each pin regardless to which bridge they come in on - or do you
>> separate A,B,C,D host interrupts for each bridge?
>
> There are separate A,B,C,D interrupts for each PCIe interface, and each
> PCIe interface is represented by an emulated PCI-to-PCI bridge. See my
> interrupt-map:
>
>                         interrupt-map = <0x0800 0 0 1 &mpic 58
>                                          0x1000 0 0 1 &mpic 59
>                                          0x1800 0 0 1 &mpic 60
>                                          0x2000 0 0 1 &mpic 61
>                                          0x2800 0 0 1 &mpic 62
>                                          0x3000 0 0 1 &mpic 63
>                                          0x3800 0 0 1 &mpic 64
>                                          0x4000 0 0 1 &mpic 65
>                                          0x4800 0 0 1 &mpic 99
>                                          0x5000 0 0 1 &mpic 103>;
>
> Here I have 10 PCIe interfaces, and therefore 10 interrupts.
>
> There is only one interrupt per PCIe interface, and for now, I don't
> distinguish A,B,C,D (I will do it later, it requires reading a register
> to know if the interrupt came from A, B, C or D, but that's a different
> problem).
>
>> If you have only 4 interrupt sources for legacy interrupts then you shouldn't
>> need to care which bus/device/function they were generated on (of_pci_map_irq
>> takes care of this for you).
>
> No, I have interrupts per PCIe interface, so I really need to take care
> of the relation between the PCIe device and the PCIe interface it is
> connected to.

In that case, I think you can create a mask that only checks for the
device number and INT pin (i.e. ignore bus and function). Looking at
your mask - it already does this...

                         interrupt-map = <0x0800 0 0 1 &mpic 58
                                          0x1000 0 0 1 &mpic 59
                                          0x1800 0 0 1 &mpic 60
                                          0x2000 0 0 1 &mpic 61
                                          0x2800 0 0 1 &mpic 62
                                          0x3000 0 0 1 &mpic 63
                                          0x3800 0 0 1 &mpic 64
                                          0x4000 0 0 1 &mpic 65
                                          0x4800 0 0 1 &mpic 99
                                          0x5000 0 0 1 &mpic 103>;

I'm not sure if the device pin part of the map is correct (I always
forget how this works) - but I know this would definately work:

                         interrupt-map-mask = <0xf800 0 0 7>
                         interrupt-map = <0x0800 0 0 1 &mpic 58
                                          0x0800 0 0 2 &mpic 58
                                          0x0800 0 0 3 &mpic 58
                                          0x0800 0 0 4 &mpic 58
                                          0x1000 0 0 1 &mpic 59
                                          0x1000 0 0 2 &mpic 59
                                          0x1000 0 0 3 &mpic 59
                                          0x1000 0 0 4 &mpic 59
                                          ....

In any case, I've realized that my original suggestion of changing the
map won't quite do (apologies). This is because the OF code won't even
look at this map as it stops at the emulated bridge below. In addition
to this type of mapping - you'll also need to investigate my solution
1 and 2.

Andrew Murray

>
> Thomas
> --
> Thomas Petazzoni, Free Electrons
> Kernel, drivers, real-time and embedded Linux
> development, consulting, training and support.
> http://free-electrons.com
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
