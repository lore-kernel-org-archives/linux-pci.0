Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:43862 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750724AbbFZCqZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 25 Jun 2015 22:46:25 -0400
Message-ID: <1435284123.3822.24.camel@kernel.crashing.org>
Subject: Re: [PATCH v7 5/9] PCI: Add pci_iomap_wc() variants
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Casey Leedom <leedom@chelsio.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
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
	<ville.syrjala@linux.intel.com>,
	David Vrabel <david.vrabel@citrix.com>,
	Jan Beulich <jbeulich@suse.com>,
	Roger Pau =?ISO-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
Date: Fri, 26 Jun 2015 12:02:03 +1000
In-Reply-To: <4985EFDD773FCB459EF7915D2A3621ADC031F8@nice.asicdesigners.com>
References: <1434751712-24333-1-git-send-email-mcgrof@do-not-panic.com>
	 <1435189081.3790.24.camel@kernel.crashing.org>
	 <4985EFDD773FCB459EF7915D2A3621ADC02F10@nice.asicdesigners.com>
	 ,<6806026.xb91q6Ad7G@wuerfel>
	 <4985EFDD773FCB459EF7915D2A3621ADC031F8@nice.asicdesigners.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 2015-06-25 at 21:40 +0000, Casey Leedom wrote:
> 
> Ah, thanks.  I see now that the __raw_*() APIs don't do any of the
> Endian Swizzling.  Unfortunately the *_relaxed() APIs on PowerPC
> are just defined as the normal *() routines.  From
> arch/powerpc/include/asm/io.h:
> 
>     /*
>      * We don't do relaxed operations yet, at least not with this
> semantic
>      */

Yes so I was looking at this but there are some difficulties.
Architecturally, even with I=1 G=1 mappings (normal ioremap), we have no
guarantee of ordering of load vs. store unless I misunderstood
something. I think all current implementations provide some of that but
without barriers in the accessors, we aren't architecturally correct.

However, having those barriers will cause issues with G=0 (write
combine). It's unclear whether eieio() will provide the required
ordering for I=1 G=0 mappings and it will probably break write combine.

I'm looking into it with our HW guys and will try to come up with a
solution for power, but it doesn't help that our memory model conflates
write combining with other relaxations and that all our barriers also
prevent write combine.

Maybe we can bias the relaxed accessors toward write, by having no
barriers in it, and putting extra ones in reads.

Cheers,
Ben.

