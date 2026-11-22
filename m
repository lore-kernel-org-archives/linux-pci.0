Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795316911;
	b=bPLJMUKSfgzoguxu6k1Gyc7jsZU180quNSQWO0wN0UxzBvOJLpXOsUiaxHoFIhwgt3hE
	 Wxv4DLe9pJ3nS7ybJAcq4aw7NRUmXQ9EC+ac+OVkV6tpYpFodvMppyRfsXaw/VJTRcxSt
	 JgrXF4sRVpnWW3KxaWOuoqIB4DkKbx9JNTLYBV2vqDdP9f+ttUqssuJFttgK3lzaeMQQp
	 UuJWmTZzWgnvX94T4MjUh65YAr78Y/kuf0Tka7TeZGSwVaHUex63cIF4G7XGug2EBM1DC
	 +t2fIw/KkOKtw8Rp4523dR2TtgUySEYLp7KN37ARsCca6YrMGx2zfJXBa9LjrZHkD8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795316911;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=wEh8EvlkwVchu46Tvm8gYaXQPdaWnhAjdg3zCaI4Hls=;
	b=1ovtCesfggsYlrU1ow1npnzvQMtJNlxnHZHYjaeJYVxuX2C8diAAmwyHqKNXWu7jQGHp
	 hwdneSwEmxXmlwANvtn10tUkGF9Su5uJHIJsiF1rF12OmQDceDK8docoj0h8UVTv4uLZW
	 0nawPOg0tu9SfvMBrmKG53zfByuhB3eI/j6ue/suicvgZufvbjfVUKPmmb/lzHObU14D1
	 sAjiWKY7iC8yNveEb/BD7z1BsFVNHgTr4GKq0Zlj+JdI38l5hqZ9P1Er8npdAcpfRCI5a
	 iMNhln889oVksWSsSfOp9n/cTIKa4rE7eUpTsOz7o3iMjmDmV7fr/cPg19mZuWxqe/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CvqfHAGc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2EF1606A320;
	Sun, 22 Nov 2026 03:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CvqfHAGc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43C611F000C0;
	Sun, 22 Nov 2026 03:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795316911;
	bh=wEh8EvlkwVchu46Tvm8gYaXQPdaWnhAjdg3zCaI4Hls=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CvqfHAGcTc6EmjtnK2KtNwI2lYOqcUOgUgBuu9BItd4vP5ddbpGMPxTW62SSKtLqH
	 2dxr84GDCUHuz7ONJoXsKheK9ePtu+RnG/ip92ig8tkD9rpA3C2rTpQ/eTx7ts82yK
	 kc+Rph7vSIjpJjJqSXjpcrw5Ubr1POgQm0jffWPeZnX7Hugl5GYjHQioXxSJUnCNTw
	 SIqLBfDuWe4HKEx8FMaiWCxudkSc7odS6tSZwxAm7YJGWL5UGQYbW/al4zYscEIjdk
	 B+Bk+BaISJgLLVtEiAGmw1U6VxZnnUy1DyT5E4cCJYxkL/BwzHqoM0wiag0Cuc+XFa
	 FlhvrOynGJpcQ==
Message-ID: <sashiko-outbox-227664@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 08/11] PCI: qcom-ep: Add Nord PCIe Endpoint controller
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Krishna Chaitanya Chundru" <krishna.chundru@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-phy@lists.infradead.org, robh@kernel.org, conor+dt@kernel.org, vkoul@kernel.org, neil.armstrong@linaro.org, olteanv@gmail.com
In-Reply-To: <20261122-nord_ep-v1-8-6d8839ffa9aa@oss.qualcomm.com>
References: <20261122-nord_ep-v1-0-6d8839ffa9aa@oss.qualcomm.com>
 <20261122-nord_ep-v1-8-6d8839ffa9aa@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 22 Nov 2026 03:08:30 +0000
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
- [High] PCI: qcom-ep: unconditional msix_capable in cfg_nord breaks
  7-reg instances
--

commit 04b8653283bc8abe57f3e64a544c24c1195d37c3
Author: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

PCI: qcom-ep: Add Nord PCIe Endpoint controller support

This commit adds the qcom,nord-pcie-ep compatible and cfg_nord configuration
for the Nord PCIe Endpoint controller, including per-channel HDMA register
spacing via ch_space_sz.

> diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/cont=
roller/dwc/pcie-qcom-ep.c
> index 335207de8f0cc..79acedb301974 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c

[ ... ]

> @@ -985,7 +989,16 @@ static const struct qcom_pcie_ep_cfg cfg_1_34_0_fw_m=
anaged =3D {
>  	.firmware_managed =3D true,
>  };
> =20
> +static const struct qcom_pcie_ep_cfg cfg_nord =3D {
> +	.hdma_support =3D true,
> +	.override_no_snoop =3D true,
> +	.disable_mhi_ram_parity_check =3D true,
> +	.msix_capable =3D true,
> +	.ch_space_sz =3D SZ_4K,
> +};

[Severity: High]
Does setting .msix_capable =3D true unconditionally in cfg_nord break the
Nord PCIe endpoint instances that do not support MSI-X?

Per Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml,
qcom,nord-pcie-ep nodes allow 7 or 8 reg entries because only one Nord
controller instance provides the 8th "msix" register region, while the
other three instances have 7 reg entries and no MSI-X support.  Because
qcom_pcie_epc_get_features() reports epc_features->msix_capable =3D true
solely from pcie_ep->cfg->msix_capable, binding pci-epf-mhi to any of the
7-reg instances leaves epf_mhi->msix_phys as 0 and causes
pci_epf_mhi_epc_init() to fail with -EINVAL ("MSI-X BAR address not
configured in DT") instead of falling back to MSI.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261122-nord_ep-v1=
-0-6d8839ffa9aa@oss.qualcomm.com?part=3D8
