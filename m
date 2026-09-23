Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B37D44C678
	for <linux-pci@vger.kernel.org>; Wed, 23 Sep 2026 07:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790148898; cv=none; b=YGAd4dMnPd+rvdbOAZEsFUwgL7gbhr88l4AZRuVrxNoSWjlZPjFtiup4LUqFsvYHWXZ7o6Csj3BXpM78/LZFQwJn9CLmLaSbPUO1o6oZ/KCxo3IhSPKONDEO5DXu/u0RBaI6N1HofHYbvoMY+CY2rHTyhxNEkkIeA6v3Mak31WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790148898; c=relaxed/simple;
	bh=D88RAHnoqba/Cy/cA1fjcFgs8MGMxtRDfXIQ//gOpTM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hvQ4UIVPSRf1VC+rAbXJk6k5xqjOZWNRixFsejnMvQkfPxT8/7emcX/OG1fjwK/XQcZaB9zJTHKy98ErY8O7M66v2xwbWt+WheUyzdlIKrvg1KolbSG6vZjlasn81rIvkc5I1qXiOKEyNrjJKA+rBTyPysq9LYwTA3VTatVBPJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TmepVe16; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TmepVe16"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE1971F0089C;
	Wed, 23 Sep 2026 07:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790148895;
	bh=D88RAHnoqba/Cy/cA1fjcFgs8MGMxtRDfXIQ//gOpTM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TmepVe16Eyiv0N0fXr64Asa6NO4Kpb1EsZZGWDU1EVfSEOyMm4x7I+MXc/YlVxhJU
	 HuqffIlKK/XL/Vi2gaxE7C8bQy0UkQm5XEwfzydKRjvX1dXkgmEOiUdKb4MpN2SFd6
	 iMbYiy4DmwNwwZfe182Z0XwLB4NyJtNgyFsflomGNUa0iNHXyPVK2FaopiWkSn+UoX
	 sgrLPGEFSfbAViA2k8FL2VSiBwozbQSRDedsJLMHfLugTkVH3katxJZssT6P7AuCB3
	 ksc4MAGKKvLcMaj/qbPhDMXNMW+FSH8enXpjrpSjuaR75pfLW4SLcdlweMJD7dZjIB
	 gOC8xv/uMXP8g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/5] PCI: dwc: Consolidate RAS-DES event counter fields
Reply-To: sashiko-reviews@lists.linux.dev
To: "Manikanta Maddireddy" <mmaddireddy@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260923071706.1134320-6-mmaddireddy@nvidia.com>
References: <20260923071706.1134320-1-mmaddireddy@nvidia.com>
 <20260923071706.1134320-6-mmaddireddy@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 07:34:54 +0000
Message-Id: <20260923073454.EE1971F0089C@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Use the shared DesignWare RAS-DES event counter register offsets and
> field masks in the common debugfs code instead of carrying duplicate
> private definitions.
>=20
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923071706.1134=
320-1-mmaddireddy@nvidia.com?part=3D5

