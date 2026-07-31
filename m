Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46B8489880;
	Fri, 31 Jul 2026 21:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785533885; cv=none; b=o70zRIiIfdOx+1Mox0pGp4CBlrnaPh470MXTYII9BbSEPefCIO920f8eRjhGeYpvbfT6s2Ekqb86HkKgBf1G9FZgkKu1lgKQ16iak7TGneAw9XthpT8N88QR7xpe939/0Mt8akf3Po26uA+b9hEa0KuOUhVJUGyCyTx6WhZqSW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785533885; c=relaxed/simple;
	bh=D+9CDnfOW1J0PKyZDsueemYFtCWp4MOHpH/c+4rEm3Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Z1wh38FggcIpLREIIeWYEDVH66WGKFLk/cjX5oYTtSyzgQJQKSD5LywKqVRDHHGnDMaR+6kjNLoGHnLcPsh/Uu5NLhrFuBWgBj01l1jB8DT1/yvN1nV/iNYLX43nLiCZIVmlBB6JaO08IF6Va1Rz3ysvAJK+T6FdUZFdAF0xpAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MwLJnJch; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MwLJnJch"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39BEE1F00AC4;
	Fri, 31 Jul 2026 21:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785533884;
	bh=pQVaPapWUaZaFghZZ/wIC3/WkZNCuTqvqmWih0XT0xM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MwLJnJchstBmgowcK60RbHLi3o+QmPhvbu2YVoukFzNLnZxWEEOcPIL/ZgpPFj8Su
	 lSVy03xHI9507iJ81DI4m7CjUcyEsrYDI69WmfHhPtUjAvpMdLDfvQU7keC5reuiTz
	 C64oc6pYQduKMY9NkSv2M3teiMiKVPCxLwLH5+nAqcWxwYZVyhm0y5cC6tzzRSPiW0
	 SsAZJrhUQXbTulv570bTYGcGp6ITERf4mhBZK5qcaA9kITdb/UOUknnQin9MnVuEzH
	 Lp86Zq+nQ2kDbcok8gFTZAgTmfz0KLAmg7sh3epnpv1aAl7zCrzaOGx+MJaXvv8kQa
	 CZysaDjwvobjQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 1/5] PCI/TPH: treat reserved 0b10 completer encoding
 as unsupported
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhiping Zhang" <zhipingz@meta.com>
Cc: dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260731211601.3033906-2-zhipingz@meta.com>
References: <20260731211601.3033906-1-zhipingz@meta.com>
 <20260731211601.3033906-2-zhipingz@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 21:38:03 +0000
Message-Id: <20260731213804.39BEE1F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> get_rp_completer_type() returns the Root Port's "TPH Completer
> Supported" field (bits 13:12 of Device Capabilities 2) verbatim. The
> 0b10 encoding is reserved, but pcie_enable_tph() feeds the raw value
> into the requester type:
>=20
> 	pdev->tph_req_type =3D min(pdev->tph_req_type, rp_req_type);
>=20
> and later writes tph_req_type to the TPH Requester Enable field, which
> only defines 0b00 (disable), 0b01 (TPH only) and 0b11 (extended TPH).
>=20
> No known hardware presents the reserved 0b10 in this field, so this is
> defensive hardening rather than a fix for observed silicon: fold the
> reserved encoding into "not supported" so only the three architected
> values can ever reach the Requester Enable field.
>=20
> Signed-off-by: Zhiping Zhang <zhipingz@meta.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731211601.3033=
906-1-zhipingz@meta.com?part=3D1

