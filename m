Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 26 May 2015 12:40:08 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: "Luis R. Rodriguez" <mcgrof@suse.com>
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
	tomi.valkeinen@ti.com, airlied@linux.ie,
	linux-fbdev@vger.kernel.org, luto@amacapital.net,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	xen-devel@lists.xensource.com, Toshi Kani <toshi.kani@hp.com>,
	Suresh Siddha <sbsiddha@gmail.com>,
	Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>,
	Juergen Gross <jgross@suse.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Dave Airlie <airlied@redhat.com>,
	Antonino Daplas <adaplas@gmail.com>,
	Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	venkatesh.pallipadi@intel.com,
	Stefan Bader <stefan.bader@canonical.com>,
	Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>,
	Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
	Borislav Petkov <bp@suse.de>, Davidlohr Bueso <dbueso@suse.de>,
	konrad.wilk@oracle.com, ville.syrjala@linux.intel.com,
	david.vrabel@citrix.com, jbeulich@suse.com,
	Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
Subject: Re: [PATCH v6 1/4] pci: add pci_iomap_wc() variants
Message-ID: <20150526174008.GN32152@google.com>
References: <1432163293-20965-1-git-send-email-mcgrof@do-not-panic.com>
 <1432163293-20965-2-git-send-email-mcgrof@do-not-panic.com>
 <20150521223321.GG32152@google.com>
 <20150522002341.GM23057@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150522002341.GM23057@wotan.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, May 22, 2015 at 02:23:41AM +0200, Luis R. Rodriguez wrote:
> On Thu, May 21, 2015 at 05:33:21PM -0500, Bjorn Helgaas wrote:
> > 
> > I tentatively put this (and the rest of the series) on a pci/resource
> > branch.  I'm hoping you'll propose some clarification about
> > EXPORT_SYMBOL_GPL().
> 
> EXPORT_SYMBOL_GPL() also serves to ensure only GPL modules can
> only run that code. So for instance although we have "Dual BSD/GPL"
> tags for modules pure "BSD" tags do not exist for module tags and
> cannot run EXPORT_SYMBOL_GPL() code [0]. Also there is some folks
> who do believe tha at run time all kernel modules are GPL [1] [2].
> And to be precise even though the FSF may claim a list of licenses
> are GPL-compatible we cannot rely on this list alone for our own
> goals and if folks want to use our EXPORT_SYMBOL_GPL()s they must
> discuss this on lkml [2].

By "propose some clarification," I meant that I hoped you would propose a
patch to Documentation/ that would give maintainers some guidance.

> ...
