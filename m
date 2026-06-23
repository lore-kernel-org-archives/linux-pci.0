Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCE1322749;
	Tue, 23 Jun 2026 03:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782185706; cv=none; b=mfFGEx34PgcdenDDTpNr7gT9A1nUp8PQSbV8f+kgOFYqei7VW6ftgR3JZTyGwYaY36odARXOSavSni/k64QuyLOzFfvrPpNhjXf2wmoi6ypEuQQhAAZkONCLtWXYTjBamqws7o8DkDufHz7Td1smPL0YZ9KIboJ54mOB7rkZEtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782185706; c=relaxed/simple;
	bh=AUAXzxBedgjvjHK1MTkIfPhPAdPmLbx5cQZiI2MMkS8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Rrr2D4EY5pDwtKpWm0Fiuw7Hxlf1t7qAuK54jLTZq8jdGP/dfRSGAWN49G9k/sioQwbewnO0eI05iFFgvPPaq2j01MRVlPHLvgzHCDPBXfr6qeLDdDwnQFAj3CQLBCpEPHcIwdG/0z6bfTrcZ4DfRqpWku1CSvLdS/Qgs95+WGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lyy3XD1q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lyy3XD1q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A3081F000E9;
	Tue, 23 Jun 2026 03:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782185705;
	bh=AUAXzxBedgjvjHK1MTkIfPhPAdPmLbx5cQZiI2MMkS8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Lyy3XD1qqY65M0p3ImaT9+BiaT2usWPsES00P2EyD6mcAnl08WBZBdJTel/AVlU/0
	 XIy2nYud+V1YT6QsM38fpwsNvtQglk3kfyXLX+AbmNd1cfYDe/WKhSc0DatAu9mE7H
	 KtmoZu7ejNg2LqM+TDJUMP7VAE0gHXiwA1SOPvNZNV2lUmPvLXlQNBtgCIQVSnuL/n
	 Nza1SHOhtLZcC7DbTE5fgFmw2mTZABKfRt1II2aRlxfkz0Zs2K5kk0s0fFTZlohCdC
	 0U1damw4BxXHh+hV0qMGFGkH8v1EOkhtZ3T37VAv94begMsL+M/M5ry5yXcahhRunL
	 q2fssDAjXJBSw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 11/11] Documentation/ABI: Document CXL Reset PCI
 reset method
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20260623032453.3404772-12-smadhavan@nvidia.com>
References: <20260623032453.3404772-1-smadhavan@nvidia.com>
 <20260623032453.3404772-12-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 03:35:05 +0000
Message-Id: <20260623033505.5A3081F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Document the "cxl_reset" PCI reset_method value for Type 2 CXL devices.
> CXL Reset is device scoped, requires affected memory to be idle,
> invalidates CPU caches, restores cached HDM decoder state, and does not
> request Memory Clear.
>=20
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623032453.3404=
772-1-smadhavan@nvidia.com?part=3D11

