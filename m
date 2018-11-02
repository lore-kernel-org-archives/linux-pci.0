Return-Path: <SRS0=VxNY=NN=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10401C65C22
	for <linux-pci@archiver.kernel.org>; Fri,  2 Nov 2018 07:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B29B20831
	for <linux-pci@archiver.kernel.org>; Fri,  2 Nov 2018 07:20:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B29B20831
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728040AbeKBQ0X (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 2 Nov 2018 12:26:23 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:48586 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727551AbeKBQ0X (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Nov 2018 12:26:23 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id wA27Jqv5064586;
        Fri, 2 Nov 2018 02:19:52 -0500
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wA27JqS5113150
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 2 Nov 2018 02:19:52 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 2 Nov
 2018 02:19:51 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 2 Nov 2018 02:19:51 -0500
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wA27Jl4C018108;
        Fri, 2 Nov 2018 02:19:47 -0500
Subject: Re: [RFC PATCH 13/40] dt-bindings: PCI: keystone: Add "reg-names"
 binding information
To:     Rob Herring <robh@kernel.org>
CC:     Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        <Gustavo.Pimentel@synopsys.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20180921102155.22839-1-kishon@ti.com>
 <20180921102155.22839-14-kishon@ti.com>
 <5baa1b0e.1c69fb81.4f57b.32f7@mx.google.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <ba9f2c1d-c1e0-b920-fdf1-22445fb6eb5a@ti.com>
Date:   Fri, 2 Nov 2018 12:49:22 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <5baa1b0e.1c69fb81.4f57b.32f7@mx.google.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Rob,

On 25/09/18 4:30 AM, Rob Herring wrote:
> On Fri, Sep 21, 2018 at 03:51:28PM +0530, Kishon Vijay Abraham I wrote:
>> Add "reg-names" binding information in order for device tree node
>> to be populated with the correct register strings.
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>>  Documentation/devicetree/bindings/pci/pci-keystone.txt | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/pci/pci-keystone.txt b/Documentation/devicetree/bindings/pci/pci-keystone.txt
>> index 2030ee0dc4f9..3a551687cfa2 100644
>> --- a/Documentation/devicetree/bindings/pci/pci-keystone.txt
>> +++ b/Documentation/devicetree/bindings/pci/pci-keystone.txt
>> @@ -12,8 +12,10 @@ described here as well as properties that are not applicable.
>>  Required Properties:-
>>  
>>  compatibility: "ti,keystone-pcie"
>> -reg:	index 1 is the base address and length of DW application registers.
>> -	index 2 is the base address and length of PCI device ID register.
>> +reg: Three register ranges as listed in the reg-names property
>> +reg-names: "dbics" for the DesignWare PCIe registers, "app" for the
>> +	   TI specific application registers, "config" for the
>> +	   configuration space address
> 
> This doesn't doesn't look like a compatible change.

The pcie-keystone driver hasn't worked in mainline because of lack of serdes
support. Since the same driver is used for am654 SoC (which has serdes support
included in this series), I'm trying to cleanup the binding.

Thanks
Kishon
