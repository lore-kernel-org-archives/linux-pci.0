Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay.restena.lu ([158.64.1.62]:41699 "EHLO
	smtprelay.restena.lu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751498AbaHVGX2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 22 Aug 2014 02:23:28 -0400
Date: Fri, 22 Aug 2014 08:23:24 +0200
From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Andreas Noever <andreas.noever@gmail.com>,
	DRI mailing list <dri-devel@lists.freedesktop.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Dave Airlie <airlied@linux.ie>,
	Matthew Garrett <matthew.garrett@nebula.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 0/2] x86, ia64: Move EFI_FB vga_default_device()
 initialization to pci_vga_fixup()
Message-ID: <20140822082324.12cb6e93@pluto>
In-Reply-To: <CAErSpo6D1B+dPLrYoAF4OA1KeWuW8VZW2_RR5jB1GbCRo+6vHg@mail.gmail.com>
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
	<20140820075508.74f5b622@pluto>
	<20140820091152.76cd4e1a@pluto>
	<CAMxnaaUodONkqmdPWedN-Q1qheHiJAScFcG_XbX1--ZmiOQZDg@mail.gmail.com>
	<20140821233435.19a9cffa@neptune.home>
	<CAErSpo6D1B+dPLrYoAF4OA1KeWuW8VZW2_RR5jB1GbCRo+6vHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 21 Aug 2014 23:39:31 -0500 Bjorn Helgaas wrote:
> On Thu, Aug 21, 2014 at 4:34 PM, Bruno Prémont wrote:
> 
> > A second step would then be to tune vgaarb's initial selection.
> > Bjorn, is it possible to verify which I/O ports are decoded by a PCI
> > device at the time of adding it to vgaarb? If so, how? I would like to
> > check for legacy VGA I/O range (0x03B0-0x03DF) and only let vgaarb set
> > a device as default if that I/O range is decoded by the device.
> 
> I don't know of a way.  I'm pretty sure VGA devices are allowed to
> respond to those legacy addresses even if there's no BAR for them, but
> I haven't found a spec reference for this.  There is the VGA Enable
> bit in bridges, of course (PCI Bridge spec, sec 12.1.1.  If the VGA
> device is behind a bridge that doesn't have the VGA Enable bit set, it
> probably isn't the default device.

Those VGA devices behind bridges are the easy ones that vgaarb selects
properly.
It's the ones not behind a bridge (integrated graphics) like the intel
one that cause problems.

For Andreas's system the discrete nvidia GPU has no I/O enabled
according to PCI_COMMAND flags while the integrated intel one does have
them (that's why the Intel GPU is chosen).

Unfortunately I don't know what makes his system choke at boot time as
he did not provide logs for the failing case.


If there is no better way to detect the proper legacy VGA device the
only remaining option would be to perform the screen_info testing in 
vga_arb_device_init() enclosed in arch #ifdef...

Bruno
