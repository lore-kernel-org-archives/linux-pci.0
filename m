Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC19F42FCA1;
	Tue, 22 Sep 2026 08:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790067392; cv=none; b=AhkZwcRKDxj/EUlSxD/srUFbGlWN6nig7TeN7i2atUc5Z1syAe+2TfLzkN5D0bXgXYYMaAmvGIPIZCZn5vP0TlxqOsDflSlKwLvNBFohV0pcE6Pz8V7/ysWX2JJhS4fjGMGhAXPGQuio5lD2IIZJWb+AWQenFf7UgMISxpneVG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790067392; c=relaxed/simple;
	bh=6eYSqkDMxx/4serteT3xEkbRZV0WQNEQBE8vpj8TcdA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KZpTlCRu1JQ1SzVk1Ijm02l7C3pt9Sd0yJqY1Eu27i2H6t7VNLaUSEgkQyAivXyjhxBTWOMDIxJqh1gvQdPnJO2/c47mmzt+63ka3UJpQfSWpPVUx7s2DE4CJ8AL/BCIbncxXQG2lczLFcx8sPvFy4rR1/N3ptM9GgF2mGCw4aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LjSdBWCg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LjSdBWCg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C35B1F0089B;
	Tue, 22 Sep 2026 08:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790067390;
	bh=6eYSqkDMxx/4serteT3xEkbRZV0WQNEQBE8vpj8TcdA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LjSdBWCgeR5va5pPbJLM5iH6xgx7NeLl2lXx8v4tusqukKXt0AoRxAidAXryQRLj4
	 sF9vxFbpT0uAa/L1pzP4QzdFrTohWbcVf2kvpJsgnZDBvFOcuXuSyNNo1ZNAYi8dVH
	 k8CXGOwZAGfU4DVuZqGi22TZOZLB/OLn8BC6g2WEHPNYI2B0vEIAOA/mL5NxC+d3Mf
	 4NL394ZAOocO4k3e5Y3QP2GL3X2yLOCYqd7MG+lC10okqHSs3S1kelGuhP+2UIU6Ot
	 ZpbEyKhGZfxuvMYeIQ56FA+NcvDmj4Lb4c2m0VkWNm665amyjSnRiiTLob+0zJdQ/B
	 uhCMuRV1ZTHeQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 12/15] PCI/CXL: Reject reset with unsafe function
 scope
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260922083924.2451158-13-smadhavan@nvidia.com>
References: <20260922083924.2451158-1-smadhavan@nvidia.com>
 <20260922083924.2451158-13-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 08:56:30 +0000
Message-Id: <20260922085630.7C35B1F0089B@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The per-device PCI reset interface must not reset sibling functions.
> Reject cxl_reset and cxl_bus for multifunction devices and PFs with
> enabled VFs.
>=20
> Reported-by: Alex Williamson <alwilliamson@nvidia.com>
> Link: https://lore.kernel.org/linux-cxl/20260626160846.426e71b6@nvidia.co=
m/
> Link: https://lore.kernel.org/linux-cxl/6a50441e2bb5e_3cabcb1003e@djbw-de=
v.notmuch/
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922083924.2451=
158-1-smadhavan@nvidia.com?part=3D12

