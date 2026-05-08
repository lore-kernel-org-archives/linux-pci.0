Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A97B10F1
	for <linux-pci@vger.kernel.org>; Fri,  8 May 2026 01:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778203757; cv=none; b=LeQAX/Ndce+EPq4u17aNPh+vQkrhAGgyLoZKKt1zInYzm/9yeFcjHVQAw+iGzKDK3CdFNbWwxMVQjtpO+UehZFScuSAmcS6rHec4ULxF61lw66cRcvNJYWdx5WX/DhuzoSBa2I2nHSk4pk8DItkTLwMnYRIiEoIf73o+ImjK2F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778203757; c=relaxed/simple;
	bh=YGuQwSfBTUvGmZMxjieGktWya+bHTKEaMd8XANNHPQQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eBAmKWXzz4qOMj489JJ0rRiY+OFFH9yBd5oEePemgjvWYdmsV4iY/pRajEzP+4ILYDbTVNV31cvja16KE3rPhCi8+oilUMlEVviLH6sGACfPvSG9NA+qt0Sz0NwkKQbTdvunGXjkAZAeHPUhBUjNHM0YX3qhKwp8zx5gH9Gm3ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dop7sBCN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dop7sBCN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3067C2BCB2;
	Fri,  8 May 2026 01:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778203756;
	bh=YGuQwSfBTUvGmZMxjieGktWya+bHTKEaMd8XANNHPQQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=dop7sBCNtz+/WwdD1Kq744b5yz1JRWWxnghTmCL9V1Akilx7TqyVXWb8qaqcR3d1s
	 dgjwVxoHBYJitoa/zYdz1NNzpfIm/kV9/vlqtIM+TG5i633x9VvZsnMWktGi6184HC
	 Shps0qg7Sn0B8mHW2vUz6T645L/jqL7xxS7HDThmZwKftLNuemCFtUu5fCkHg6LcTR
	 u/QPAVFvy2a0ououJJdyLiwqnoGE+NpOELe7LlFS3Qc8YWXAP8NO1LpC5DNtzAb9mB
	 mOAP/UEMKyw3i7mMIG/SQ+roPLq3gJhGORbROIKPzy14gQT8XkcqQa7zH2riVyXsXZ
	 SBEf3FX2tdNeA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] PCI: qcom: Add support for Hawi
Reply-To: sashiko@lists.linux.dev
To: "Matthew Leung" <matthew.leung@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260508-hawi-pcie-v1-2-0c910906f7e5@oss.qualcomm.com>
References: <20260508-hawi-pcie-v1-2-0c910906f7e5@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 08 May 2026 01:29:16 +0000
Message-Id: <20260508012916.C3067C2BCB2@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The introduced compatible string `qcom,hawi-pcie` deviates from the=
 established `qcom,pcie-<soc>` naming convention.
--

commit 190903f616d8f4e9c8306f764cc2fdb2f6027cd6
Author: Matthew Leung <matthew.leung@oss.qualcomm.com>

PCI: qcom: Add support for Hawi

This commit adds support for the Hawi platform. It introduces a new device
tree match entry for the dual PCIe controllers present on the system.

> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/control=
ler/dwc/pcie-qcom.c
> index af6bf5cce65be..80a238aa26b68 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -2121,6 +2121,7 @@ static int qcom_pcie_resume_noirq(struct device *de=
v)
>  }
> =20
>  static const struct of_device_id qcom_pcie_match[] =3D {
> +	{ .compatible =3D "qcom,hawi-pcie", .data =3D &cfg_1_9_0 },

This isn't a bug, but should this compatible string follow the established
qcom,pcie- prefix format used by the other entries?

If renamed to qcom,pcie-hawi, would it also make sense to move this entry
further down in the array to maintain alphabetical sorting?

>  	{ .compatible =3D "qcom,pcie-apq8064", .data =3D &cfg_2_1_0 },
>  	{ .compatible =3D "qcom,pcie-apq8084", .data =3D &cfg_1_0_0 },
>  	{ .compatible =3D "qcom,pcie-ipq4019", .data =3D &cfg_2_4_0 },

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260508-hawi-pcie-=
v1-0-0c910906f7e5@oss.qualcomm.com?part=3D2
