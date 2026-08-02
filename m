Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C433B38BC
	for <linux-pci@vger.kernel.org>; Sun,  2 Aug 2026 15:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785684395; cv=none; b=ao6Ro02N8VUHGl8RWUnn7AbACEoYjWmxyJIQqS/1XKShME+pvtx4zgPYn3A0JfL8P7q1HasnkVgh3SxDci0Lq5Gbv3J/JZmpGbMz4MtMErxac8SoNmEEmQaz2gEkiqUZlBuKPnJ3zeRqQuzHKduJGOYTFqQxdjUVmfHd/a7kgYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785684395; c=relaxed/simple;
	bh=udk3fGEP7gVHKcuzBM8ae05KzrGX9CI87aGcikp7SLk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Gi7qRWlFCp/knx8wOqxWGd4YEKEMTf7LdEyfahT6NcXozK4WNh2brYbq3vanN11OBNN0VJrg7MvsNquX9ApLEENE29xwXxVoCQ36v73FOW3p+vLB0dS71ImdvheVLyYqV93CmDaxxDp9ne3r/KulZVltkO8/iyG9qMcuAED8M5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AHQTZsqs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AHQTZsqs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 422651F000E9;
	Sun,  2 Aug 2026 15:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785684394;
	bh=udk3fGEP7gVHKcuzBM8ae05KzrGX9CI87aGcikp7SLk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AHQTZsqsitzvfV3obf3edWnDxRbYwcF3JjR507+viY3emae3yWhRx59EHX20/ilJn
	 Jcc4D0HwX2Na3Bt9aDmXICxG98trm9/ouUplkn6ZUgfPUwvKewfTJuJdHQgmRFlwPU
	 uL1RwVXVYSCz+GjDGsl1fId3eHgOR14KAO4UaCP0yGTD+PE48Gt8YWutAGRGCfpsx5
	 +bjfBytnSLG0UqaMKWjCib6SToQjthEA9c7F7L/9RpV3vbnrRvH+zsiHs//u4XGqwG
	 ovH6muqKVKMz8RlAlxqy2cksER1ufPtVNP2UKRGbKdxIIKe/mxxfDS5VL/naf7hqtT
	 Bz/Smk61207EA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 03/13] PCI/P2PDMA: Document the Address Type assumption
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260802-fix-p2p-acs-v1-3-a7c5eb64fff6@nvidia.com>
References: <20260802-fix-p2p-acs-v1-0-a7c5eb64fff6@nvidia.com>
 <20260802-fix-p2p-acs-v1-3-a7c5eb64fff6@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 02 Aug 2026 15:26:33 +0000
Message-Id: <20260802152634.422651F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Leon Romanovsky <leonro@nvidia.com>
>=20
> P2PDMA selects a mapping from the ACS controls that govern Requests
> carrying an Untranslated address. PCIe r7.0, sec 6.12.3 routes a Request
> carrying a Translated address directly to the peer whenever ACS Direct
> Translated P2P is enabled, regardless of P2P Request Redirect and P2P
> Egress Control.
>=20
> An ATS capable client can therefore reach the peer on the direct path
> whichever mapping is selected. Record that assumption.
>=20
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260802-fix-p2p-ac=
s-v1-0-a7c5eb64fff6@nvidia.com?part=3D3

