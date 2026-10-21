Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792591663;
	b=1/2bFmImuSfWjzVSja+t6Mehq8Zbc6nAf4akvUG7MdhL+fOi4TF7+BmGzeLXSaWqK86H
	 i7Fo4kWI5ZuZNRueohCexCiu2Jk6bw1MpVRg+Ta6+3DDEp7DJeqB7mNpSXTubK4zJzFIV
	 HHWN1G2s/UNfwUFM7x3DKX3Z2argLUqagVB9LLorzjHRKpjdM+GeO7Zb7kXDvMBIyLPUv
	 LVz4/Ap5XQKQDc1dHe2NnuNJKFiWnaxgWnOmWt60r+fdFqOTHce3EWZQ4o2vLQ8efGKkv
	 VV0bm+s60iU0jIiVpMnxRQrR2vVOO38MEloomCGA8tqXLiA36HSh4ZKDPHVKVnvteSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792591663;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=trtHOGTtTLrVcgpNN+TLTjZ9CJqLKZHoZlCTwxshGiU=;
	b=jmos5bAQMHstD9Y+hgkNlF87EAMlaOpHZngINkyrOfI72KMT/zGZvVr349qnrH5PGAKB
	 7hiGq9psH+E0PpnFrGEBvyz3lwFW1HB3wt+ZuDVB3jLQplNqb4AMIi5i7VP9tZMiyVPBc
	 NFSy7s5A+hnYATjHGCOqczZhiEN/w9OX50vhnoFTFdgkBBkXhP8y6XzxqRZhebusWiWy/
	 dtvrfRjv4X4hYj3lyQ82lUAMjQ35V8XrmWdnyHqcmjtgB7vPipWUCKsHB/RYHPf74ij8o
	 zOO/xQh4m5mdN0j4grEN0HqJx14UA3Oq4XmCEBN9q7EuFd26QuKZm7Lyu97oX60ZCCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LWms49C1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14593606A31B
	for <linux-pci@vger.kernel.org>; Wed, 21 Oct 2026 14:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LWms49C1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8815E1F000C4;
	Wed, 21 Oct 2026 14:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792591662;
	bh=trtHOGTtTLrVcgpNN+TLTjZ9CJqLKZHoZlCTwxshGiU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LWms49C1PU3JV+tSgitnhNdj5faEFO1uA2OLFRM2VkXlPMDg4wwuQ9PPk6fwe3MYZ
	 uT8BZaL34B3cnvJFegxb1GxCNObMlG8PGs4BlX6rA5UIxQwjdLifefTFBGcIpexr7j
	 hd/alqVaowxgMXJktq+scrQyjbui3kLd16QrFekqFww4AXjXAKScvitECAdXShuFXo
	 apzWx9RD84OknNU8xb1nuJLdQ+o4FmmuJBi6N3tLaocdiVheHMKSMeB49i+g7m7mW4
	 DT18t2ZyAVM9Pop2Wm/fCMQ8yMtgE1zKBq8goy5Yu703j2H72m93m6gvT3nChWQyJv
	 +LslwwfZrZaOw==
Message-ID: <sashiko-outbox-180348@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] arm64: dts: qcom: glymur-crd: Describe the PCIe M.2
 Key B connector
Reply-To: sashiko-reviews@lists.linux.dev
To: "Krishna Chaitanya Chundru" <krishna.chundru@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261021-pcie6_fix-v1-3-ad37134c35a3@oss.qualcomm.com>
References: <20261021-pcie6_fix-v1-0-ad37134c35a3@oss.qualcomm.com>
 <20261021-pcie6_fix-v1-3-ad37134c35a3@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 14:07:42 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> The Glymur CRD has a WWAN M.2 slot connected to PCIe6. Currently the
> vreg_wwan supply is described directly on the PCIe6 host bridge. As a
> result, the supply follows the PCIe controller power state and is turned
> off when the controller is powered down, regardless of the requirements
> of the device connected to the slot.
>=20
> Move control of the WWAN supply to the generic
> pci-pwrctrl-slot/pwrseq-pcie-m2 framework. This allows slot power to be
> coordinated with PCI device power-management requirements and keeps the
> supply enabled when required by the PCI device, such as for PME-based
> wake-up.
>=20
> Describe the slot as a PCIe M.2 Mechanical Key B connector and link it
> to the PCIe6 Root Port using a graph port/endpoint pair, as required by
> the pcie-m2-b-connector binding.
>=20
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.co=
m>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021-pcie6_fix-=
v1-0-ad37134c35a3@oss.qualcomm.com?part=3D3

