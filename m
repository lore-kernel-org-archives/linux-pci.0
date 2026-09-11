Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AFC03CC7CA
	for <linux-pci@vger.kernel.org>; Fri, 11 Sep 2026 23:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789170188; cv=none; b=LJbdowTmIPWagyxA+jt5hPXmFilTXih8QfTSJIUAPaKmUkeYWuMGsNZgl/AD1FgT37XBnzgMZCOIBcglrac+4eMKcbufwWM1Tuo76ntv70gy/+Nt04UX5TBW31UCyEVBDLES93h+ggEo7ryVZkKS/MySg3Lf6FBw8UR9zEkxgtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789170188; c=relaxed/simple;
	bh=/0y3yQkBx4lzIS9egl1KMYw9H+fAnx/gvUUNtaYOJ9M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AugI2F5pPaibUEW69YRI9PliEPlOmFx6vTfOn0yLDX5KLiUNTBaPMovVrc5p+4905GxbEu806jxKIoi1hpe3zXMvpm2crG/ruvu8PU6L9yYsMhjAIUut8fwmG12u8Wx9dynO1x2Js3T/yoVdedEMWbjpMdCH2ZVd3RcyXAu4KVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nodos5Qb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nodos5Qb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D25A1F000FF;
	Fri, 11 Sep 2026 23:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789170186;
	bh=FhPPv1rxraajubFkr7PpEiLOGr6Xi61Qi/Q/+P5j2GI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nodos5Qbs10+61a/0Afw06C4iVCHGxVAj61eF8EUjkLRXrmgtZ5J/CdE9gXkdAZWs
	 nSR16anEjsKRiuXPRpOLqz6gEiZPTbEIXZuVoCuzd7d3fvEjl1UNtRjFCmOh2ys3SF
	 9t0Vu798xsHZX8d5D9apn7wGBbAuFjwFnCErQidJS2t0hXbIFjUeAN9CZrzX5tAYAp
	 eX7SlqDgPkzrwDWhkYjMupQ+nZN5pJzs7OU/dANVrq/DxVBQzMpf5etcCxUxBiljMy
	 /Yl1S36Ftb0FKNrJAOMtmbQhccPp2PYjPdKE95pD7I6ks/t0nHfdby4Z/Vw6jgy4zn
	 8/d1zIZbgyFCw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 08/13] PCI: brcmstb: Declare and assign quirk
 NO_RGR1_TIMER
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jim Quinlan" <james.quinlan@broadcom.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260911233541.1650895-9-james.quinlan@broadcom.com>
References: <20260911233541.1650895-1-james.quinlan@broadcom.com>
 <20260911233541.1650895-9-james.quinlan@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 23:43:06 +0000
Message-Id: <20260911234306.6D25A1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Very few SoCs do not have an internal bus timer whose timeout value may be
> adusted for L1SS operation.  Declare this as a quirk and assign it
> accordingly.
>=20
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911233541.1650=
895-1-james.quinlan@broadcom.com?part=3D8

