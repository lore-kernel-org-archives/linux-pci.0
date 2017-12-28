Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qk0-f182.google.com ([209.85.220.182]:38027 "EHLO
        mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750854AbdL1QN5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Dec 2017 11:13:57 -0500
Received: by mail-qk0-f182.google.com with SMTP id l19so15983712qke.5
        for <linux-pci@vger.kernel.org>; Thu, 28 Dec 2017 08:13:56 -0800 (PST)
From: "Jingoo Han" <jingoohan1@gmail.com>
To: "'Kishon Vijay Abraham I'" <kishon@ti.com>,
        "'Gustavo Pimentel'" <gustavo.pimentel@synopsys.com>,
        <marc.zyngier@arm.com>, <Joao.Pinto@synopsys.com>,
        <bhelgaas@google.com>
Cc: <linux-pci@vger.kernel.org>, <m-karicheri2@ti.com>,
        <thomas.petazzoni@free-electrons.com>,
        <minghuan.Lian@freescale.com>, <mingkai.hu@freescale.com>,
        <tie-fei.zang@freescale.com>, <hongxing.zhu@nxp.com>,
        <l.stach@pengutronix.de>, <niklas.cassel@axis.com>,
        <jesper.nilsson@axis.com>, <wangzhou1@hisilicon.com>,
        <gabriele.paoloni@huawei.com>, <svarbanov@mm-sol.com>,
        <nsekhar@ti.com>
References: <cover.1514455857.git.gustavo.pimentel@synopsys.com> <d814c419df5591f9170223d61388a0af746577c4.1514455857.git.gustavo.pimentel@synopsys.com> <10d22382-4914-da3b-a842-eb33693c7a83@ti.com>
In-Reply-To: <10d22382-4914-da3b-a842-eb33693c7a83@ti.com>
Subject: Re: [PATCH v3 7/9] pci: keystone SoC driver adapted to new irq API
Date: Thu, 28 Dec 2017 11:13:53 -0500
Message-ID: <000201d37ff6$dbdb6fb0$93924f10$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday, December 28, 2017 7:44 AM, Kishon Vijay Abraham I wrote:
> 
> Hi Gustavo,
> 
> On Thursday 28 December 2017 05:26 PM, Gustavo Pimentel wrote:
> > This patch adapts Keystone SoC specific driver to use the new interrupt
> api
> > available in pcie-designware. A new callback was added to
> dw_pcie_host_ops
> > to handle a specific Keystone function and msi_host_init callback is
> > changed to simplify the access to pci data structure for keystone all
> SoC
> > drivers that use the structure.
> >
> > Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> > ---
> > Change v1->v2:
> > - Removed hardcoded num_vectors configuration (now it is done in the
> core driver by default)
> > Change v2->v3:
> > -
> >
> >
> >
> >
> >
> >  drivers/pci/dwc/pci-keystone-dw.c      | 88
++---------------------------
> -----
> >  drivers/pci/dwc/pci-keystone.c         |  1 +
> >  drivers/pci/dwc/pci-keystone.h         |  4 +-
> >  drivers/pci/dwc/pci-layerscape.c       |  3 +-
> >  drivers/pci/dwc/pcie-designware-host.c | 19 ++++++--
> >  drivers/pci/dwc/pcie-designware.h      |  3 +-
> 
> The designware specific patches should be part of
> "[1/9] pci: adding new irq api to pci-designware"
> 
> Also layerscap is not related to $subject.

Yes, right.

To Gustavo,
Please split this patch to two patches. 

> 
> Thanks
> Kishon
