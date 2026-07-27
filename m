Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1273876A1
	for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2026 19:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785181448; cv=none; b=hgeUN2PN3MEwu5GtP0gmCcGvQKC1mukRdtPdjUMYLVlEgpcbJdHoBnmUWmP8ErRgs2TpoW1TgDO+niI9ACZDI+rUcGxTGbyoyHjVMzJtv6l7ECVBwTIFpr6Gc960IcmZJOEXewgvg57ZRnLOof2sDs53Ib3adWgSZA4YF2UvsiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785181448; c=relaxed/simple;
	bh=RmfX1ipFOdeuBB/fD0LJDckxfdSlcLCLfA1By+UsCrs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Yw4qClqTM/D0TITTYN5ZOgTwTdOM1U6FB2vmcaJR8DkqZP7wwsHgHO1vGIx+ztWSjzx6YBJlbakydS+Et2ROwLbxOZH0/DhQ+Tzv1I37zaNiHE/00GK/PVC0tDRQQsTncjNEmUyZmJD9oBDpGL+h0tOJjVdbkp40bNNBwUIjr+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VQoZVNOv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VQoZVNOv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 419041F000E9;
	Mon, 27 Jul 2026 19:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785181442;
	bh=5+I7/Vs1bsffcVCPwZKxFdmHkJ0pjclp2cH4mzd02MM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VQoZVNOvMZnDxL9778fFhDzHQkHDJh+/86nc6QfQmQJL/2wkKxyvLW2F7vVUVlJgU
	 q82JVwihoetezQRMEsCSRbaq1Zzt9kPi9/v004G0f+49XxKYYHesqal2ORTTh1RMMm
	 5LUngOXDfDr1CNOJBhjrX1D4pGE7eBnvY3Vtb6xgnJI1uhjPvUpcUVQH52Yml+21vi
	 LhUsePoiY11uOg2wr7AsBGXkebCDSjKX7Ncab5RsDfjjUi25N03WSo1zWk3kaQQxom
	 a4nKB7dcd63rF6NEkfGOVQANeFPUugrfwC4cfX88UuR48nmPn/Dr6uQ3/kutrm1dQj
	 wnG5kKZzRxR3g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] PCI: Don't report zero-sized resources as assignment
 failures
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Pighin" <anthony.pighin@nokia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260727193714.598562-1-anthony.pighin@nokia.com>
References: <20260727193714.598562-1-anthony.pighin@nokia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 19:44:01 +0000
Message-Id: <20260727194402.419041F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> A hotplug bridge may request a window with required size 0 plus
> add_size headroom.  For example, the PCI core speculatively requests
> a non-prefetchable MMIO reserve for a hotplug bridge even when no
> downstream BAR currently requires that space.
>=20
> reassign_resources_sorted() temporarily grows an unassigned resource
> from its required size to the required size plus add_size.  If
> pci_assign_resource() fails, the failure is ignored because the
> additional space is optional, but the error path does not restore
> start/end, so the resource is left unassigned at the enlarged size.
>=20
> Since commit 96336ec70264 ("PCI: Perform reset_resource() and build
> fail list in sync"), the __assign_resources_sorted() out path
> unconditionally adds every remaining unassigned resource to fail_head.
> The headroom-enlarged window is therefore reported as though a required
> [ ... ]
> upstream windows to make room for zero bytes cannot help.
>=20
> Fixes: 96336ec70264 ("PCI: Perform reset_resource() and build fail list i=
n sync")
> Cc: stable@vger.kernel.org
> Signed-off-by: Anthony Pighin <anthony.pighin@nokia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727193714.5985=
62-1-anthony.pighin@nokia.com?part=3D1

