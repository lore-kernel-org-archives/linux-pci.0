Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30162547058
	for <linux-pci@vger.kernel.org>; Sat, 19 Sep 2026 21:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789851943; cv=none; b=E2xXzLUblHOBVXKYkvu5apbcgR0+4+F4mIDtwKJmmSCRt6/DfgqgNLy7+gwSsR6OX7zpm+puQXcZYaYRg/oFryg4soBU1Lce0wmgFEvXkYYVORScBideoHazgTNs7HVi1VXKSGo204ZnevlhmbNto8YnuCRboP2D297GOYjRkSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789851943; c=relaxed/simple;
	bh=yfm/aLZ0N1xq31+5HFQQdorj1xprc19t5u/Q1b3vRoE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=edGpsh+Q32VzcwHS+e3PJkoq7xFWHb677Ipi46lZDVlCDUhgeP+SUXAPP/Ll9QqoOYMxooSgKjHkWbSMA96yjJrA7ylqaRJ4MXBcPj3eJuP19ozpKmjNcjHxfk9+3tevA4ZVpbzxKB3urj9/LHUnNrQDgXcXKUtQ2w/+wwKL4qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rr9RzhUM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rr9RzhUM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8E031F000FF;
	Sat, 19 Sep 2026 21:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789851941;
	bh=myc9d1ejp5N53ucfUT3HJv9gRlGZMGitV9otR2WNmUU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Rr9RzhUM2/KNdqveqbdfsmtlH180VB+qaRlDUUzQ0TET0L4gS1m5tqFKFb+5YsdLy
	 HNOXCmKjoH/sMe6kMa8V3vfCOAzq6p5H3YLfN6SYqwCr8jXpe6PK93MleEfOGDVLQb
	 d3Qo+cSnSkR6QHyV/6nrrJ7M5685Vwq2ipMfT2dB1UDytEc7Q2Usn7j+oEMIpGaFLj
	 ru50OvozlUQtT8sGMTCGcEgwLddL2CY/NwJzQvgqV0dNOsDC39zQ3O3MnJcgPS1tO8
	 RGC+nn9EE/FriNc5A/KK9h4CcFXvup0LNb7cxqMk4BousCRo7cnRKhHZVx0ynML27G
	 iZvWR7FX54KrQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: Add ID@path device format for pci= parameters
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ben Cressey" <ben@cressey.dev>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260919-pci-idpath-selector-v1-1-5881de83f248@cressey.dev>
References: <20260919-pci-idpath-selector-v1-1-5881de83f248@cressey.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 19 Sep 2026 21:05:41 +0000
Message-Id: <20260919210541.C8E031F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The <pci_dev> grammar shared by pci=3Dresource_alignment=3D,
> pci=3Ddisable_acs_redir=3D and pci=3Dconfig_acs=3D names a device either =
by
> address, with an optional path, or by ID. When one command line serves
> more than one platform, neither form limits an entry to the intended
> device: an address applies to whatever occupies it on each platform, and
> an ID applies to every instance, such as all Downstream Ports of a
> switch rather than the one that needs different ACS settings.
>=20
> Accept pci:<vendor>:<device>[:<subvendor>:<subdevice>]@<path>, where
> <path> is the address format, and match only when both halves match. An
> entry written for one platform is then inert on another where that
> address holds a different device. For example,
>=20
>   pci=3Dconfig_acs=3Dxx111x1@pci:10b5:8749@0000:80:02.0/00.0/08.0
>=20
> configures ACS on the Downstream Port at that path only if it is a
> PEX 8749 port, and matches nothing on a system where 0000:80:02.0 leads
> to some other device.
>=20
> The path goes last since pci_dev_str_match_path() consumes up to the
> next ';'. The <order>@ and <flags>@ prefixes of resource_alignment and
> config_acs are stripped before pci_dev_str_match() is called, so the
> callers are unchanged.
>=20
> Reviewed-by: Anthony Vardaro (Anthropic) <me@anthonyvardaro.com>
> Signed-off-by: Ben Cressey <ben@cressey.dev>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260919-pci-idpath=
-selector-v1-1-5881de83f248@cressey.dev?part=3D1

