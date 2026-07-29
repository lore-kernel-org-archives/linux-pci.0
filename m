Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3034B3B05AA;
	Wed, 29 Jul 2026 14:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785337167; cv=none; b=bTSYOb1FbAbO62kRZbisaI2V4KTCwaN4HfAOjYTP/+0qqB8WpIJ3/XRLmyARQ1N/whpCLcwT8sw0ncv7XLiZQqfG4ogNp85rXhReQi87NZPa7lKcoFcjWWjevug9QYerEMgT9JQkcryhDXFtfpEpxhXO4SOAJbyAbheIsDb0N5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785337167; c=relaxed/simple;
	bh=bj/UwuoUnJZ3tn86q+F0sxhjTWplfET/bLzCnsxJssA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FrM9OS7GDrxNwRt/i4NTCFq1Oa0Wx6aYZ9EHZ5FOj+gZ//5VezxB3XvgwuZWAwOlNGx0CQx83k4NPa4fI8rekEojBvQLkrYZgri1A84qhWsqCIqhLWp3MdWMbyIhsHQn4AsOiS7xi5fsQpO/11ncYvPwS6oUWRzhQBdCuUrpHuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AxOWZQh1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AxOWZQh1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 943F81F00A3A;
	Wed, 29 Jul 2026 14:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785337165;
	bh=G+tZjvFhxq6UIzAaHPAhGRKGSA857DTEum5PlaOx5dI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AxOWZQh11oNMAbynPPs/tjCueqW1bu5Zs+vxFD5AEesVuVH545CiLeeGY0Y59uFLJ
	 2EAfhSMwzvKjqES26vRp10al5H79sx2jvm5rcR86javGIQrtjSb6Bxzg2wssKD02LK
	 r10HIYsbSW6QP4lz6NnOEso8/RUpnLigWela7k9gSKHdtt5KDbMDNOiuuEPhgjQrmG
	 dEs3zXO1ai9Mz76pDky9XSSrsbUc44l2I5MsMqFefe9uXsGOChcG5ZdgDQZB3lgQ2Q
	 WjfdhRnZul9BdSUSwePbSiEug5YwKSqeUg97uPvcrCtqJ5GX+DU0iArNJGHP+QlWUQ
	 1FsaeZjB9Zm3A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/3] arm64: dts: qcom: eliza-evk: Add PCIe0 with M.2
 E key connector
Reply-To: sashiko-reviews@lists.linux.dev
To: "Krishna Chaitanya Chundru" <krishna.chundru@oss.qualcomm.com>
Cc: conor+dt@kernel.org, robh@kernel.org, devicetree@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260729-eliza_evk-v5-2-41790a5a24de@oss.qualcomm.com>
References: <20260729-eliza_evk-v5-0-41790a5a24de@oss.qualcomm.com>
 <20260729-eliza_evk-v5-2-41790a5a24de@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 14:59:25 +0000
Message-Id: <20260729145925.943F81F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Incorrect GPIO polarity for the W_DISABLE2# signal (`w-disable2-gp=
ios`) on the M.2 E key connector.
--

--- Patch [2]: [PATCH v5 2/3] arm64: dts: qcom: eliza-evk: Add PCIe0 with M=
.2 E key connector ---
commit e61546d91652b5590b157402a4ee5bfc16fe5075
Author: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

arm64: dts: qcom: eliza-evk: Add PCIe0 with M.2 E key connector

The Eliza EVK board features an M.2 E key connector connected to PCIe0.
Enable the PCIe0 root port and its QMP PHY with the necessary RPMH
regulator supplies. The M.2 slot's 3.3V supply rail is GPIO-controlled
via a TCA9538 I/O expander on I2C4.

> diff --git a/arch/arm64/boot/dts/qcom/eliza-evk.dtsi b/arch/arm64/boot/dt=
s/qcom/eliza-evk.dtsi
> index e47b24f8b8277..b35fffb509765 100644
> --- a/arch/arm64/boot/dts/qcom/eliza-evk.dtsi
> +++ b/arch/arm64/boot/dts/qcom/eliza-evk.dtsi
[ ... ]
> +	connector-0 {
> +		compatible =3D "pcie-m2-e-connector";
> +		vpcie3v3-supply =3D <&vreg_pcie_m_3p3>;
> +		w-disable1-gpios =3D <&tlmm 35 GPIO_ACTIVE_LOW>;
> +		w-disable2-gpios =3D <&pm8550vs_g_gpios 4 GPIO_ACTIVE_HIGH>;

[Severity: High]
Does this code invert the expected logic for the Bluetooth radio?

The W_DISABLE2 signal on an M.2 E key connector is physically active-low
according to the PCI Express M.2 specification.

Using GPIO_ACTIVE_HIGH causes the kernel power sequencing framework to
drive the GPIO low when attempting to logically deassert the signal and
enable the device, which will effectively disable the radio instead.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729-eliza_evk-=
v5-0-41790a5a24de@oss.qualcomm.com?part=3D2
