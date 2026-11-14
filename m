Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794619083;
	b=B68V5LF9GWmpAao3+GWQAdbfo2VcQiKRIEgi8AE6B6qF+EXMjz/MZG1nCBLG9oMgcNwy
	 QuvrCcVJZyqSmjmQSGAHNPRNe6yGnIOi/oVCvTeUo7uVJ6e17jZDZPbZ3cydnoDbnuC9h
	 Lo1fDrDI/2D1rdtnP6ipoz5FozA56hdGRKXzbbALl433e3WFYJRmRAtH8mJY8NRTeaM0L
	 T8cjo2gDKwfZaY5xxdc6ERLLn8HeyO1kV9RBjWsWCDfljzBYaUxKcBQZnh9yLUeOOzJ6p
	 ehlOWc7m1js4+xbxJUdugSDu9E3KfHY7uUY3poT+wmsW5DGboxh/YNsh7dR9WJiyhcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794619083;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=rHu1pLcg3VwZxy6J+9TzuIDbS77c1z3hA26yZSkO1Ks=;
	b=tBGnT2VPCRq5nE8EqLCmgPNOpy7NQI4b7Ox9tvykvSQIpntgypWBbxI2s7mQC25SoZyA
	 0nlJR/hoCaVZftaTdX29eobH0EL7wxTWazGpxBKNmRyixdlPJ6+wTTdCA0Ya1Aq7vHCxR
	 01ld0GVg6vSqCXNOpXjO+x6at7CrCjzN2JUUI7dVcShNfCXTKNzcU1G2LD/cmbpjx/IEB
	 pWSb6uKR2hAziebICCKcgNPBT7B9/VNFX8Iu1FeoA+Ik58t1QJq6+AU5UP8SfLXpRHmRz
	 Ig9pfoaiwiDdY6HvDA2F9JW16hRSwCMYJ50eLg57A7qAYU1Yz/PhH/Jo0MDLGKVOLJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OMmLzOSd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EEA606A33A
	for <linux-pci@vger.kernel.org>; Sat, 14 Nov 2026 01:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OMmLzOSd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AB831F000C4;
	Sat, 14 Nov 2026 01:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794619082;
	bh=rHu1pLcg3VwZxy6J+9TzuIDbS77c1z3hA26yZSkO1Ks=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OMmLzOSd9xn6NL8vp/SHyatY0hJdFkwaoAERiglwvAajvZRGLSbiQPN/MD9drLQVm
	 ZOFhhek7YMWfw/Y+MbwoWkXF2N//IR2iryl4aW6SlkpQZWpQk521hXYr+cIPFuPtXB
	 beI6BCLZNyDeLc8IUqFiPZ/kFV1H8N2KbUMYrpOIqf5GzGu+2WEdmmNDyuI6/Gl3yB
	 RcFYSRWr2pbxNp7f17a0JJXmRtsOmYfmH2WnSglGnx4T8xRDu6FW47/erE7/NBn+XJ
	 CSQSu069VwawmzvRjfQBFSyFzVEZWAbTvDde2KlhfSTBymeviZCXAfVpggWRhzaMQY
	 112+BXYBx/f0Q==
Message-ID: <sashiko-outbox-213999@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 5/6] arm64: qcom: monaco: Fix pcie1_phy compatible to
 list qcs8300 first
Reply-To: sashiko-reviews@lists.linux.dev
To: "Krishna Chaitanya Chundru" <krishna.chundru@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261114-monaco_ep-v3-5-7fe227cdfac0@oss.qualcomm.com>
References: <20261114-monaco_ep-v3-0-7fe227cdfac0@oss.qualcomm.com>
 <20261114-monaco_ep-v3-5-7fe227cdfac0@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 01:18:01 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> The existing pcie1_phy node only listed qcom,sa8775p-qmp-gen4x4-pcie-phy
> compatible, since no QCS8300-specific compatible was documented for this
> PHY at the time.
>=20
> Now that qcom,qcs8300-qmp-gen4x4-pcie-phy is documented, list it first
> with qcom,sa8775p-qmp-gen4x4-pcie-phy as its fallback, matching the
> order used by the pcie0_ep and pcie1_ep nodes.
>=20
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.co=
m>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114-monaco_ep-=
v3-0-7fe227cdfac0@oss.qualcomm.com?part=3D5

