Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.126.93.86
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792479651;
	b=ME7Dg4ZwnfbvG4SfutUubcIe168KMeXQ8rOop+HEiPpoP8gh8zmt+54mZVXgeMkI0vbc
	 qg4lvpWV99TsCyQQC6L+IHYqdyoJpSASRF9qlBQ17jX2ciA/QT6FIGgSurbMpwxLmcECS
	 SxCsQXdD3LivAhdiTDHU6itSLApa3U/2nm7vgPeIY/X4nfLDW+K86l5hAhjL00MDvhJIz
	 JMr5Xv7BdVFrtBBA39pJrLEnKfkW7DkLPBZsLb0NIuMmRkkFEsPYEqAUBNjF6heCpuobz
	 HPUZXkgxXkyGeGFNygolohBxKd8vyZt8oqaFdWIGKWgdUDBsYOaMZskFtMPYzNMFAyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792479651;
	h=DMARC-Filter:Received:Message-ID:Date:MIME-Version:User-Agent:Cc:
	 Subject:To:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-HM-Tid:X-HM-MType:X-HM-Spam-Status:
	 DKIM-Signature;
	bh=thq2hHwoScZOEAaOI+/Pj/0+Ftp0dTMilGrkNQz0BRI=;
	b=hsoAKgUXwOX08sv6oKhY1HFAHfKDRo6C3uBUc/2nydjZfkPCpT6Gszz7kmpShGewumdg
	 sOeaGtwiElY7qdPthH07ZMVF0sOPjjzjcIZX5oVfwxWq1p18wSuNT1tJZZMGFc6CT4KzQ
	 8cSE4DSHaUwoBRPvMnYg1MhisLC+/6ljBtgdL/ZZPRRbo/824uSNJINiaP9z+xpkrB0iW
	 ZS3sMTrNB7hlRcgoGL2cl2TrM2T938bfE0wgCwq96NLo+z/fc0Gc3SpNRDCGl7/pinAO/
	 GT7wza0AS9FBZytlvTbpIg9vyecBEz6sBC2MdtF9T3ERrzsfxMo3XMA4fzsOR/tc3ZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rock-chips.com;
	spf=pass smtp.mailfrom=rock-chips.com;
	dkim=pass header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=EcFn7h41;
	arc=none smtp.remote-ip=103.126.93.86
Received: from mail-m9386.xmail.ntesmail.com (mail-m9386.xmail.ntesmail.com [103.126.93.86])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC22606A323;
	Tue, 20 Oct 2026 07:00:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2BC22606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=EcFn7h41
Received: from [172.16.12.48] (unknown [61.154.14.86])
	by smtp.qiye.163.com (Hmail) with ESMTP id 51ac91982;
	Tue, 20 Oct 2026 15:00:37 +0800 (GMT+08:00)
Message-ID: <55944278-6103-48e9-a664-c423a3a1ac7d@rock-chips.com>
Date: Tue, 20 Oct 2026 15:00:36 +0800
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Magnus Damm <magnus.damm@gmail.com>, Jingoo Han <jingoohan1@gmail.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Frank Li <Frank.Li@nxp.com>,
 Niklas Cassel <cassel@kernel.org>, Wilfred Mallawa
 <wilfred.mallawa@wdc.com>, Serge Semin <fancer.lancer@gmail.com>,
 linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 10/17] PCI: dwc: Free the MSI domain after the host
 .deinit() callback
To: Koichiro Den <den@valinux.co.jp>
References: <20261020031049.969895-1-den@valinux.co.jp>
 <20261020031049.969895-11-den@valinux.co.jp>
 <5f982595-f3b1-4d64-8b14-ad38dac2b3a1@rock-chips.com>
 <ghdrvrjbozm32y3o5m5vw6tl4l2tcep4ok4i6vtcvgbsbnb662@7katihdy32nl>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <ghdrvrjbozm32y3o5m5vw6tl4l2tcep4ok4i6vtcvgbsbnb662@7katihdy32nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa1581cb08803a4kunm2019d6b99427ab
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZHRgaVh0ZTRhCQh9NQ0xISlYVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
	9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=EcFn7h41IkuKtsA2NmzNlr+yyO4b6ET7hbAj7lfDF98u0/rT1nubNOyn4iPQ/ho6S1qG0SmYBGG5AMZlYHckFmbyuZYt8819P52eOVviHLE2VpK/guV/aPbQH19+GxWIQv1JVaNlebIqXKsycVAaXToCd89KcBezGSJyZTL9OMA=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=thq2hHwoScZOEAaOI+/Pj/0+Ftp0dTMilGrkNQz0BRI=;
	h=date:mime-version:subject:message-id:from;

在 2026/10/20 星期二 14:41, Koichiro Den 写道:
> On Tue, Oct 20, 2026 at 11:54:18AM +0800, Shawn Lin wrote:
>> Hi Koichiro
>>
>> 在 2026/10/20 星期二 11:10, Koichiro Den 写道:
>>> dw_pcie_host_deinit() frees the iMSI-RX domain before calling the host
>>> .deinit() callback. For a core-owned parent interrupt,
>>> dw_pcie_free_msi() removes the chained handler right before the domain.
>>> A glue driver that owns the parent interrupt and demultiplexes the MSIs
>>> itself through dw_handle_msi_irq() can only stop its handler in
>>> .deinit(), after the domain is gone, so a late interrupt can still
>>> dispatch into the freed domain.
>>>
>>
>> I think you need a rebase anyway since there are two patches touching
>> MSI irq naming stuff in pci-tree's next branch and will probably
>> show up in tommorow's linux-next.
> 
> Hi Shawn, thanks for the heads-up! And thanks for the review.
> 
>>
>> ...
>>
>>> +static void dw_pcie_free_msi_domain(struct dw_pcie_rp *pp)
>>> +{
>>>    	irq_domain_remove(pp->irq_domain);
>>> +	pp->irq_domain = NULL;
>>> +}
>>> +
>>> +void dw_pcie_free_msi(struct dw_pcie_rp *pp)
>>> +{
>>> +	dw_pcie_remove_msi_handlers(pp);
>>> +	dw_pcie_free_msi_domain(pp);
>>>    }
>>>    EXPORT_SYMBOL_GPL(dw_pcie_free_msi);
>>
>>
>> dw_pcie_free_msi() now calls freeing irq_domain unconditionally:
>>
>> The problem is that pcie-qcom.c uses the ECAM init path, which does not
>> go through dw_pcie_host_init(), and registers its own devres action,
>> see:
>> drivers/pci/controller/dwc/pcie-qcom.c:2034
>>       return devm_add_action_or_reset(dev, qcom_pci_free_msi, pp);
>>
>> drivers/pci/controller/dwc/pcie-qcom.c:1995
>>       static void qcom_pci_free_msi(void *ptr)
>>       {
>>              struct dw_pcie_rp *pp = (struct dw_pcie_rp *)ptr;
>>
>>              if (pp && pp->use_imsi_rx)
>>                      dw_pcie_free_msi(pp);
>>       }
>>
>> This leads to the following sequence:
>>
>>    1. dw_pcie_host_init() succeeds and pp->irq_domain is created;
>>    2. the driver is removed or probe fails, dw_pcie_host_deinit() calls
>>       dw_pcie_free_msi_domain() and sets pp->irq_domain to NULL;
>>    3. the devres action qcom_pci_free_msi() still holds the same pp and
>>       calls dw_pcie_free_msi(), which enters dw_pcie_free_msi_domain()
>>       again;
> 
> I'm a bit confused. Steps 1 and 2 here seem to describe the regular DWC path,
> but the devres action in step 3 looks like it's only registered in the
> firmware-managed ECAM path. I don't see where that path would call
> dw_pcie_host_deinit(). Am I missing something?
> 

My apologies for any confusion my earlier response may have caused. I
brought up qcom merely as an example of a driver managing the MSI IRQ
lifecycle with its own devres action, with a remove path that can go
through dw_pcie_host_deinit(). For such combinations the safe check I
suggested would matter, I intended this as a defensive improvement, not
necessarily implying a bug exists now.

> Best regards,
> Koichiro Den
> 
>>    4. irq_domain_remove(NULL) dereferences a NULL pointer and the kernel
>>       crashes.
>>
>>
>> So I suggest you to add a safe check if (!pp->irq_domain) before doing
>> that.
>>
>>
>>> @@ -633,7 +643,7 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
>>>    	ret = of_pci_get_equalization_presets(dev, &pp->presets, pci->num_lanes);
>>>    	if (ret)
>>> -		goto err_free_msi;
>>> +		goto err_deinit_host;
>>>    	/*
>>>    	 * Allocate the resource for MSG TLP before programming the iATU
>>> @@ -649,7 +659,7 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
>>>    	ret = dw_pcie_edma_detect(pci);
>>>    	if (ret)
>>> -		goto err_free_msi;
>>> +		goto err_deinit_host;
>>>    	ret = dw_pcie_setup_rc(pp);
>>>    	if (ret)
>>> @@ -686,14 +696,16 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
>>>    err_remove_edma:
>>>    	dw_pcie_edma_remove(pci);
>>> -err_free_msi:
>>> -	if (pp->use_imsi_rx)
>>> -		dw_pcie_free_msi(pp);
>>> -
>>>    err_deinit_host:
>>> +	if (pp->use_imsi_rx && pp->irq_domain)
>>> +		dw_pcie_remove_msi_handlers(pp);
>>> +
>>>    	if (pp->ops->deinit)
>>>    		pp->ops->deinit(pp);
>>> +	if (pp->use_imsi_rx && pp->irq_domain)
>>> +		dw_pcie_free_msi_domain(pp);
>>> +
>>>    err_free_ecam:
>>>    	if (pp->cfg)
>>>    		pci_ecam_free(pp->cfg);
>>> @@ -718,11 +730,14 @@ void dw_pcie_host_deinit(struct dw_pcie_rp *pp)
>>>    	dw_pcie_edma_remove(pci);
>>>    	if (pp->use_imsi_rx)
>>> -		dw_pcie_free_msi(pp);
>>> +		dw_pcie_remove_msi_handlers(pp);
>>>    	if (pp->ops->deinit)
>>>    		pp->ops->deinit(pp);
>>> +	if (pp->use_imsi_rx)
>>> +		dw_pcie_free_msi_domain(pp);
>>> +
>>>    	if (pp->cfg)
>>>    		pci_ecam_free(pp->cfg);
>>>    }
>>
> 

