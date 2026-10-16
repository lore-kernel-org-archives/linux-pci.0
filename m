Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1E759C972;
	Fri, 16 Oct 2026 18:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792174405; cv=none; b=SalzEzIObz9vBHXs8fyjBFVqXXEVIEhiMp4WHj2jlNRANyjHZntqxCKCcf+q5iw1mCCa8QFuB8R/cisiZU4Jbs0TpJuVqxmnobVG8QOnQjWtX93liG111kfg4m8F6jhgA6WH333Jb+sAgerOBNgbkRtiLPFfjcPSgUIQkWd2g3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792174405; c=relaxed/simple;
	bh=XFxsqBkBnEixzuS58BkSr4iRJBYRibjiIZN6fy79EKY=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=K03sbyJQLxPoLVjEZzz+zu6v7WuvFI/Ny4vY4FRuLSON8cZY6snGA5JI0U7LcqkW/WzZ3StyivPyll2LbnpmCv86LRuE30JgJmgVbssdiLAG13nLV152BhxynB9nh78fj5Z2vzK0nVOQ7wki0UJ1+UFFI04Nk355RXOzF5tuwPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=euOgTGjJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="euOgTGjJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 320A71F000C6;
	Fri, 16 Oct 2026 18:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792174404;
	bh=XFxsqBkBnEixzuS58BkSr4iRJBYRibjiIZN6fy79EKY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=euOgTGjJNT2z34h2q3buwTfWgYf/DbaHeSVi28ILtFOm1s3kMhucDiEDSfxTnhec+
	 4Cg58/i7rypRJfm+k27Aul75mAk7xpU75cuv299axrMzJ0splYojwgnCp8CYMnt5ia
	 l3ya2Z/931vI/aiyiNu1sRsntTtZ7Fd0IwRWl1aw1r9wD6uJrnqx8LFXf71xQwq5VE
	 iw6I3b0/91/zLLcFhc9xnQTOGqbytKBSA0O6tgt0khcdXmpl1n/M5/0LcZIZlri2Op
	 OeIl7MrKP4ysq33EQKMAtLqJmmbi4zVFQDtojm08/idREjxmM3OlSdAePxSyQ440Xh
	 blqgb9Z68+X+w==
Message-ID: <sashiko-outbox-174755@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v27 2/4] rust: leds: Add Mode trait
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markus Probst" <markus.probst@posteo.de>
Cc: linux-leds@vger.kernel.org, linux-pci@vger.kernel.org, lee@kernel.org
In-Reply-To: <20261016-rust_leds-v27-2-2c296d8a8e5b@posteo.de>
References: <20261016-rust_leds-v27-0-2c296d8a8e5b@posteo.de>
 <20261016-rust_leds-v27-2-2c296d8a8e5b@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 18:13:23 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Markus Probst <markus.probst@posteo.de>
>=20
> Add the `led::Mode` trait to allow for other types of led class devices
> in `led::LedOps`.
>=20
> Signed-off-by: Markus Probst <markus.probst@posteo.de>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016-rust_leds-=
v27-0-2c296d8a8e5b@posteo.de?part=3D2

