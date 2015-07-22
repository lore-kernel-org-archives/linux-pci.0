Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:38268 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932731AbbGVIiw (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 22 Jul 2015 04:38:52 -0400
Date: Wed, 22 Jul 2015 10:38:45 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Luis R. Rodriguez" <mcgrof@suse.com>,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>, bp@suse.de,
	arnd@arndb.de, luto@amacapital.net, akpm@linux-foundation.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	tomi.valkeinen@ti.com, mst@redhat.com, toshi.kani@hp.com,
	linux-fbdev@vger.kernel.org, xen-devel@lists.xensource.com,
	benh@kernel.crashing.org
Subject: Re: [PATCH v9 0/8] pci: add pci_iomap_wc() and pci_ioremap_wc_bar()
Message-ID: <20150722083844.GA14626@gmail.com>
References: <1436406859-1280-1-git-send-email-mcgrof@do-not-panic.com>
 <20150717202923.GC30479@wotan.suse.de>
 <20150721085252.GA15861@gmail.com>
 <20150721132157.GE16841@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150721132157.GE16841@google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


* Bjorn Helgaas <bhelgaas@google.com> wrote:

> > > > Let me know if these are OK or if there are any questions.
> > > > 
> > > > [0] http://lkml.kernel.org/r/20150625204703.GC4898@pd.tnic
> > > > [1] http://lkml.kernel.org/r/20150707095012.GQ7021@wotan.suse.de
> > > 
> > > Ingo,
> > > 
> > > Just a friendly reminder. Let me know if there are any issues or questions.
> > 
> > It would be nice to get an Acked-by from Bjorn for the PCI API bits.
> 
> I think the actual code of pci_ioremap_wc() and pci_ioremap_wc_bar() is fine 
> (although I might have named it pci_ioremap_bar_wc() for consistency).
> 
> I declined to merge or ack them myself because they're obvious extensions of 
> pci_ioremap() and pci_ioremap_bar(), and I would prefer that they be exported 
> the same way, i.e., with EXPORT_SYMBOL(), not EXPORT_SYMBOL_GPL().

Huh? AFAICS pci_ioremap_bar() has been a _GPL export for a long time:

1684f5ddd4c0c   (Andrew Morton  2008-12-01 14:30:30 -0800       126)#ifdef CONFIG_HAS_IOMEM
1684f5ddd4c0c   (Andrew Morton  2008-12-01 14:30:30 -0800       127)void __iomem *pci_ioremap_bar(struct pci_dev *pdev, int bar)
1684f5ddd4c0c   (Andrew Morton  2008-12-01 14:30:30 -0800       128){
1f7bf3bfb5d60   (Bjorn Helgaas  2015-03-12 12:30:11 -0500       129)    struct resource *res = &pdev->resource[bar];
1f7bf3bfb5d60   (Bjorn Helgaas  2015-03-12 12:30:11 -0500       130)
1684f5ddd4c0c   (Andrew Morton  2008-12-01 14:30:30 -0800       131)    /*
1684f5ddd4c0c   (Andrew Morton  2008-12-01 14:30:30 -0800       132)     * Make sure the BAR is actually a memory resource, not an IO resource
1684f5ddd4c0c   (Andrew Morton  2008-12-01 14:30:30 -0800       133)     */
646c0282df042   (Bjorn Helgaas  2015-03-12 12:30:15 -0500       134)    if (res->flags & IORESOURCE_UNSET || !(res->flags & IORESOURCE_MEM)) {
1f7bf3bfb5d60   (Bjorn Helgaas  2015-03-12 12:30:11 -0500       135)            dev_warn(&pdev->dev, "can't ioremap BAR %d: %pR\n", bar, res);
1684f5ddd4c0c   (Andrew Morton  2008-12-01 14:30:30 -0800       136)            return NULL;
1684f5ddd4c0c   (Andrew Morton  2008-12-01 14:30:30 -0800       137)    }
1f7bf3bfb5d60   (Bjorn Helgaas  2015-03-12 12:30:11 -0500       138)    return ioremap_nocache(res->start, resource_size(res));
1684f5ddd4c0c   (Andrew Morton  2008-12-01 14:30:30 -0800       139)}
1684f5ddd4c0c   (Andrew Morton  2008-12-01 14:30:30 -0800       140)EXPORT_SYMBOL_GPL(pci_ioremap_bar);
1684f5ddd4c0c   (Andrew Morton  2008-12-01 14:30:30 -0800       141)#endif

commit 1684f5ddd4c0c happened in 2008, well before you became PCI maintainer in 
2012.

and I'd prefer keeping the same EXPORT_SYMBOL_GPL() pattern for the new APIs.

(ioremap_wc() is EXPORT_SYMBOL() mostly by accident, it's the odd one out.)

Also, FWIIW: I personally got essentially zero feedback and help from proprietary 
binary kernel module vendors in the past couple of years as x86 maintainer, 
despite a fair chunk of kernel crashes reported on distro kernels occuring in 
them...

Based on that very negative experience, when we introduce something as complex and 
as critical as new caching APIs, the last thing I want is to have obscure bugs in 
binary modules I cannot fix in any reasonable fashion. So even if the parent APIs 
of new APIs weren't already _GPL exports (as in this case), I'd export them as 
_GPL in this case.

> I think using EXPORT_SYMBOL_GPL to express individual political aims rather than 
> as a hint about what might be derived work makes us look like zealots, and 
> that's not my style.

As far as I'm concerned it's a pure technological choice: I don't want to export 
certain types of hard to fix and critical functionality to drivers that I cannot 
then fix.

But I also applied EXPORT_SYMBOL() patches in the past, so I'm not one-sided about 
it.

Thanks,

	Ingo
