Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2699343B4BD;
	Mon, 21 Sep 2026 20:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790022310; cv=none; b=sVEMFwZysmqFe0VJOi+M2GCoszAqZShAXd75cc0EjRpH3k5vG5TNwyOG3JgzmHM6MR7zzCBE7JNE+JjywEmXFWb981iXITf/hqGFbGYx/dbyvX95Vh01HYyE0HFcZLHrahA9rRUp6DjEu6vRWz4PMkPzViFWgD4R43LlrXn1aQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790022310; c=relaxed/simple;
	bh=5aTX38hlAzLLBg7PQAMJ3viQM6pgFp+XJaTWYrtw7ig=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K8Qj1CjIkaEY8Rwc+6oyLJyLqNyTrmb3F0y4axrddBIbPntTDrmRPhYfphxNExnO4n9sDmXHXcdZtcQPn98TrBeWqLIim/yQdo2afiQ79HUunzmjUNt/5XKYUIKZjFMAg4G0ZV237giqAR4FITqhaGQJaBVPbisQippIX+7bp5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=QuEBpeOu; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="QuEBpeOu"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4hpZTq64Y3zMlQy;
	Mon, 21 Sep 2026 22:25:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1790022303;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dRzP3ENc6tuYZpq9SJzScYYWeAdwA1kasfQ0tDxWbZ0=;
	b=QuEBpeOuKwpwI2owvAPpi2sDUtIlmAI5oEYI6LHXnTxCxeNfHpEJ0cs3J6ZuX7qcuEk+Df
	UmMYYF6iECx5iLyqmLQKZqMs/rLRmzsgc/5BYhaxdry9efXniuye8wVkVoJ//7QS87fTax
	2V8zeCmCLCT8B8g0aStLxftktEpNonaEY+fVE3eZ8MyGJVgCy/P+O/CQe0lqVyjiW5w1lB
	HxcKbdgBlONGuFCbMzSxULf0FoJPpM6c3tGmz5fXU8p7DPCxztPIV0JfSMx6UxYIu8UWMg
	+LEnfKMN08OusujSt397i0pRdMdD6pCNwnQd9uMLUyK+sOnC3fPnTGIRyEOIqg==
Message-ID: <064d546b-faf9-4dfc-bdbe-f4ed787ac44e@mailbox.org>
Date: Mon, 21 Sep 2026 22:24:59 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 6/6] PCI: dwc: rcar-gen4: Add support for R-Car X5H
 PCIe4
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Conor Dooley <conor+dt@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Rob Herring <robh@kernel.org>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org
References: <20260905212649.360498-1-marek.vasut+renesas@mailbox.org>
 <20260905212649.360498-7-marek.vasut+renesas@mailbox.org>
 <ygec5dvolsujxmaxxjqnmusfj6shzszkiprlckbwqkdf6u6hc6@5sm6ayrfzkkm>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <ygec5dvolsujxmaxxjqnmusfj6shzszkiprlckbwqkdf6u6hc6@5sm6ayrfzkkm>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 94x7icccsnrx48j1podtih9k5tnwhtgc
X-MBO-RS-ID: 56bed019913caf2c494

On 9/21/26 6:03 PM, Manivannan Sadhasivam wrote:

Hello Manivannan,

>> +static int rcar_gen5_pcie_speed_control(struct rcar_gen4_pcie *rcar)
>> +{
>> +	struct dw_pcie *dw = &rcar->dw;
>> +	u32 lnkcap = dw_pcie_readl_dbi(dw, EXPCAP(PCI_EXP_LNKCAP));
>> +	u32 lnksta = dw_pcie_readw_dbi(dw, EXPCAP(PCI_EXP_LNKSTA));
>> +	u32 val, retries;
>> +
>> +	if ((lnksta & PCI_EXP_LNKSTA_CLS) == (lnkcap & PCI_EXP_LNKCAP_SLS))
>> +		return 0;
>> +
>> +	/* Retrain link */
>> +	val = dw_pcie_readw_dbi(dw, EXPCAP(PCI_EXP_LNKCTL));
>> +	val |= PCI_EXP_LNKCTL_RL;
>> +	dw_pcie_writew_dbi(dw, EXPCAP(PCI_EXP_LNKCTL), val);
>> +
>> +	/* Wait for link retrain */
>> +	for (retries = 0; retries <= 10; retries++) {
> 
> So this loop executes 11 times. Is that intented?

No, I don't think this is correct, or in fact sufficient. The training 
should poll for at least 100ms.

>> +		lnksta = dw_pcie_readw_dbi(dw, EXPCAP(PCI_EXP_LNKSTA));
>> +
>> +		/* Check retrain flag */
>> +		if (!(lnksta & PCI_EXP_LNKSTA_LT))
>> +			break;
>> +
>> +		usleep_range(1000, 1100);
> 
> What is the expected behavior if the Link retrain is not successfull? If it is
> safe to continue, shouldn't the users be warned atleast?

They should, I will be replacing this with this simpler option, which 
returns -ETIMEDOUT in case the training failed:

diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c 
b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
index a5feb73864c7f..7f4bda6a492ab 100644
--- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
+++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
@@ -183,7 +183,7 @@ static int rcar_gen5_pcie_speed_control(struct 
rcar_gen4_pcie *rcar)
         struct dw_pcie *dw = &rcar->dw;
         u32 lnkcap = dw_pcie_readl_dbi(dw, EXPCAP(PCI_EXP_LNKCAP));
         u32 lnksta = dw_pcie_readw_dbi(dw, EXPCAP(PCI_EXP_LNKSTA));
-       u32 val, retries;
+       u32 val;

         if ((lnksta & PCI_EXP_LNKSTA_CLS) == (lnkcap & PCI_EXP_LNKCAP_SLS))
                 return 0;
@@ -193,18 +193,10 @@ static int rcar_gen5_pcie_speed_control(struct 
rcar_gen4_pcie *rcar)
         val |= PCI_EXP_LNKCTL_RL;
         dw_pcie_writew_dbi(dw, EXPCAP(PCI_EXP_LNKCTL), val);

-       /* Wait for link retrain */
-       for (retries = 0; retries <= 10; retries++) {
-               lnksta = dw_pcie_readw_dbi(dw, EXPCAP(PCI_EXP_LNKSTA));
-
-               /* Check retrain flag */
-               if (!(lnksta & PCI_EXP_LNKSTA_LT))
-                       break;
-
-               usleep_range(1000, 1100);
-       }
-
-       return 0;
+       /* Wait for link retrain, 500ms must be enough for all link 
rates. */
+       return read_poll_timeout(dw_pcie_readw_dbi, lnksta, !(lnksta & 
PCI_EXP_LNKSTA_LT),
+                                1000, 5 * PCIE_RESET_CONFIG_WAIT_MS * 
USEC_PER_MSEC,
+                                false, dw, EXPCAP(PCI_EXP_LNKSTA));
  }

  /*

>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>   /*
>>    * Enable LTSSM of this controller and manually initiate the speed change.
>>    * Always return 0.
>> @@ -285,6 +322,49 @@ static int rcar_gen4_v4h_v4m_pcie_init(struct rcar_gen4_pcie *rcar)
>>   	return 0;
>>   }
>>   

[...]

>> +static int rcar_gen5_pcie_ltssm_control(struct rcar_gen4_pcie *rcar, bool enable)
>> +{
>> +	u32 val;
>> +
>> +	val = readl(rcar->base + PCIERSTCTRL1);
>> +	if (enable) {
>> +		val |= APP_LTSSM_ENABLE;
>> +		val &= ~APP_HOLD_PHY_RST;
>> +	} else {
>> +		val &= ~APP_LTSSM_ENABLE;
>> +		val |= APP_HOLD_PHY_RST;
>> +	}
>> +	writel(val, rcar->base + PCIERSTCTRL1);
>> +
>> +	if (enable)
>> +		phy_power_on(rcar->phy);
>> +	else
>> +		phy_power_off(rcar->phy);
> 
> It is quite unusual to handle PHY power on/off in the start_link() callback.
> Should this be moved to init/deinit callbacks?

This really has to be here, else the controller programming order does 
not follow the sequence in the SoC datasheet.
