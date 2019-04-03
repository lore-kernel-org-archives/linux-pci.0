Return-Path: <SRS0=9zG9=SF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8EC3C4360F
	for <linux-pci@archiver.kernel.org>; Wed,  3 Apr 2019 13:36:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90B6A2075E
	for <linux-pci@archiver.kernel.org>; Wed,  3 Apr 2019 13:36:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="pZ8RyOJ3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbfDCNgV (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 3 Apr 2019 09:36:21 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:16398 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbfDCNgV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 Apr 2019 09:36:21 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ca4b6d90000>; Wed, 03 Apr 2019 06:36:25 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 03 Apr 2019 06:36:21 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 03 Apr 2019 06:36:21 -0700
Received: from [10.24.47.153] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 3 Apr
 2019 13:36:18 +0000
Subject: Re: [PATCH v4 0/5] PCI: dwc: Support remove
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>
CC:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Robin Murphy <robin.murphy@arm.com>
References: <20190329194750.265f6df6@xhacker.debian>
 <20190401134946.GA4722@e107981-ln.cambridge.arm.com>
X-Nvconfidentiality: public
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <aff1dc7f-1108-1df7-1ccb-11be08413e28@nvidia.com>
Date:   Wed, 3 Apr 2019 19:06:15 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190401134946.GA4722@e107981-ln.cambridge.arm.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1554298585; bh=C0oQ7FYIrJb0RBLM8r34YqTNLG1rc+1+fDNURJ0zZdQ=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=pZ8RyOJ31JvpJHEgduTQ+X1TvA10BMAhKQbSyCacJ80aQucnlJMI1QkfMgWZfJoRC
         NbYFN96AehjJRtnSlawsE1/DWWLR6C/YTquP1VHdRxLf9qIBCpTYuQzffI0Aehmmfh
         aJc5pbRdHsn+k5cJ8OXUvZxaNU5TBEXm51buwXmRzeaV4bf33D9slVmo6w5z5CFRhP
         NFaELlAGPHCsk83oI+Fxq9WTy6k+2kFUrMy7ii0LEWpx5WdtT5gNJcdAOIRSE+cgVP
         PB2eue4a6QKbgQ5pookLfqQNz7k48hHUfo0PeqsPMdiB9owBuODwP89PSHoBn1LwYO
         QT5XuU2WlKjrA==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Verified it with Tegra194 PCIe host controller driver, but had to do
EXPORT_SYMBOL_GPL() for a bunch of APIs.
I'll push changes to export all those APIs as part of Tegra194 PCIe driver patch series.

Thanks
Vidya Sagar

On 4/1/2019 7:20 PM, Lorenzo Pieralisi wrote:
> On Fri, Mar 29, 2019 at 11:55:36AM +0000, Jisheng Zhang wrote:
>> Currently, the PCI dwc host users don't support the remove, but nothing
>> prevent us from supporting it. To achieve this goal, we need to ensure
>> we can do necessary clean up work.
>>
>> Changes since v3:
>>    - add Gustavo's ACK to patch2, patch5
>>    - remove IS_ENABLED(CONFIG_PCI_MSI) check
>>
>> Changes since v2:
>>    - address all Gustavo's comments
>>    - add Gustavo's ACK to patch1, patch3, patch4
>>
>> Changes since v1:
>>    - address Bjorn's comments, I.E Capitalize, s/irq/IRQ/, s/msi/MSI/
>>
>>
>> Jisheng Zhang (5):
>>    PCI: dwc: Fix dw_pcie_free_msi() if msi_irq is invalid
>>    PCI: dwc: Free the page for MSI IRQ in dw_pcie_free_msi()
>>    PCI: dwc: Free MSI in the error code path of dw_pcie_host_init()
>>    PCI: dwc: Use devm_pci_alloc_host_bridge() to simplify the code
>>    PCI: dwc: Save root bus for driver remove
>>
>>   .../pci/controller/dwc/pcie-designware-host.c | 60 ++++++++++---------
>>   drivers/pci/controller/dwc/pcie-designware.h  |  2 +
>>   2 files changed, 34 insertions(+), 28 deletions(-)
>   
> Applied to pci/dwc for v5.2, thanks.
> 
> Lorenzo
> 

