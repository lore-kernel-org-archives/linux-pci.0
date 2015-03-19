Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:54169 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752685AbbCSDqX (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 18 Mar 2015 23:46:23 -0400
Date: Wed, 18 Mar 2015 20:46:18 -0700
From: Darren Hart <dvhart@infradead.org>
To: Bruno =?iso-8859-1?Q?Pr=E9mont?= <bonbons@linux-vserver.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	platform-driver-x86@vger.kernel.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Petri Hodju <petrihodju@yahoo.com>,
	Matthew Garrett <matthew.garrett@nebula.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [Patch v3] apple-gmux: lock iGP IO to protect from vgaarb changes
Message-ID: <20150319034618.GB22993@fury.dvhart.com>
References: <20150223215155.18444386@neptune.home>
 <20150303172753.GF83894@vmdeb7>
 <20150305232038.1873d380@neptune.home>
 <20150306174254.GB19001@vmdeb7>
 <20150307011546.0050279d@neptune.home>
 <20150309225238.0b9ced4e@neptune.home>
 <CAErSpo61r-_hy1hfUMm2ooXZVLTBhtjd-x5uXbyEg=WcG=itnQ@mail.gmail.com>
 <20150311223445.6af76f7c@neptune.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20150311223445.6af76f7c@neptune.home>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Mar 11, 2015 at 10:34:45PM +0100, Bruno Prémont wrote:
> As GMUX depends on IO for iGP to be enabled and active, lock the IO at
> vgaarb level. This should prevent GPU driver for dGPU to disable IO for
> iGP while it tries to own legacy VGA IO.
> 
> This fixes usage of backlight control combined with closed nvidia
> driver on some Apple dual-GPU (intel/nvidia) systems.
> 
> On those systems loading nvidia driver disables intel IO decoding,
> disabling the gmux backlight controls as a side effect.
> Prior to commits moving boot_vga from (optional) efifb to less optional
> vgaarb this mis-behavior could be avoided by using right kernel config
> (efifb enabled but vgaarb disabled).
> 
> This patch explicitly does not try to trigger vgaarb changes in order
> to avoid confusing already running graphics drivers. If IO has been
> mis-configured by vgaarb gmux will thus fail to probe.
> It is expected to load/probe gmux prior to graphics drivers.
> 
> Fixes: ce027dac592c0ada241ce0f95ae65856828ac450 # nvidia interaction
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=86121
> Reported-by: Petri Hodju <petrihodju@yahoo.com>
> Tested-by: Petri Hodju <petrihodju@yahoo.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Matthew Garrett <matthew.garrett@nebula.com>
> Signed-off-by: Bruno Prémont <bonbons@linux-vserver.org>
> ---
> Resending v2 in the hope Darren won't hit quoted-printable.
> Also adding linux-pci on CC by Bjorn's request in bugzilla.

Much better, thanks. Queued.

-- 
Darren Hart
Intel Open Source Technology Center
