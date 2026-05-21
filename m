Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269103D7D74
	for <linux-pci@vger.kernel.org>; Thu, 21 May 2026 13:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779370998; cv=none; b=l9OPFY4JsvyYjTpLIcWG+7AeLGnZ7gb0+5l3BlfJxmXh7ISYACu7Of9TB4HRg8lPw/t/L3YWvdubDr2DXV+B+JZVIo/Lq/NVsrx8qHsiDA7cqbWJzrPzj678E4oUhX0ykOVa4bWQ4O5PhTK6BQlkl+pfH0HF0v5hjNBuQDSgflg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779370998; c=relaxed/simple;
	bh=09QTSyPQ9okMVOh+EcEfrzTAV+TRPxhoto31R2s8wvQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jTF7no63V5i/QrH3c1KQR3mN8Tvl9FWvqtqmwz0qKJfx8r+V27ReVSAYAORBjPZLgDsZgP++wmAIwB32LDkxBqnhDrPJMA2ZLI+z36q2ky3OYIxnYS53Vjhdyj2nwNfyQwOAQsoq31EgSCUy1tTn6OoUp1PD/Jz2khN1ckZYrkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i5BJBy6S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i5BJBy6S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B9821F000E9;
	Thu, 21 May 2026 13:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779370996;
	bh=zhDFGbwzEpT2wZ4v12gWB0teXiBE4KiXnHSxklDbAYE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=i5BJBy6SYKiHqIpvS6Q4Z58Jsem8lwu4o2HFW+QytikSvT+aE6/q3maBtcdmvylCx
	 zpbWjoXrSw80ZStnO9RG3eEZcFLQRhRykKRZOq2D4mxr+3m7fjXBDDAWnD47Phg1Zf
	 JKsecwGDiq8ZTlBInp1mTF/nF83v2clJL3mCgs8nd6tXKhby0USeEnG6HCxa4BnT9Q
	 HE+jrRRSml+N3NCM+JUmyoCKel8z3s28/goS1ZZdwtjOspvj/inkj66AVuWnlnnpop
	 0/jEcXg4bhWIBd5z586D8yfJjbLAhx+UqJaSLKaniqPn0+zI2j1ZQaxrpYuJmrxND0
	 aqnZUcpmIoD6A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/4] PCI: qcom: Keep PERST# GPIO state as-is during
 probe
Reply-To: sashiko-reviews@lists.linux.dev
To: "Krishna Chaitanya Chundru" <krishna.chundru@oss.qualcomm.com>
Cc: linux-phy@lists.infradead.org, vkoul@kernel.org, neil.armstrong@linaro.org, linux-pci@vger.kernel.org, olteanv@gmail.com
In-Reply-To: <20260521-link_retain-v2-2-08ed448b081c@oss.qualcomm.com>
References: <20260521-link_retain-v2-2-08ed448b081c@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 May 2026 13:43:15 +0000
Message-Id: <20260521134316.8B9821F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Silent hardware control failure due to incorrect GPIO direction wh=
en using `GPIOD_ASIS`.
--

commit b4b7937282f9b2dc2dff52265ec3936b1024af9d
Author: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

PCI: qcom: Keep PERST# GPIO state as-is during probe

This commit changes the PERST# GPIO request to use GPIOD_ASIS instead of
GPIOD_OUT_HIGH. This preserves the existing GPIO state configured by the
bootloader or firmware to avoid unintentionally asserting reset during
probe.

> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/control=
ler/dwc/pcie-qcom.c
> index af6bf5cce65be..bfe873cbf44f6 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1707,7 +1707,7 @@ static int qcom_pcie_parse_perst(struct qcom_pcie *=
pcie,
>  		goto parse_child_node;
> =20
>  	reset =3D devm_fwnode_gpiod_get(dev, of_fwnode_handle(np), "reset",
> -				      GPIOD_OUT_HIGH, "PERST#");
> +				      GPIOD_ASIS, "PERST#");

[Severity: High]
If the bootloader leaves the PERST# pin floating or as an input, will
this cause gpiod_set_value_cansleep() to silently fail later?

When using GPIOD_ASIS, if the pin was not previously configured as an
output, GPIOD_FLAG_IS_OUT will not be set in the GPIO descriptor.

Later in qcom_pcie_host_init(), the driver attempts to toggle the reset
pin by calling gpiod_set_value_cansleep() via __qcom_pcie_perst_assert().

Because gpiod_set_value_cansleep() enforces directionality, it will
return -EPERM if the pin is not configured as an output. Since
__qcom_pcie_perst_assert() ignores the return value of
gpiod_set_value_cansleep(), the reset line might never actually be driven.

Could this break PCIe link initialization on platforms where the
bootloader hasn't set the GPIO direction to output?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260521-link_retai=
n-v2-0-08ed448b081c@oss.qualcomm.com?part=3D2
