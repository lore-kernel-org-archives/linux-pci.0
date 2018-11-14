Return-Path: <SRS0=Q3Ib=NZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E1A3C43441
	for <linux-pci@archiver.kernel.org>; Wed, 14 Nov 2018 04:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F4DF2145D
	for <linux-pci@archiver.kernel.org>; Wed, 14 Nov 2018 04:31:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F4DF2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wwwdotorg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbeKNOcq (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 14 Nov 2018 09:32:46 -0500
Received: from avon.wwwdotorg.org ([104.237.132.123]:43174 "EHLO
        avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726610AbeKNOcp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Nov 2018 09:32:45 -0500
Received: from [192.168.101.41] (50-76-47-61-ip-static.hfc.comcastbusiness.net [50.76.47.61])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by avon.wwwdotorg.org (Postfix) with ESMTPSA id 7B80F1C00E3;
        Tue, 13 Nov 2018 21:31:15 -0700 (MST)
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.100.2 at avon.wwwdotorg.org
Subject: Re: [PATCH] PCI: designware: don't hard-code DBI/ATU offset
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Vidya Sagar <vidyas@nvidia.com>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>,
        Stephen Warren <swarren@nvidia.com>
References: <20181112225710.29557-1-swarren@wwwdotorg.org>
 <ce3ac825-c05b-c782-81ba-dad0acc8d3c8@synopsys.com>
From:   Stephen Warren <swarren@wwwdotorg.org>
Openpgp: preference=signencrypt
Autocrypt: addr=swarren@wwwdotorg.org; prefer-encrypt=mutual; keydata=
 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
 93UTmhOymgekufw=
Message-ID: <87acc658-489a-6b8f-44cb-f9fbad3297a3@wwwdotorg.org>
Date:   Tue, 13 Nov 2018 20:31:14 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <ce3ac825-c05b-c782-81ba-dad0acc8d3c8@synopsys.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/12/18 9:19 PM, Gustavo Pimentel wrote:
> Hi Stephen,
> 
> I'd suggest to change the designware on the patch name by dwc and use another
> description for the patch instead of don't hard-code DBI/ATU offset.

What issue do you see with the patch description? I believe it's
correct/accurate. Perhaps the confusion is due to the question you
raised below; see my answer there.

> On 12/11/2018 22:57, Stephen Warren wrote:
>> From: Stephen Warren <swarren@nvidia.com>
>>
>> The DWC PCIe core contains various separate register spaces: DBI, DBI2,
>> ATU, DMA, etc. The relationship between the addresses of these register
>> spaces is entirely determined by the implementation of the IP block, not
>> by the IP block design itself. Hence, the DWC driver must not make
>> assumptions that one register space can be accessed at a fixed offset from
>> any other register space. To avoid such assumptions, introduce an
>> explicit/separate register pointer for the ATU register space. In
>> particular, the current assumption is not valid for NVIDIA's T194 SoC.
> 
> If I understood this patch correctly, you basically replace the dbi_base offset
> by atu_base offset that still depends of dbi_base offset.

That's not what the patch does.

The patch leaves most DBI accesses still using dbi_base, but updates
just a few accesses to use atu_base. Thus, after the patch, all accesses
use the correct base address for the register being accessed.

There is a default value supplied for atu_base, which does indeed depend
on dbi_base. This maintains backwards compatibility, so that all the
existing drivers don't need to be updated to explicitly set atu_base,
and will continue to use the existing offset between DBI and ATU base.

In the future, we'll send a driver for the NVIDIA Tegra SoC which does
explicitly set atu_base to a non-default value.

> I agree the code is
> now more readable, but I'm not seeing it by applying this patch what is the
> benefit since you are not allowing to change the current atu_base. I though that
> was the propose of this patch.

atu_base may be set by the implementation-specific driver before calling
dw_pcie_ep_init(), or the host controller equivalent.

>> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h

>> -#define PCIE_GET_ATU_OUTB_UNR_REG_OFFSET(region)	\
>> -			((0x3 << 20) | ((region) << 9))
>> +#define PCIE_GET_ATU_OUTB_UNR_REG_OFFSET(region) \
>> +		((region) << 9)
> 
> I'd suggest to remove the parenthesis around the region variable, like this:
> (region << 9)

Note that this is a pre-existing issue, and not caused/influenced by
this patch. The existing code is correct though; it's best practice to
always bracket all macro parameters, so that if the expression passed to
the macro contains operators, the macro implementation can guarantee the
correct calculation bracketing.
