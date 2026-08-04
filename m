Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4D948986E
	for <linux-pci@vger.kernel.org>; Tue,  4 Aug 2026 03:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785815163; cv=none; b=Cn3bvqcgkX3E5PBXDuPeyEABGZrAJ3rPfHTMgtqOhuj+9tv1Kc1+qrD9KmW2TYWRxPsLYhmUgV0SPJtYfprC9jXKAxdv/sqCCBBp0E8UOtabWfg3KtBQDLhhaEZwSbfnnOS9kgaDNmvlEsBhndhn5yW57UnTC4wGAhskYq6BJIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785815163; c=relaxed/simple;
	bh=jb9AI5ut4GeR83DK1yCo8Py0dRtMIdw9+zqTSSaSQSI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Cg2q/Sj9YBpvPSwKgzuJlCGF6352m/Cqg0Yj5TUrAQu5fHEc4n8MBGsPc0kMNsJjEELtfjncS0nKgis0LxoQ6yEpa5HRRLNdjRYUsbpmUsklyw/Px2uV7e2UTqEA1vVHrszBmWDGKWoEHG6NQ9XDlMi+WyGV8vQd/OsG9wD4rCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fdwi3Vdl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fdwi3Vdl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49E1C1F000E9;
	Tue,  4 Aug 2026 03:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785815162;
	bh=jb9AI5ut4GeR83DK1yCo8Py0dRtMIdw9+zqTSSaSQSI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Fdwi3VdlBbb0st0JXgtljwtTIgt7vlu/Qt3Y9kKQxxemnI7pYi7TbvzuNibePqszT
	 yz3pjUBDbMqyCki2ysieYyuTkRKGO+eOCDWBBTflf0bw9sglbaaYrXGwNpY8bf6ltj
	 WyFpl2+dC3/VdH0mlWn9hMRXY0ARXXbjUU3p5vTTk8zcCWxrZrLmiBvEiFrz9rHbrw
	 tjyg8kAo78IpC9fKCGJwUhBExp0nctfbnkv+UmNqmZg7VPu6qO7E6XIHnLQ4NTxIyE
	 KtSSDUstIjmq46dPchPrBqdjKFXsmWSkBujtdFbiZ9deP7LuvXPsnXNfwy7OXT0G4N
	 RwEDtD3fWM3wg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 5/6] PCI: dwc: Implement endpoint DMA channel
 delegation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260804033855.2115817-6-den@valinux.co.jp>
References: <20260804033855.2115817-1-den@valinux.co.jp>
 <20260804033855.2115817-6-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 03:46:01 +0000
Message-Id: <20260804034602.49E1C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Implement the EPC DMA channel delegation operations for DesignWare
> endpoint controllers. The DWC backend uses the local DesignWare eDMA
> provider to reserve the requested hardware channel and returns it as an
> opaque EPC DMA channel handle to generic endpoint functions.
>=20
> Validate the requested direction and hardware channel against the
> linked-list channel counts before delegation.
>=20
> DWC eDMA/HDMA generates DMA requests with a programmable requester
> function number. For delegated channels, the host-side dw-edma-pcie
> instance bound to the exposed DMA function reserves the channel and
> programs its own PCI_FUNC() into the per-channel requester field; the
> endpoint-side chip func_no does not participate in that handoff.
>=20
> Reject VF requests because the RC-programmable DWC eDMA/HDMA register
> window is assigned to a PF BAR only.
>=20
> Reclaim releases the delegated local channel through the DesignWare eDMA
> provider, which returns it to endpoint ownership. Propagate the EPC
> quiesce request so bind failure paths can release unexposed reservations
> without touching DMA engine state.
>=20
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804033855.2115=
817-1-den@valinux.co.jp?part=3D5

