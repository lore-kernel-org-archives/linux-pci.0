Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:52738 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753306AbbFZTcH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 26 Jun 2015 15:32:07 -0400
Date: Fri, 26 Jun 2015 21:31:58 +0200
From: "Luis R. Rodriguez" <mcgrof@suse.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
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
	Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
Subject: Re: [PATCH v7 5/9] PCI: Add pci_iomap_wc() variants
Message-ID: <20150626193158.GJ3005@wotan.suse.de>
References: <1434751712-24333-1-git-send-email-mcgrof@do-not-panic.com>
 <1435189081.3790.24.camel@kernel.crashing.org>
 <4985EFDD773FCB459EF7915D2A3621ADC02F10@nice.asicdesigners.com>
 <6806026.xb91q6Ad7G@wuerfel>
 <4985EFDD773FCB459EF7915D2A3621ADC031F8@nice.asicdesigners.com>
 <1435272718.3822.7.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1435272718.3822.7.camel@kernel.crashing.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jun 26, 2015 at 08:51:58AM +1000, Benjamin Herrenschmidt wrote:
> On Thu, 2015-06-25 at 21:40 +0000, Casey Leedom wrote:
> > Hhmmm, so what do PowerPC Drivers do when they want to take
> > advantage of Write Combining?  Do their own Endian Swizzling
> > with the __raw_*() APIs?
> 
> Yeah either, we need to fix our relaxed implementation (patch
> welcome :-)

Yikes, so although powerpc has useful heuristics to automatically
enable WC the default write ops have been nullifying its effects?
Shouldn't this have been blatantly obvious in performance benchmarks
and expectations? If not a change should give considerable performance
gains... If the WC was nullified on powerpc then the experience and
value of the heuristics have less value and even if they are going
to be only considered for userspace mmap() it should be taken with
a bit grain of salt it seems.

  Luis
