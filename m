Return-Path: <SRS0=vi1x=SO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81884C282CE
	for <linux-pci@archiver.kernel.org>; Fri, 12 Apr 2019 08:51:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5234D20818
	for <linux-pci@archiver.kernel.org>; Fri, 12 Apr 2019 08:51:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="L+zrl/lZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbfDLIvk (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 12 Apr 2019 04:51:40 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:48202 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726616AbfDLIvk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 Apr 2019 04:51:40 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x3C8pImV103252;
        Fri, 12 Apr 2019 03:51:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1555059078;
        bh=th70+twh7HkI/eIDcRitXYsgf4ynNKVisCSmCddN6vs=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=L+zrl/lZ3F50vWPCeYHB8UmvlFwqnWexxTqXZONmnyThzy5vv+MA5L2HLPnJYUcUS
         OlN0aEuZog9kJHkU6o/vWPyk8h3hnzzT4GXSJ1p1+3v/+tu4Zn3hvIdo8YvJTJWVMO
         GjEPOLsQkucVZ7LtI536fjjLD4PR1KpUIQ10I1As=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x3C8pIKW045018
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 12 Apr 2019 03:51:18 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 12
 Apr 2019 03:51:18 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 12 Apr 2019 03:51:18 -0500
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x3C8p9Yw035000;
        Fri, 12 Apr 2019 03:51:10 -0500
Subject: Re: [PATCH v3 12/26] PCI: keystone: Prevent ARM32 specific code to be
 compiled for ARM64
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-kernel@axis.com>, Minghuan Lian <minghuan.Lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>
References: <20190325093947.32633-1-kishon@ti.com>
 <20190325093947.32633-13-kishon@ti.com> <20190411150332.GC6862@red-moon>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <ee9d27e6-c653-4965-b552-3cf1ce5bdf51@ti.com>
Date:   Fri, 12 Apr 2019 14:20:06 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190411150332.GC6862@red-moon>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lorenzo,

On 11/04/19 8:33 PM, Lorenzo Pieralisi wrote:
> On Mon, Mar 25, 2019 at 03:09:33PM +0530, Kishon Vijay Abraham I wrote:
>> hook_fault_code is an ARM32 specific API for hooking into data abort.
>> Since pci-keystone.c will be used for AM65X platforms which is an
>> ARM64 platform,
> 
> Hi Kishon,
> 
> How is the problem plugged by the fault hook fixed on ARM64 ?

At least in AM654 platform, I don't see a bus error when PCIe device is not
connected but returns 0xffffffff. So there is no necessary for hook_fault_code
in AM654 platform.

Thanks
Kishon

> 
> Thanks,
> Lorenzo
> 
>> allow hook_fault_code to be compiled only for ARM32.
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>>  drivers/pci/controller/dwc/pci-keystone.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
>> index dfe54553d832..93296d434f40 100644
>> --- a/drivers/pci/controller/dwc/pci-keystone.c
>> +++ b/drivers/pci/controller/dwc/pci-keystone.c
>> @@ -710,6 +710,7 @@ static int ks_pcie_config_legacy_irq(struct keystone_pcie *ks_pcie)
>>  	return ret;
>>  }
>>  
>> +#ifdef CONFIG_ARM
>>  /*
>>   * When a PCI device does not exist during config cycles, keystone host gets a
>>   * bus error instead of returning 0xffffffff. This handler always returns 0
>> @@ -729,6 +730,7 @@ static int ks_pcie_fault(unsigned long addr, unsigned int fsr,
>>  
>>  	return 0;
>>  }
>> +#endif
>>  
>>  static int __init ks_pcie_init_id(struct keystone_pcie *ks_pcie)
>>  {
>> @@ -778,12 +780,14 @@ static int __init ks_pcie_host_init(struct pcie_port *pp)
>>  	if (ret < 0)
>>  		return ret;
>>  
>> +#ifdef CONFIG_ARM
>>  	/*
>>  	 * PCIe access errors that result into OCP errors are caught by ARM as
>>  	 * "External aborts"
>>  	 */
>>  	hook_fault_code(17, ks_pcie_fault, SIGBUS, 0,
>>  			"Asynchronous external abort");
>> +#endif
>>  
>>  	ks_pcie_start_link(pci);
>>  	dw_pcie_wait_for_link(pci);
>> -- 
>> 2.17.1
>>
