Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bmailout1.hostsharing.net ([83.223.95.100]:42733 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726865AbeHFLe1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Aug 2018 07:34:27 -0400
Date: Mon, 6 Aug 2018 11:26:14 +0200
From: Lukas Wunner <lukas@wunner.de>
To: poza@codeaurora.org
Cc: Sinan Kaya <okaya@kernel.org>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Keith Busch <keith.busch@intel.com>
Subject: Re: [PATCH v7 1/1] PCI: pciehp: Ignore link events when there is a
 fatal error pending
Message-ID: <20180806092614.GA28462@wunner.de>
References: <20180805225136.5800-1-okaya@kernel.org>
 <20180805225136.5800-2-okaya@kernel.org>
 <c1cfff22c63f6d3d6285575721a2a3e8@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <c1cfff22c63f6d3d6285575721a2a3e8@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 06, 2018 at 01:21:03PM +0530, poza@codeaurora.org wrote:
> On 2018-08-06 04:21, Sinan Kaya wrote:
> >+bool pcie_wait_fatal_error_clear(struct pci_dev *pdev, u32 usrmask)
> >+{
> >+	int timeout = 1000;
> >+	bool ret;
> >+
> >+	for (;;) {
> >+		ret = pcie_fatal_error_pending(pdev, usrmask);
> >+		if (ret == false)
> >+			return true;
> >+		if (timeout <= 0)
> >+			break;
> >+		msleep(20);
> >+		timeout -= 20;
> I assume that this timeout will come into effect if
> 1) AER/DPC takes longer time than 1 sec for recovery.
> 2) Lets us say both AER and DPC are disabled....are we going to wait for
> this timeout before HP can take over ?

If CONFIG_PCIEAER is disabled, pdev->aer_cap will not be set because
it is populated in pci_aer_init().

pcie_fatal_error_pending(), as introduced by this patch, returns false
if pdev->aer_cap is not set.  So pciehp will fall back to a cold reset
if CONFIG_PCIEAER is disabled.

I'm not seeing a similar check for CONFIG_PCIE_DPC=n in this patch,
but I'm not familiar enough with PCIe error recovery to know if such
a check is at all needed.

Thanks,

Lukas
