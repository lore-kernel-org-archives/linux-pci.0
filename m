Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f182.google.com ([209.85.217.182]:34820 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751326Ab3FARzs (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 1 Jun 2013 13:55:48 -0400
Received: by mail-lb0-f182.google.com with SMTP id q15so384841lbi.13
        for <linux-pci@vger.kernel.org>; Sat, 01 Jun 2013 10:55:46 -0700 (PDT)
MIME-Version: 1.0
Reply-To: pricardofc@ipfn.ist.utl.pt
In-Reply-To: <CAH9N0t-Bg8QNLG3m0tmHN9s1ORPxOX2C01WAEt9yi0pd=y8xbA@mail.gmail.com>
References: <CAH9N0t8ODdHOz-ajwUBUv34XOH=i65S=4D0=HnvDLjCV7N3n8g@mail.gmail.com>
	<CAE9FiQVZoybuq-ekQWUmXs8ggKmSdGo2zsLbxv7Shj3ZQAkiqw@mail.gmail.com>
	<CAH9N0t-Bg8QNLG3m0tmHN9s1ORPxOX2C01WAEt9yi0pd=y8xbA@mail.gmail.com>
Date: Sat, 1 Jun 2013 18:55:46 +0100
Message-ID: <CAH9N0t-pkU0XjzGD--9o9=GeRaoazxMm=GkraC5X_yBsZ4=sRg@mail.gmail.com>
Subject: Re: Pcie Linux HotPlug Driver Automatic Scripts
From: Paulo Fortuna Carvalho <pricardofc@ipfn.ist.utl.pt>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello,
Bjorn and Yinghai,

Everything is working as expected now.
Both boards are hotplugging.
Im working in the udev configuration to run scripts automatically but
i think its the easiest part.
Thanks for your help,
Paulo.


2013/5/31, Paulo Fortuna Carvalho <pricardofc@ipfn.ist.utl.pt>:
> I'll explain better.
> We have the following architecture.
> PC (Intel Root Port) downstream->Upstream OneStopSystems RootComplex
> 8733 downstream->upstream PCIe Switch 8696 in a ATCA card downstream->
> another ATCA card.
> When another ATCA card is removed from the system all the process goes ok.
> When the first ATCA card that has the PCIe 8696 onboard is removed
> from system and inserted again all the PEX show rev (ff) and also the
> 2 ATCA cards have rev (ff)
> The only thing in system with rev (ba) ok is the Root Complex 8733.
> The ATCA card with PCIE Switch 8696 onboard is plugged to the PC via a
> HotPlug cable and we dont actually remove the card only the cable (is
> the same thing I guess). So when we plug the cable back i think we
> have to send a reset signal to the pciexpress bus in order to
> initialize all the pci bus, detect and power on all the tree from Root
> Complex 8733 until PCIe Switch 8696 and at last ATCA cards in order to
> insert ATCA cards device drivers.
>
> So I tryed echo 1 > /sys/bus/pci/rescan didnt work. Then I identify
> from which device the rev ff was and found that from device
> 0000:04:08.0 rev was ff and so all the nodes below this one were also
> with rev ff. then I tryed
> echo 1 > /sys/bus/pci/devices/0000\:04\:08.0/power but also nothing
> happened.
> So is there a command that I can execute to activate all the pci bus
> from that node?
> My work colleague told me that after plug the pci express cable he
> always had to reboot the pc (because it needs a reset signal in that
> hw line) but I think that there should be a linux command that would
> be able to send this reset signal.
> I also tryed echo 1 > /sys/bus/pci/devices/0000\:04\:08.0/reset but
> this file doenst exist...
> Paulo.
>
> 2013/5/31, Yinghai Lu <yinghai@kernel.org>:
>> On Fri, May 31, 2013 at 10:35 AM, Paulo Fortuna Carvalho
>> <pricardofc@ipfn.ist.utl.pt> wrote:
>>
>>> Also, How can I perform an entire pcie express bus reset from linux
>>> terminal?
>>
>> disable_pcie_link and reenable the pcie link?
>>
>
