Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from stargate.chelsio.com ([67.207.112.58]:15243 "EHLO
	stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752453AbbFYVlV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 25 Jun 2015 17:41:21 -0400
From: Casey Leedom <leedom@chelsio.com>
To: Arnd Bergmann <arnd@arndb.de>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
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
	"Thomas Gleixner" <tglx@linutronix.de>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	"Dave Airlie" <airlied@redhat.com>,
	Antonino Daplas <adaplas@gmail.com>,
	Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"venkatesh.pallipadi@intel.com" <venkatesh.pallipadi@intel.com>,
	Stefan Bader <stefan.bader@canonical.com>,
	Ville =?ISO-8859-1?Q?Syrj=E4l=E4? = <syrjala@sci.fi>,
	Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
	Borislav Petkov <bp@suse.de>, Davidlohr Bueso <dbueso@suse.de>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	=?iso-8859-1?Q?Ville_Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>,
	David Vrabel <david.vrabel@citrix.com>,
	"Jan Beulich" <jbeulich@suse.com>,
	=?iso-8859-1?Q?Roger_Pau_Monn=E9?= <roger.pau@citrix.com>
Subject: RE: [PATCH v7 5/9] PCI: Add pci_iomap_wc() variants
Date: Thu, 25 Jun 2015 21:40:12 +0000
Message-ID: <4985EFDD773FCB459EF7915D2A3621ADC031F8@nice.asicdesigners.com>
References: <1434751712-24333-1-git-send-email-mcgrof@do-not-panic.com>
 <1435189081.3790.24.camel@kernel.crashing.org>
 <4985EFDD773FCB459EF7915D2A3621ADC02F10@nice.asicdesigners.com>,<6806026.xb91q6Ad7G@wuerfel>
In-Reply-To: <6806026.xb91q6Ad7G@wuerfel>
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

| From: Arnd Bergmann [arnd@arndb.de]
| Sent: Thursday, June 25, 2015 1:44 PM
| 
| On Thursday 25 June 2015 15:01:56 Casey Leedom wrote:
| >
| >   Is there a reference I can read on this so I can understand
| > when and where we can use the __raw_*() APIs?  Can these
| > Raw Read/Write operations be reordered with respect to
| > each other or are the use of the various flavors of SYNC
| > instructions just to maintain order between Cached Memory
| > Accesses and I/O Instructions?
| 
| The interpretation is not consistent across architectures.
| 
| My best description would be that the __raw_*() accessors should
| only be used for accessing RAM areas that are known to have no
| side-effects and can be read in any size (8-bit to 64-bit wide),
| any alignment, and do not have a specific endianess.
| 
| If you are dealing with MMIO registers that have a fixed endianess
| and size, the correct accessor would be readl_relaxed(), which
| is like readl() but lacks the barriers on certain architectures.

Ah, thanks.  I see now that the __raw_*() APIs don't do any of the
Endian Swizzling.  Unfortunately the *_relaxed() APIs on PowerPC
are just defined as the normal *() routines.  From
arch/powerpc/include/asm/io.h:

    /*
     * We don't do relaxed operations yet, at least not with this semantic
     */
    #define readb_relaxed(addr)     readb(addr)
    #define readw_relaxed(addr)     readw(addr)
    #define readl_relaxed(addr)     readl(addr)
    #define readq_relaxed(addr)     readq(addr)
    #define writeb_relaxed(v, addr) writeb(v, addr)
    #define writew_relaxed(v, addr) writew(v, addr)
    #define writel_relaxed(v, addr) writel(v, addr)
    #define writeq_relaxed(v, addr) writeq(v, addr)

    (And in fact, this is true for most of the architectures.)

So we could go ahead and use these but for now there wouldn't be
any effect.

Hhmmm, so what do PowerPC Drivers do when they want to take
advantage of Write Combining?  Do their own Endian Swizzling
with the __raw_*() APIs?

Casey