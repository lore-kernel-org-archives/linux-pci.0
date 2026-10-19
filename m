Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979A448FF7D
	for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2026 08:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792399231; cv=none; b=CZ9QjF0FCHSm4QRg+Col19gwccxkXqKCDz3IxsqbxTDl3ihy9ffELbE1hGk3+cavbNNYXb116mBniVKVNj08tm38JSgS2DFEGQuGrBoHKn9lvBOwdMXKmtLy4GTV5xPMUa8ZDq/JAVQARyHGWwuYT2j+FtvtSNlij2E8gmIwANc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792399231; c=relaxed/simple;
	bh=6/a5kw8CHjdO4Xo0qzsrk1w5drI5+LMcHoTP3cff9sA=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=NONIDVebOS0SSp3CPxzjjorQ4/WrnURcx7/Nm9+p0V+y3m+OEwlXay7WS4QUJvd/cmFVYk479k4iXdKpNCGW6el5BvRgDUK7fjxMGuo4JMZNYpuWZHQh4/2Xr1zSRMX1r0WJ86Isw6Z0gGvykimFLt6rqxE4XR+Gtyt/zSU1rLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WNznOXcr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WNznOXcr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 077411F000C4;
	Mon, 19 Oct 2026 08:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792399230;
	bh=6/a5kw8CHjdO4Xo0qzsrk1w5drI5+LMcHoTP3cff9sA=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=WNznOXcri/21SZ7IcHuYhOrnmWzQdamqSN2foQwVfJLYUzXGp7/Uwi7nsdPkWp01F
	 BhvoS2ZkmjFmihGNIrA7gwXiJsIYqPs6LNTPg4PtnvWLC1rN7Z3xdOzT0b+q0uaVw+
	 vDkZF8q06mDcFSaZtZyLcMUN82HHktSZ4xnNpb4wHX/ezp4S3Jli0xDrwZN5rv3IMd
	 Po+A5Maf6h0P+cuwam5XTB4gt5tT9tcEqkMlol9pksWnGP9eIOetszCeCbgrue6jMj
	 /5azxMNrUGv+x3UB6tIYpswVFtQRZNHcoK06zeFdVH6WhhoHNiexmaF4ZgIh3shyzk
	 VipOignOlaqaQ==
Message-ID: <sashiko-outbox-176823@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 09/13] PCI/TSM: Use generic VF iterators
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lukasz Laguna" <lukasz.laguna@intel.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261019083514.838640-10-lukasz.laguna@intel.com>
References: <20261019083514.838640-1-lukasz.laguna@intel.com>
 <20261019083514.838640-10-lukasz.laguna@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 08:40:29 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> pci_tsm_walk_fns() and pci_tsm_walk_fns_reverse() implement their own VF
> iteration logic. Replace it with for_each_pci_vf() and
> for_each_pci_vf_reverse().
>=20
> Signed-off-by: Lukasz Laguna <lukasz.laguna@intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019083514.8386=
40-1-lukasz.laguna@intel.com?part=3D9

