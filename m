Return-Path: <SRS0=Mgic=SR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FC33C10F0E
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 15:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0D5A2147C
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 15:31:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="E6XhoTyT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbfDOPbc (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 15 Apr 2019 11:31:32 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:4640 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbfDOPbb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Apr 2019 11:31:31 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cb4a3c00000>; Mon, 15 Apr 2019 08:31:12 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 15 Apr 2019 08:31:31 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 15 Apr 2019 08:31:31 -0700
Received: from [10.24.70.150] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 15 Apr
 2019 15:31:20 +0000
Subject: Re: [PATCH 21/30] PCI: tegra: Add "pci" type check before parsing
 child device tree node
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     <bhelgaas@google.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <jonathanh@nvidia.com>,
        <lorenzo.pieralisi@arm.com>, <vidyas@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <20190411170355.6882-1-mmaddireddy@nvidia.com>
 <20190411170355.6882-22-mmaddireddy@nvidia.com> <20190415133715.GV29254@ulmo>
X-Nvconfidentiality: public
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
Message-ID: <059fd53c-8a53-be56-a5bc-393f37aae168@nvidia.com>
Date:   Mon, 15 Apr 2019 21:00:58 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190415133715.GV29254@ulmo>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1555342272; bh=szYz+7XTO0E12n6oXn6oO7zWIBKovUfepajt7hxqQB4=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:
         Content-Transfer-Encoding:Content-Language;
        b=E6XhoTyT9SBqxRJsqmVOBU8mZVujkU3LuKuUB4iz/MfrU54SR3gGWhUmX84ZPZizF
         ZQ1yq3mDXZnnIY+eomr35zkRfc4N/URYVrWTQb86BACLt7H6qvm0NVLKkpbUTeHAo+
         7XEnQOEntl6D9G7iT2sJFtv2Q+a9xw3gTFvMyxXFMUA9wxPKpZfmkPWdQzXcWkulrG
         VPaEdRqfUBDZTz4dUqWGv8WfQDoNZXKeTPIM1QkPEc30G34qVrEnI3Q6OhNUCoAaTf
         wc9RNZvKAQzl6Rohm4Vz6vzpOGaESAJ/n+xcSHPpdK0dvKJasKMI8701rZevt8gyEn
         Np7sOerj7/2FA==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 15-Apr-19 7:07 PM, Thierry Reding wrote:
> On Thu, Apr 11, 2019 at 10:33:46PM +0530, Manikanta Maddireddy wrote:
>> Each root port is added as a child device tree node of PCIe controller
>> node. These child nodes are parsed using open firmware PCI bus accessor
>> functions. If the child node is not of "pci" type then device tree
>> parsing fails. Add "pci" type check before parsing child device tree node.
>>
>> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
>> ---
>>  drivers/pci/controller/pci-tegra.c | 3 +++
>>  1 file changed, 3 insertions(+)
> Erm... what is the use-case that you're trying to support? Why would we
> ever have children nodes that are not of type "pci"?
>
> Thierry
In downstream kernel we have "prod-settings" node as one of the child nodes.
Even though we are not supporting this in upstream kernel, I believe this
check is good to have.

Manikanta
>> diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
>> index 8fdc7934d4c9..d08a63132c77 100644
>> --- a/drivers/pci/controller/pci-tegra.c
>> +++ b/drivers/pci/controller/pci-tegra.c
>> @@ -2197,6 +2197,9 @@ static int tegra_pcie_parse_dt(struct tegra_pcie *pcie)
>>  		unsigned int index;
>>  		u32 value;
>>  
>> +		if (!of_node_is_type(port, "pci"))
>> +			continue;
>> +
>>  		err = of_pci_get_devfn(port);
>>  		if (err < 0) {
>>  			dev_err(dev, "failed to parse address: %d\n", err);
>> -- 
>> 2.17.1
>>

