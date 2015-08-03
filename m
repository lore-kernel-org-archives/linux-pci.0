Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f172.google.com ([209.85.214.172]:35288 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754224AbbHCXbH (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 3 Aug 2015 19:31:07 -0400
Received: by obbop1 with SMTP id op1so111064559obb.2
        for <linux-pci@vger.kernel.org>; Mon, 03 Aug 2015 16:31:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150803222726.GB11144@google.com>
References: <CABLseQ6HhaozD6D0Y-gPpjz1R5Ass_-mumn9jfcWReAVvrdjHQ@mail.gmail.com>
	<CAErSpo4f_BLrnq7T2foOA2HAySPTDVYn61dfyOfZahyiyzGTdg@mail.gmail.com>
	<CABLseQ4eR5DyzSar+TwTOOJkq2_za2t47j-4RYPgQnNrZXmWiA@mail.gmail.com>
	<20150803222726.GB11144@google.com>
Date: Mon, 3 Aug 2015 16:31:06 -0700
Message-ID: <CABLseQ56naxmEHupwjKLQE0J_w6oTGqC=ox_0J4CV1eisK=5Dg@mail.gmail.com>
Subject: Re: Failure to HotPlug if devices not present at boot - no memory space
From: Barry Grussling <barry@grussling.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Yinghai Lu <yinghai@kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 3, 2015 at 3:27 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>
> You might have a host bridge driver that knows how to set up the
> windows.  Your dmesg logs mention altera_hps2fpga_bridge, which
> doesn't seem to be in the upstream kernel, so I don't know what it
> does.

Sorry.  Forgot to tell you it is based on the driver available at:
http://rocketboards.org/foswiki/view/Projects/PCIeRootPortWithMSI

I figured/hoped it was a general PCIe lack of understanding on
my part and not something specifically related to the PCIe root complex
driver.

> In the other log ("08:00.0 not present at boot"), we actually *do*
> enumerate an 08:00.0 device:
>
>   pci 0000:08:00.0: [1d00:0000] type 00 class 0x00001d
>   pci 0000:08:00.0: reg 0x30: [mem 0x00001800-0x00001fff pref]

Yea.  Not sure what that is since there is no device physically present.
PLX must be reserving the spot or something.

> I don't know what this device is (lspci says "non-VGA unclassified
> device") and it only requests 2K of space for an option ROM.  And the
> log doesn't include the part where you hot-add the real device --
> that's the interesting information should be.

I added the dmesg for enumeration after hot-adding the device
to the bugzilla entry.  Don't want to omit the interesting
part.

> I see that you already boot with "pcie=hpmemsize=256M", but that
> doesn't help in this case because it's only used for hotplug bridges,
> and 02:0f.0 (the Downstream Port leading to bus 08) is not marked as
> hotplug-capable:
>
>   02:0f.0 PCI bridge: PLX Technology, Inc. PEX 8619
>     Capabilities: [68] Express (v2) Downstream Port (Slot+), MSI 00
>       SltCap:   AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
>
> I think if you could get the PCI_EXP_SLTCAP_HPC bit set for 02:0f.0,
> and you booted with "pcie=hpmemsize=256M", it would likely work.  It's
> possible it could be made to work even without that, but in general
> it's hard to reserve the right amount of space for a bridge if you
> don't know what might be plugged in later.

This makes sense to me.  I think I have enough information now to
try to massage the PLX port into being a hotplug port and maybe
everything will work.

Thanks for yor help Bjorn!  I have something to try now.

Barry
