Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD70F317164;
	Wed, 23 Sep 2026 01:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790128401; cv=none; b=k1KdUFUh1fhfzdBzxzHSsto0yOXn2347KfXlooR612rbrdnxprzP2W5jJYb9UC9Mu7c6aF4z3tl/Ki+4ziUAdbbOvMifeESNAKdMwzUC/S0ceHpc3Fa1j5Qq8Q69/3QmOqNuGmaWPrkpeTMIkLC3WyKx4yDMo6Oghf3LQC30qiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790128401; c=relaxed/simple;
	bh=j338SFZ7SQaaPwRqvBJj4xNSrIy6yPBwUIb+1/ATaYI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iWsSJd+vEkZ7wATLq5CaysuuHD/LNBnvc8HqZCR+fy+KDnARqlVUnyJXvQptRqxGLLDxhvW9H532n6JuRvuS2aqUgmjG0aSHEqRD4NhFSx2m+klXzJ/69D1pNUlSPQqi/L2RNbUol7Ir0KOEtbXIfaQaGpbmkTMomZ6L+SPM+IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b77E0gfS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b77E0gfS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 157BF1F000FF;
	Wed, 23 Sep 2026 01:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790128400;
	bh=j338SFZ7SQaaPwRqvBJj4xNSrIy6yPBwUIb+1/ATaYI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=b77E0gfSsVYzk6HJAJHBO5UET9+A9+IFpoh4BVbGx7d+1+1uD2aLAczZdZ+DQRjth
	 8Tl32AG+NtyeQ2A9mRidzlJXm9GnA8QbZXM+UbRRn+Z6m2eb4elPEEtDFOml/yis/u
	 1gYU52kgl+Cac0yFRQDyCs7+MzCDFg/CbK1q69dmLrTofZSeYf9r+aPQdLATUPgewk
	 Sdr/vnlXWVx0gHYdHyC8nemorhIFJyPZ3WuitC+b7HBiSeUgrVerGUReOWxTs/dTJz
	 uEe2bwm3e1PmF+NEZ4Af+zgWuZoL5lPZbHr29/pUyS5SHJ1D/r3/yKq5iXhOC1FMRt
	 FNQ82gSJWK4lg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/6] PCI: spacemit-k1: Add device data support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Inochi Amaoto" <inochiama@gmail.com>
Cc: devicetree@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260923015016.64069-2-inochiama@gmail.com>
References: <20260923015016.64069-1-inochiama@gmail.com>
 <20260923015016.64069-2-inochiama@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 01:53:19 +0000
Message-Id: <20260923015320.157BF1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> To reuse the K1 PCIe driver logic for K3 PCIe controller, add device
> data to handle the K1 specific logic and make room for the incoming
> logic for K3.
>=20
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923015016.6406=
9-1-inochiama@gmail.com?part=3D1

