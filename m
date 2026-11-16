Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794863031;
	b=oc6SSiw1YIfgtfgqJt7KX23btoELH7QaRyca3zaO5g1JJFcajoy1C5/XCn1BroqdJ13k
	 NjqMhU5Ws5UQk/44rqp6P1rzcmbSTZonZuk6E4w+B1ylfsfB8tVvWuSHNsWBpntjOZW0S
	 eaO5VGkY2Okr84mVxtc0vH/RAnMB8Q/10Tfhv2ZkOmKYZpUE2c4eyTEQ1pWi9gSESX6Zk
	 q0RVTIF87UtSUhxefllpcERBdne7bjk/XkZpmcNah6eCSuPP+R93vGliInfP533/P8GLj
	 UV4L+BP1CibiF+UY1MOR8mDVKWKUfZu+5DPB1S1E7huYygRTtgJgOOW/HW0bwr24kIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794863031;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=vV/ch3hr516mo037dnlie1jlv7enT3KWVe6qZl10yeQ=;
	b=tpAi1P8N/brr7DP9M57UcwGyGSvFRIWKv98YL6G/D7lOWJ4MCh4yngvlAeiYDD5/JMjA
	 45nzvn1KejUBEXqjkOVthhnSWDHa+2skSrV4C/ibLdp1V0MGsSFC+bw0O+z6VgK5lyENf
	 P7lRYc7FDdq0hE9gs9SVpF8BXh1E4HW7y6M+BNJT+ITMvPuqrzmACpJbTEUjh6vFKBOP+
	 iZEe9VPWijTEGkUU5+5mqWq4Zn42bM884iw/2lv5f/uh9d0D7zPVWEdvf1BV2SfCEWk1q
	 W9epH3aF9gQW5dnJMYH/dZ5mTvJfTOSTUZIh1W6v7qWE6h6tvWdL/8AJW9Cx19091Qg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OVrt1n2F;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DB6606A323
	for <linux-pci@vger.kernel.org>; Mon, 16 Nov 2026 21:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OVrt1n2F
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0E1C1F000C9;
	Mon, 16 Nov 2026 21:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794863031;
	bh=vV/ch3hr516mo037dnlie1jlv7enT3KWVe6qZl10yeQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OVrt1n2FQWwTKEYKB3U7BIt6aRggA/G9Wa5FRGTFLxdK+cfYL96NY7NTnpYrVPgID
	 SMRt31QO+eXQ1k50texEtTZHG4fLLe0GmlmOKwK85u4A1CfQnk10AV8H920p7N4Sph
	 /f/21FqAHjn+QCkb9eiDW5SBZYrpCOh2VKOIAebIbPt+B0RndoibIMIfzAuxiPnkZd
	 6eZAWzNlU4xTg05TV8P8WqUy4qRj720VK699ZUSsY8GCJ4dz3054umaxBd+AgFyKo6
	 aPNqwocXPycoAw5wnIfRcDuqfM13Eb5POxZM+t4l40AxwOzUyCuXpbyI8IDmoZAYEJ
	 sKImY+GUqj1OQ==
Message-ID: <sashiko-outbox-217689@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: fu740: Check return value of clk_prepare_enable()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jayaraj Devaraj" <jayarajdmit@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261116204922.159384-1-jayarajdmit@gmail.com>
References: <20261116204922.159384-1-jayarajdmit@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 21:03:50 +0000
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
- [Low] PCI: fu740: missing Fixes trailer forfu740_pcie_host_init()
  clock check
It also noticed 1 related pre-existing issue this patch does not
introduce:
- [Medium] PCI: fu740: missing .deinit cleanup and unchecked
  clk_prepare_enable() [1]
--

commit 04ba94c4c15cc3b4e7a1a6837f3336a1c0b55bce
Author: Jayaraj Devaraj <jayarajdmit@gmail.com>

> PCI: fu740: Check return value of clk_prepare_enable()
>
> fu740_pcie_host_init() ignores the return value of the second
> clk_prepare_enable() call on pcie_aux, so a failure to enable the
> clock is silently ignored and the controller is programmed anyway.
>
> Check the return value and propagate the error.
>
> Signed-off-by: Jayaraj Devaraj <jayarajdmit@gmail.com>

[Severity: Low]
Since this fixes a missing error check in fu740_pcie_host_init(), should it
include:

  Fixes: e7e21b3a339b ("PCI: fu740: Add SiFive FU740 PCIe host controller d=
river")

> diff --git a/drivers/pci/controller/dwc/pcie-fu740.c b/drivers/pci/contro=
ller/dwc/pcie-fu740.c
> index 4908077e58c4c..c9bb4c4fba23f 100644
> --- a/drivers/pci/controller/dwc/pcie-fu740.c
> +++ b/drivers/pci/controller/dwc/pcie-fu740.c
> @@ -270,7 +270,11 @@ static int fu740_pcie_host_init(struct dw_pcie_rp *p=
p)
>  	/* Clear hold_phy_rst */
>  	writel_relaxed(0x0, afp->mgmt_base + PCIEX8MGMT_APP_HOLD_PHY_RST);
>  	/* Enable pcieauxclk */
> -	clk_prepare_enable(afp->pcie_aux);
> +	ret =3D clk_prepare_enable(afp->pcie_aux);
> +	if (ret) {
> +		dev_err(dev, "unable to re-enable pcie_aux clock\n");
> +		return ret;
> +	}
>  	/* Set RC mode */
>  	writel_relaxed(0x4, afp->mgmt_base + PCIEX8MGMT_DEVICE_TYPE);
> =20

[Severity: Medium]
This problem wasn't introduced by this patch, but does returning here or
failing later in dw_pcie_host_init() leak the clock and reset state
[1]?

Earlier in fu740_pcie_host_init(), reset_control_deassert(afp->rst)
deasserts the reset line, so returning when the second
clk_prepare_enable(afp->pcie_aux) fails leaves afp->rst deasserted.
In addition, fu740_pcie_host_ops has no .deinit callback, so if a later
step in dw_pcie_host_init() fails after fu740_pcie_host_init() succeeds,
afp->pcie_aux remains enabled and afp->rst remains deasserted.

[1] https://sashiko.dev/#/bug/linux-e8a8fccf-83d6-4777-a6b0-51ba01cc3409

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116204922.1593=
84-1-jayarajdmit@gmail.com?part=3D1
