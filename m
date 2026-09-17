Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E647A38F65B;
	Thu, 17 Sep 2026 03:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789615557; cv=none; b=RkqEuECwufv7CR8E2neoQmQqwO8wEvq8Oym5NKADRlRo2FNYMaqsaXxlK+Y12W5N5+XWisWB2sglA/Q+0WCDjLAu3b+40LsVhM5mHBs7YiNKTSRZO/uIt02GjI4JSlNchaRdx9k00WzUaiFyl1IlYBprWm5PtFzlEoU9y4kQCIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789615557; c=relaxed/simple;
	bh=JEOoVifFVQMutCzbtfWI8jC/mZ+9cwj85H663L5mpD8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k1QY5NWz3ZZ9xz3sqmk45s8ve6zFvlAPo9c9C4UkbY2afzjrA3xabNqnAb2zrzy0vuMEgQLCdUzrDxEGiTLGUuA3uel7y95Wp3cOivlS6vVqAvF4RWGLbH9BdSo2OWS1XOdHbBwZY52dGzqZBd2Y+Q8mLbTquDociA8lCTX1ijE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 79cf1424b24711f19a56ed5b684f684d-20260917
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:207d48ca-5de2-4f92-816c-75fd6229f8cb,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:d1ef7e50752c1ad0c3c8568be5f83d39,BulkI
	D:nil,BulkQuantity:0,SF:80|81|82|83|102|865|898,TC:nil,Content:0|15|52|99,
	EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 79cf1424b24711f19a56ed5b684f684d-20260917
X-User: lilinmao@kylinos.cn
Received: from [10.0.2.15] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <lilinmao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 244453343; Thu, 17 Sep 2026 11:25:48 +0800
Message-ID: <80bbc457-671f-4374-bc87-6671e4930a7e@kylinos.cn>
Date: Thu, 17 Sep 2026 11:25:44 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI: cadence: Store the core controller in platform
 drvdata
To: Aksh Garg <a-garg7@ti.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Tom Joseph <tjoseph@cadence.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260915082826.4135665-1-lilinmao@kylinos.cn>
 <1789614322740341.344.seg@mailgw.kylinos.cn>
From: Linmao Li <lilinmao@kylinos.cn>
In-Reply-To: <1789614322740341.344.seg@mailgw.kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2026/9/16 18:38, Aksh Garg 写道:
>
>
> On 15/09/26 13:58, Linmao Li wrote:
>> cdns_plat_pcie_probe() stores a struct cdns_plat_pcie pointer with
>> platform_set_drvdata(). cdns_plat_pcie_shutdown() and the callbacks in
>> cdns_pcie_pm_ops retrieve the same pointer with dev_get_drvdata() and
>> use it as a struct cdns_pcie pointer. This makes them read phy_count
>> and phy beyond the wrapper.
>>
>> struct cdns_plat_pcie only contains a pointer to struct cdns_pcie. Drop
>> the redundant wrapper and store the struct cdns_pcie pointer directly.
>>
>> Fixes: bd22885aa188 ("PCI: cadence: Refactor driver to use as a core 
>> library")
>> Suggested-by: Aksh Garg <a-garg7@ti.com>
>> Signed-off-by: Linmao Li <lilinmao@kylinos.cn>
>> ---
>
> Suggested-by tag can be dropped IMO as the suggestion was not the core 
> insight of the patch (to store the struct cdns_pcie pointer directly).
>
> Reviewed-by: Aksh Garg <a-garg7@ti.com>
>
> Regards,
> Aksh Garg

Agreed, please drop the Suggested-by tag when applying. Happy to resend 
a v3 with it removed if that's preferred.

Thanks,
Linmao

>
>> Changes in v2:
>> - Drop the redundant struct cdns_plat_pcie wrapper (Aksh Garg).
>> ---
>>   .../controller/cadence/pcie-cadence-plat.c    | 27 ++++++-------------
>>   1 file changed, 8 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/pci/controller/cadence/pcie-cadence-plat.c 
>> b/drivers/pci/controller/cadence/pcie-cadence-plat.c
>> index 13edc6be21f5..4a24302cc5b2 100644
>> --- a/drivers/pci/controller/cadence/pcie-cadence-plat.c
>> +++ b/drivers/pci/controller/cadence/pcie-cadence-plat.c
>> @@ -14,14 +14,6 @@
>>     #define CDNS_PLAT_CPU_TO_BUS_ADDR    0x0FFFFFFF
>>   -/**
>> - * struct cdns_plat_pcie - private data for this PCIe platform driver
>> - * @pcie: Cadence PCIe controller
>> - */
>> -struct cdns_plat_pcie {
>> -    struct cdns_pcie        *pcie;
>> -};
>> -
>>   static const struct of_device_id cdns_plat_pcie_of_match[];
>>     static u64 cdns_plat_cpu_addr_fixup(struct cdns_pcie *pcie, u64 
>> cpu_addr)
>> @@ -36,9 +28,9 @@ static const struct cdns_pcie_ops cdns_plat_ops = {
>>   static int cdns_plat_pcie_probe(struct platform_device *pdev)
>>   {
>>       const struct cdns_plat_pcie_of_data *data;
>> -    struct cdns_plat_pcie *cdns_plat_pcie;
>>       struct device *dev = &pdev->dev;
>>       struct pci_host_bridge *bridge;
>> +    struct cdns_pcie *pcie;
>>       struct cdns_pcie_ep *ep;
>>       struct cdns_pcie_rc *rc;
>>       bool is_rc;
>> @@ -51,11 +43,6 @@ static int cdns_plat_pcie_probe(struct 
>> platform_device *pdev)
>>       is_rc = data->is_rc;
>>         pr_debug(" Started %s with is_rc: %d\n", __func__, is_rc);
>> -    cdns_plat_pcie = devm_kzalloc(dev, sizeof(*cdns_plat_pcie), 
>> GFP_KERNEL);
>> -    if (!cdns_plat_pcie)
>> -        return -ENOMEM;
>> -
>> -    platform_set_drvdata(pdev, cdns_plat_pcie);
>>       if (is_rc) {
>>           if (!IS_ENABLED(CONFIG_PCIE_CADENCE_PLAT_HOST))
>>               return -ENODEV;
>> @@ -67,9 +54,9 @@ static int cdns_plat_pcie_probe(struct 
>> platform_device *pdev)
>>           rc = pci_host_bridge_priv(bridge);
>>           rc->pcie.dev = dev;
>>           rc->pcie.ops = &cdns_plat_ops;
>> -        cdns_plat_pcie->pcie = &rc->pcie;
>> +        pcie = &rc->pcie;
>>   -        ret = cdns_pcie_init_phy(dev, cdns_plat_pcie->pcie);
>> +        ret = cdns_pcie_init_phy(dev, pcie);
>>           if (ret) {
>>               dev_err(dev, "failed to init phy\n");
>>               return ret;
>> @@ -94,9 +81,9 @@ static int cdns_plat_pcie_probe(struct 
>> platform_device *pdev)
>>             ep->pcie.dev = dev;
>>           ep->pcie.ops = &cdns_plat_ops;
>> -        cdns_plat_pcie->pcie = &ep->pcie;
>> +        pcie = &ep->pcie;
>>   -        ret = cdns_pcie_init_phy(dev, cdns_plat_pcie->pcie);
>> +        ret = cdns_pcie_init_phy(dev, pcie);
>>           if (ret) {
>>               dev_err(dev, "failed to init phy\n");
>>               return ret;
>> @@ -114,13 +101,15 @@ static int cdns_plat_pcie_probe(struct 
>> platform_device *pdev)
>>               goto err_init;
>>       }
>>   +    platform_set_drvdata(pdev, pcie);
>> +
>>       return 0;
>>      err_init:
>>    err_get_sync:
>>       pm_runtime_put_sync(dev);
>>       pm_runtime_disable(dev);
>> -    cdns_pcie_disable_phy(cdns_plat_pcie->pcie);
>> +    cdns_pcie_disable_phy(pcie);
>>         return ret;
>>   }
>>
>> base-commit: 9a9d18547ddc97a73d5d90cff4d5aef90bd8c15d
