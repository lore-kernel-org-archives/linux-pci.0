Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795603517;
	b=EbCzk0pAoiAQ6DJWzlVryqLW5Enzx14Lyayx2XiE7SMjBlpFnZxihj4IrQ7Uq4vGjebb
	 Hke5+QHij11IazDXsJGTspjt3iQAOpPrBHTEM34/s11/K/bHblTdYCeRLzfOqME1txlEN
	 wtXm7OmxLdCnh1eKMShCgGM99yBtZAEFpcnN82HVoQIGpL9awuEMdAtVTzSW2IdGayjX5
	 bS3L1Mq1BbYi6ei7ebfSRSw3DLTTecnE0k75S5MOzIweEbhjM9U5C4SogQLBADatAp6KM
	 ZTFDRCuo/l9rT2rtcXPMrlyfgBSxRWX/Spzsq/of/5f0xDs2CIuYgnYBdO43nTI1FKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795603517;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=r5mUNik5S3s6lNfOvdH2YejAnGh/8Zs/9s+olobSCxY=;
	b=hQobxHVPuNpv7Jf/v+E+w5tYxOcLAlHfiICpeB3/4wjmSO4PVeaET5GkMZsEaW5ssVM2
	 HNGNQ/R3s1PWNTGC2+SlLrIKBSD6RU6QRzmCa11naehXqRaVEQ1WOEGlxXWm9ux2BZpr5
	 TS0XLeBwgoiRJdZ+8pXflBwt+cKyHTfpuZPD6Xq3nxQ52BuFHn0gbin4PkCr7WNZtsA/m
	 +eeYj/TK32m9g22cVtH2ageW09e9IUIwaSUMv6L9pGbzFsxhuTqdvuAU7MaSmKFKwJXfA
	 mbNzMQjWXou9i2IVtzjxIroVsPYNsro5yTqj+6yIZ7Z/pEIS+rLeohNllukmaIwIM6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UoeXAcK5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3837B606A31E
	for <linux-pci@vger.kernel.org>; Wed, 25 Nov 2026 10:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UoeXAcK5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFE4E1F000CA;
	Wed, 25 Nov 2026 10:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795603517;
	bh=r5mUNik5S3s6lNfOvdH2YejAnGh/8Zs/9s+olobSCxY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UoeXAcK5ma5T4fgDD2+sX7+LAeDOAhl5enDEhqgOtcGiBwFXMR59x0tXumQV8RD+X
	 kLX5wGzrSgFq+hv/6rDscUdvym/wLnjjGju2PRtlabKcmRZJNdcbvATry+ENmeLPO+
	 04nPMvCUHiBl3hJRZaE7Wi9KcMPiiKxty9oSMix3VhFb5H13GZhbl9nngWH1/8NqKA
	 pVSZPUvQ+4R8BPtxBHWnwibxl0uhMjqonvrDOZlVoP5FfSVhrLTkPODDRR4glhjIiW
	 Iocs3nFulqKv3R0fUHKPQyEIzkbKCXw9RTOjsiY4Cz735O8KPVFdvirdul9oZcXbKa
	 x8alKbK5X6x+g==
Message-ID: <sashiko-outbox-233156@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 0/4] PCI: qcom: Recalibrate the PHY on temperature drift
Reply-To: sashiko-reviews@lists.linux.dev
To: "Manivannan Sadhasivam" <manivannan.sadhasivam@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261125-glymur-thermal-fix-v1-0-b93a9feae156@oss.qualcomm.com>
References: <20261125-glymur-thermal-fix-v1-0-b93a9feae156@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 10:45:15 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Sashiko has finished reviewing this 4-patch series:

- Patches 1, 2, and 4: no issues found.
- Patch 3 ("PCI: qcom: Recalibrate the PHY on temperature drift"): 8
  potential issues (6 Medium, 2 Low)

A detailed review has been sent as a separate reply to patch 3.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125-glymur-the=
rmal-fix-v1-0-b93a9feae156@oss.qualcomm.com
