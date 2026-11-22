Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795316924;
	b=n83B9FAHT4dW4mUQw0VfLRE2WLRBMj2cko9Fb8EBiEzNRqi7prVKqm8gIcCx74v1Ws9w
	 nSoy4Rf0zU8Eeg8Ul/4c8psv11W6CvINnAGh6pAn/NGJKgCUy0o7CqmIaOScwyxDouHbB
	 u39DU0L6CmQ81+kK02ayjy4PEHsPxwVCO6wH88QpXGw7oqOuT6fNI4xalqZ6hgDkYqxpq
	 u1yEgdiSp5RwCvjOQC0wC50YboFGyc8viPUr/chC2DjuoD+SKJclhTe4Tcb6B+parp7rW
	 +Gv8kSzjjVF8n9EjdgvuFpDGoVsTA5cEJlVq1LwHrSpyhnFp8Tlo1uAJweb3wktaOpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795316924;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=EvCqLTtWxekyY1rDCREt5XLzuU0zepZ0+JMeYxIFsdA=;
	b=fQglOauKOOO9uUUuKJFZY/M0FghP4dz1013hgBSk+wascdLyrU9+ckuKu0rYMD8BdHmj
	 vVae4AoBtyQcR954y9fGC//PlXPFOdjASj/CuIqNhSfvllEIDCsXfRSMX5CzWY+toyHYt
	 aCrzG3/alznXQTu7ahPSPByNWFcYUCPXG45HDj21PDTrkU7bHWPFk/Krmv7KVLwNN/5SG
	 GrEy5Qt1bGkx6UnBgHB+itmEQqPVtxrktapxQlV012PTbC9EGbaZDb6N86m6ZRTUa/7oL
	 IlVKwl1dPryGa7d3tECSRA07DoMoQyAVP5FabBWcej41LLeqQMMSQFmErHuJJ1azMYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TEONfliw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8293606A320;
	Sun, 22 Nov 2026 03:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TEONfliw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F38351F000C4;
	Sun, 22 Nov 2026 03:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795316924;
	bh=EvCqLTtWxekyY1rDCREt5XLzuU0zepZ0+JMeYxIFsdA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TEONfliwJG3+Ff2zmTo9L704IRHCmrpAfO8irg8sh1mkwmWjZAoHiYAnQuN73hQ75
	 duJBxg6FnFQgc8RxNXYuct1rrnyvmAmjmG6YJtkHPt8ENqFTO6U0ZF1XC0WWy3EFEm
	 RshUtkFgU4QGYJeNfe1Hnkn1GnNtNAmH/Tra4NkVawz5qNPsaEVE/IZxuE6038Kwp9
	 lS/cKq03aIfvWuvL30tNfvl36SZPdX/PNGk2IkE79x7+PZTpH2wThnoJU0iUGy/OAr
	 DTWhYRX2ZUwfTnpnoq2vkjuUw8pMd64ltF8BKQOzkw8tES2Z2U8gPr1KiBrCk1giie
	 854/TiFrvpOmQ==
Message-ID: <sashiko-outbox-227665@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 02/11] PCI: qcom-ep: Add MSI-X support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Krishna Chaitanya Chundru" <krishna.chundru@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-phy@lists.infradead.org, robh@kernel.org, conor+dt@kernel.org, vkoul@kernel.org, neil.armstrong@linaro.org, olteanv@gmail.com
In-Reply-To: <20261122-nord_ep-v1-2-6d8839ffa9aa@oss.qualcomm.com>
References: <20261122-nord_ep-v1-0-6d8839ffa9aa@oss.qualcomm.com>
 <20261122-nord_ep-v1-2-6d8839ffa9aa@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 22 Nov 2026 03:08:43 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] PCI: qcom-ep: modpost error on unexported
  dw_pcie_ep_raise_msix_irq_doorbell()
--

commit 2d6d23ea15c7e7d49381c678551e49590d53c5b3
Author: Anvita T <anvita.t@oss.qualcomm.com>

PCI: qcom-ep: Add MSI-X support

This commit adds MSI-X support to the Qualcomm PCIe Endpoint driver by
introducing an msix_capable SoC config flag and routing PCI_IRQ_MSIX
requests to dw_pcie_ep_raise_msix_irq_doorbell().

> diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/cont=
roller/dwc/pcie-qcom-ep.c
> index abbf6b738c380..335207de8f0cc 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
[ ... ]
> @@ -807,6 +809,8 @@ static int qcom_pcie_ep_raise_irq(struct dw_pcie_ep *=
ep, u8 func_no,
>  		return dw_pcie_ep_raise_intx_irq(ep, func_no);
>  	case PCI_IRQ_MSI:
>  		return dw_pcie_ep_raise_msi_irq(ep, func_no, interrupt_num);
> +	case PCI_IRQ_MSIX:
> +		return dw_pcie_ep_raise_msix_irq_doorbell(ep, func_no, interrupt_num);
>  	default:
>  		dev_err(pci->dev, "Unknown IRQ type\n");
>  		return -EINVAL;

[Severity: High]
Does building with CONFIG_PCIE_QCOM_EP=3Dm fail at modpost with an undefined
reference to dw_pcie_ep_raise_msix_irq_doorbell()?

CONFIG_PCIE_QCOM_EP is tristate and selects the bool symbol
CONFIG_PCIE_DW_EP, but unlike dw_pcie_ep_raise_intx_irq() and
dw_pcie_ep_raise_msi_irq(), dw_pcie_ep_raise_msix_irq_doorbell() in
drivers/pci/controller/dwc/pcie-designware-ep.c lacks EXPORT_SYMBOL_GPL().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261122-nord_ep-v1=
-0-6d8839ffa9aa@oss.qualcomm.com?part=3D2
