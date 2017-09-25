Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 25 Sep 2017 11:13:44 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Alex Williamson <alex.williamson@redhat.com>,
        Joerg Roedel <jroedel@suse.de>,
        linux-pci <linux-pci@vger.kernel.org>,
        iommu@lists.linux-foundation.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pci: Add dummy for pci_acs_enabled() if CONFIG_PCI=n to
 fix iommmu build
Message-ID: <20170925161344.GC15970@bhelgaas-glaptop.roam.corp.google.com>
References: <1505132955-9517-1-git-send-email-geert@linux-m68k.org>
 <20170922155605.GB15970@bhelgaas-glaptop.roam.corp.google.com>
 <CAMuHMdU4atjKiddgtt-=jee1FSjt8cHVN2XGg1m+1TzaMytAUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CAMuHMdU4atjKiddgtt-=jee1FSjt8cHVN2XGg1m+1TzaMytAUg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Sep 22, 2017 at 08:12:46PM +0200, Geert Uytterhoeven wrote:
> Hi Björn,
> 
> On Fri, Sep 22, 2017 at 5:56 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Mon, Sep 11, 2017 at 02:29:15PM +0200, Geert Uytterhoeven wrote:
> >> If CONFIG_PCI=n, and gcc (e.g. 4.1.2) decides not to inline
> >> get_pci_function_alias_group(), the build fails with:
> >>
> >>     drivers/iommu/iommu.o: In function `get_pci_function_alias_group':
> >>     iommu.c:(.text+0xfdc): undefined reference to `pci_acs_enabled'
> >>
> >> Due to the various dummies for PCI calls in the CONFIG_PCI=n case,
> >> pci_acs_enabled() isn't actually ever called, but not all versions of
> >> gcc are smart enough to realize that.
> >>
> >> While explicitly marking get_pci_function_alias_group() inline would fix
> >> the build, this would inflate the code for the CONFIG_PCI=y case, as
> >> get_pci_function_alias_group() is a not-so-small function called from
> >> two places.
> >>
> >> Hence fix the issue by introducing a dummy for pci_acs_enabled()
> >> instead.
> >>
> >> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> >
> > Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> >
> > Joerg, if you pick this up, would you mind capitalizing the subject
> > line to match the PCI convention, e.g.,
> >
> >   PCI: Add dummy pci_acs_enabled() for CONFIG_PCI=n build
> >
> > If it's too late for you to pick this up this week, I can include it
> > next week.  I assume this is not related to a specific change, i.e.,
> > it's not a regression?  Should it be marked for stable?
> 
> It was introduced by commit 0ae349a0f33fb040 ("iommu/qcom: Add qcom_iommu"),
> which enabled IOMMU support for compile-testing in e.g. allmodconfig on
> platforms that don't have IOMMUs.

I put this on my for-linus branch for v4.14 with Alex's reviewed-by.

Since 0ae349a0f33f was merged in the v4.14 merge window (it first
appeared in v4.14-rc1), I don't think we need to mark it for stable.

Bjorn
