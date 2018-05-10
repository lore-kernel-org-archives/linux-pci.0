Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Thu, 10 May 2018 08:33:50 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH] Kirin-PCIe: Add kirin pcie msi feature.
Message-ID: <20180510133350.GH173327@bhelgaas-glaptop.roam.corp.google.com>
References: <1525763028-107417-1-git-send-email-chenyao11@huawei.com>
 <20180508125658.GK161390@bhelgaas-glaptop.roam.corp.google.com>
 <20180509045151.GA24899@dragon>
MIME-Version: 1.0
In-Reply-To: <20180509045151.GA24899@dragon>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, lorenzo.pieralisi@arm.com,
 dimitrysh@google.com, guodong.xu@linaro.org, linux-pci@vger.kernel.org,
 catalin.marinas@arm.com, wangbinghui@hisilicon.com, will.deacon@arm.com,
 linux-kernel@vger.kernel.org, xuwei5@hisilicon.com,
 Stanimir Varbanov <svarbanov@mm-sol.com>, Jianguo Sun <sunjianguo1@huawei.com>,
 robh+dt@kernel.org, songxiaowei@hisilicon.com, bhelgaas@google.com,
 linux-arm-kernel@lists.infradead.org, Yao Chen <chenyao11@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 09, 2018 at 12:51:53PM +0800, Shawn Guo wrote:
> Hi Bjorn,
> 
> On Tue, May 08, 2018 at 07:56:58AM -0500, Bjorn Helgaas wrote:
> ...
> > > +			return ret;
> > > +		}
> > > +	}
> > > +
> > > +	pci->pp.root_bus_nr = -1;
> > 
> > Setting root_bus_nr looks like an unrelated change that should be in a
> > separate patch.
> > 
> > But I'm not sure why you need to set root_bus_nr at all, since
> > dw_pcie_host_init() always sets it.
> > 
> > Some other callers of dw_pcie_host_init() do set it:
> > 
> >   exynos_add_pcie_port()
> >   imx6_add_pcie_port()
> >   armada8k_add_pcie_port()
> >   artpec6_add_pcie_port()
> >   dw_plat_add_pcie_port()
> >   histb_pcie_probe()
> >   qcom_pcie_probe()
> >   spear13xx_add_pcie_port()
> > 
> > But I don't see *why* any of these need to set it.  If they don't need to
> > set it, they shouldn't.
> 
> Mostly it's a blind copy of unnecessary code.  I tested histb driver
> by dropping the line, and did not see anything broken.  I will cook up
> a series to remove the code from all above drivers, and copy
> corresponding driver owner to comment.

Thanks, Shawn, I really appreciate that!

> > And it would be nice if histb and qcom followed the structure and naming
> > conventions of the other drivers, i.e., they should have
> > histb_add_pcie_port() and qcom_add_pcie_port().
> 
> I can create a patch for histb driver, but will leave qcom one to
> Stanimir to decide.

Sounds good, thanks again!

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
