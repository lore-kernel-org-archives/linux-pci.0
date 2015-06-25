Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from stargate.chelsio.com ([67.207.112.58]:1847 "EHLO
	stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752288AbbFYPDW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 25 Jun 2015 11:03:22 -0400
From: Casey Leedom <leedom@chelsio.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	"Luis R. Rodriguez" <mcgrof@suse.com>
CC: "Michael S. Tsirkin" <mst@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Toshi Kani <toshi.kani@hp.com>,
	Andy Lutomirski <luto@amacapital.net>,
	Juergen Gross <jgross@suse.com>,
	Tomi Valkeinen <tomi.valkeinen@ti.com>,
	Arnd Bergmann <arnd@arndb.de>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>,
	linux-fbdev <linux-fbdev@vger.kernel.org>,
	Suresh Siddha <sbsiddha@gmail.com>,
	"Ingo Molnar" <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Dave Airlie <airlied@redhat.com>,
	Antonino Daplas <adaplas@gmail.com>,
	Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"venkatesh.pallipadi@intel.com" <venkatesh.pallipadi@intel.com>,
	Stefan Bader <stefan.bader@canonical.com>,
	=?iso-8859-1?Q?Ville_Syrj=E4l=E4?= <syrjala@sci.fi>,
	Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
	Borislav Petkov <bp@suse.de>, Davidlohr Bueso <dbueso@suse.de>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	=?iso-8859-1?Q?Ville_Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>,
	"David Vrabel" <david.vrabel@citrix.com>,
	Jan Beulich <jbeulich@suse.com>,
	=?iso-8859-1?Q?Roger_Pau_Monn=E9?= <roger.pau@citrix.com>
Subject: RE: [PATCH v7 5/9] PCI: Add pci_iomap_wc() variants
Date: Thu, 25 Jun 2015 15:01:56 +0000
Message-ID: <4985EFDD773FCB459EF7915D2A3621ADC02F10@nice.asicdesigners.com>
References: <1434751712-24333-1-git-send-email-mcgrof@do-not-panic.com>
	 <1434751712-24333-6-git-send-email-mcgrof@do-not-panic.com>
	 <1435099343.3996.13.camel@kernel.crashing.org>
	 <20150624163821.GF11147@wotan.suse.de>
	 <1435183509.3790.14.camel@kernel.crashing.org>
	 <CAB=NE6X0ySW=1udE3LCbo_eCjMfdrOMrceGsPvBZbDW+N-pLTw@mail.gmail.com>,<1435189081.3790.24.camel@kernel.crashing.org>
In-Reply-To: <1435189081.3790.24.camel@kernel.crashing.org>
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

/ From: Benjamin Herrenschmidt [benh@kernel.crashing.org]
| Sent: Wednesday, June 24, 2015 4:38 PM
| 
| It is to be noted that on powerpc at least, writel() and co will never
| combine due to the memory barriers in them. Only "normal" stores (or
\ __raw_writel) will.

/ From: Benjamin Herrenschmidt [benh@kernel.crashing.org]
| Sent: Wednesday, June 24, 2015 5:52 PM
| 
| Right, and as I mentioned, on some archs like powerpc (and possibly
\ more), writel() and co contains an implicit mb()

  Hhmmm, interesting.  I definitely hadn't known that.  In our network
drivers we explicitly manage all of our own memory barrier semantics.
(wmb() between writes to DMA Queues and writes to Device Registers
informing hardware of new data available to be DMA'ed, etc.)  And we
do have code to take advantage of Write Combining Mappings using
writeq().  It looks like this is implemented eventually as out_be64()
in arch/powerpc/include/asm/io.h for PPC-BE:

#define DEF_MMIO_OUT_D(name, size, insn)                                \
static inline void name(volatile u##size __iomem *addr, u##size val)    \
{                                                                       \
        __asm__ __volatile__("sync;"#insn"%U0%X0 %1,%0"                 \
                : "=m" (*addr) : "r" (val) : "memory");                 \
        IO_SET_SYNC_FLAG();                                             \
}

DEF_MMIO_OUT_D(out_be64, 64, std);

  So, if understand your notes and the source correctly, all of
our code to do register reads/writes are getting SYNC instructions,
as are the 64-bit writeq()s we're attempting to use for our Write
Combining code on PowerPC.  Hhmmm indeed ...

  Is there a reference I can read on this so I can understand
when and where we can use the __raw_*() APIs?  Can these
Raw Read/Write operations be reordered with respect to
each other or are the use of the various flavors of SYNC
instructions just to maintain order between Cached Memory
Accesses and I/O Instructions?

Casey