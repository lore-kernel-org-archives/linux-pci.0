Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CDD495528
	for <linux-pci@vger.kernel.org>; Thu, 11 Jun 2026 17:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781198485; cv=none; b=aC1lu9wQqRPn9sPcIyautqtxHQSChERNiUBasOMivfgY+MwoEiHtO+MOcT8b9fFG2ngGXDtU3Kt1JcqXx8GChkZttmEu1tZ4qy6G5CZ2gwzq2isvRy4d4Bodsb5OaKn+1Px/q0PUjchbDL5o6nbwrNi4dMBqb84xesVJzkynnlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781198485; c=relaxed/simple;
	bh=rxmT4EXVrC2yPmlUW4UrcRP96HMPM0knxSTqoonqRFI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oXsWDO+qFVpWX7KSrEeGfqfXJbylLoghIvSo7CgvhklUz7PpYTmk03EoG7q/LsKzJPmRCN3hGujMG6jCAdnPBjdxK1sk5AnyJy093/w0jYJw+16o5VJ0ABwkV5RqUGOxfDwBFaCUttWh28FTLlA8MKXDzAgk4mLTmdzUK20NcRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KarMgPbq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KarMgPbq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AA401F00893;
	Thu, 11 Jun 2026 17:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781198483;
	bh=rxmT4EXVrC2yPmlUW4UrcRP96HMPM0knxSTqoonqRFI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KarMgPbqavGNaEzvKuW2iO/5ecGq8qH0Uy9XJj+4xgePc0h184A9mTQYqTw8gkqX+
	 i45ytQL4I5sCEov+ztcyLexwBWskQKipGwva+an+Mn89MDysUvEmUdzol/CVp/AVME
	 Ks8pZyVqtEb5d+fcddxndf9arSV8K90bOzUdpYqPtH4aKWU+c4y7eKp28r/sb3Euxp
	 GWCMbCQYJkH1ziTFKZw41bsIL4SnLkAyEcr8hMgpJ8c7JYAeqRvw8Mwt98fDpvr3oM
	 KFfpTAP+/7uA5XWWyycqclCi201bDYyu6uohrLImB3Ba1ibrp6ORfPrzdanmGH7zsm
	 hpD3inE759BBg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 06/20] rust: io: rename `Mmio` to `MmioOwned`
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: dri-devel@lists.freedesktop.org, ojeda@kernel.org, "Alexandre Courbot" <acourbot@nvidia.com>, linux-pci@vger.kernel.org, "Danilo
 Krummrich" <dakr@kernel.org>
In-Reply-To: <20260611-io_projection-v4-6-1f7224b02dcb@garyguo.net>
References: <20260611-io_projection-v4-6-1f7224b02dcb@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 17:21:20 +0000
Message-Id: <20260611172122.7AA401F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Most users would more commonly reach out to a view of `Mmio` rather than =
an
> owned instance of `Mmio`. Only implementor of `Io` like `Bar` or `IoMem`
> would need the owned version. Thus, rename `Mmio` to `MmioOwned` so that
> the name `Mmio` can be used for the view type instead.
>=20
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611-io_project=
ion-v4-0-1f7224b02dcb@garyguo.net?part=3D6

