Return-Path: <SRS0=e3W/=SH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33BF4C4360F
	for <linux-pci@archiver.kernel.org>; Fri,  5 Apr 2019 14:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F320E218C3
	for <linux-pci@archiver.kernel.org>; Fri,  5 Apr 2019 14:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554473455;
	bh=rOs16tjl4NeqpvLRx3378WVrHemAT6MQngXXgPQU91M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RA8nrWIKsyDU3FNs1KsjhYBDuO/0WC1YlROOEYpz8J0/M4IVr8PwS+5e5pE+pa/pX
	 SPGaABC9+GVdsmiybdvj6BMXv9rl7aF0/Y9Ei3kxSj6iiljhQExG3OohXw7vARXyP5
	 A4vqmLmjTZF+KZr7IPDgQp8UpB0vGOqrDqX/Ukdw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729704AbfDEOKy (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 5 Apr 2019 10:10:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:55852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726594AbfDEOKy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 5 Apr 2019 10:10:54 -0400
Received: from localhost (173-25-63-173.client.mchsi.com [173.25.63.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9379F21852;
        Fri,  5 Apr 2019 14:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554473452;
        bh=rOs16tjl4NeqpvLRx3378WVrHemAT6MQngXXgPQU91M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oio3KZkvSyU16WJdRfEzLqceSF5fiV0m2ETPP1JVgXOnSYUYTOnuapOsF9onnOi4z
         vHHFRRhXrtiZMBI1QguRzJHne/BmGZ1KhU1kB8jgdD6U5lJcGivh0h3ONbAo08n+Gb
         E3FcCVHG5/Sf18MBlGJAj1fGj3hXU4fCulrHeGWA=
Date:   Fri, 5 Apr 2019 09:10:51 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ron Murray <rjmx@rjmx.net>
Cc:     linux-pci@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Alan Stern <stern@rowland.harvard.edu>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: PCI device appears intermittently
Message-ID: <20190405141051.GA109021@google.com>
References: <06ca8af7-46e3-2769-cce0-48596ce99211@rjmx.net>
 <20190402130925.GC141706@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190402130925.GC141706@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Borislav, Alan, Marcel, Johan, linux-usb, LKML]

On Tue, Apr 02, 2019 at 08:09:25AM -0500, Bjorn Helgaas wrote:
> On Thu, Mar 28, 2019 at 09:22:03PM -0400, Ron Murray wrote:
> > I have an ASRock 970A-G/3.1 motherboard, which, with current Linux
> > kernels, occasionally "finds" an extra PCI device on the initial
> > scan.
> 
> Hmmm, I don't have any good ideas.  You mention "current" kernels.  Is
> this a regression?  If there is an earlier kernel that never finds
> this extra device, it's possible we could find the problem by
> bisecting.  It's a little harder with intermittent problems like this,
> though.
> 
> Is there any rhyme or reason to when the problem occurs?  Do you dual
> boot with Windows?  Does it happen after an unusual shutdown (crash,
> oops, etc)?  Is there anything connected to that port?
> 
> Can you collect the output of "sudo lspci -vvv" and the dmesg logs for
> successful and failing boots?  Maybe attach them to a
> bugzilla.kernel.org entry.

The bugzilla entry is https://bugzilla.kernel.org/show_bug.cgi?id=203157
Thanks, Ron!

I unpacked the tar file and attached the individual files.  I think
they might be labeled backwards, though.  Compared to lspci-vvv.good,
lspci-vvv.bad contains two extra devices:

  00:09.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI] RD890/RD9x0/RX980 PCI to PCI bridge (PCI Express GPP Port 4)
  02:00.0 USB controller: ASMedia Technology Inc. ASM1143 USB 3.1 Host Controller

The 00:09.0 bridge leads to bus 02, i.e., to the XHCI USB device.
Obviously if we don't find the bridge, we won't find the USB device
either.

Is there anything you can relate to the USB device?  I assume it's not
something like "the USB controller appears only when there's a USB
device connected to it"?  No flaky USB device connected (low battery
or something)?

Looking at USB, I see this weirdness:

  $ grep "BCM\|000272C95496" dmesg.*
  dmesg.bad:usb 4-2: Product: BCM20702A0
  dmesg.bad:usb 4-2: SerialNumber: 000272C95496
  dmesg.bad:Bluetooth: hci0: BCM: chip id 63
  dmesg.bad:Bluetooth: hci0: BCM: features 0x07
  dmesg.bad:Bluetooth: hci0: BCM20702A
  dmesg.bad:Bluetooth: hci0: BCM20702A1 (001.002.014) build 0000
  dmesg.bad:Bluetooth: hci0: BCM20702A1 (001.002.014) build 1338
  dmesg.good:usb 4-2: Product: BCM920702 Bluetooth 4.0
  dmesg.good:usb 4-2: SerialNumber: 000272C95496
  dmesg.good:Bluetooth: hci0: BCM: chip id 63
  dmesg.good:Bluetooth: hci0: BCM: features 0x07
  dmesg.good:Bluetooth: hci0: BCM20702A1 (001.002.014) build 1338
  dmesg.good:Bluetooth: hci0: BCM20702A1 (001.002.014) build 1338

Looks like the same device, but for some reason it identifies
differently.  Added some Bluetooth guys in case they have an idea;
I sure don't.

> > I wouldn't mind, but it finds it early in the piece, and that
> > changes the PCI allocation of my Ethernet board from 02:06.0 to
> > 03:06.0, and, with systemd, Linux comes up with no network
> > connection. A reboot fixes it, mostly.
> > 
> > Here's the first few lines of 'lspci' when Linux doesn't find the
> > extra device
> > 
> > > 00:00.0 Host bridge: Advanced Micro Devices, Inc. [AMD/ATI] RD9x0/RX980 Host Bridge (rev 02) 
> > > 00:00.2 IOMMU: Advanced Micro Devices, Inc. [AMD/ATI] RD890S/RD990 I/O Memory Management Unit (IOMMU)
> > > 00:02.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI] RD890/RD9x0/RX980 PCI to PCI bridge (PCI Express GFX port 0)
> > > 00:11.0 SATA controller: Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0 SATA Controller [AHCI mode] (rev 40) 
> > 
> > and here's the same thing when it does:
> > 
> > > 00:00.0 Host bridge: Advanced Micro Devices, Inc. [AMD/ATI] RD9x0/RX980 Host Bridge (rev 02)
> > > 00:00.2 IOMMU: Advanced Micro Devices, Inc. [AMD/ATI] RD890S/RD990 I/O Memory Management Unit (IOMMU)
> > > 00:02.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI] RD890/RD9x0/RX980 PCI to PCI bridge (PCI Express GFX port 0)
> > > 00:09.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI] RD890/RD9x0/RX980 PCI to PCI bridge (PCI Express GPP Port 4)
> > > 00:11.0 SATA controller: Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0 SATA Controller [AHCI mode] (rev 40)
> > > 00:12.0 USB controller: Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0 USB OHCI0 Controller 
> > 
> > The 00:09.0 device is the extra one. Anything else I can provide to assist?
