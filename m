Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 1 Jun 2015 08:22:27 +0200
From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
To: Darren Hart <dvhart@infradead.org>
Cc: Michael Marineau <michael.marineau@coreos.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	platform-driver-x86@vger.kernel.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Petri Hodju <petrihodju@yahoo.com>,
	Matthew Garrett <matthew.garrett@nebula.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [Patch v3] apple-gmux: lock iGP IO to protect from vgaarb
 changes
Message-ID: <20150601082227.01663ac8@pluto.restena.lu>
In-Reply-To: <20150529163650.GA94698@vmdeb7>
References: <20150305232038.1873d380@neptune.home>
	<20150306174254.GB19001@vmdeb7>
	<20150307011546.0050279d@neptune.home>
	<20150309225238.0b9ced4e@neptune.home>
	<CAErSpo61r-_hy1hfUMm2ooXZVLTBhtjd-x5uXbyEg=WcG=itnQ@mail.gmail.com>
	<20150311223445.6af76f7c@neptune.home>
	<CAGr1u3tKVtQno=hUrKemLFYG12dtvPjFVR7oFwDG5cewJGCnJQ@mail.gmail.com>
	<20150527044749.GB21644@fury.dvhart.com>
	<CAGr1u3t1+ktKG_v74nQ2H6txGcWSwBBfsWS74k0Ao2pNTvgAng@mail.gmail.com>
	<20150527081323.35a3cf88@pluto.restena.lu>
	<20150529163650.GA94698@vmdeb7>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, 29 May 2015 18:36:50 +0200 Darren Hart wrote:
> > Making sure to lock only the intel GPU when present and especially protecting
> > against nvidia driver will be hard if legacy-IO is being processed by a hidden
> > device!
> 
> Ugh indeed. Worst case we can special case via dmi strings. Is this Apple device
> significantly different from others? Bruno, what are you testing on?

I only own a pretty old MacBook Air with just NVIDIA IGP and had to
rely on BUG reports and testing from affected users.

Not doing anything on apple-gmux when only a single GPU is visible
should be easy, but denying any vgaarb operation when Intel IGP is
hidden and just discrete GPU present is much harder (if one does not
want to risk opening the next can of worms).

DMI based special-casing would work but will it uncover the next issue
with the same device configured differently?

Bruno
