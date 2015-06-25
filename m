Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:36090 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751239AbbFYAxh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 24 Jun 2015 20:53:37 -0400
Message-ID: <1435193521.3790.26.camel@kernel.crashing.org>
Subject: Re: [PATCH v7 5/9] PCI: Add pci_iomap_wc() variants
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Luis R. Rodriguez" <mcgrof@suse.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
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
	Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Dave Airlie <airlied@redhat.com>,
	Antonino Daplas <adaplas@gmail.com>,
	Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	venkatesh.pallipadi@intel.com,
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
Date: Thu, 25 Jun 2015 10:52:01 +1000
In-Reply-To: <20150625000803.GH11147@wotan.suse.de>
References: <1434751712-24333-1-git-send-email-mcgrof@do-not-panic.com>
	 <1434751712-24333-6-git-send-email-mcgrof@do-not-panic.com>
	 <1435099343.3996.13.camel@kernel.crashing.org>
	 <20150624163821.GF11147@wotan.suse.de>
	 <1435183509.3790.14.camel@kernel.crashing.org>
	 <CAB=NE6X0ySW=1udE3LCbo_eCjMfdrOMrceGsPvBZbDW+N-pLTw@mail.gmail.com>
	 <1435189081.3790.24.camel@kernel.crashing.org>
	 <20150625000803.GH11147@wotan.suse.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 2015-06-25 at 02:08 +0200, Luis R. Rodriguez wrote:
> 
> OK thanks I'll proceed with these patches then.
> 
> > As for user mappings,
> 
> Which APIs were you considering in this regard BTW?

mmap of the generic /sys/bus/pci/.../resource*

> > maybe the right thing to do is to let us do what we do by
> > default with a quirk that can set a flag in pci_dev to disable that
> > behaviour (maybe on a per BAR basis ?).
> 
> That might mean it could restrict userspace WC to require devices
> to have WC parts on a full PCI BAR. Although this is restrictive
> having reviewed most WC uses in the kernel I'd think this would be
> a fair compromise to make, but again, if things are still murky
> perhaps best we kiss this idea good bye for now and hope for it
> to come in on future buses or ammendments (if that's even possible?).
> 
> > I think the common case is that WC works.
> 
> If WC does not I will note one hack which migh be worth mentioning --
> just for
> the record, this was devised as a shortcoming of a device where they
> failed to
> split things properly and that *without* WC performance suffered quite
> a bit so
> they made one full PCI BAR WC and as a work around this:
> 
> http://lkml.kernel.org/r/20150416041837.GA5712@hykim-PC
> 
> That is for registers that needed it:
> 
> write; wmb;
> 
> Then if they wanted to wait till the NIC has seen the write, they did:
> 
> write; wmb; read;
> 

Right, and as I mentioned, on some archs like powerpc (and possibly
more), writel() and co contains an implicit mb()

>   Luis--


