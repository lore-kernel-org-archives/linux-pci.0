Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 22 Jul 2015 08:43:48 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: "Luis R. Rodriguez" <mcgrof@suse.com>,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>, bp@suse.de,
	arnd@arndb.de, luto@amacapital.net, akpm@linux-foundation.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	tomi.valkeinen@ti.com, mst@redhat.com, toshi.kani@hp.com,
	linux-fbdev@vger.kernel.org, xen-devel@lists.xensource.com,
	benh@kernel.crashing.org
Subject: Re: [PATCH v9 0/8] pci: add pci_iomap_wc() and pci_ioremap_wc_bar()
Message-ID: <20150722134348.GA10966@google.com>
References: <1436406859-1280-1-git-send-email-mcgrof@do-not-panic.com>
 <20150717202923.GC30479@wotan.suse.de>
 <20150721085252.GA15861@gmail.com>
 <20150721132157.GE16841@google.com>
 <20150722083844.GA14626@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150722083844.GA14626@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Ingo,

On Wed, Jul 22, 2015 at 10:38:45AM +0200, Ingo Molnar wrote:
> 
> * Bjorn Helgaas <bhelgaas@google.com> wrote:
> 
> > > > > Let me know if these are OK or if there are any questions.
> > > > > 
> > > > > [0] http://lkml.kernel.org/r/20150625204703.GC4898@pd.tnic
> > > > > [1] http://lkml.kernel.org/r/20150707095012.GQ7021@wotan.suse.de
> > > > 
> > > > Ingo,
> > > > 
> > > > Just a friendly reminder. Let me know if there are any issues or questions.
> > > 
> > > It would be nice to get an Acked-by from Bjorn for the PCI API bits.
> > 
> > I think the actual code of pci_ioremap_wc() and pci_ioremap_wc_bar() is fine 
> > (although I might have named it pci_ioremap_bar_wc() for consistency).
> > 
> > I declined to merge or ack them myself because they're obvious extensions of 
> > pci_ioremap() and pci_ioremap_bar(), and I would prefer that they be exported 
> > the same way, i.e., with EXPORT_SYMBOL(), not EXPORT_SYMBOL_GPL().
> 
> Huh? AFAICS pci_ioremap_bar() has been a _GPL export for a long time:
> ...
> (ioremap_wc() is EXPORT_SYMBOL() mostly by accident, it's the odd one out.)

You're right, I was mistaken about pci_ioremap_bar().  But I'm not
convinced yet that ioremap_wc() is the odd one out.  All the interfaces I
found, with the exception of ioremap_uc() on x86 and pci_ioremap_bar(), are
EXPORT_SYMBOL(), even the _wc and _wt flavors.

> Also, FWIIW: I personally got essentially zero feedback and help from proprietary 
> binary kernel module vendors in the past couple of years as x86 maintainer, 
> despite a fair chunk of kernel crashes reported on distro kernels occuring in 
> them...
> 
> Based on that very negative experience, when we introduce something as complex and 
> as critical as new caching APIs, the last thing I want is to have obscure bugs in 
> binary modules I cannot fix in any reasonable fashion. So even if the parent APIs 
> of new APIs weren't already _GPL exports (as in this case), I'd export them as 
> _GPL in this case.
> 
> > I think using EXPORT_SYMBOL_GPL to express individual political aims rather than 
> > as a hint about what might be derived work makes us look like zealots, and 
> > that's not my style.
> 
> As far as I'm concerned it's a pure technological choice: I don't want to export 
> certain types of hard to fix and critical functionality to drivers that I cannot 
> then fix.

That's a good argument that I hadn't heard before (or possibly it was there
and I missed it).  It would be stronger still if we could change the parent
APIs similarly.  If a proprietary driver can't use pci_ioremap_wc() because
it's exported _GPL, it's trivial to use ioremap_wc() directly.

Bjorn
