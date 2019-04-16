Return-Path: <SRS0=aMvC=SS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73411C10F13
	for <linux-pci@archiver.kernel.org>; Tue, 16 Apr 2019 13:31:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44315205ED
	for <linux-pci@archiver.kernel.org>; Tue, 16 Apr 2019 13:31:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="phFwp9ix"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbfDPNa7 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 16 Apr 2019 09:30:59 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:18011 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbfDPNa7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Apr 2019 09:30:59 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cb5d90f0001>; Tue, 16 Apr 2019 06:30:55 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 16 Apr 2019 06:30:58 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 16 Apr 2019 06:30:58 -0700
Received: from [10.24.45.163] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 16 Apr
 2019 13:30:53 +0000
Subject: Re: [PATCH V2 02/16] PCI/PME: Export pcie_pme_disable_msi() API
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     <bhelgaas@google.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <jonathanh@nvidia.com>, <kishon@ti.com>,
        <catalin.marinas@arm.com>, <will.deacon@arm.com>,
        <lorenzo.pieralisi@arm.com>, <jingoohan1@gmail.com>,
        <gustavo.pimentel@synopsys.com>, <mperttunen@nvidia.com>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <sagar.tv@gmail.com>
References: <1554407683-31580-1-git-send-email-vidyas@nvidia.com>
 <1554407683-31580-3-git-send-email-vidyas@nvidia.com>
 <20190411101657.GF4633@ulmo>
X-Nvconfidentiality: public
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <f47408e4-c02d-bd28-31f9-96b92be02df5@nvidia.com>
Date:   Tue, 16 Apr 2019 19:00:50 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190411101657.GF4633@ulmo>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1555421455; bh=Buo3FKJ+OrKPu0SzaKomyODYyh2t364y6qnHcREIcTM=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=phFwp9ixooO6oat7hX8787Pmy7LSg3uM6tqnEr/wWRwtJPIgj4aBs2P2pNG8WM3Sd
         VkQ//rz1V5VxYK5/EFYU4PDFwf/63Y0NLsso3IqQol5fudRP/3uxGDkkWGM6KQKRDb
         Cyzjj4TADJN7v5TUzNxE6ozeNpZ2olO9tMq6KI1IiEw0yEBgumTTjQYNdZmKlyZIHh
         GXODKoobsEYu31iMv+PyUNPvwb91nwBIaG265OxucVfUDQpQ2YAz1YoyC9enJhRoHA
         ehHWES8jYk0AuW6zh0hDSOBwoHfkgMaCeMOMPI0Ntd7+vsndHL+pa9lFx4PkyqivJX
         VJr0yt2L56eeQ==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 4/11/2019 3:46 PM, Thierry Reding wrote:
> On Fri, Apr 05, 2019 at 01:24:29AM +0530, Vidya Sagar wrote:
>> Export pcie_pme_disable_msi() API to enable drivers using this API be able to
>> build as loadable modules
>>
>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>> ---
>> Changes from [v1]:
>> * This is a new patch in v2 series
>>
>>   drivers/pci/pcie/pme.c     | 6 ++++++
>>   drivers/pci/pcie/portdrv.h | 5 +----
>>   2 files changed, 7 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/pci/pcie/pme.c b/drivers/pci/pcie/pme.c
>> index 54d593d10396..18e815c1e3c9 100644
>> --- a/drivers/pci/pcie/pme.c
>> +++ b/drivers/pci/pcie/pme.c
>> @@ -27,6 +27,12 @@
>>    */
>>   bool pcie_pme_msi_disabled;
>>   
>> +void pcie_pme_disable_msi(void)
>> +{
>> +	pcie_pme_msi_disabled = true;
>> +}
>> +EXPORT_SYMBOL_GPL(pcie_pme_disable_msi);
>> +
>>   static int __init pcie_pme_setup(char *str)
>>   {
>>   	if (!strncmp(str, "nomsi", 5))
>> diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
>> index 1d50dc58ac40..2be7b7e9a784 100644
>> --- a/drivers/pci/pcie/portdrv.h
>> +++ b/drivers/pci/pcie/portdrv.h
>> @@ -127,10 +127,7 @@ struct pci_dev;
>>   #ifdef CONFIG_PCIE_PME
>>   extern bool pcie_pme_msi_disabled;
>>   
>> -static inline void pcie_pme_disable_msi(void)
>> -{
>> -	pcie_pme_msi_disabled = true;
>> -}
>> +void pcie_pme_disable_msi(void);
>>   
>>   static inline bool pcie_pme_no_msi(void)
>>   {
> 
> Perhaps also export pcie_pme_no_msi()? That way you could get rid of the
> extern declaration of the pcie_pme_msi_disabled variable and make it
> static to drivers/pci/pcie/pme.c?
Agree. I'll take care of this in V3 patch series.

> 
> Thierry
> 

