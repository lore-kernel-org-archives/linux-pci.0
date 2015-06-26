Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:52440 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752184AbbF0ASP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 26 Jun 2015 20:18:15 -0400
Message-ID: <1435362871.26815.24.camel@kernel.crashing.org>
Subject: Re: [Xen-devel] [PATCH v7 5/9] PCI: Add pci_iomap_wc() variants
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Luis R. Rodriguez" <mcgrof@suse.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Dave Airlie <airlied@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Andy Lutomirski <luto@amacapital.net>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Suresh Siddha <sbsiddha@gmail.com>,
	Ingo Molnar <mingo@elte.hu>,
	Antonino Daplas <adaplas@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Roger Pau =?ISO-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	ville.syrjala@linux.intel.com,
	"venkatesh.pallipadi@intel.com" <venkatesh.pallipadi@intel.com>,
	Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
	Tomi Valkeinen <tomi.valkeinen@ti.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	linux-fbdev <linux-fbdev@vger.kernel.org>,
	David Vrabel <david.vrabel@citrix.com>,
	Casey Leedom <leedom@chelsio.com>,
	Juergen Gross <jgross@suse.com>,
	Toshi Kani <toshi.kani@hp.com>,
	"xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>,
	Stefan Bader <stefan.bader@canonical.com>,
	Arnd Bergmann <arnd@arndb.de>, Jan Beulich <jbeulich@suse.com>
Date: Sat, 27 Jun 2015 09:54:31 +1000
In-Reply-To: <CAB=NE6XwczF6FYXV=RHyK=7ikVk_tGp+h9ouWPyORNENq4+=Kw@mail.gmail.com>
References: <1434751712-24333-1-git-send-email-mcgrof@do-not-panic.com>
	 <1435189081.3790.24.camel@kernel.crashing.org>
	 <4985EFDD773FCB459EF7915D2A3621ADC02F10@nice.asicdesigners.com>
	 <6806026.xb91q6Ad7G@wuerfel>
	 <4985EFDD773FCB459EF7915D2A3621ADC031F8@nice.asicdesigners.com>
	 <1435272718.3822.7.camel@kernel.crashing.org>
	 <20150626193158.GJ3005@wotan.suse.de>
	 <1435356258.26815.13.camel@kernel.crashing.org>
	 <CAB=NE6XwczF6FYXV=RHyK=7ikVk_tGp+h9ouWPyORNENq4+=Kw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, 2015-06-26 at 15:41 -0700, Luis R. Rodriguez wrote:

> > It wasn't nullified for the main user at the time, the fb. And I
> > mentioned an IB adapter or two for which the code had been hand
> tuned.
> 
> This still means there could be some affected drivers when used on
> powerpc, no?

Yes. In fact what about things like ARM who also have barriers in their
writel() ? Won't they also break WC ?

I'm trying to work with the architect and designers here to figure out
exactly where we stand and what we can do. As spelled out by our
architecture, things don't look great, because basically, we only have
attribute bit (garded) which when not set implies both WC and out of
order (& prefetch), and unclear barrier semantics in that case as well.

I *think* we might be able to settle with something along the lines of
"writel_relaxed() will allow combine on a WC mapping" but how I'm going
to get there is TBD.

It would be interesting to clarify the semantics of using the relaxed
accessors in combination with WC anyway. I wouldn't mind if the
definition involved also relaxing general ordering :-) It would
definitely make my life easier.

Cheers,
Ben.


