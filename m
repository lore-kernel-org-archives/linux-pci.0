Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C663769EB
	for <linux-pci@vger.kernel.org>; Fri, 17 Jul 2026 05:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784265128; cv=none; b=uUW8HdkoGyMCNVRvrIsTfnuIkrA2J8vvr+HrV/IDCjxJ7PcCxm+4xsRNcu500kSqkLbO4Ihdty0m2dhGhOFr0jmaf81G9ROcJRjndS1Qs0x9sLuUy/xdsFRcoU2/oxRF5Xv9p9Rhw+gFKVXUoGnbR4qsKVRjCC3qNg8zZTVUcKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784265128; c=relaxed/simple;
	bh=HGuzTZ5tK24zfqqzSm4BlJJO2sCImGOtD/nXNiDSN2E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=B0k1X/YZJzH6F0KzZJP+7GW9ZtLElKMA43NgR1IpwjZgXHdPWed7artIJOR7GqMYqmCLk7sIp+0u1S3rSZ0x1WlzwQ8vPwj61JwpK/c7y6J7RrdE+FZ3PvL53q3bG1Ig9QLL1FJ3ZarI/tqc3aAYaGBc3pEUCO1kn+OO4hJWDyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nvwI8cdE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nvwI8cdE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 698751F00A3A;
	Fri, 17 Jul 2026 05:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784265126;
	bh=HGuzTZ5tK24zfqqzSm4BlJJO2sCImGOtD/nXNiDSN2E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nvwI8cdEO720pd0NyOR6zCvDXCVfzffmRarfP1X1g6l1pkHlhHnXk5VaiSHmoTUWp
	 ANx25jDjAPH8HRhdiKIRpTb8v1yQUfmBDV+MCvvQdiMWboxas9kZGsSs9CmTPHqcvX
	 bfiWVg9kAPWCaCfHOVMu3Oonr/mSQ1qTO7ztteEzxfKbRG9L6fWB0c7fqtk8iGJtxv
	 kXEMBv20027eUtJGfvMimnm5mmilz7wU6Tqsc4nt/Fg5DZl2I7IxuwUr55MneQbtI1
	 j1nWlbUeixscZn15fSk+WiDIfzT2b9yFRcAWUKvOd+9vaVT4+uufzLWrd35qEVCCuy
	 b5J7kV9eaqULA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 6/6] PCI: dwc: Implement endpoint DMA channel
 delegation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260717050635.2145014-7-den@valinux.co.jp>
References: <20260717050635.2145014-1-den@valinux.co.jp>
 <20260717050635.2145014-7-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 05:12:06 +0000
Message-Id: <20260717051206.698751F00A3A@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717050635.2145=
014-1-den@valinux.co.jp?part=3D6

