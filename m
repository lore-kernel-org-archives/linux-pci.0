Return-Path: <SRS0=FU33=H6=huawei.com=chenyao11@kernel.org>
Return-Path: <SRS0=FU33=H6=huawei.com=chenyao11@kernel.org>
From: "chenyao (F)" <chenyao11@huawei.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: songxiaowei <songxiaowei@hisilicon.com>, Wangbinghui
	<wangbinghui@hisilicon.com>, "lorenzo.pieralisi@arm.com"
	<lorenzo.pieralisi@arm.com>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"xuwei (O)" <xuwei5@huawei.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>, "catalin.marinas@arm.com"
	<catalin.marinas@arm.com>, "will.deacon@arm.com" <will.deacon@arm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, Suzhuangluan <suzhuangluan@hisilicon.com>,
	Kongfei <kongfei@hisilicon.com>, "dimitrysh@google.com"
	<dimitrysh@google.com>, "guodong.xu@linaro.org" <guodong.xu@linaro.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>, Tejun Heo <tj@kernel.org>
Subject: RE: [PATCH v2 1/2] PCI: kirin: Add MSI support
Date: Fri, 11 May 2018 08:30:59 +0000
Message-ID: <1F615B5A909C3342A3B7B4843796B9151C35E2A4@dggemi502-mbs.china.huawei.com>
References: <1525854012-24228-1-git-send-email-chenyao11@huawei.com>
 <1525854012-24228-2-git-send-email-chenyao11@huawei.com>
 <20180510140431.GJ173327@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20180510140431.GJ173327@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

>=20
> [+cc Tejun, Wolfram]
>=20
> On Wed, May 09, 2018 at 04:20:11PM +0800, Yao Chen wrote:
> > Add support for MSI.
> > ...
>=20
> > @@ -448,6 +467,26 @@ static int kirin_pcie_host_init(struct pcie_port
> > *pp)  static int __init kirin_add_pcie_port(struct dw_pcie *pci,
> >  				      struct platform_device *pdev)  {
> > +	int ret;
> > +
> > +	if (IS_ENABLED(CONFIG_PCI_MSI)) {
> > +		pci->pp.msi_irq =3D platform_get_irq(pdev, 0);
> > +		if (!pci->pp.msi_irq) {
>=20
> I think this test is incorrect.  platform_get_irq() returns a negative er=
rno
> value when it fails.  Most calls test "irq < 0" to check for failure.
>=20
> There's a lot of duplicated code like this, so maybe we should consider
> putting that check into devm_request_irq(), similar to what
> devm_ioremap_resource() does, so the driver code could look like this:
>=20
>   pci->pp.msi_irq =3D platform_get_irq(pdev, 0);
>   ret =3D devm_request_irq(&pdev->dev, pci->pp.msi_irq, ...);
>   if (ret) {
>     dev_err(&pdev->dev, "failed to request MSI IRQ\n");
>     return ret;
>   }
>=20
> The basic devm_ioremap_resource() motivation is here: 72f8c0bfa0de ("lib:
> devres: add convenience function to remap a resource") and the same
> considerations seem to apply here.
>=20
> But that's more than you need to do for *this* series.  So for now, I wou=
ld
> simply fix the test to check for "irq < 0" and update the messages as I
> mention below.

Thank you for pointing out my mistake.  I'll fix it.

>=20
> > +			dev_err(&pdev->dev, "failed to get msi irq[%d]\n",
> > +				pci->pp.msi_irq);
> > +			return -ENODEV;
> > +		}
> > +		ret =3D devm_request_irq(&pdev->dev, pci->pp.msi_irq,
> > +				       kirin_pcie_msi_irq_handler,
> > +				       IRQF_SHARED | IRQF_NO_THREAD,
> > +				       "kirin_pcie_msi", &pci->pp);
> > +		if (ret) {
> > +			dev_err(&pdev->dev, "failed to request msi
> irq[%d]\n",
>=20
> s/msi irq/MSI IRQ/ in both dev_err() messages above.  This is because the
> message is English text (not code), and the convention is that non-words =
like
> these initialisms written in all caps.
>=20
> I would style the first one as "failed to get MSI IRQ (%d)" because the %=
d
> there is a return code, probably -ENXIO.
>=20
> The second one should be "failed to request MSI IRQ %d" because here
> the %d is the actual IRQ.
>=20

I'll fix it. Thanks again.

> > +				pci->pp.msi_irq);
> > +			return ret;
> > +		}
> > +	}
> > +
> >  	pci->pp.ops =3D &kirin_pcie_host_ops;
> >
> >  	return dw_pcie_host_init(&pci->pp);
> > --
> > 1.9.1
> >

Best regards,
Yao
