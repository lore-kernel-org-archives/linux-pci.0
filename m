Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:46316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732377AbeHFROK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 6 Aug 2018 13:14:10 -0400
Subject: Re: [PATCH v7 1/1] PCI: pciehp: Ignore link events when there is a
 fatal error pending
To: poza@codeaurora.org, Lukas Wunner <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Keith Busch <keith.busch@intel.com>,
        linux-pci-owner@vger.kernel.org
References: <20180805225136.5800-1-okaya@kernel.org>
 <20180805225136.5800-2-okaya@kernel.org>
 <c1cfff22c63f6d3d6285575721a2a3e8@codeaurora.org>
 <20180806092614.GA28462@wunner.de>
 <2b4c23a2e97f61a124c95c49d604a853@codeaurora.org>
From: Sinan Kaya <okaya@kernel.org>
Message-ID: <3d491f25-1d59-f257-1125-302e2d50e960@kernel.org>
Date: Mon, 6 Aug 2018 11:04:37 -0400
MIME-Version: 1.0
In-Reply-To: <2b4c23a2e97f61a124c95c49d604a853@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 8/6/2018 10:55 AM, poza@codeaurora.org wrote:
>>
> 
> Either AER or DPC would get triggered, not both.
> in that case, if AER is disabled, then this code will return false 
> thinking HP needs to handle it.
> but it might be that DPC would be triggering as well.
> but I dont see DPC check anywhere, rather we are relying on PCI_EXP_DEVSTA
> and following condition:
> if (!pdev->aer_cap)
>        return false;
> so here we dont check anything with respect to DPC capability (although 
> there is no such thing as dpc_cap)
> (except If I missed something)

That's true. We either need to go poll every single source (AER/DPC) for
an error or rely on the DEVSTA. For ease of implementation, I suggest
DEVSTA. Something like this:

+bool pcie_fatal_error_pending(struct pci_dev *pdev, u32 usrmask)
+{
+	u16 err_status = 0;
+	u32 status, mask, severity;
+	int rc;
+
+	if (!pci_is_pcie(pdev))
+		return false;
+
+	rc = pcie_capability_read_word(pdev, PCI_EXP_DEVSTA, &err_status);
+	if (rc)
+		return false;
+
+	if (!(err_status & PCI_EXP_DEVSTA_FED))
+		return false;
+	return true;
+}
