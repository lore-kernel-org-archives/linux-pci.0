Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795193750;
	b=GZ6W87mIsDiAf/J5AiCrG9IcaeHgkwpoE8I40Q725K2agWwnyweJCjqDsS3MAJ165X+X
	 E+EB78AfmOGlmS2WpxuYNSOCYOIMCyIY8pSXDNMvMs/zkjxhy16j6l1b3cT9La/ylOwSF
	 oJPSj4fBA0LFtkbKauisfOreockC8f1W9W2/5oFdinP2fce7oyc8xxriXp+xl8NaAMjDY
	 IIdXe66gBuG1Rr+Lh/swSBj29VYo7AGWFSxn+LsXMYWZhUn7+/VKiI4hhw2E8CLhDoG6b
	 WaHbzjIOv/8zpH2oVZdrCd1Cs9ncGlAu98s/mEXHcyGDab+aPZipN/bR6W7IfymlvUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795193750;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=6XgHblxXTExitsxzkgHnfiFBSj/eKxbMVA10iAl9NaI=;
	b=K4wb3PjObvZzyWNZZJZpAFjQAv2eTNHFIblIfegEy2x7pkn2DNNwd+XxVbfxGDwZLfWu
	 8QLwD2BlZMyyz5EH+WnS2ElZyQpkLkQRIb812mg3trPPslFFQs/8lp2FrN233S5xBNNQy
	 qv5S9cTcTzaEPo17mDOegA17jsO3B9u96TweVuStHCjXwG2twc/DaXxA9+Sv43cohZ3cb
	 56HigioHtREcAfdbrKmlWdLRRNhUyzErpUWEPFaXamsR4bToykOCUN4r8soPKZwRaY/a0
	 XMLCcygl5v77hGKiRgEk/wZ+/zAGRcoWLRAIiwc4vpiYWFqILQTH2THOBP2PZ6rjI0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IwrGtZZw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F1260A2619
	for <linux-pci@vger.kernel.org>; Fri, 20 Nov 2026 16:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IwrGtZZw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6253B1F000D4;
	Fri, 20 Nov 2026 16:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795193750;
	bh=6XgHblxXTExitsxzkgHnfiFBSj/eKxbMVA10iAl9NaI=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=IwrGtZZwkBQkuwH5+qpPPgenahij3C6LMEwHNqv9ClvCisUsa/IE/0H3U9bS/+NPi
	 fu1G4jJ2Lt2K3scjDh8mKm4OTLEg6YqF4/16Ky1Hj77xA0zudr0BKNGdDdQYmbU4qt
	 7sA/sBKgW2r18lFvB1tmgFlh3qF3dbAM2URw6BeLBLTtmHNjdgYTTjETHWy+OMhLq9
	 6/AyPFWVhY9IaE48H4PEsJldeZQRyVtuezOzaVt27y3THmMcldEHN1+rNbzBSYYD7r
	 3tfagZbmLXwXLmoglt1ZP3SMuQstg6f4QVd6dEb0RYfs15hKKOxrzBONwXliuw+xlB
	 BT/IXA6RbeAIg==
Date: Fri, 20 Nov 2026 10:55:49 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Abhishek Kumar <abhishek.kumar15@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	krishna.chundru@oss.qualcomm.com
Subject: Re: [PATCH] PCI/pwrctrl: tc9563: Enable 8 GT/s equalization
 fine-tuning
Message-ID: <20261120165549.GA888766@bhelgaas>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261119-tc9563_fine_tune-v1-1-b83c74bf1e94@oss.qualcomm.com>

On Thu, Nov 19, 2026 at 04:57:12PM +0530, Abhishek Kumar wrote:
> On some boots, links on the PCIe switch report a continuous flood of
> correctable AER errors (RxErr, BadTLP and Replay Timer Timeout) at
> 8 GT/s. This happens because the 8 GT/s equalization fine-tuning
> setting is never programmed: max_num_of_fine_tuning_iterations_at_8gt
> in K_EQUTUNING_033_028 resets to 0, so equalization only selects a
> preset and never fine-tunes the transmitter coefficients for the
> channel, leaving the link with marginal signal quality.
> 
> Fix this by programming one fine-tuning iteration on the upstream port
> and downstream ports 1 and 2 at power-on, so that 8 GT/s equalization
> adapts the transmitter coefficients to the channel. With this setting
> the links no longer report any AER errors.
> 
> Signed-off-by: Abhishek Kumar <abhishek.kumar15@oss.qualcomm.com>

Applied to pci/pwrctrl for v7.5, thank you!

I added "Toshiba TC9563" to the commit log because this applies to
only this device, not PCIe switches in general.

> ---
>  drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c b/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
> index 4091a2f30aa7..d27b009430f1 100644
> --- a/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
> +++ b/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
> @@ -29,6 +29,9 @@
>  #define TC9563_PORT_L0S_DELAY		0x82496c
>  #define TC9563_PORT_L1_DELAY		0x824970
>  
> +#define TC9563_K_EQUTUNING_033_028	0x824a10
> +#define TC9563_EQ_FINE_TUNING_ITER	1
> +
>  #define TC9563_EMBEDDED_ETH_DELAY	0x8200d8
>  #define TC9563_ETH_L1_DELAY_MASK	GENMASK(27, 18)
>  #define TC9563_ETH_L1_DELAY_VALUE(x)	FIELD_PREP(TC9563_ETH_L1_DELAY_MASK, x)
> @@ -346,6 +349,20 @@ static int tc9563_pwrctrl_set_nfts(struct tc9563_pwrctrl *tc9563,
>  				      ARRAY_SIZE(nfts_seq));
>  }
>  
> +static int tc9563_pwrctrl_set_eq_fine_tuning(struct tc9563_pwrctrl *tc9563)
> +{
> +	int ret;
> +
> +	ret = regmap_write(tc9563->regmap, TC9563_PORT_SELECT,
> +			   BIT(TC9563_USP) | BIT(TC9563_DSP1) |
> +			   BIT(TC9563_DSP2));
> +	if (ret)
> +		return ret;
> +
> +	return regmap_write(tc9563->regmap, TC9563_K_EQUTUNING_033_028,
> +			    TC9563_EQ_FINE_TUNING_ITER);
> +}
> +
>  static int tc9563_pwrctrl_assert_deassert_reset(struct tc9563_pwrctrl *tc9563,
>  						bool deassert)
>  {
> @@ -557,6 +574,12 @@ static int tc9563_pwrctrl_power_on(struct pci_pwrctrl *pwrctrl)
>  	if (ret)
>  		goto power_off;
>  
> +	ret = tc9563_pwrctrl_set_eq_fine_tuning(tc9563);
> +	if (ret) {
> +		dev_err(dev, "Failed to enable 8 GT/s EQ fine-tuning\n");
> +		goto power_off;
> +	}
> +
>  	for (i = 0; i < TC9563_MAX; i++) {
>  		cfg = &tc9563->cfg[i];
>  		ret = tc9563_pwrctrl_disable_port(tc9563, i);
> 
> ---
> base-commit: e8017d29067fd1310a65c3494ce1a1b492adbac6
> change-id: 20261119-tc9563_fine_tune-1fee86f2e4a3
> 
> Best regards,
> --  
> Abhishek Kumar <abhishek.kumar15@oss.qualcomm.com>
> 
