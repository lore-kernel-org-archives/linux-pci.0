Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from va3ehsobe004.messaging.microsoft.com ([216.32.180.14]:53504
	"EHLO VA3EHSOBE002.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754175Ab2B1Rmm (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 28 Feb 2012 12:42:42 -0500
Date: Tue, 28 Feb 2012 18:42:32 +0100
From: Andreas Herrmann <andreas.herrmann3@amd.com>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
CC: Ingo Molnar <mingo@elte.hu>,
	"Brandeburg, Jesse" <jesse.brandeburg@intel.com>,
	<linux-pci@vger.kernel.org>
Subject: Re: [andreas.herrmann3@amd.com: [PATCH 1/2] x86/amd: Restore
 early_fill_mp_bus_to_node]
Message-ID: <20120228174232.GI31006@alberich.amd.com>
References: <20120227094406.GB10078@elte.hu>
 <20120227122240.778bcc5b@jbarnes-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20120227122240.778bcc5b@jbarnes-desktop>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Feb 27, 2012 at 12:22:40PM -0800, Jesse Barnes wrote:
> On Mon, 27 Feb 2012 10:44:06 +0100
> Ingo Molnar <mingo@elte.hu> wrote:
> 
> > 
> > Yours?
> > 
> > ----- Forwarded message from Andreas Herrmann <andreas.herrmann3@amd.com> -----
> > 
> > Date: Fri, 24 Feb 2012 16:19:12 +0100
> > From: Andreas Herrmann <andreas.herrmann3@amd.com>
> > To: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin"
> > 	<hpa@zytor.com>
> > CC: linux-kernel@vger.kernel.org
> > Subject: [PATCH 1/2] x86/amd: Restore early_fill_mp_bus_to_node
> > 
> > 
> > Once upon a time this function was overloaded with quirky stuff to fix
> > resource detection on systems w/ _CRS defects (seems that some Sun and
> > HP systems were affected).
> > 
> > See commit 30a18d6c3f1e774de656ebd8ff219d53e2ba4029
> > (x86: multi pci root bus with different io resource range, on 64-bit)
> > 
> > Restore the old function and thus decouple it from the quirk that is
> > CPU family specific (e.g. it won't work on AMD family 15h CPUs). BTW,
> > I assume that the _CRS stuff is working on current systems.
> > 
> > This is required to properly initilize the numa_node information of
> > PCI busses and associated devices.
> > 
> > Signed-off-by: Andreas Herrmann <andreas.herrmann3@amd.com>
> > ---
> >  arch/x86/pci/amd_bus.c |   84 +++++++++++++++++++++++++++++++----------------
> 
> ISTR this function getting things wrong on some Nehalem based systems,
> and assigning all IO devices to node 0, resulting in bad NIC
> performance.

Are you referring to the original early_fill_mp_bus_to_node function?
I don't see how this can happen as it's only called in case of
existence of AMD CPU NB devices. Those won't be detected on Intel at
all.

> Jesse, are things working ok now?  Care to test this patch to make
> sure it doesn't regress anything on one of the previously affected
> systems?




Andreas


