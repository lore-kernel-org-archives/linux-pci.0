Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <1435194764.3790.33.camel@kernel.crashing.org>
Subject: Re: [Xen-devel] [PATCH v7 5/9] PCI: Add pci_iomap_wc() variants
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Luis R. Rodriguez" <mcgrof@suse.com>
Cc: linux-fbdev <linux-fbdev@vger.kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Jan Beulich <jbeulich@suse.com>,
	Ville =?ISO-8859-1?Q?Syrj=E4l=E4?=
	<ville.syrjala@linux.intel.com>,
	"xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Davidlohr Bueso <dbueso@suse.de>,
	Tomi Valkeinen <tomi.valkeinen@ti.com>,
	Mel Gorman <mgorman@suse.de>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Dave Airlie <airlied@redhat.com>, Ingo Molnar <mingo@elte.hu>,
	Borislav Petkov <bp@suse.de>,
	Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
	Antonino Daplas <adaplas@gmail.com>,
	Suresh Siddha <sbsiddha@gmail.com>,
	Stefan Bader <stefan.bader@canonical.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>,
	Juergen Gross <jgross@suse.com>,
	Toshi Kani <toshi.kani@hp.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Andy Lutomirski <luto@amacapital.net>,
	David Vrabel <david.vrabel@citrix.com>,
	venkatesh.pallipadi@intel.com,
	Roger Pau =?ISO-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
Date: Thu, 25 Jun 2015 11:12:44 +1000
In-Reply-To: <CAB=NE6VTHL1pGVMAkThx07wHNEPAGToJg5Ns_YEd6U1edb8__g@mail.gmail.com>
References: <1434751712-24333-1-git-send-email-mcgrof@do-not-panic.com>
	 <1434751712-24333-6-git-send-email-mcgrof@do-not-panic.com>
	 <1435099343.3996.13.camel@kernel.crashing.org>
	 <20150624163821.GF11147@wotan.suse.de>
	 <1435183509.3790.14.camel@kernel.crashing.org>
	 <CAB=NE6X0ySW=1udE3LCbo_eCjMfdrOMrceGsPvBZbDW+N-pLTw@mail.gmail.com>
	 <1435189081.3790.24.camel@kernel.crashing.org>
	 <20150625000803.GH11147@wotan.suse.de>
	 <1435193521.3790.26.camel@kernel.crashing.org>
	 <CAB=NE6VTHL1pGVMAkThx07wHNEPAGToJg5Ns_YEd6U1edb8__g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 2015-06-24 at 17:58 -0700, Luis R. Rodriguez wrote:
> On Wed, Jun 24, 2015 at 5:52 PM, Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
> > On Thu, 2015-06-25 at 02:08 +0200, Luis R. Rodriguez wrote:
> >>
> >> OK thanks I'll proceed with these patches then.
> >>
> >> > As for user mappings,
> >>
> >> Which APIs were you considering in this regard BTW?
> >
> > mmap of the generic /sys/bus/pci/.../resource*
> 
> Like? Got a demo patch in mind ? :)

Nope. I was just thinking out loud. Today I have yet to see a problem
with what we do so ...

Cheers,
Ben.


