Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB843B0AC6;
	Tue,  4 Aug 2026 19:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785872416; cv=none; b=AytB0p0A8x/8BXMsqnU1wVrPnpzAYldtmDo6CtunI51UIYH/eS5fwqK30CUhstBSay+2+SzEYWY749LJQ4vY597v9U3MUffLPY4CfzmwalnNUBKNZZsFZzv69oo2kfdkfjtQuH617Ej7UFACryb8nAJLMfPbSwcQxTLY7mfcY8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785872416; c=relaxed/simple;
	bh=igQJUt2nf9wvG3Px6dR0GnSxuX64urVqbuZKxxTZQFo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=u2S35Mg1GHdlzj7cYUrUwNYqpZO5YhK78uvkFUFaLBYxVZEj6Z0/bY9T5t9vZ9y8kO0txO2XooM5d3QoH7xmF+AiztRIiczD7AXAnGWN4vLOmkVyI4H5ynRBpvynPvPscP8HO0I3V4l5FYyGBr57Kt2N1508SiQ9d3onuLTGzYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lOdxgFKF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lOdxgFKF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45DE81F000E9;
	Tue,  4 Aug 2026 19:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785872412;
	bh=igQJUt2nf9wvG3Px6dR0GnSxuX64urVqbuZKxxTZQFo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lOdxgFKFaIR0fSQ4LlHPETXQXC3leHuw3F2pk4AnMtIo+QEEV49HVTSZKF3hcn36L
	 KyCm3GkJGxrxhnmco8JwUc94eV5QgND4Eh4V3v575ph9qTr7tRQxyefAFxgBu5sr5R
	 jyD6adBfl2hl0ehg8VpRE8wLpzeZOwEoxyGDzFBHtYLsWH0KYZM6aKB4KJkbTzQ91a
	 qBTLWNltrcYe19n7/GW2pnPYNMoUXTkMDXDPZMOZpbeqEHdavyZpt6dkvx1SH63pdP
	 Dlb5nenb126TgtNEYrM0teQ7DWXXfGv6ubaOkpTahKC/bprBkL5I7CbS3AJzizoAJ+
	 5OidcbXw5ptLg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 08/12] cxl: Reject CXL Reset on multifunction
 devices
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260804192958.1823952-9-smadhavan@nvidia.com>
References: <20260804192958.1823952-1-smadhavan@nvidia.com>
 <20260804192958.1823952-9-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 19:40:11 +0000
Message-Id: <20260804194012.45DE81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> CXL Reset can be exposed as a PCI function reset method only when the
> reset is function-scoped. PCI reset-method probing runs during
> enumeration, so walking sibling functions there can race with functions
> that have not been added to the bus yet.
>=20
> Reject multifunction devices for now instead of trying to infer reset
> scope from sibling state. Systems that can prove a multifunction device
> has function-scoped CXL Reset can be enabled later.
>=20
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804192958.1823=
952-1-smadhavan@nvidia.com?part=3D8

