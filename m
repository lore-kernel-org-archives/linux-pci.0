Return-Path: <SRS0=c1rG=H4=linaro.org=shawn.guo@kernel.org>
Return-Path: <SRS0=c1rG=H4=linaro.org=shawn.guo@kernel.org>
Date: Wed, 9 May 2018 12:51:53 +0800
From: Shawn Guo <shawn.guo@linaro.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Yao Chen <chenyao11@huawei.com>, songxiaowei@hisilicon.com,
	wangbinghui@hisilicon.com, lorenzo.pieralisi@arm.com,
	bhelgaas@google.com, xuwei5@hisilicon.com, robh+dt@kernel.org,
	mark.rutland@arm.com, catalin.marinas@arm.com, will.deacon@arm.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	dimitrysh@google.com, guodong.xu@linaro.org,
	Stanimir Varbanov <svarbanov@mm-sol.com>,
	Jianguo Sun <sunjianguo1@huawei.com>
Subject: Re: [PATCH] Kirin-PCIe: Add kirin pcie msi feature.
Message-ID: <20180509045151.GA24899@dragon>
References: <1525763028-107417-1-git-send-email-chenyao11@huawei.com>
 <20180508125658.GK161390@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180508125658.GK161390@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On Tue, May 08, 2018 at 07:56:58AM -0500, Bjorn Helgaas wrote:
...
> > +			return ret;
> > +		}
> > +	}
> > +
> > +	pci->pp.root_bus_nr = -1;
> 
> Setting root_bus_nr looks like an unrelated change that should be in a
> separate patch.
> 
> But I'm not sure why you need to set root_bus_nr at all, since
> dw_pcie_host_init() always sets it.
> 
> Some other callers of dw_pcie_host_init() do set it:
> 
>   exynos_add_pcie_port()
>   imx6_add_pcie_port()
>   armada8k_add_pcie_port()
>   artpec6_add_pcie_port()
>   dw_plat_add_pcie_port()
>   histb_pcie_probe()
>   qcom_pcie_probe()
>   spear13xx_add_pcie_port()
> 
> But I don't see *why* any of these need to set it.  If they don't need to
> set it, they shouldn't.

Mostly it's a blind copy of unnecessary code.  I tested histb driver
by dropping the line, and did not see anything broken.  I will cook up
a series to remove the code from all above drivers, and copy
corresponding driver owner to comment.

> And it would be nice if histb and qcom followed the structure and naming
> conventions of the other drivers, i.e., they should have
> histb_add_pcie_port() and qcom_add_pcie_port().

I can create a patch for histb driver, but will leave qcom one to
Stanimir to decide.

Shawn

> 
> >  	pci->pp.ops = &kirin_pcie_host_ops;
> >  
> >  	return dw_pcie_host_init(&pci->pp);
> > -- 
> > 1.9.1
> > 
> > 
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
