Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34725 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755481AbcCNKCN (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 14 Mar 2016 06:02:13 -0400
Received: by mail-wm0-f66.google.com with SMTP id p65so14231147wmp.1
        for <linux-pci@vger.kernel.org>; Mon, 14 Mar 2016 03:02:13 -0700 (PDT)
Date: Mon, 14 Mar 2016 11:02:59 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Dave Airlie <airlied@gmail.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	dri-devel <dri-devel@lists.freedesktop.org>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH 1/2] vga_switcheroo: add power support for windows 10
 machines.
Message-ID: <20160314100259.GP14170@phenom.ffwll.local>
References: <1457504045-12738-1-git-send-email-airlied@gmail.com>
 <2736217.utxPzJExd5@vostro.rjw.lan>
 <20160311105815.GS1796@lahna.fi.intel.com>
 <2759763.dR5D0KopkA@vostro.rjw.lan>
 <CAPM=9txo4aOOa-CS-mnyQe+vYDtAOCm1bzAgfMzwJJS8ZuYmwQ@mail.gmail.com>
 <20160314094335.GE1796@lahna.fi.intel.com>
 <CAPM=9txx1s3ZZSaTAGDFh=hKk-Ek2Y=Wyw74CpTWu-cTDAnJ7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAPM=9txx1s3ZZSaTAGDFh=hKk-Ek2Y=Wyw74CpTWu-cTDAnJ7A@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Mar 14, 2016 at 07:47:39PM +1000, Dave Airlie wrote:
> >
> >> -     if (pcie_port_runtime_suspend_allowed(dev))
> >> +     if (pcie_port_runtime_suspend_allowed(dev)) {
> >> +             pm_runtime_allow(&dev->dev);
> >
> > PCI drivers typically have left this decision up to the userspace. I'm
> > wondering whether it is good idea to deviate from that here? Of course
> > this allows immediate power savings but could potentially cause problems
> > as well.
> >
> 
> No distro has ever shipped userspace to do this, I really think this
> is a bad design.
> We have wasted countless watts of power on this stupid idea that people will
> run powertop, only a few people in the world run powertop, lots of
> people use Linux.
> 
> The kernel should power stuff down not wait for the user to run powertop,
> At least for the GPU it's in the area of 8W of power, and I've got the
> GPU drivers doing this themselves,
> 
> I could have the GPU driver call runtime allow for it's host bridge I suppose,
> if we insist on the userspace cares, but I'd prefer not doing so.

Yes, fully agreed. Runtime PM that's not enabled by default is useless,
since no one runs powertop, which also means it's buggy because no one
tests it. Not enabling power saving features by default is imo just a lame
excuse. Shit better just work, and tuneables should only exposed if
there's a real reason why autotuning is infeasible. E.g. we auto-ramp the
gpu clock down/up in i915 in software to compensate for some of the
silliness in how the hw does it alone. And the sysfs tunables are mostly
just to make benchmarking (where slower, but without any thermal
throttling) is sometimes preferred.

And yes i915 hasn't enabled rpm yet by default because there's bugs left
:(
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
