Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:34591 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932251AbbHCUdU (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 3 Aug 2015 16:33:20 -0400
Received: by obre1 with SMTP id e1so108126165obr.1
        for <linux-pci@vger.kernel.org>; Mon, 03 Aug 2015 13:33:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAErSpo4f_BLrnq7T2foOA2HAySPTDVYn61dfyOfZahyiyzGTdg@mail.gmail.com>
References: <CABLseQ6HhaozD6D0Y-gPpjz1R5Ass_-mumn9jfcWReAVvrdjHQ@mail.gmail.com>
	<CAErSpo4f_BLrnq7T2foOA2HAySPTDVYn61dfyOfZahyiyzGTdg@mail.gmail.com>
Date: Mon, 3 Aug 2015 13:33:20 -0700
Message-ID: <CABLseQ4eR5DyzSar+TwTOOJkq2_za2t47j-4RYPgQnNrZXmWiA@mail.gmail.com>
Subject: Re: Failure to HotPlug if devices not present at boot - no memory space
From: Barry Grussling <barry@grussling.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> Can you attach complete dmesg logs and "lspci -vv" output for both
> cases?  (You can attach them to a kernel.org bugzilla if they're too
> big for email.)
>

Can do:
https://bugzilla.kernel.org/show_bug.cgi?id=102231

> The dmesg logs will tell us what space is allocated to the host
> bridge.  That is generally done by firmware or the bootloader, and
> Linux doesn't change it.  So if firmware only assigns 0xc0000000 to
> 0xc59fffff to the host bridge, the current Linux kernel will only
> assign PCI devices inside that region; it will never expand the
> region.
Okay.  That makes sense.

We are using u-boot.  I don't believe our current u-boot build has any
PCIe knowledge in it though.

Our SoC/PCIe root complex is the Altera Cyclone V:
https://www.altera.com/en_US/pdfs/literature/ug/ug_c5_pcie_avmm.pdf

Thanks for your help!

Barry
