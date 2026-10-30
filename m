Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793340432;
	b=v9Kvxx8D96E7xRy/h5N4FmxWJ9n8yd3X51/cfsn8uqcud6IqpNaNrCmYpjwMCqj5Nb+O
	 aZQUXMFHpijKPTYdnJ2R1XaKM8nBAhnR2iBD6byzJ9sBYRLwCyO29ktEgAiYybBKq9ptn
	 4fdxelEE1iCSvOTr1By/68VZL/UMTIgvXas6PSyW6krmlS20EWhdLwIXLZTFPwx3cwfYk
	 nRZYEhMkDxxLkPdoCxW4FZm66ID70bK51jiOT5nzRb4LMHP7wnAJqgLUmIyzr846xyYfX
	 MXjlZuMIGM3M3BIX3oNoEhuUeOnyMvUCRSrWuwj9iKSU74XtiVxAdre3JS6NFIOQMnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793340432;
	h=Received:MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:
	 From:To:Cc:In-Reply-To:References:Date:Message-Id:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=MjJjLX/qV1+lyxi0iixx5duL/lrS5HdRSjax3k0IDWQ=;
	b=gI7kMNtEHsKIlgeNG0qmPwhaaddRmslOQFjc/DgwwqOAMeFDHRlJHgI1b2CbuEWlPUKL
	 wipmPzZjP/tqyyNV0EFIMV9U+98kdTtXetjuaKradyT2rWBDFiWu36C5GT92NAzMEh0GN
	 fbzzWVePkYBquoGRrTiCKNX8i86AZiZ2yD+psTKuLneCx4cbqr23tHn9RWGZObCP07NNC
	 yLnZceHemNcDc3Qxxf6KrHCdsAvVm5EO9V0eq+BuBdpxv1+FwZy9KJnApxnFLfQ6ponIn
	 3B5wC/fKRoXfzgRWvCKFxF3sFPXS6Bc+skMfOO8oK5GgbKEW/yAD/e0tS+LjOS3jATQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5A2606A31A;
	Fri, 30 Oct 2026 06:07:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC29F1F000C1;
	Fri, 30 Oct 2026 06:07:03 +0000 (UTC)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] PCI: rcar-gen4: Isolate 256B MRRS limit only to R-Car
 Gen4 SoC PCIe controller
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-pci@vger.kernel.org, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 Magnus Damm <magnus.damm@gmail.com>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
In-Reply-To: <20261028172208.20948-1-marek.vasut+renesas@mailbox.org>
References: <20261028172208.20948-1-marek.vasut+renesas@mailbox.org>
Date: Fri, 30 Oct 2026 11:36:42 +0530
Message-Id: <179334040211.5551.2573230628622674128.b4-reply@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2036;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=4edNlj4hhxIn12ce5F/wVnHs7h2/NapSUJQfe8DP0lo=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBq5DQBPrEWzsVqr9VNbSLmlTUCdQKwXi+BG4lKw
 MN5aHrzsfeJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCauQ0AQAKCRBVnxHm/pHO
 9ZIwCACiov7Ld7Mb4yli0vS5531D50cP0nq2vYpavxqmIm7S9AkB0tXBACbuDl5QiweQ+29fkGh
 4Q/LskrsSQfg8Uwn91FIjMDeq61kQaR3AAZAffLB9/p3cYv/+Qa0b2Zsegjy6ah0bvosAqYgpab
 7F57Vsweo8IshJbVCVHvUU1ZrfjvTmbN9biN8SNQrnHAJACTjH9mXIInVmlfR6Yhlq9GCOExsYt
 KSinPu+I/Is+bPUKBz4aR34mwBrtgY4f1KyrtBJmXRpgPOTDCT4woF8R2aZUMDA19VXqDXrpa3S
 /VTXzq7sztb4djdXE5EsYLLvskXoXiN0ogJEZpVgBtYmk8Dr
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

On 2026-10-28 18:21 +0100, Marek Vasut wrote:
> The R-Car Gen5 SoC PCIe4 controller is not affected by the 256B MRRS
> limitation that was present on R-Car Gen4 SoC PCIe controller. Apply
> the 256B MRRS limitation workaround to R-Car Gen4 SoC PCIe controller
> only. For details of the 256B MRRS limitation, please refer to commit
> f0a5c6bd797c ("PCI: rcar-gen4: Limit Max_Read_Request_Size to 256 Bytes") .
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: "Krzysztof Wilczyński" <kwilczynski@kernel.org>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Cc: Manivannan Sadhasivam <mani@kernel.org>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-pci@vger.kernel.org
> Cc: linux-renesas-soc@vger.kernel.org
> ---
>  drivers/pci/controller/dwc/pcie-rcar-gen4.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> index 9a64a9f4ab0d1..1e4405181eef3 100644
> --- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> @@ -99,6 +99,7 @@ struct rcar_gen4_pcie_drvdata {
>  	int (*ltssm_control)(struct rcar_gen4_pcie *rcar, bool enable);
>  	int (*speed_control)(struct rcar_gen4_pcie *rcar);
>  	enum dw_pcie_device_mode mode;
> +	bool mrrs_256b_limit;
>  };
>  
>  struct rcar_gen4_pcie {
> @@ -663,7 +664,7 @@ static int rcar_gen4_pcie_host_init(struct dw_pcie_rp *pp)
>  	if (ret)
>  		return ret;
>  
> -	if (pp->bridge)
> +	if (rcar->drvdata->mrrs_256b_limit && pp->bridge)
>  		pp->bridge->enable_device = rcar_gen4_pcie_enable_device;

I'd suggest moving this check inside enable_device() callback to make it clear
where exactly the skipping happens.

- Mani

