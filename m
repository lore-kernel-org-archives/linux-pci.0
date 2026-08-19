Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8693C09EB
	for <linux-pci@vger.kernel.org>; Wed, 19 Aug 2026 11:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787138344; cv=none; b=r5v7GVSn8l8j21v0H+zNNHIMM6AF2c1j+ZxxLrEklSHQq9yA9m2pvwFlHEgqPxFQ+4SG91E4Pe7dUw622pDlIJHA0dnbe3s+k3bAeAM2Za3W4HNQG6kzryCKSeuGnNUjkAudcMN7sfWTaY0MIYYU6cEJEWW9JxfEWndevyTpFVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787138344; c=relaxed/simple;
	bh=6k+B6lOWgybsWDuGg6eOb/EcSA1us+EwslmJp1Bb6Jo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YcYZ3bWN+Db0iT0uAuTfirAHCnWUiCc/DA3CCIMm2SdoKEoNViaAMHuwlKQ84TXv2YajHaoBCneoILOb4brSs3amMqw3/3KWFkzBNv+9ongrJSROirO5pof1q3GQNnxZoovgKh7pTxRyN7Au3+1quNUNSBBYUvCImv59npsrypw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TvW4R33H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TvW4R33H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E01111F00A3A;
	Wed, 19 Aug 2026 11:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787138343;
	bh=6k+B6lOWgybsWDuGg6eOb/EcSA1us+EwslmJp1Bb6Jo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TvW4R33HsCyJVx4I7xr6MbIiSdTUg9WTGnEx2oyABrhSlp+IOUEGz2MD8jh6wcdi7
	 iWvE4lu4ambWx5jrc5nuKKd4kSiVpvls5FRRpChFs8DupP18XjPO3SwI9pNDaOS3XZ
	 KSOm4TIe7bXYwOjy8Qe2xhHmLhHlmTQDtHfaQULvYu713GYUgir9Es15DLhmCjUFHs
	 vUgdpC+CI0BKtpb5NPmNh8usV2dRjKMJOdMg9Kr29AYoqFsZTSLgbujyYcFyw594c1
	 sLynKJghJa50ZDrAk78YEEGeUCftVutvkxDXFtfOCS1uUYvBNTXn4rEoljH7jZhgHO
	 A6VqFB4Q1UvMA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 07/16] gpu: nova-core: specify base type for
 registers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: linux-pci@vger.kernel.org, "Alexandre Courbot" <acourbot@nvidia.com>, "Danilo
 Krummrich" <dakr@kernel.org>, ojeda@kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260819-typed_register-v3-7-3699a75fadf1@garyguo.net>
References: <20260819-typed_register-v3-0-3699a75fadf1@garyguo.net>
 <20260819-typed_register-v3-7-3699a75fadf1@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 11:19:02 +0000
Message-Id: <20260819111902.E01111F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> All registers use the same base type, which is `<Bar0 as IO>::Target`. Th=
us
> add the base parameter to `register!` invocation.
>=20
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819-typed_regi=
ster-v3-0-3699a75fadf1@garyguo.net?part=3D7

