Return-Path: <SRS0=yOQI=2O=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD193C2D0CF
	for <linux-pci@archiver.kernel.org>; Tue, 24 Dec 2019 08:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CE902071A
	for <linux-pci@archiver.kernel.org>; Tue, 24 Dec 2019 08:04:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="B0O2k2Wr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbfLXIEl (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 24 Dec 2019 03:04:41 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:48372 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfLXIEl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 24 Dec 2019 03:04:41 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBO84WQf044802;
        Tue, 24 Dec 2019 02:04:32 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1577174672;
        bh=1Ded6pvuMA3oMdmazX4/A7l0KSskT0kDg81kNM68v+Q=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=B0O2k2Wr9saFAaISz01NN4EwJZsrFCOh2m5F9hZDnD2YsjuYdtLRN5c+JPWn2R9sb
         7wduya7EG5lefJZ5YCtVDMq/9+2PmotsaEVzTpfl2iQs6TOkPAZ79k9Otr+mTolvFM
         iWnfa4fvzk4uA6k0A/r/u7b9XuQmWwyL9+WcsHEE=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xBO84WjW050928
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 24 Dec 2019 02:04:32 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 24
 Dec 2019 02:04:32 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 24 Dec 2019 02:04:32 -0600
Received: from [10.24.69.159] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBO84TMr013924;
        Tue, 24 Dec 2019 02:04:30 -0600
Subject: Re: [PATCH 09/13] dt-bindings: PCI: Add host mode dt-bindings for
 TI's J721E SoC
To:     Rob Herring <robh@kernel.org>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Murray <andrew.murray@arm.com>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>
References: <20191209092147.22901-1-kishon@ti.com>
 <20191209092147.22901-10-kishon@ti.com> <20191219000841.GA4251@bogus>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <fc145cbc-88f2-5ccb-5c20-4be1ac81fe25@ti.com>
Date:   Tue, 24 Dec 2019 13:36:25 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20191219000841.GA4251@bogus>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Rob,

On 19/12/19 5:38 AM, Rob Herring wrote:
> On Mon, Dec 09, 2019 at 02:51:43PM +0530, Kishon Vijay Abraham I wrote:
>> Add host mode dt-bindings for TI's J721E SoC.
>>
>> Cc: Rob Herring <robh+dt@kernel.org>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>>  .../bindings/pci/ti,j721e-pci-host.yaml       | 161 ++++++++++++++++++
>>  1 file changed, 161 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
>> new file mode 100644
>> index 000000000000..96184e1f419f
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
>> @@ -0,0 +1,161 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +# Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com/
>> +%YAML 1.2
>> +---
>> +$id: "http://devicetree.org/schemas/pci/ti,j721e-pci-host.yaml#"
>> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
>> +
>> +title: TI J721E PCI Host (PCIe Wrapper)
>> +
>> +maintainers:
>> +  - Kishon Vijay Abraham I <kishon@ti.com>
> 
> There's now a PCI bus schema. Reference it here:
> 
> allOf:
>   - $ref: "/schemas/pci/pci-bus.yaml#"
> 
>> +
>> +properties:
>> +  compatible:
>> +      enum:
>> +          - ti,j721e-pcie-host
> 
> Indentation.
> 
>> +
>> +  reg:
>> +    maxItems: 4
>> +
>> +  reg-names:
>> +    items:
>> +      - const: intd_cfg
>> +      - const: user_cfg
>> +      - const: reg
>> +      - const: cfg
>> +
>> +  ti,syscon-pcie-ctrl:
>> +    description: Phandle to the SYSCON entry required for configuring PCIe mode
>> +                 and link speed.
>> +    allOf:
>> +      - $ref: /schemas/types.yaml#/definitions/phandle
> 
> You can drop the 'allOf' here if there aren't more constraints.

Do you mean I don't have to include phandle schema here? I don't seem to
be able to include $ref without allOf.

Thanks
Kishon
