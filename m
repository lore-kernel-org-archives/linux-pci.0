Return-Path: <SRS0=gAuQ=QF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28D3EC282D0
	for <linux-pci@archiver.kernel.org>; Tue, 29 Jan 2019 10:20:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBF6321473
	for <linux-pci@archiver.kernel.org>; Tue, 29 Jan 2019 10:20:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="tb6+AX1B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbfA2KUw (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 29 Jan 2019 05:20:52 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:45900 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbfA2KUv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Jan 2019 05:20:51 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0TAKUWE058370;
        Tue, 29 Jan 2019 04:20:30 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1548757230;
        bh=Ws8cfEW/GdK3qAnIerup80pZ7QCUAQ/ikhsMVH1JYMg=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=tb6+AX1BmbjyH91s/hiKSJdzczG6BvCc1pWzl0eWbuYfAWdBAEQE8RZhUS5gVotO0
         aQbNfeOQrAHwfWdK12biUy6+fdpOWpwi3LBE6clpDMm5eM/pn/NrBAoYgSWbCq7Ffu
         h0mIWNNzMF0VsH4bIpNEfXbuzPRZDhtQCXDx0CLc=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0TAKTto091224
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 29 Jan 2019 04:20:29 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 29
 Jan 2019 04:20:29 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 29 Jan 2019 04:20:29 -0600
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0TAKNdi014159;
        Tue, 29 Jan 2019 04:20:24 -0600
Subject: Re: [PATCH 18/24] PCI: dwc: Fix dw_pcie_ep_find_capability to return
 correct capability offset
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     Jingoo Han <jingoohan1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-arm-kernel@axis.com" <linux-arm-kernel@axis.com>
References: <20190114132424.6445-1-kishon@ti.com>
 <20190114132424.6445-19-kishon@ti.com>
 <13501c15-8f3d-604b-c4fc-bde3fb208745@synopsys.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <a3c7458b-f8e8-1f02-116b-3e9f4fbf00f3@ti.com>
Date:   Tue, 29 Jan 2019 15:49:51 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <13501c15-8f3d-604b-c4fc-bde3fb208745@synopsys.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Gustavo,

On 29/01/19 2:55 PM, Gustavo Pimentel wrote:
> Hi Kishon,
> 
> On 14/01/2019 13:24, Kishon Vijay Abraham I wrote:
>> commit beb4641a787df79a ("PCI: dwc: Add MSI-X callbacks handler") while
>> adding MSI-X callback handler, introduced dw_pcie_ep_find_capability and
>> __dw_pcie_ep_find_next_cap for finding the MSI and MSIX capability.
>>
>> However if MSI or MSIX capability is the last capability (i.e there are
>> no additional items in the capabilities list and the Next Capability
>> Pointer is set to '0'), __dw_pcie_ep_find_next_cap will return '0'
>> even though MSI or MSIX capability may be present. This is because of
>> incorrect ordering of "next_cap_ptr" check. Fix it here.
>>
>> Fixes: beb4641a787df79a142 ("PCI: dwc: Add MSI-X callbacks handler")
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>>  drivers/pci/controller/dwc/pcie-designware-ep.c | 10 +++++-----
>>  1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
>> index d5144781005b..cd51b008858c 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
>> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
>> @@ -46,16 +46,19 @@ static u8 __dw_pcie_ep_find_next_cap(struct dw_pcie *pci, u8 cap_ptr,
>>  	u8 cap_id, next_cap_ptr;
>>  	u16 reg;
>>  
>> +	if (!cap_ptr)
>> +		return 0;
>> +
> 
> Supposedly this was already verified by the function that calls this one.

Right, with with this fix cap_ptr is checked only once. This being a recursive
function, it makes sense to have the check only here instead of once in the
calling function and once here.
> 
>>  	reg = dw_pcie_readw_dbi(pci, cap_ptr);
>> -	next_cap_ptr = (reg & 0xff00) >> 8;
>>  	cap_id = (reg & 0x00ff);
>>  
>> -	if (!next_cap_ptr || cap_id > PCI_CAP_ID_MAX)
>> +	if (cap_id > PCI_CAP_ID_MAX)
>>  		return 0;
>>  
>>  	if (cap_id == cap)
>>  		return cap_ptr;
>>  
>> +	next_cap_ptr = (reg & 0xff00) >> 8;
> 
> This fix seems to be a bit overdone, especially when you only need to swap the
> if blocks order to achieve the desired goal.

No, cap_id > PCI_CAP_ID_MAX is a base error case and it should checked before
returning the offset IMO.
> 
>>  	return __dw_pcie_ep_find_next_cap(pci, next_cap_ptr, cap);
>>  }
>>  
>> @@ -67,9 +70,6 @@ static u8 dw_pcie_ep_find_capability(struct dw_pcie *pci, u8 cap)
>>  	reg = dw_pcie_readw_dbi(pci, PCI_CAPABILITY_LIST);
>>  	next_cap_ptr = (reg & 0x00ff);
>>  
>> -	if (!next_cap_ptr)
>> -		return 0;
>> -
> 
> Why remove it?
> If pointer is null, why to jump to another function to check is the the same
> pointer is null?

so that we check cap_ptr only once.

Thanks
Kishon
