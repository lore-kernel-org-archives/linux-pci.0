Return-Path: <SRS0=tMyV=2J=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53EBFC43603
	for <linux-pci@archiver.kernel.org>; Thu, 19 Dec 2019 12:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29842227BF
	for <linux-pci@archiver.kernel.org>; Thu, 19 Dec 2019 12:47:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="o68tTLPU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbfLSMrf (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 19 Dec 2019 07:47:35 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:59364 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726779AbfLSMre (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Dec 2019 07:47:34 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBJClSwY112282;
        Thu, 19 Dec 2019 06:47:28 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1576759648;
        bh=SogRC5gjBaf0iibZikKVZUfmnMdsVVFLcx/i8VXaKHw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=o68tTLPUKK9vljQTIfqHHwjgeK5n8xWdh+FmOUm/No6weITdPd+mzcs+ZsbkMwNnG
         u4j5tf3djDQvaQSI/auJKsuOJCYslcYR0cVtmDx5rxKM5GFWq5ZB42Lrh5qhjtSeva
         SNH1B3BHo56ATIdvWZNbc3ja5eEMLBKfZXWqqUyA=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBJClS2V081213;
        Thu, 19 Dec 2019 06:47:28 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 19
 Dec 2019 06:47:28 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 19 Dec 2019 06:47:28 -0600
Received: from [10.24.69.159] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBJClOWn125168;
        Thu, 19 Dec 2019 06:47:25 -0600
Subject: Re: [PATCH 05/13] PCI: cadence: Add read and write accessors to
 perform only 32-bit accesses
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Murray <andrew.murray@arm.com>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>
References: <20191217233651.GA3930@google.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <bf31d43f-6a58-c94c-b7d4-8f0ae97e9602@ti.com>
Date:   Thu, 19 Dec 2019 18:19:07 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191217233651.GA3930@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Andrew,

On 18/12/19 5:06 am, Bjorn Helgaas wrote:
> On Mon, Dec 09, 2019 at 02:51:39PM +0530, Kishon Vijay Abraham I wrote:
>> Certain platforms like TI's J721E allow only 32-bit register accesses.
>> Add read and write accessors to perform only 32-bit accesses in order to
>> support platfroms like TI's J721E.
> 
> s/platfroms/platforms/
> 
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>>  drivers/pci/controller/cadence/pcie-cadence.c | 40 +++++++++++++++++++
>>  drivers/pci/controller/cadence/pcie-cadence.h |  2 +
>>  2 files changed, 42 insertions(+)
>>
>> diff --git a/drivers/pci/controller/cadence/pcie-cadence.c b/drivers/pci/controller/cadence/pcie-cadence.c
>> index cd795f6fc1e2..de5b3b06f2d0 100644
>> --- a/drivers/pci/controller/cadence/pcie-cadence.c
>> +++ b/drivers/pci/controller/cadence/pcie-cadence.c
>> @@ -7,6 +7,46 @@
>>  
>>  #include "pcie-cadence.h"
>>  
>> +u32 cdns_pcie_read32(void __iomem *addr, int size)
>> +{
>> +	void __iomem *aligned_addr = PTR_ALIGN_DOWN(addr, 0x4);
>> +	unsigned int offset = (unsigned long)addr & 0x3;
>> +	u32 val = readl(aligned_addr);
>> +
>> +	if (!IS_ALIGNED((uintptr_t)addr, size)) {
>> +		pr_err("Invalid Address in function:%s\n", __func__);
> 
> It might be nice to have a hint about *why* it's invalid, e.g., the
> addr and size values.

Sure.

Thanks
Kishon
