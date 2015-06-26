Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from stargate.chelsio.com ([67.207.112.58]:13254 "EHLO
	stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752235AbbFZQZW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 26 Jun 2015 12:25:22 -0400
From: Casey Leedom <leedom@chelsio.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Arnd Bergmann <arnd@arndb.de>,
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
	"Ingo Molnar" <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Dave Airlie <airlied@redhat.com>,
	Antonino Daplas <adaplas@gmail.com>,
	Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"venkatesh.pallipadi@intel.com" <venkatesh.pallipadi@intel.com>,
	Stefan Bader <stefan.bader@canonical.com>,
	"ville.syrjala@linux.intel.com" <ville.syrjala@linux.intel.com>,
	David Vrabel <david.vrabel@citrix.com>,
	"Jan Beulich" <jbeulich@suse.com>,
	=?iso-8859-1?Q?Roger_Pau_Monn=E9?= <roger.pau@citrix.com>
Subject: RE: [PATCH v7 5/9] PCI: Add pci_iomap_wc() variants
Date: Fri, 26 Jun 2015 16:24:27 +0000
Message-ID: <4985EFDD773FCB459EF7915D2A3621ADC03621@nice.asicdesigners.com>
References: <1434751712-24333-1-git-send-email-mcgrof@do-not-panic.com>
	 <1435189081.3790.24.camel@kernel.crashing.org>
	 <4985EFDD773FCB459EF7915D2A3621ADC02F10@nice.asicdesigners.com>
	 ,<6806026.xb91q6Ad7G@wuerfel>
	 <4985EFDD773FCB459EF7915D2A3621ADC031F8@nice.asicdesigners.com>,<1435284123.3822.24.camel@kernel.crashing.org>
In-Reply-To: <1435284123.3822.24.camel@kernel.crashing.org>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

  Thanks for looking into this Ben.  As it stands now, it seems as
if Write Combined mappings simply aren't supported and/or all
driver writers trying to utilize Write Combined mappings have to
"hand roll" their own solutions which really isn't supportable.

  One thing that might be considered is simply to treat the desire
to utilize the Write Combining hardware as a separate issue and
develop writel_wc(), writeq_wc(), etc.  Those could be defined
as legal only for Write Combined Mappings and would "do the
right thing" for each architecture.  The initial implementations
could simply be writel(), writeq(), etc. till each architecture'si
ssues were investigated and understood.

  Additionally, it would be very useful to have some sort of
predicate which could be used to determine if an architecture
supported Write Combining.  Our drivers would use this to
eliminate a wasteful attempt to use write combining on those
architectures where it didn't work.

Casey

________________________________________
From: Benjamin Herrenschmidt [benh@kernel.crashing.org]
Sent: Thursday, June 25, 2015 7:02 PM
To: Casey Leedom
Cc: Arnd Bergmann; Luis R. Rodriguez; Michael S. Tsirkin; Bjorn Helgaas; Toshi Kani; Andy Lutomirski; Juergen Gross; Tomi Valkeinen; linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org; xen-devel@lists.xensource.com; linux-fbdev; Suresh Siddha; Ingo Molnar; Thomas Gleixner; Daniel Vetter; Dave Airlie; Antonino Daplas; Jean-Christophe Plagniol-Villard; Dave Hansen; venkatesh.pallipadi@intel.com; Stefan Bader; ville.syrjala@linux.intel.com; David Vrabel; Jan Beulich; Roger Pau Monné
Subject: Re: [PATCH v7 5/9] PCI: Add pci_iomap_wc() variants

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

