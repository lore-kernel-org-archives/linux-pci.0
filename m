Return-Path: <k.kozlowski.k@gmail.com>
Return-Path: <k.kozlowski.k@gmail.com>
Date: Mon, 10 Oct 2016 19:49:42 +0300
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	Kukjin Kim <kgene@kernel.org>, linux-pci@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH 1/8] PCI: exynos: Name private struct pointer "exynos"
 consistently
Message-ID: <20161010164942.GA3352@kozik-lap>
References: <20161007163526.25314.29033.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20161008194144.GA2991@kozik-lap>
 <20161010133644.GA30267@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20161010133644.GA30267@localhost>
List-ID: <linux-pci.vger.kernel.org>

On Mon, Oct 10, 2016 at 08:36:44AM -0500, Bjorn Helgaas wrote:
> Hi Krzysztof,
> 
> Thanks a lot for taking the time to look these over.
> 
> On Sat, Oct 08, 2016 at 10:41:44PM +0300, Krzysztof Kozlowski wrote:
> > On Fri, Oct 07, 2016 at 11:35:26AM -0500, Bjorn Helgaas wrote:
> > > Use a device-specific name, "exynos", for struct exynos_pcie pointers
> > > to hint that this is device-specific information.
> > 
> > I don't get it. "exynos_pcie" is already a exynos-device-specific name.
> > There are a lot of changes but I don't see the real reason/benefit. What
> > was your intention?
> 
> I'm looking across all the drivers in drivers/pci/host/, not just
> exynos.  Many of them used "pcie" as name for pointers to the
> device-specific struct, leading to things like "pcie->lut" or
> "pcie->breg_base".  These *look* like they should be sort of generic,
> but in fact they are device-specific.
> 
> My idea was to replace that "pcie" name with something
> device-specific, and I started with the simplest possible name, e.g.,
> "exynos".  Others pointed out that that for SoCs, that is often not
> enough specific enough, and something like "exynos_pcie" is more
> appropriate.
> 
> In the specific case of exynos, it already uses "exynos_pcie" in most
> cases, so I tweaked this patch to use it in the few remaining places
> where it didn't (the register accessor functions).

Thanks for clarification, I am fine with it.

> > > No functional change
> > > intended.
> > 
> > Oh, but there is. Inline disappeared in first functions. Although I
> > don't mind but this should be seprate from trivial rename.
> 
> I didn't think of "inline" as a functional change, but I split it out
> into its own patch.  I'm embarrassed at how much churn this turned out
> to be, so I didn't want to add more patches than I had to, but I did
> split it out for you.
> 
> I repushed the branch.

Thanks,
Krzysztof
