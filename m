Return-Path: <SRS0=Vy8e=QE=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32D40C282CB
	for <linux-pci@archiver.kernel.org>; Mon, 28 Jan 2019 05:02:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04A45217D8
	for <linux-pci@archiver.kernel.org>; Mon, 28 Jan 2019 05:02:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="S8BhtOZu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbfA1FCI (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 28 Jan 2019 00:02:08 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:55560 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbfA1FCI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Jan 2019 00:02:08 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0S51dxx030139;
        Sun, 27 Jan 2019 23:01:39 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1548651699;
        bh=XPjDlXvG3F0BiZ3mpuQAQvzcxWbKcbzD2ZGGw5Vhk/4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=S8BhtOZux8OFN8h0SoN5YzzMoHxGuu7hNDUeJN4DxrB8IOHR2sKc5yFL5F51Yt+AF
         WGOdEPoyJaOJf8cUMEQmCI6y30tnhV4fPgrqcih/Zgng/DtvdD6H2ZyDBT5MlKwNEb
         fiCjsuT5KMNYK/Kp5gyyOrdI6Ucb35Ko8Ih/5yck=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0S51db7103823
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 27 Jan 2019 23:01:39 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Sun, 27
 Jan 2019 23:01:39 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Sun, 27 Jan 2019 23:01:38 -0600
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0S51YDd013948;
        Sun, 27 Jan 2019 23:01:35 -0600
Subject: Re: [PATCH 00/15] PCI: endpoint: Cleanup EPC features
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Alan Douglas <adouglas@cadence.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Cyrille Pitchen <cyrille.pitchen@free-electrons.com>,
        Jia-Ju Bai <baijiaju1990@gmail.com>,
        <linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-rockchip@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20190107064148.10152-1-kishon@ti.com>
 <20190124145219.GD23362@e107981-ln.cambridge.arm.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <ae09e4e2-3015-f4c9-4b3c-093f30e9b508@ti.com>
Date:   Mon, 28 Jan 2019 10:31:03 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190124145219.GD23362@e107981-ln.cambridge.arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 24/01/19 8:22 PM, Lorenzo Pieralisi wrote:
> On Mon, Jan 07, 2019 at 12:11:33PM +0530, Kishon Vijay Abraham I wrote:
>> Hi Lorenzo,
>>
>> The Endpoint controller driver uses features member in 'struct pci_epc'
>> to advertise the list of supported features to the endpoint function
>> driver.
>>
>> There are a few shortcomings with this approach.
>>   *) Certain endpoint controllers support fixed size BAR (e.g. TI's
>>      AM654 uses Designware configuration with fixed size BAR). The
>>      size of each BARs cannot be passed to the endpoint function
>>      driver.
>>   *) Too many macros for handling EPC features.
>>      (EPC_FEATURE_NO_LINKUP_NOTIFIER, EPC_FEATURE_BAR_MASK,
>>       EPC_FEATURE_MSIX_AVAILABLE, EPC_FEATURE_SET_BAR,
>>       EPC_FEATURE_GET_BAR)
>>   *) Endpoint controllers are directly modifying struct pci_epc
>>      members. (I have plans to move struct pci_epc to
>>      drivers/pci/endpoint so that pci_epc members are referenced
>>      only by endpoint core).
>>
>> To overcome the above shortcomings, introduced pci_epc_get_features()
>> API, pci_epc_features structure and a ->get_features() callback.
>>
>> Also added a patch to set BAR flags in pci_epf_alloc_space and
>> remove it from pci-epf-test function driver.
>>
>> Tested on TI's DRA7xx platform.
> 
> Hi Kishon,
> 
> I have no major objections to this series but I would like to see some
> testing done in EP mode (on test platforms other than DRA7XX) to make
> sure it does not break anything.
> 
> Please do help Kishon get some testing done.

Please test v2 of this series please [1]

[1] -> https://www.spinics.net/lists/arm-kernel/msg699787.html

Thanks
Kishon

> 
> Thanks,
> Lorenzo
> 
>> Thanks
>> Kishon
>>
>> Kishon Vijay Abraham I (15):
>>   PCI: endpoint: Add new pci_epc_ops to get EPC features
>>   PCI: dwc: Add ->get_features() callback function in dw_pcie_ep_ops
>>   PCI: designware-plat: Populate ->get_features() dw_pcie_ep_ops
>>   PCI: pci-dra7xx: Populate ->get_features() dw_pcie_ep_ops
>>   PCI: rockchip: Populate ->get_features() dw_pcie_ep_ops
>>   PCI: cadence: Populate ->get_features() cdns_pcie_epc_ops
>>   PCI: endpoint: Add helper to get first unreserved BAR
>>   PCI: endpoint: Fix pci_epf_alloc_space to set correct MEM TYPE flags
>>   PCI: pci-epf-test: Remove setting epf_bar flags in function driver
>>   PCI: pci-epf-test: Do not allocate next BARs memory if current BAR is
>>     64Bit
>>   PCI: pci-epf-test: Use pci_epc_get_features to get EPC features
>>   PCI: cadence: Remove pci_epf_linkup from Cadence EP driver
>>   PCI: rockchip: Remove pci_epf_linkup from Rockchip EP driver
>>   PCI: designware-plat: Remove setting epc->features in Designware plat
>>     EP driver
>>   PCI: endpoint: Remove features member in struct pci_epc
>>
>>  drivers/pci/controller/dwc/pci-dra7xx.c       | 13 +++
>>  .../pci/controller/dwc/pcie-designware-ep.c   | 12 +++
>>  .../pci/controller/dwc/pcie-designware-plat.c | 17 +++-
>>  drivers/pci/controller/dwc/pcie-designware.h  |  1 +
>>  drivers/pci/controller/pcie-cadence-ep.c      | 25 +++---
>>  drivers/pci/controller/pcie-rockchip-ep.c     | 16 +++-
>>  drivers/pci/endpoint/functions/pci-epf-test.c | 80 ++++++++++---------
>>  drivers/pci/endpoint/pci-epc-core.c           | 52 ++++++++++++
>>  drivers/pci/endpoint/pci-epf-core.c           |  3 +
>>  include/linux/pci-epc.h                       | 30 +++++--
>>  10 files changed, 185 insertions(+), 64 deletions(-)
>>
>> -- 
>> 2.17.1
>>
