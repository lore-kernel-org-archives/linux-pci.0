Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([45.249.212.188]:8343 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750761AbdFSNUI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Jun 2017 09:20:08 -0400
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "bhelgaas@google.com" <bhelgaas@google.com>,
        Linuxarm <linuxarm@huawei.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "lukas@wunner.de" <lukas@wunner.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "liudongdong (C)" <liudongdong3@huawei.com>
Subject: RE: [PATCH v5 0/2] add MSI support for PCIe port services and DPC
 IRQ support
Date: Mon, 19 Jun 2017 13:19:45 +0000
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E40ACFEF0@FRAEML521-MBX.china.huawei.com>
References: <1495549439-10372-1-git-send-email-gabriele.paoloni@huawei.com>
 <20170617003716.GI11129@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20170617003716.GI11129@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn

[...]

++++++++++++++--
> ----------
> >  2 files changed, 50 insertions(+), 21 deletions(-)
> 
> Applied to pci/portdrv for v4.13, thanks!
> 
> I tweaked the PME/hotplug no-MSI logic in pcie_init_service_irqs()
> because I thought it was getting hard to read with the negations and
> conjunctions.  Please double-check to make sure I didn't break it.

liudongdong tested the patchset as reworked in your branch and it works
ok 

> 
> https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/log/?h=
> pci/portdrv
> 
> I also capitalized your name consistently, Gabriele :)

Many thanks, next time I should be consistent with myself :)

Cheers
Gab
