Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:52763 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751201AbbFYUxI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 25 Jun 2015 16:53:08 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Casey Leedom <leedom@chelsio.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	"Luis R. Rodriguez" <mcgrof@suse.com>,
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
	Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>,
	Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
	Borislav Petkov <bp@suse.de>, Davidlohr Bueso <dbueso@suse.de>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Ville =?ISO-8859-1?Q?Syrj=E4l=E4?=
	<ville.syrjala@linux.intel.com>,
	David Vrabel <david.vrabel@citrix.com>,
	Jan Beulich <jbeulich@suse.com>,
	Roger Pau =?ISO-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
Subject: Re: [PATCH v7 5/9] PCI: Add pci_iomap_wc() variants
Date: Thu, 25 Jun 2015 22:44:07 +0200
Message-ID: <6806026.xb91q6Ad7G@wuerfel>
In-Reply-To: <4985EFDD773FCB459EF7915D2A3621ADC02F10@nice.asicdesigners.com>
References: <1434751712-24333-1-git-send-email-mcgrof@do-not-panic.com> <1435189081.3790.24.camel@kernel.crashing.org> <4985EFDD773FCB459EF7915D2A3621ADC02F10@nice.asicdesigners.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday 25 June 2015 15:01:56 Casey Leedom wrote:
> 
>   Is there a reference I can read on this so I can understand
> when and where we can use the __raw_*() APIs?  Can these
> Raw Read/Write operations be reordered with respect to
> each other or are the use of the various flavors of SYNC
> instructions just to maintain order between Cached Memory
> Accesses and I/O Instructions?

The interpretation is not consistent across architectures.

My best description would be that the __raw_*() accessors should
only be used for accessing RAM areas that are known to have no
side-effects and can be read in any size (8-bit to 64-bit wide),
any alignment, and do not have a specific endianess.

If you are dealing with MMIO registers that have a fixed endianess
and size, the correct accessor would be readl_relaxed(), which
is like readl() but lacks the barriers on certain architectures.

	Arnd
