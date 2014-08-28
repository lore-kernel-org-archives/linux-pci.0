Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hygieia.santi-shop.eu ([78.46.175.2]:37289 "EHLO
	hygieia.santi-shop.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750875AbaH1Ur4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 28 Aug 2014 16:47:56 -0400
Date: Thu, 28 Aug 2014 22:47:50 +0200
From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Andreas Noever <andreas.noever@gmail.com>,
	dri-devel@lists.freedesktop.org,
	Matthew Garrett <matthew.garrett@nebula.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linux PCI <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 1/2 v2] vgaarb: Don't default exclusively to first video
 device with mem+io
Message-ID: <20140828224750.23148125@neptune.home>
In-Reply-To: <CAMxnaaUoLBbN1gNgD3qvPV1mx3JoM6FPV9EndQG9vJSpux2xMw@mail.gmail.com>
References: <20140514224339.7f8be3a9@neptune.home>
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
	<20140822082324.12cb6e93@pluto>
	<CAMxnaaU9EiMcne-aQjS1sY1Orn6xGbVHEnd057ogcZ77p74Y=Q@mail.gmail.com>
	<20140823130624.06ecc057@neptune.home>
	<20140824230953.7c04890f@neptune.home>
	<CAMxnaaUoLBbN1gNgD3qvPV1mx3JoM6FPV9EndQG9vJSpux2xMw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 26 August 2014 Andreas Noever <andreas.noever@gmail.com> wrote:
> On Sun, Aug 24, 2014 at 11:09 PM, Bruno Prémont wrote:
> > With commit 20cde694027e boot video device detection was moved from
> > efifb to x86 and ia64 pci/fixup.c.
> >
> > For dual-GPU Apple computers above change represents a regression as
> > code in efifb did forcefully override vga_default_device while the
> > merge did not (vgaarb happens prior to PCI fixup).
> >
> > To improve on initial device selection by vgaarb (it cannot know if
> > PCI device not behind bridges see/decode legacy VGA I/O or not), move
> > the screen_info based check from pci_video_fixup to vgaarb's init
> > function and use it to refine/override decision taken while adding
> > the individual PCI VGA devices.
> > This way PCI fixup has no reason to adjust vga_default_device
> > anymore but can depend on its value for flagging shadowed VBIOS.
> >
> > This has the nice benefit of removing duplicated code but does
> > introduce a #if defined() block in vgaarb.
> > Not all architectures have screen_info and would cause compile to
> > fail without it.
> >
> > Reported-By: Andreas Noever <andreas.noever@gmail.com>
> > CC: Matthew Garrett <matthew.garrett@nebula.com>
> > CC: stable@vger.kernel.org # v3.5+
> > Signed-off-by: Bruno Prémont <bonbons@linux-vserver.org>
> > ---
> > Andreas, does this work properly for you, including the improvement
> > on i915 complaint about VBIOS going from KERN_ERR to KERN_INFO?
> Yep, thanks!
> 
> >
> > Other arches using PCI and vgaarb that have screen_info may want
> > to be added to the #if defined() block or even introduce a new
> > CONFIG_HAVE_SCREEN_INFO or similar...

Bjorn, can you queue these two patches, probably going through -next
for a week and passing them to Linus for -rc4, adding Andreas's Tested-by
to Patch 1/2 v2?

Thanks,
Bruno
