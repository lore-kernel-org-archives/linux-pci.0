Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794695159;
	b=p8HnJK6dKPtNGoyMmkPVH7KKXbguxHP3ojKp1AzYzhQ5fvk2tLey7qds6waDIAtUg8xm
	 Dp0cmPVJ+A7llIsc6+bGeUJ+y6xcdh/kjZAZY3eAMoR1NOpzLQaXxUyqyEhi1IkTYqlK0
	 Bgmrraj8xWK6+geJkRqrj1nOqb32tdb4kovP6BiYupFK8sHpGH0MrGRbxt/F0BoMh1sWJ
	 xlByYKxqQ3+6Ad29edW/T/rdBfRhpy5T1Y0bKmqKOdMN7fAJ0o/yRlY0k/MZqTd1kEDM1
	 dtNbI5idXXnOkCNnwUQE2Xx0LY6LMsCoG7JKrTu/RyPkDwzujBgXkCVy6P0h6PHcMlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794695159;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=l9Lktmad6aldki3CP7RDALK/ehOQCSYds+PrMiE3D5A=;
	b=C2OUIcpzf1cLLOciaPZUJi7/ir1OG3kkfzmUa3AObTMJjqx1bxOOuixo5RhNYcOrsWon
	 SRhjh2qxvZ+Jar+2ozLIk+Q/yovmw+/+IO6CLUWDAev0BC0ApHG1mWK0TZW0EvqotsRUm
	 36EK1A72ddvWe883bU2mBBHay3Qd9XxJPJ2OGmFlOeEwm/D1mBoqmyBNoDdX8q/mRk5PY
	 jEdhPgME9n8BJminfizJFBCOZ8qtJzR01jT7dwK3+axlznKWg6eBdof71H2bJSpt0ljeO
	 q5ppOpgScdfOfqlfY6CxmPq2R7g/cDz6CdRTdomTlW6oTAymXSlNuK56Z0ouwZVAoYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="AvB/lWrP";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A46606A323
	for <linux-pci@vger.kernel.org>; Sat, 14 Nov 2026 22:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AvB/lWrP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A783C1F000C4;
	Sat, 14 Nov 2026 22:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794695158;
	bh=l9Lktmad6aldki3CP7RDALK/ehOQCSYds+PrMiE3D5A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AvB/lWrP8v9GcrrvW2Pmr7ajGncTAtJRvRNVqAIdoTC5ufisV0JhTH16UXpW24N8+
	 sJJlpNUzSLtD4npePslI5AuNA7hlRj8RjpAyigEieVZIjwBfQlR3Lnc7Ih9maYLEz7
	 0badfCwHVupXpbyGvpP5l8eZGtZMw9XuCdu9i1snV5AZlYJR2C7de+qDFC/8vkYR9X
	 qfZiBQlqj/hIv4q4LGve5BASwhvCpMIX94RSdCTogCCYBYfLuicaaN9ChPTlW07b8N
	 tFbNvkDjjutSvk/INxNaAIkAGaVPnDJ33V4BdQ2c4iL+CvV7vZXO6rnPBEEyecstW/
	 qE5JsAO1pGLpg==
Message-ID: <sashiko-outbox-215064@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] PCI: meson: Add system suspend/resume support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Igor Velkov" <iav@iav.lv>
Cc: linux-pci@vger.kernel.org, linux-amlogic@lists.infradead.org, neil.armstrong@linaro.org
In-Reply-To: <20261114-b4-pci-meson-suspend-v1-2-be3d04a13304@iav.lv>
References: <20261114-b4-pci-meson-suspend-v1-0-be3d04a13304@iav.lv>
 <20261114-b4-pci-meson-suspend-v1-2-be3d04a13304@iav.lv>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 22:25:58 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [Medium] PCI: meson: accidental clearing of W1C bits in Device Status
  register [1]
--

commit f7a5cff83ce20dd936f701817faa8230379ab3ad
Author: Igor Velkov <iav@iav.lv>

PCI: meson: Add system suspend/resume support

This commit adds noirq suspend and resume callbacks for the Amlogic Meson
PCIe controller when attached to a power domain, along with a
.pme_turn_off callback and power state tracking across host init and
deinit.

> diff --git a/drivers/pci/controller/dwc/pci-meson.c b/drivers/pci/control=
ler/dwc/pci-meson.c
> index 627470c83bb5d..5ef7369bb21bf 100644
> --- a/drivers/pci/controller/dwc/pci-meson.c
> +++ b/drivers/pci/controller/dwc/pci-meson.c

[ ... ]

> @@ -385,6 +389,8 @@ static int meson_pcie_host_init(struct dw_pcie_rp *pp)
>  		return ret;
>  	}
> =20
> +	mp->powered =3D true;
> +
>  	pp->bridge->ops =3D &meson_pci_ops;
> =20
>  	meson_set_max_payload(mp, MAX_PAYLOAD_SIZE);

[Severity: Medium]
This problem wasn't introduced by this patch, but can
meson_set_max_payload() and meson_set_max_rd_req_size() inadvertently
clear write-1-to-clear status bits in PCI_EXP_DEVSTA [1] when
meson_pcie_host_init() runs on probe and resume?

drivers/pci/controller/dwc/pci-meson.c:meson_set_max_payload() {
    ...
	val =3D dw_pcie_readl_dbi(pci, offset + PCI_EXP_DEVCTL);
	val &=3D ~PCI_EXP_DEVCTL_PAYLOAD;
	dw_pcie_writel_dbi(pci, offset + PCI_EXP_DEVCTL, val);

	val =3D dw_pcie_readl_dbi(pci, offset + PCI_EXP_DEVCTL);
	val |=3D PCIE_CAP_MAX_PAYLOAD_SIZE(max_payload_size);
	dw_pcie_writel_dbi(pci, offset + PCI_EXP_DEVCTL, val);
}

Both helpers perform 32-bit read-modify-write accesses at offset +
PCI_EXP_DEVCTL, which includes the 16-bit PCI_EXP_DEVSTA register in the
upper half of the word.  Writing back 1s read from PCI_EXP_DEVSTA clears
pending correctable or non-fatal error status bits, and using
dw_pcie_readw_dbi() and dw_pcie_writew_dbi() would avoid touching
PCI_EXP_DEVSTA.

[1] https://sashiko.dev/#/bug/linux-607d4e29-7318-49b1-a7c3-c91a4c4f26a0

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114-b4-pci-mes=
on-suspend-v1-0-be3d04a13304@iav.lv?part=3D2
