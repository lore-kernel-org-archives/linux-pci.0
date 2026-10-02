Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430E347C0F2
	for <linux-pci@vger.kernel.org>; Fri,  2 Oct 2026 11:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790941440; cv=none; b=nMD9EQjAMBApNo00J8EsEipXUm1vv1l78RZF8fZAheO0PC8ov9zdBIZPfCDQ/GdmII0BZYLgh5b2lvA83zzES2+8miGNR+Hf57d9fw9YPrr1S74ZlsFK644Kg+eZplj2CHv7+2CrTJGZTBTE3UcUM6ecG1GdenqtaUIX+kNn1Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790941440; c=relaxed/simple;
	bh=p29mgMRgrKk8deejXD28SYroG6Gr1w7FnspHt7/dR+8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=azbT0D2RG9Aeq261lE6R1/2yRw3anzWl9hdg/g0bRmJ6ctCV3btwy3QF07AGnXU+O8bfit8YQfKQXej/u2qKAtxilDUR7+/gOXpfacexOphm37TyYU2H90JcIo16/lER+FsqAf8cEFqgLn0c49+5czRgSoN2FEy8Z1mOgD9Bk1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gr2S0+ZR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gr2S0+ZR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA7301F000FF;
	Fri,  2 Oct 2026 11:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790941439;
	bh=p29mgMRgrKk8deejXD28SYroG6Gr1w7FnspHt7/dR+8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gr2S0+ZRo75ba0nmQ4zyKsAXh39bcH9FXlyhGL2CP/utrj/1nSTWOTXrpzBgifX7P
	 hHvp5yY4SxRzmywfNMqiWdBPz4DWooGzu0xLw7ek86cpU/W4si5jZPdoMC53CzyU00
	 SP9OMSPiOBI6BnTHI8je2i1hMAOBI/FstTokQYZxDArmyi6gha7M7Dwsun6O0ApOu8
	 hqUp+msBxb0Cc8EmVQPV9MXr+Cb//OQ2qzfaYFQMp7VrJtlofSOqb2ckL0GSAmwenb
	 JI5OBfP4vd1+I5EaFjMBHrRwguPj6JB0xEjB6TxEtZCagPBk78vLToJRyiF5jL9Zv2
	 /0LR37t+z4u9g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/7] resource: Mark free space assigned
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261002113319.6652-2-ilpo.jarvinen@linux.intel.com>
References: <20261002113319.6652-1-ilpo.jarvinen@linux.intel.com>
 <20261002113319.6652-2-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 11:43:58 +0000
Message-Id: <20261002114358.EA7301F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Free space ranges are (part of) assigned ranges. Since new resources
> have IORESOURCE_UNSET, the flag gets copied also to full_avail.flags,
> which hampers printing them with %pR.
>=20
> Clear IORESOURCE_UNSET for the free space indicator resource.
>=20
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002113319.6652=
-1-ilpo.jarvinen@linux.intel.com?part=3D1

