Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793104448;
	b=k+abECwdKj0ZVad4wpKB0TNLnp3foUzFtvVmoLIuqeQ9HmbLjx0Oay/wOyCWklHL7Hp+
	 AKhiRQ+gZkpEKIlgK65Ixo8DYCJxcbzd0KmIB8kA0E6jl+vVwvnH6e12W/LQd1aZe4mxD
	 lFscqhssS6TNwILL90tHc/AwH3fdIe5vDiclGz1gGfaFoNtqo9dSV8GP3HEjDTJQtu9EG
	 +X9JpuVWWw8EcnlRmJEuLHLaOYq4rXizWGYCP/V/UAMWRP9IP6Gwh92kg9wfTmtNYTcIN
	 uDhXvhL7QbKB4pGvviGTKQVHA7kMW/i0pFcWmj7A+9ATA2samKgdspmPO/jf4oQR/yw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793104448;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=H1mkUqhxEFXPGPFxRq3VSObhnGkJC3tHv2JXuO7hjGg=;
	b=UocFVeJERmDJ2EFVPVuyL70zw+FtAyP1G2eV4uFOc0PmznkaEC2WqJaZwW08HLgx/tk0
	 cdy5T5OdCy7drSSuZ4SY8PYPWgneAUhFi62WMvptIpUp23ZhOz0NVy7jLNUHa5VZnaCbe
	 PYwqt0xIGtsbGBhJ+EqkEFHQftQV0UWbKe/7/aSZf0A9nzrETCsi2XiSA66mO7IMc5SeE
	 4ZPyFxrL0G4xKEPmP1DspgV8pyrfDSns8g4mXESiSwpZDltn9wu/w7e4q34LHDMWpD3WS
	 TqN1QLug1trmsRQ9EN//kOYD6pkzc5eX/xf4e9XPUYlbbnk55leNnlkRBNjpUFgjF4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GO8+VtcM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886FF606A31F
	for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2026 12:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GO8+VtcM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB8671F01829;
	Tue, 27 Oct 2026 12:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793104448;
	bh=H1mkUqhxEFXPGPFxRq3VSObhnGkJC3tHv2JXuO7hjGg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GO8+VtcMJ8sXLrNnMqupLGVwxlktAeLiwkPWFTAPzjANQpeKbeqmTjp2p8I8HHhJv
	 UPpHWFJxr/0MwgdyxVFi2K08w3uFwIOOeR2tGQzIvSVn/t3OvaMnVgKUyT6Rnof3jY
	 4S1AHdgaFETH3/CoTKi3PMRp+P5pGb5r2gnBTWIM910D0UjKpTWgpf1yBlAbyozRnG
	 ZWWVgsqKHu8MmOC1DbHS0/zrtAvqxEbZH79uyfa6qhYqgjpBkniV4WDl/jfmLoLRMh
	 euXx1CJSwVwa2ogQaPGni83rGNQdklc63L1RrZPU64IQc/FnirwxDgowql+FRvm8YP
	 35x1TPc2C9orA==
Message-ID: <sashiko-outbox-186565@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 11/16] PCI: dwc: qcom: Use cached PCIe capability
 offset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hans Zhang" <18255117159@163.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261027122827.2725643-12-18255117159@163.com>
References: <20261027122827.2725643-1-18255117159@163.com>
 <20261027122827.2725643-12-18255117159@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 12:34:07 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Convert the dw_pcie_find_capability(pci, PCI_CAP_ID_EXP) users in the
> Qualcomm host driver to dw_pcie_get_pcie_cap():
>=20
>   qcom_pcie_clear_aspm_l0s()
>   qcom_pcie_set_slot_cap()
>   qcom_pcie_post_init_2_3_3()
>   qcom_pcie_post_init_2_9_0()
>   qcom_pcie_link_up()
>   qcom_pcie_icc_opp_update()
>=20
> Note that the .post_init callbacks of struct qcom_pcie_ops run from
> qcom_pcie_host_init() before qcom_pcie_clear_aspm_l0s(), so relying on
> that function to populate the cache would have left the offset
> uninitialized for them. Doing the lazy lookup inside each function
> makes the ordering irrelevant: the capability is searched exactly where
> the register is accessed, i.e. where the open coded
> dw_pcie_find_capability() call used to be, and every one of these paths
> runs after qcom_pcie_init_*() has enabled clocks, resets and power.
>=20
> Signed-off-by: Hans Zhang <18255117159@163.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027122827.2725=
643-1-18255117159@163.com?part=3D11

