Return-Path: <SRS0=vi1x=SO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 061D7C282CE
	for <linux-pci@archiver.kernel.org>; Fri, 12 Apr 2019 11:31:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BECF72084D
	for <linux-pci@archiver.kernel.org>; Fri, 12 Apr 2019 11:31:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="yNspnvg2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbfDLLbH (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 12 Apr 2019 07:31:07 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:38538 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbfDLLbG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 Apr 2019 07:31:06 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x3CBUm7j030254;
        Fri, 12 Apr 2019 06:30:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1555068648;
        bh=Y1rNB6oc6AGCC4SE/0j/FG0THzR6LL5wU9HWi6heXdg=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=yNspnvg29mP5Uyj/qlWhy2fWNRTDeTBe5w8kGLowHpe6Ncz9nIMyn/91XcnZ0d3qo
         ffL/JmcE5GkMOu4Z7nMKD6ts/MdoAl0RO98BFSIwL/924IG/L8JWmESZT1JgTyhZJU
         Py9XBooGN4mPSZGlm4K8jvKjtN8xLD1deabAP1Gc=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x3CBUm7c124471
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 12 Apr 2019 06:30:48 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 12
 Apr 2019 06:30:47 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 12 Apr 2019 06:30:47 -0500
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x3CBUdHC005527;
        Fri, 12 Apr 2019 06:30:41 -0500
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
 <ee9d27e6-c653-4965-b552-3cf1ce5bdf51@ti.com>
 <20190412111156.GE8113@red-moon>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <9cb169b1-577a-2345-d4b8-ddef4509f80c@ti.com>
Date:   Fri, 12 Apr 2019 16:59:36 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190412111156.GE8113@red-moon>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lorenzo,

On 12/04/19 4:41 PM, Lorenzo Pieralisi wrote:
> On Fri, Apr 12, 2019 at 02:20:06PM +0530, Kishon Vijay Abraham I wrote:
>> Hi Lorenzo,
>>
>> On 11/04/19 8:33 PM, Lorenzo Pieralisi wrote:
>>> On Mon, Mar 25, 2019 at 03:09:33PM +0530, Kishon Vijay Abraham I wrote:
>>>> hook_fault_code is an ARM32 specific API for hooking into data abort.
>>>> Since pci-keystone.c will be used for AM65X platforms which is an
>>>> ARM64 platform,
>>>
>>> Hi Kishon,
>>>
>>> How is the problem plugged by the fault hook fixed on ARM64 ?
>>
>> At least in AM654 platform, I don't see a bus error when PCIe device
>> is not connected but returns 0xffffffff. So there is no necessary for
>> hook_fault_code in AM654 platform.
> 
> That can't have much to do with ARM32<->ARM64, it is rather a platform
> integration issue AFAICS. Russell has a point, this has to be documented
> I can do it for you but I need additional information.

Right now only ARM32 exports hook_fault_code which was used by K2G (ARM32
platform) and since AM654 (ARM64 platform) uses the same driver, it'll result
in compilation error. Also AM654 doesn't require hook_fault_code (or something
similar) because it doesn't throw bus error on accessing PCIe address space
when PCI device is not connected).

Are you looking for some other information?

Thanks
Kishon
> 
> Thanks,
> Lorenzo
> 
>> Thanks
>> Kishon
>>
>>>
>>> Thanks,
>>> Lorenzo
>>>
>>>> allow hook_fault_code to be compiled only for ARM32.
>>>>
>>>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>>>> ---
>>>>  drivers/pci/controller/dwc/pci-keystone.c | 4 ++++
>>>>  1 file changed, 4 insertions(+)
>>>>
>>>> diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
>>>> index dfe54553d832..93296d434f40 100644
>>>> --- a/drivers/pci/controller/dwc/pci-keystone.c
>>>> +++ b/drivers/pci/controller/dwc/pci-keystone.c
>>>> @@ -710,6 +710,7 @@ static int ks_pcie_config_legacy_irq(struct keystone_pcie *ks_pcie)
>>>>  	return ret;
>>>>  }
>>>>  
>>>> +#ifdef CONFIG_ARM
>>>>  /*
>>>>   * When a PCI device does not exist during config cycles, keystone host gets a
>>>>   * bus error instead of returning 0xffffffff. This handler always returns 0
>>>> @@ -729,6 +730,7 @@ static int ks_pcie_fault(unsigned long addr, unsigned int fsr,
>>>>  
>>>>  	return 0;
>>>>  }
>>>> +#endif
>>>>  
>>>>  static int __init ks_pcie_init_id(struct keystone_pcie *ks_pcie)
>>>>  {
>>>> @@ -778,12 +780,14 @@ static int __init ks_pcie_host_init(struct pcie_port *pp)
>>>>  	if (ret < 0)
>>>>  		return ret;
>>>>  
>>>> +#ifdef CONFIG_ARM
>>>>  	/*
>>>>  	 * PCIe access errors that result into OCP errors are caught by ARM as
>>>>  	 * "External aborts"
>>>>  	 */
>>>>  	hook_fault_code(17, ks_pcie_fault, SIGBUS, 0,
>>>>  			"Asynchronous external abort");
>>>> +#endif
>>>>  
>>>>  	ks_pcie_start_link(pci);
>>>>  	dw_pcie_wait_for_link(pci);
>>>> -- 
>>>> 2.17.1
>>>>
