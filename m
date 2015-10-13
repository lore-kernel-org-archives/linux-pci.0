Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:56875 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752350AbbJMLNJ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 13 Oct 2015 07:13:09 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Zhou Wang <wangzhou1@hisilicon.com>,
	Bjorn Helgaas <bhelgaas@google.com>, jingoohan1@gmail.com,
	pratyush.anand@gmail.com, linux@arm.linux.org.uk,
	thomas.petazzoni@free-electrons.com, gabriele.paoloni@huawei.com,
	lorenzo.pieralisi@arm.com, james.morse@arm.com,
	Liviu.Dudau@arm.com, jason@lakedaemon.net, robh@kernel.org,
	gabriel.fernandez@linaro.org, Minghuan.Lian@freescale.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	zhangjukuo@huawei.com, qiuzhenfa@hisilicon.com,
	liudongdong3@huawei.com, qiujiang@huawei.com, xuwei5@hisilicon.com,
	liguozhu@hisilicon.com, Kefeng Wang <wangkefeng.wang@huawei.com>,
	Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v10 4/6] PCI: hisi: Add PCIe host support for HiSilicon SoC Hip05
Date: Tue, 13 Oct 2015 13:12:12 +0200
Message-ID: <6336414.HvfCQcuT3Y@wuerfel>
In-Reply-To: <20151012213545.GA17479@localhost>
References: <1444445957-239522-1-git-send-email-wangzhou1@hisilicon.com> <1444445957-239522-5-git-send-email-wangzhou1@hisilicon.com> <20151012213545.GA17479@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Monday 12 October 2015 16:35:45 Bjorn Helgaas wrote:
> 
> > +{
> > +     u64 addr;
> > +     struct device_node *msi_node;
> > +     struct resource res;
> > +     struct device_node *np = pp->dev->of_node;
> > +     struct hisi_pcie *pcie = to_hisi_pcie(pp);
> > +
> > +     msi_node = of_parse_phandle(np, "msi-parent", 0);
> > +     if (!msi_node) {
> > +             dev_err(pp->dev, "failed to find msi-parent\n");
> > +             return -EINVAL;
> > +     }
> > +     of_address_to_resource(msi_node, 0, &res);
> 
> Does this use the "msi-parent" node in the same way as other drivers
> do?  I'm sure there must be other places where we extract struct
> resource information from an "msi-parent" node, but I don't see them.
> 
> I'm trying to verify that this isn't some kind of incompatible
> extension of the "msi-parent" property.  I cc'd Arnd and Rob (DT
> experts).

This is not ok, what this does is that it relies on a particular
implementation of the MSI controller and directly accesses its
registers.

Instead, it should reference only the msi irq domain and let the
driver for the MSI controller access the registers. Otherwise this
code has to be rewritten once the same PCI host code appears in
a machine that has a real GICv2m or GICv3.

	Arnd
