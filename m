Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:47262 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755403AbbHFVpn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 6 Aug 2015 17:45:43 -0400
Date: Thu, 6 Aug 2015 23:45:39 +0200
From: "Luis R. Rodriguez" <mcgrof@suse.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Ingo Molnar <mingo@kernel.org>,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>, bp@suse.de,
	arnd@arndb.de, luto@amacapital.net, akpm@linux-foundation.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	tomi.valkeinen@ti.com, mst@redhat.com, toshi.kani@hp.com,
	linux-fbdev@vger.kernel.org, xen-devel@lists.xensource.com,
	benh@kernel.crashing.org
Subject: Re: [PATCH v9 0/8] pci: add pci_iomap_wc() and pci_ioremap_wc_bar()
Message-ID: <20150806214539.GQ30479@wotan.suse.de>
References: <1436406859-1280-1-git-send-email-mcgrof@do-not-panic.com>
 <20150717202923.GC30479@wotan.suse.de>
 <20150721085252.GA15861@gmail.com>
 <20150721132157.GE16841@google.com>
 <20150722083844.GA14626@gmail.com>
 <20150722134348.GA10966@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150722134348.GA10966@google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jul 22, 2015 at 08:43:48AM -0500, Bjorn Helgaas wrote:
> Hi Ingo,
> 
> On Wed, Jul 22, 2015 at 10:38:45AM +0200, Ingo Molnar wrote:
> > 
> > * Bjorn Helgaas <bhelgaas@google.com> wrote:
> > 
> > > > > > Let me know if these are OK or if there are any questions.
> > > > > > 
> > > > > > [0] http://lkml.kernel.org/r/20150625204703.GC4898@pd.tnic
> > > > > > [1] http://lkml.kernel.org/r/20150707095012.GQ7021@wotan.suse.de
> > > > > 
> > > > > Ingo,
> > > > > 
> > > > > Just a friendly reminder. Let me know if there are any issues or questions.
> > > > 
> > > > It would be nice to get an Acked-by from Bjorn for the PCI API bits.
> > > 
> > > I think the actual code of pci_ioremap_wc() and pci_ioremap_wc_bar() is fine 
> > > (although I might have named it pci_ioremap_bar_wc() for consistency).
> > > 
> > > I declined to merge or ack them myself because they're obvious extensions of 
> > > pci_ioremap() and pci_ioremap_bar(), and I would prefer that they be exported 
> > > the same way, i.e., with EXPORT_SYMBOL(), not EXPORT_SYMBOL_GPL().
> > 
> > Huh? AFAICS pci_ioremap_bar() has been a _GPL export for a long time:
> > ...
> > (ioremap_wc() is EXPORT_SYMBOL() mostly by accident, it's the odd one out.)
> 
> You're right, I was mistaken about pci_ioremap_bar().  But I'm not
> convinced yet that ioremap_wc() is the odd one out.  All the interfaces I
> found, with the exception of ioremap_uc() on x86 and pci_ioremap_bar(), are
> EXPORT_SYMBOL(), even the _wc and _wt flavors.

The documentation update I provided on EXPORT_SYMBOL_GPL() which is now
upstream, at *your request* specifically for this series, *acknowledges* these
differences in opinions about new features, but it also clarifies that
positions on EXPORT_SYMBOL_GPL() can be up to developers and maintainers then,
so long as its for *new features*.

So this can be a position to take, and the guidence is there now. You asked for
this.

I acknowledge a subtle topic we seem to have stumbled upon here is what happens
if there is old "related technology" APIs with EXPORT_SYMBPOL(). Let me
elaborate on that, in my effort to provide guidence to reflect some historical
baggage while being apolagetic for those who hold a position of exclusive use
for *any* new functionality with EXPORT_SYMBOL_GPL(), like myself.

You seem to be taking a position of not allowing patches in that express the
freedom to use EXPORT_SYMBOL() because "related technology APIs had used
EXPORT_SYMBOL()". This is rather unfair for a few reasons:

0) This assumes that folks who wrote some old ioremap() calls had a position to
green light proprietary drivers to use them and embrace the idea that
EXPORT_SYMBOL_GPL() is the whitelist. As discussed in *many places* this
cannot be a reasonably general assumption as it does a *huge disservice* to many
people who always have held the position over their code always to not be
usable by proprietary drivers, and in even some cases that EXPORT_SYMBOL_GPL()
is pointless and does more harm than good, to the point they want to throw
tables at you for trying to add EXPORT_SYMBOL_GPL() code. Please consider
this *seriously*, not doing so is unfair to them.

1) Regardless of 0) its unfair to developers who do not want to deal with bug
reports for new features *at all*. Now this is important: one reason to take a
position to use EXPORT_SYMBOL_GPL() for new features even on *related
technology* APIs can be that we *cannot* change older APIs, *even* if consensus
is gathered that we don't want bug reports for certain functionality or
features.  That is, even if you think 0) is dodgy there can be a general
consensus and position by maintainers to not want bug reports on certain area
in the kernel. Also using your argument one could always negate this freedom
since EXPORT_SYMBOL() is historically spread out thorugh the entire kernel, so
one could make the argument that "related technology" APIs exist all over the
kernel, thereby denying any use of EXPORT_SYMBOL_GPL() everywhere.  This is
really unfair for new developers who start contributing who *do not want*
proprietary drivers to make use of their own new features.

2) Even if you consider 0 and 1) dodgy... we have positions expressed from developers
and maintainers on PAT interfaces with consensus that we don't want to deal with bug
reports for new PAT interfaces for proprietary drivers.

> > Also, FWIIW: I personally got essentially zero feedback and help from proprietary 
> > binary kernel module vendors in the past couple of years as x86 maintainer, 
> > despite a fair chunk of kernel crashes reported on distro kernels occuring in 
> > them...
> > 
> > Based on that very negative experience, when we introduce something as complex and 
> > as critical as new caching APIs, the last thing I want is to have obscure bugs in 
> > binary modules I cannot fix in any reasonable fashion. So even if the parent APIs 
> > of new APIs weren't already _GPL exports (as in this case), I'd export them as 
> > _GPL in this case.
> > 
> > > I think using EXPORT_SYMBOL_GPL to express individual political aims rather than 
> > > as a hint about what might be derived work makes us look like zealots, and 
> > > that's not my style.
> > 
> > As far as I'm concerned it's a pure technological choice: I don't want to export 
> > certain types of hard to fix and critical functionality to drivers that I cannot 
> > then fix.
> 
> That's a good argument that I hadn't heard before (or possibly it was there
> and I missed it).

Actually, that's likely the most common reason for these positions... so yes,
you missed it, but I don't blame you. Another strong reason is the strong
legal value over EXPORT_SYMBOL_GPL(). So folks in old camp 0) above may feel
now the need to be explicit due to the legal value of EXPORT_SYMBOL_GPL().

So let me re-iterate: camp 0) folks may have taken a slightly different
position these days. Also some folks who were maybe on the fence over
"related technology" positions may simply be fed up with proprietary drivers
in general, and they have the freedom to do so and if EXPORT_SYMBOL_GPL()
is a good technical stop-gap that's their choice.

> It would be stronger still if we could change the parent APIs similarly.

Sorry, that cannot happen. It is widely accepted that this was something we
would not do, in fact Linus has held a *strong* position that this would be
highly frowned upon.  So think about this -- if you acknowledge that its
sensible for developers or maintainers to not want to deal with bug reports for
hard to fix functionality and we cannot change old APIs to EXPORT_SYMBOL_GPL()
then that in and of itself is a reason then for why some developers and
maintainers have taken the position to accept *new features* to go in with
EXPORT_SYMBOL_GPL(), as a compromise.

Those who do not want to deal with the implications of proprietary drivers only
have the option to make new features EXPORTS_SYMBOL_GPL(). Denying them this
means allowing a slew of crap reports for new features for all of us.  It also
is denying anyone the sentiment or change of heart that perhaps enabling
proprietary drivers was a bad idea. Letting them use EXPORTS_SYMBOL_GPL()
enables them to express this sentiment.

> If a proprietary driver can't use pci_ioremap_wc() because
> it's exported _GPL, it's trivial to use ioremap_wc() directly.

That's under the assumption again that people who wrote ioremap_wc()
meant to enable such use. And again, the documentation today does
let folks add new *features* under EXPORT_SYMBOL_GPL() so if it makes
proprietary folks just do a bit more work, why not.

  Luis
