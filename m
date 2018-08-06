Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:40446 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727099AbeHFRFQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Aug 2018 13:05:16 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Mon, 06 Aug 2018 20:25:48 +0530
From: poza@codeaurora.org
To: Lukas Wunner <lukas@wunner.de>
Cc: Sinan Kaya <okaya@kernel.org>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Keith Busch <keith.busch@intel.com>,
        linux-pci-owner@vger.kernel.org
Subject: Re: [PATCH v7 1/1] PCI: pciehp: Ignore link events when there is a
 fatal error pending
In-Reply-To: <20180806092614.GA28462@wunner.de>
References: <20180805225136.5800-1-okaya@kernel.org>
 <20180805225136.5800-2-okaya@kernel.org>
 <c1cfff22c63f6d3d6285575721a2a3e8@codeaurora.org>
 <20180806092614.GA28462@wunner.de>
Message-ID: <2b4c23a2e97f61a124c95c49d604a853@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2018-08-06 14:56, Lukas Wunner wrote:
> On Mon, Aug 06, 2018 at 01:21:03PM +0530, poza@codeaurora.org wrote:
>> On 2018-08-06 04:21, Sinan Kaya wrote:
>> >+bool pcie_wait_fatal_error_clear(struct pci_dev *pdev, u32 usrmask)
>> >+{
>> >+	int timeout = 1000;
>> >+	bool ret;
>> >+
>> >+	for (;;) {
>> >+		ret = pcie_fatal_error_pending(pdev, usrmask);
>> >+		if (ret == false)
>> >+			return true;
>> >+		if (timeout <= 0)
>> >+			break;
>> >+		msleep(20);
>> >+		timeout -= 20;
>> I assume that this timeout will come into effect if
>> 1) AER/DPC takes longer time than 1 sec for recovery.
>> 2) Lets us say both AER and DPC are disabled....are we going to wait 
>> for
>> this timeout before HP can take over ?
> 
> If CONFIG_PCIEAER is disabled, pdev->aer_cap will not be set because
> it is populated in pci_aer_init().
> 
> pcie_fatal_error_pending(), as introduced by this patch, returns false
> if pdev->aer_cap is not set.  So pciehp will fall back to a cold reset
> if CONFIG_PCIEAER is disabled.
> 
> I'm not seeing a similar check for CONFIG_PCIE_DPC=n in this patch,
> but I'm not familiar enough with PCIe error recovery to know if such
> a check is at all needed.
> 

Either AER or DPC would get triggered, not both.
in that case, if AER is disabled, then this code will return false 
thinking HP needs to handle it.
but it might be that DPC would be triggering as well.
but I dont see DPC check anywhere, rather we are relying on 
PCI_EXP_DEVSTA
and following condition:
if (!pdev->aer_cap)
       return false;
so here we dont check anything with respect to DPC capability (although 
there is no such thing as dpc_cap)
(except If I missed something)

> Thanks,
> 
> Lukas
