Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay.restena.lu ([158.64.1.62]:40632 "EHLO
	smtprelay.restena.lu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750984AbaHTGCG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 20 Aug 2014 02:02:06 -0400
Date: Wed, 20 Aug 2014 07:55:08 +0200
From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
To: Andreas Noever <andreas.noever@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	DRI mailing list <dri-devel@lists.freedesktop.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Dave Airlie <airlied@linux.ie>,
	Matthew Garrett <matthew.garrett@nebula.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 0/2] x86, ia64: Move EFI_FB vga_default_device()
 initialization to pci_vga_fixup()
Message-ID: <20140820075508.74f5b622@pluto>
In-Reply-To: <CAMxnaaWQoX9KMQVCKHTkeqSxGEybz5u1qU6AVBqzW3+mj_nJHQ@mail.gmail.com>
References: <20140514224339.7f8be3a9@neptune.home>
	<20140527234255.GJ11907@google.com>
	<20140602201650.35f0e936@neptune.home>
	<20140602201926.4d476818@neptune.home>
	<20140625005501.7ff7e982@neptune.home>
	<20140705171503.GC6247@google.com>
	<CAMxnaaXxAZAJAdr5AYYRZC_xKFCuyrfY=qpJu8x+P-S+osm5vw@mail.gmail.com>
	<CAMxnaaXGQe4vg9cY5e2KZBnG4F-z49OriwxEGUE-DCE6MKUryQ@mail.gmail.com>
	<20140810112654.1bf684d6@neptune.home>
	<CAMxnaaUsd+XHppMmPMXdFL13d1-OhLzoH_yjv_9abOx_uP=_Ug@mail.gmail.com>
	<20140810183411.19370721@neptune.home>
	<CAMxnaaVNpiSZmhQsHa_ZHJckgzG+xHyOL6hOT3Ts8GdcGN_A9g@mail.gmail.com>
	<20140816192135.34260115@neptune.home>
	<CAMxnaaWQoX9KMQVCKHTkeqSxGEybz5u1qU6AVBqzW3+mj_nJHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 19 Aug 2014 17:45:00 +0200 Andreas Noever wrote:
> On Sat, Aug 16, 2014 at 7:21 PM, Bruno Prémont wrote:
> > This series improves on commit 20cde694027e (x86, ia64: Move EFI_FB
> > vga_default_device() initialization to pci_vga_fixup()):
> > - cleanup remaining but always-true #ifndefs
> > - fix boot regression on dual-GPU Macs
> >
> > Andreas, can you please test this series? It is a modification from
> > previous testing patch that should still work fine for you.
> > That testing patch would have been failing X startup on old BIOS systems
> > booted with vga=normal (or otherwise in VGA text mode).
> >
> >
> > Greg, in case you have scheduled above-mentioned commit for your next
> > stable iteration, please hold it back in the queue until this follow-up
> > has landed and can be included within the same stable update as alone
> > that patch regresses for Macs with dual-GPU and using efifb.
> >
> > Bruno
> 
> Fails again (with and without efifb).
> 
> The vga_set_default_device in vga_arbiter_add_pci_device is at fault.
> It sets the boot video device to intel. Removing it makes the system
> bootable again.

Could you provide your whole kernel log? I would like to understand
how your vga devices are setup and why it starts the wrong way.

If you can grab kernel log from both working and failing setups it
would be even better. The failing one is interesting for where exactly it
starts failing at boot.


Bruno
