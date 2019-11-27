Return-Path: <SRS0=kckM=ZT=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53E0FC432C0
	for <linux-pci@archiver.kernel.org>; Wed, 27 Nov 2019 08:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E64D2071E
	for <linux-pci@archiver.kernel.org>; Wed, 27 Nov 2019 08:23:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="q3UBmSxG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbfK0IXm (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 27 Nov 2019 03:23:42 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:51376 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbfK0IXm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Nov 2019 03:23:42 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id xAR8NSIX098777;
        Wed, 27 Nov 2019 02:23:28 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1574843008;
        bh=c3p+untF1DqNrT7u8zgrjYKfBj2PhnudxBIzqK/7Ssw=;
        h=Subject:From:To:CC:References:Date:In-Reply-To;
        b=q3UBmSxGuVraf7vXEpjmOGixV+UhQcS+sLztjkatVdN4cCq0q+fRG/GMRl8RbPobG
         pt4479mm0BMlCdOZx42BesnU68CvKXu3oaG2tAmStmiXtiQcIJd1pI0OKTYWf0W0iG
         aOHOlxTWqcPkiRVt96c/GWVVlZaaETb0+0Qzh6Yo=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xAR8NSpa041206
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 27 Nov 2019 02:23:28 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 27
 Nov 2019 02:23:28 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 27 Nov 2019 02:23:28 -0600
Received: from [10.24.69.157] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id xAR8NNBR024827;
        Wed, 27 Nov 2019 02:23:24 -0600
Subject: Re: [PATCH 2/4] PCI: endpoint: Add notification for core init
 completion
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Vidya Sagar <vidyas@nvidia.com>, <jingoohan1@gmail.com>,
        <gustavo.pimentel@synopsys.com>, <lorenzo.pieralisi@arm.com>,
        <andrew.murray@arm.com>, <bhelgaas@google.com>,
        <thierry.reding@gmail.com>
CC:     <Jisheng.Zhang@synaptics.com>, <jonathanh@nvidia.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <sagar.tv@gmail.com>
References: <20191113090851.26345-1-vidyas@nvidia.com>
 <20191113090851.26345-3-vidyas@nvidia.com>
 <122c1625-2075-d34a-80da-8b73a03096d3@ti.com>
Message-ID: <5ce04eb6-8afc-3248-4658-b191a0ef8012@ti.com>
Date:   Wed, 27 Nov 2019 13:52:42 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <122c1625-2075-d34a-80da-8b73a03096d3@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 27/11/19 1:48 PM, Kishon Vijay Abraham I wrote:
> Hi,
> 
> On 13/11/19 2:38 PM, Vidya Sagar wrote:
>> Add support to send notifications to EPF from EPC once the core
>> registers initialization is complete.
>>
>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>> ---
>>  drivers/pci/endpoint/pci-epc-core.c | 19 ++++++++++++++++++-
>>  include/linux/pci-epc.h             |  1 +
>>  include/linux/pci-epf.h             |  5 +++++
>>  3 files changed, 24 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
>> index 2f6436599fcb..fcc3f7fb19c0 100644
>> --- a/drivers/pci/endpoint/pci-epc-core.c
>> +++ b/drivers/pci/endpoint/pci-epc-core.c
>> @@ -542,10 +542,27 @@ void pci_epc_linkup(struct pci_epc *epc)
>>  	if (!epc || IS_ERR(epc))
>>  		return;
>>  
>> -	atomic_notifier_call_chain(&epc->notifier, 0, NULL);
>> +	atomic_notifier_call_chain(&epc->notifier, LINK_UP, NULL);
>>  }
>>  EXPORT_SYMBOL_GPL(pci_epc_linkup);
> 
> Is this based on upstream kernel? or did you create this after applying [1]?

never mind, you've mentioned this depends on my other series in your cover letter.

Thanks
Kishon
