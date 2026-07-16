Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E53433B6CC
	for <linux-pci@vger.kernel.org>; Thu, 16 Jul 2026 18:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784227724; cv=none; b=Y3s4WdxazheziePaFWap9+jQKmrOAfSOvcN4gaI/73JbGsJYAv1hkcpDh5Y3umMeSLfdU3pio1kUER7ILP+yFuVdwRjDEqDLcYwhve1Y/cD/lzFvAoSnu/kLUL4n7sXptQX62hLx63xOmcVBIXwr9zVEXVW5G8JvIRUbBflTNxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784227724; c=relaxed/simple;
	bh=L/BFaFjssLtfgT7Z6AREhZSZs1c1XSrP+hsDtu4wwFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N6eUElanDP7RtgUtxQrtWq0mkowABI0e7FXfGFHtXY/qYmqSh4iMLFZD8h49Tk1+FbWcYcNissSphK4E8FMAPq6iP7q8LcXeZeODX7+nUrg0K6gThKZGs/8CXUAwsaBByfkB2UJmg4KoWNifVQLYK4Ug+Vy09M+3SaWsi2lFeWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WxuWjJ0G; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=jmnPF8RN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WxuWjJ0G";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="jmnPF8RN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784227722;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k90VREcyUMcR/OGuKj3U3g7OaZ/zXu0WG1tLumtRQ8E=;
	b=WxuWjJ0G4EKXtHEM0S5925dJEeneFsNy/EEreYYwAQGpXRbQURY6V7kpBMk/8Ya6KbBSo2
	ZS3L7snwivR8vadnHX3BZkIiCyEVFBLyGQA9UTnqrC3NkbcV2kKcpzqHeyknQYAaLNtSm7
	uRqTfPggtBLRjXylHgCjZ2g27+BQlfQ=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-230-KM6ovJ-tNw-qVXEp6IXteA-1; Thu, 16 Jul 2026 14:48:40 -0400
X-MC-Unique: KM6ovJ-tNw-qVXEp6IXteA-1
X-Mimecast-MFC-AGG-ID: KM6ovJ-tNw-qVXEp6IXteA_1784227720
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-92e53b8a302so1108411085a.1
        for <linux-pci@vger.kernel.org>; Thu, 16 Jul 2026 11:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784227720; x=1784832520; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=k90VREcyUMcR/OGuKj3U3g7OaZ/zXu0WG1tLumtRQ8E=;
        b=jmnPF8RNupTwFZxnyNAHc6Syulr2ACziGHuSnaCI1P04CZTuAkNGuWTo3d/lmVL1tt
         SyCXfvNillap2wrMndV9JQu39YE1rr5tB1A+UIJ+GzAz4Xd+HdmuV1hCM2XtUVkMQqLY
         0DYP2N7LwUN52bo/lOrRI+FMD+3EQTeu0Zxmxhcc936eTScONJ/sB2ATYhTtzU0c6+0Y
         0n2mfV65QFQIJMfzRpP7WVYjvrxDvT5AuwfJRne1oPFjpOhtZd+t2AP93wh7C3pp6/e5
         6c7J8m7pN6v/0TltIm/2Acr3m+qxAZ20axfSPU8rkn1KfpMRD00p/EqblZfPVD0DH5qN
         w5bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784227720; x=1784832520;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k90VREcyUMcR/OGuKj3U3g7OaZ/zXu0WG1tLumtRQ8E=;
        b=cZRCKBPj06cWd3uJ9D0/8xtnpaD4agEvdFk4JMaEGdP2g2uCUYfdJWp8tm1olbAGs+
         J/o+qe3l5szalCH3jo9KRIaTNVjoLjnyKOeJH0rVRqMdrXVdq6HvjEQ5ibvCna0BGW7O
         D8tlJJoXzF83eVftgL4E/V87BOsi8XhP9WCdRtIAcr40jl8Y6TlzTmXOCvgMq0N7aj3Q
         TtjQZGCWXzpcipyA6InNrigQ6Tzy08WTOpC/ElTv/Z4q56JSQh1PWKagM+1tVb3BqMsO
         0KO1i9SCq1gJTeCXwEKEHns7kvL7aSGIjUdunJIUrZyiQbf1DS6HMblFlcYbqMdQ+I8i
         kJdw==
X-Forwarded-Encrypted: i=1; AHgh+RpH2V51KDSZo9qEIK7FauwSVBOBPBl9GMoF9uc28OL9J+rHl8L1FGmw6Pun7rGZ/Cb+lJIcwl9pooE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8yKX8n0KDcbJwtXX7Al5r9DS9nfVGI6tjRfZ1rcBiEu1pR7pW
	tsA38Bnp4RgjKKXf4FhiVSL7LR0gUFRRLcUCM2q2BNzoUq/v6BZe9MVEry5bNnW5HRexZF2OjGJ
	YL46mjoXRMbCmlRrzdrfuLPWtaPL60ID+oTJSyThuxuJpEVwt76nnB5f4jHiiIA==
X-Gm-Gg: AfdE7ckJMo8buDsHmmR/E2fEIlQLY0XJJsegW2sknQzjTUSCWagWEYyhtbuNn4azBjn
	3MbMt3QTXrkD7TNKPAeSUkmuF1zkbYoUZpawsCtCA00KOYNPaNNoxhKzOtnBPIgWhGX1PgG8h2U
	tYay/BttuYfOVGTkei26nCkamegoOyR/PtuYk1Z5CY4usSEAlC9B6PNKzaGpff3sJdfomCKPfQL
	DjWF16MVB88bceVgNg3x0Ih/jzSzUQ4oCVdxefIxubgd2xa6exqb9erJ6352hgn/4uBQe+85LRF
	w7eZHnjHI8iF2P+LsSwZfTCOb/RfoUMRQwDE4csBjqzN6hZiyc3blmQCaEBBm17Xd9cy1aod6eK
	vcn9dpBfNoDtn4sOjJItln/Q5E9rj9yXs2HE=
X-Received: by 2002:a05:620a:1a14:b0:92e:e569:dc20 with SMTP id af79cd13be357-930962abddbmr924060385a.78.1784227720182;
        Thu, 16 Jul 2026 11:48:40 -0700 (PDT)
X-Received: by 2002:a05:620a:1a14:b0:92e:e569:dc20 with SMTP id af79cd13be357-930962abddbmr924057085a.78.1784227719524;
        Thu, 16 Jul 2026 11:48:39 -0700 (PDT)
Received: from redhat.com (c-73-183-53-213.hsd1.pa.comcast.net. [73.183.53.213])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5cf9d9bsm2074490485a.28.2026.07.16.11.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 11:48:38 -0700 (PDT)
Date: Thu, 16 Jul 2026 14:48:35 -0400
From: Brian Masney <bmasney@redhat.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 2/4] clk: en7523: add support for dedicated PCIe
 PERSTOUT reset
Message-ID: <alkng6IIkInZjxqA@redhat.com>
References: <20260714115848.8537-1-ansuelsmth@gmail.com>
 <20260714115848.8537-3-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714115848.8537-3-ansuelsmth@gmail.com>
User-Agent: Mutt/2.4.0 (2026-06-19)

Hi Christian,

On Tue, Jul 14, 2026 at 01:58:44PM +0200, Christian Marangi wrote:
> Add support for resetting the PCIe lines with the PERSTOUT reset. These
> special reset are controlled by the PCIC register and are specific to each
> of the 3 PCIe lines.
> 
> Notice that reset logic is inverted for these bit where 0 is assert and 1
> deassert. This is intenrally handled in the reset function.

s/intenrally/internally/

The "these bit" above is awkward as well. Sorry I don't have a
suggestion offhand, but I see what you mean below based on the code.

> 
> PCI enable/disable are updated to drop PERSTOUT bits in favor dedicated
> reset handling.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  drivers/clk/clk-en7523.c | 39 ++++++++++++++++++++++++++++-----------
>  1 file changed, 28 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/clk/clk-en7523.c b/drivers/clk/clk-en7523.c
> index 1ab0e2eca5d3..c9b21d9bf2f3 100644
> --- a/drivers/clk/clk-en7523.c
> +++ b/drivers/clk/clk-en7523.c
> @@ -338,6 +338,7 @@ static const struct en_clk_desc en7581_base_clks[] = {
>  static const u16 en7581_rst_ofs[] = {
>  	REG_RST_CTRL2,
>  	REG_RST_CTRL1,
> +	REG_NP_SCU_PCIC,
>  };
>  
>  static const u16 en751221_rst_ofs[] = {
> @@ -450,6 +451,11 @@ static const u16 en7581_rst_map[] = {
>  	[EN7581_CPU_TIMER_RST]		= RST_NR_PER_BANK + 28,
>  	[EN7581_PCIE_HB_RST]		= RST_NR_PER_BANK + 29,
>  	[EN7581_XPON_MAC_RST]		= RST_NR_PER_BANK + 31,
> +
> +	/* RST_PCIC */
> +	[EN7581_PCIC_PERSTOUT0_RST]	= 2 * RST_NR_PER_BANK + 29,
> +	[EN7581_PCIC_PERSTOUT1_RST]	= 2 * RST_NR_PER_BANK + 26,
> +	[EN7581_PCIC_PERSTOUT2_RST]	= 2 * RST_NR_PER_BANK + 16,
>  };
>  
>  static const u16 en751221_rst_map[] = {
> @@ -635,9 +641,7 @@ static int en7581_pci_enable(struct clk_hw *hw)
>  	void __iomem *np_base = cg->base;
>  	u32 val, mask;
>  
> -	mask = REG_PCI_CONTROL_REFCLK_EN0 | REG_PCI_CONTROL_REFCLK_EN1 |
> -	       REG_PCI_CONTROL_PERSTOUT1 | REG_PCI_CONTROL_PERSTOUT2 |
> -	       REG_PCI_CONTROL_PERSTOUT;
> +	mask = REG_PCI_CONTROL_REFCLK_EN0 | REG_PCI_CONTROL_REFCLK_EN1;
>  	val = readl(np_base + REG_PCI_CONTROL);
>  	writel(val | mask, np_base + REG_PCI_CONTROL);
>  
> @@ -650,9 +654,7 @@ static void en7581_pci_disable(struct clk_hw *hw)
>  	void __iomem *np_base = cg->base;
>  	u32 val, mask;
>  
> -	mask = REG_PCI_CONTROL_REFCLK_EN0 | REG_PCI_CONTROL_REFCLK_EN1 |
> -	       REG_PCI_CONTROL_PERSTOUT1 | REG_PCI_CONTROL_PERSTOUT2 |
> -	       REG_PCI_CONTROL_PERSTOUT;
> +	mask = REG_PCI_CONTROL_REFCLK_EN0 | REG_PCI_CONTROL_REFCLK_EN1;
>  	val = readl(np_base + REG_PCI_CONTROL);
>  	writel(val & ~mask, np_base + REG_PCI_CONTROL);
>  	usleep_range(1000, 2000);
> @@ -754,14 +756,21 @@ static int en7523_reset_update(struct reset_controller_dev *rcdev,
>  			       unsigned long id, bool assert)
>  {
>  	struct en_rst_data *rst_data = container_of(rcdev, struct en_rst_data, rcdev);
> -	void __iomem *addr = rst_data->base + rst_data->bank_ofs[id / RST_NR_PER_BANK];
> +	u32 offset = rst_data->bank_ofs[id / RST_NR_PER_BANK];
> +	void __iomem *addr = rst_data->base + offset;
> +	bool inverted = false;
>  	u32 val;
>  
> +	/* For PCIC reset logic is inverted, 0:assert 1:deassert*/

Add space before end of comment.

> +	if (offset == REG_NP_SCU_PCIC)
> +		inverted = true;
> +
>  	val = readl(addr);
> +	val &= ~BIT(id % RST_NR_PER_BANK);
>  	if (assert)
> -		val |= BIT(id % RST_NR_PER_BANK);
> +		val |= inverted ? 0 : BIT(id % RST_NR_PER_BANK);
>  	else
> -		val &= ~BIT(id % RST_NR_PER_BANK);
> +		val |= inverted ? BIT(id % RST_NR_PER_BANK) : 0;

Could you do:

    if (assert ^ inverted)

Then keep the existing logic for val inside the if/else?



>  	writel(val, addr);
>  
>  	return 0;
> @@ -783,9 +792,17 @@ static int en7523_reset_status(struct reset_controller_dev *rcdev,
>  			       unsigned long id)
>  {
>  	struct en_rst_data *rst_data = container_of(rcdev, struct en_rst_data, rcdev);
> -	void __iomem *addr = rst_data->base + rst_data->bank_ofs[id / RST_NR_PER_BANK];
> +	u32 offset = rst_data->bank_ofs[id / RST_NR_PER_BANK];
> +	void __iomem *addr = rst_data->base + offset;
> +	bool inverted = false;
> +	u32 val;
> +
> +	/* For PCIC reset logic is inverted, 0:assert 1:deassert*/

Add space before */

Brian

