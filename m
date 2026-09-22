Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0024F5DE1;
	Tue, 22 Sep 2026 21:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790110960; cv=none; b=AAkCKxlygS9ltH7/jcJk7keBHTxRQ4CR7qujViCgXXDUmryARszJ+a5Of5KE7NKWFtihuKvNYa3CaoAdbc4qeztUCy1dbvesHiW3nUZ2hmW+y35Xnumd3w1KFOw4pQRFX1vbkDEguwRpXgUFzCFM4S2HfjyRfCeZ3syWFOAMS1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790110960; c=relaxed/simple;
	bh=M+YuJ6+BbSs49sATSNSOc+DxmvKvfUYxPeauTiC3NcI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MlsK/6FW0gdoyfi5fx91JBA0BkktM8sPZRilZSNfH3+sJ2gGw63r7P6A4x792++sjSWMNT/sILqOP3GLlSwEUKk9/w60kK1Lo5wQf3AQKow9CUcKNLgGv+j3onOCnGXgr3xyqodhdtw2g/YnWw7/ZV4VEDQvGAmH9QlR3CQgc4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=sNKFLieF; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="sNKFLieF"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4hqCGQ5WmlzMlF2;
	Tue, 22 Sep 2026 23:02:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1790110942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XTslkiXIVplCu3AnBYkWgwj7/gIMyu6gg3YCKOJ1/hQ=;
	b=sNKFLieFKKCI0I+/1RoOM3gR2muNAD0Yfoa2jTTCpedqPjRp2PVweHjzqEo8YyYtoBWUTS
	dcQlsVspl2mPayqlxIIk5B4K744iUGVOFVrRfsU9d/tSdxZB6pLbQ+64kwntHr1LeVOj+P
	adTzA/MfVeggGB0MTThvJRkvokApjSwqLFlKkFoCoandl48WmmqAcPOnqQbGmQWhYuS88e
	oehStBeepVvGjByTpAQfKqIWTvN7CV8Wq4r15QIg532ojwNzvPIo1URf4u32pYlFwN5l9o
	LT6Jj50fZLhLDpftd8sEjk7y4SBRXikO0id2JwMDlDbzIBvGOhDo69qheZMHkQ==
Message-ID: <c2807afc-3e69-4744-8588-20f60839a603@mailbox.org>
Date: Tue, 22 Sep 2026 22:56:02 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 02/11] PCI: rcar-gen4: Drop the APP-based link_up check
To: Koichiro Den <den@valinux.co.jp>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>, Jingoo Han <jingoohan1@gmail.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, Frank Li <Frank.Li@nxp.com>,
 Niklas Cassel <cassel@kernel.org>, Wilfred Mallawa
 <wilfred.mallawa@wdc.com>, Serge Semin <fancer.lancer@gmail.com>,
 linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260918032038.2216471-1-den@valinux.co.jp>
 <20260918032038.2216471-3-den@valinux.co.jp>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260918032038.2216471-3-den@valinux.co.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: bgrh71wp63h1bo4gwdrsrodgbheawy8s
X-MBO-RS-ID: df39a8f2dfa6ffd0da6

Hello Den-san,

I apologize for my late reply.

On 9/18/26 5:20 AM, Koichiro Den wrote:
> rcar_gen4_pcie_link_up() checks link state using SMLH_LINK_UP and
> RDLH_LINK_UP in PCIEINTSTS0. However, these bits do not reflect the live
> link state. On an R-Car S4, after taking down the endpoint, a link-down
> interrupt saw PCIEINTSTS0 = 0x20a000c5 with both bits still set. Even
> after resetting the controller with the LTSSM back in Polling, they read
> 0xa000c5, still set.
> 
> As a result, dw_pcie_link_up() keeps reporting the link as up after it
> has gone down. That defeats the check in dw_pcie_other_conf_map_bus(),
> which is supposed to stop config accesses to downstream devices while
> the link is down, so such accesses go out on the dead link and stall the
> host. It also makes the callback useless for the link-down recovery
> added later, which has to wait for the link to actually come back after
> resetting the controller.
> 
> Drop the callback and let the DesignWare core use its PORT_DEBUG1 check
> instead, which correctly detects the downed link.
> 
> Fixes: 0d0c551011df ("PCI: rcar-gen4: Add R-Car Gen4 PCIe controller support for host mode")
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
>   drivers/pci/controller/dwc/pcie-rcar-gen4.c | 14 --------------
>   1 file changed, 14 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> index 5a076aa3f490..fe1f1940e809 100644
> --- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> @@ -44,8 +44,6 @@
>   /* PCIe Interrupt Status 0 Enable */
>   #define PCIEINTSTS0EN		0x0310
>   #define MSI_CTRL_INT		BIT(26)
> -#define SMLH_LINK_UP		BIT(7)
> -#define RDLH_LINK_UP		BIT(6)
>   
>   /* PCIe DMA Interrupt Status Enable */
>   #define PCIEDMAINTSTSEN		0x0314
> @@ -102,17 +100,6 @@ struct rcar_gen4_pcie {
>   #define to_rcar_gen4_pcie(_dw)	container_of(_dw, struct rcar_gen4_pcie, dw)
>   
>   /* Common */
> -static bool rcar_gen4_pcie_link_up(struct dw_pcie *dw)
> -{
> -	struct rcar_gen4_pcie *rcar = to_rcar_gen4_pcie(dw);
> -	u32 val, mask;
> -
> -	val = readl(rcar->base + PCIEINTSTS0);
> -	mask = RDLH_LINK_UP | SMLH_LINK_UP;
> -
> -	return (val & mask) == mask;
> -}
> -
>   /*
>    * Manually initiate the speed change. Return 0 if change succeeded; otherwise
>    * -ETIMEDOUT.
> @@ -298,7 +285,6 @@ static int rcar_gen4_pcie_get_resources(struct rcar_gen4_pcie *rcar)
>   static const struct dw_pcie_ops dw_pcie_ops = {
>   	.start_link = rcar_gen4_pcie_start_link,
>   	.stop_link = rcar_gen4_pcie_stop_link,
> -	.link_up = rcar_gen4_pcie_link_up,
>   };
>   
>   static struct rcar_gen4_pcie *rcar_gen4_pcie_alloc(struct platform_device *pdev)

Can we include some form of the draft patch below, so the S4 Reference 
Manual rev.1.40 , page 1564 , Figure 104.5 Initial Setting of PCIEC , 
bottommost diamond in the figure (smlh_link_up and rdlh_link_up = 1 
test), would still be fulfilled, and the initialization code in the 
driver would not diverge from the initialization sequence listed in the 
reference manual ? What do you think ?

The PCIEINTSTS0CLR should clear the link state bits before the link gets 
started, so the initialization code should be able to sample those bits 
after the link came up and confirm they were set during the link up.

The PCIEINTSTS0CLR usage however won't solve the case where the DWC PCIe 
core code has to sample PCIe link state at arbitrary time, this is what 
this patch does solve correctly.

"
diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c 
b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
index e5833f36625d2..9f29055f0bed7 100644
--- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
+++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
@@ -203,17 +203,28 @@ static int rcar_gen5_pcie_speed_control(struct 
rcar_gen4_pcie *rcar)
   * Enable LTSSM of this controller and manually initiate the speed change.
   * Always return 0.
   */
+#define PCIEINTSTS0CLR		0x0340
  static int rcar_gen4_pcie_start_link(struct dw_pcie *dw)
  {
  	struct rcar_gen4_pcie *rcar = to_rcar_gen4_pcie(dw);
+	u32 val, mask;
  	int ret;

+	/* Clear RDLH/SMLH link state */
+	writel(RDLH_LINK_UP | SMLH_LINK_UP, rcar->base + PCIEINTSTS0CLR);
+
  	if (rcar->drvdata->ltssm_control) {
  		ret = rcar->drvdata->ltssm_control(rcar, true);
  		if (ret)
  			return ret;
  	}

+	ret = rcar->drvdata->speed_control(rcar);
+	if (ret)
+		return ret;
+
+	val = readl(rcar->base + PCIEINTSTS0);
+	mask = RDLH_LINK_UP | SMLH_LINK_UP;
+	return ((val & mask) == mask)
  }

@@ -223,6 +234,9 @@ static void rcar_gen4_pcie_stop_link(struct dw_pcie *dw)

  	if (rcar->drvdata->ltssm_control)
  		rcar->drvdata->ltssm_control(rcar, false);
+
+	/* Clear RDLH/SMLH link state */
+	writel(RDLH_LINK_UP | SMLH_LINK_UP, rcar->base + PCIEINTSTS0CLR);
  }

  static int rcar_gen4_pcie_common_init(struct rcar_gen4_pcie *rcar)
"

-- 
Best regards,
Marek Vasut
