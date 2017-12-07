Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.47.9]:44548 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753676AbdLGPOb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Dec 2017 10:14:31 -0500
From: Joao Pinto <Joao.Pinto@synopsys.com>
To: Murali Karicheri <m-karicheri2@ti.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Minghuan Lian <minghuan.Lian@freescale.com>,
        Mingkai Hu <mingkai.hu@freescale.com>,
        "Roy Zang" <tie-fei.zang@freescale.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Niklas Cassel <niklas.cassel@axis.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        <Gustavo.Pimentel@synopsys.com>,
        linux-pci <linux-pci@vger.kernel.org>
Subject: Re-activate task to add MSI-X to pcie-designware
Message-ID: <647c9bb3-94f6-a138-fbde-e946c105d517@synopsys.com>
Date: Thu, 7 Dec 2017 15:14:22 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello to all,

I am sending this e-mail to request your opinion about the tasks needed to add
support for MSI-X for pcie-designware based solutions.

A few months ago I submited a patch-set that added support for MSI-X:

[v2,9/9] pci: remove limitation of the number of the available IRQs
https://patchwork.ozlabs.org/patch/771320/
[v2,8/9] pci: removing old irq api from pcie-designware
https://patchwork.ozlabs.org/patch/771360/
[v2,7/9] pci: keystone SoC driver adapted to new irq API
https://patchwork.ozlabs.org/patch/771361/
[v2,6/9] pci: qcom SoC driver adapted to new irq API
https://patchwork.ozlabs.org/patch/771362/
[v2,5/9] pci: generic PCIe DW driver adapted to new irq API
https://patchwork.ozlabs.org/patch/771365/
[v2,4/9] pci: artpec6 SoC driver adapted to new irq API
https://patchwork.ozlabs.org/patch/771364/
[v2,3/9] pci: imx6 SoC driver adapted to new irq API
https://patchwork.ozlabs.org/patch/771363/
[v2,2/9] pci: exynos SoC driver adapted to new irq API
https://patchwork.ozlabs.org/patch/771359/
[v2,1/9] pci: adding new irq api to pci-designware
https://patchwork.ozlabs.org/patch/771366/

The patch-set was globally accepted, but it broke the MSI mechanism for
Keystone, due to its specificity.

We are now going to resume this task and we would like to have your feedback
about our plan:

Task 1: Help TI to create a keystone_msi driver to isolate its custom msi mechanism
Task 2: Port the existing patches to the new kernel version (except the keystone
one)

If TI can do the keystone_msi implementation it would be easier. If it's not
possible, we volunteer to do it, but we will need testing & debug assistance.

I appreciate very much your attention and feedback.

Thanks and have a good day,
Joao Pinto
