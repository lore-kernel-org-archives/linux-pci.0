Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:53048 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753399AbbFZWFe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 26 Jun 2015 18:05:34 -0400
Message-ID: <1435356258.26815.13.camel@kernel.crashing.org>
Subject: Re: [PATCH v7 5/9] PCI: Add pci_iomap_wc() variants
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Luis R. Rodriguez" <mcgrof@suse.com>
Cc: Casey Leedom <leedom@chelsio.com>, Arnd Bergmann <arnd@arndb.de>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Toshi Kani <toshi.kani@hp.com>,
	Andy Lutomirski <luto@amacapital.net>,
	Juergen Gross <jgross@suse.com>,
	Tomi Valkeinen <tomi.valkeinen@ti.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>,
	linux-fbdev <linux-fbdev@vger.kernel.org>,
	Suresh Siddha <sbsiddha@gmail.com>,
	Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Dave Airlie <airlied@redhat.com>,
	Antonino Daplas <adaplas@gmail.com>,
	Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"venkatesh.pallipadi@intel.com" <venkatesh.pallipadi@intel.com>,
	Stefan Bader <stefan.bader@canonical.com>,
	ville.syrjala@linux.intel.com,
	David Vrabel <david.vrabel@citrix.com>,
	Jan Beulich <jbeulich@suse.com>,
	Roger Pau =?ISO-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
Date: Sat, 27 Jun 2015 08:04:18 +1000
In-Reply-To: <20150626193158.GJ3005@wotan.suse.de>
References: <1434751712-24333-1-git-send-email-mcgrof@do-not-panic.com>
	 <1435189081.3790.24.camel@kernel.crashing.org>
	 <4985EFDD773FCB459EF7915D2A3621ADC02F10@nice.asicdesigners.com>
	 <6806026.xb91q6Ad7G@wuerfel>
	 <4985EFDD773FCB459EF7915D2A3621ADC031F8@nice.asicdesigners.com>
	 <1435272718.3822.7.camel@kernel.crashing.org>
	 <20150626193158.GJ3005@wotan.suse.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, 2015-06-26 at 21:31 +0200, Luis R. Rodriguez wrote:
> > Yeah either, we need to fix our relaxed implementation (patch
> > welcome :-)
> 
> Yikes, so although powerpc has useful heuristics to automatically
> enable WC the default write ops have been nullifying its effects?

The heuristic is for userspace mapping which don't use the kernel
accessors. To cut a long story short, this was all done back in the day
to speed up X.org which doesn't use fancy accessors with barriers to
access the framebuffer (neither does the kernel fbdev layer).

> Shouldn't this have been blatantly obvious in performance benchmarks
> and expectations? 

> If not a change should give considerable performance
> gains... If the WC was nullified on powerpc then the experience and
> value of the heuristics have less value and even if they are going
> to be only considered for userspace mmap() it should be taken with
> a bit grain of salt it seems.

It wasn't nullified for the main user at the time, the fb. And I
mentioned an IB adapter or two for which the code had been hand tuned.

Cheers,
Ben.

