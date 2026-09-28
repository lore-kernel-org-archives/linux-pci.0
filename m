Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1DD367F26;
	Mon, 28 Sep 2026 16:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790614651; cv=none; b=FKuzm+Y2v0OorpPvi+y8PiUBP+97Y4CwpuxwVBzK6QHRcES4awsNKVB0ZykI0v++VmDb+GZsjufPAXPfzINugEYWGUcR6+MYlzTU+s1uqYd4TbrxJA378hWlxPUHlgEj5YJ/pqkXmrH9c8EPhcrpfqLiqw8cuCfUjJI8e5i/6KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790614651; c=relaxed/simple;
	bh=EXjxxj8VfD4fDNtnu+zwBryLeHZEqZKXS8iANFydHWE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MvAXQshDYDMGHj8DiEZXtmtxsRBF03buWu+mM5ErdyHN+UWnfGwU+WIFLEc3f4AnPOsplNxWGvoG5zkZ4lxzPBRp6bpKS6g+AtMX/FAFYVT1zCU7RD652ulf7CppghfHlXQbJtbHnUh4Vkr7UH1sEtDbsZXrurJmxlCm4AmQ7/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LzmzsWsD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LzmzsWsD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60DDB1F000FF;
	Mon, 28 Sep 2026 16:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790614649;
	bh=EXjxxj8VfD4fDNtnu+zwBryLeHZEqZKXS8iANFydHWE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LzmzsWsDoaJlf+YiNkUbym+1qFr7ljT7DVgym/TwqrSy2t67aqoL/0fftTOwCic/d
	 rsZ76Cwy6sq5gP5hGfU4w06caaEkVQwfW0CJn5/FjdmUHGW/ShKbMxo5zy3BqYEd6t
	 GDugSE6k4kYFVdprB4X34qURjhnxgHTMhZUZtTEFB79fCHNzWgFQUZ+pLLXezKyyXq
	 I27rTaroEBVh1r59dPc1a+DkqYo8HtdzyJPaB12vf8j+SbRFYiNC/t7Rt1Mtg/0ila
	 0Uav75c55KSYXYMkENmTULB0koIchBGGgDOsInrR+bRIovIA8tIx/3FQiUPLoaL97T
	 dPLh11LroYdvw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 05/15] PCI: rcar-gen4: Move deinitialization helpers
 before SoC initialization
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: robh@kernel.org, linux-pci@vger.kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, wsa+renesas@sang-engineering.com
In-Reply-To: <20260928165230.3397664-6-den@valinux.co.jp>
References: <20260928165230.3397664-1-den@valinux.co.jp>
 <20260928165230.3397664-6-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 16:57:28 +0000
Message-Id: <20260928165729.60DDB1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Move common_deinit() next to common_init(), ahead of the Gen5 .init()
> that will call it when PHY initialization fails. Place the Gen5 .deinit()
> before the Gen5 initialization code as well.
>=20
> Keep these moves separate from the following initialization refactoring
> to make that patch easier to review. The function bodies are unchanged.
>=20
> No functional changes.
>=20
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928165230.3397=
664-1-den@valinux.co.jp?part=3D5

