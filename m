Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951A84766AB
	for <linux-pci@vger.kernel.org>; Tue,  4 Aug 2026 16:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785861226; cv=none; b=d9M+J0xkwL/7pmrSXtimaS9N9VKvmXpWTzwbI6jMfAlKKx5snO6lIMGpeIVsW1oMJkXwAGuhcFZApbISJuHTomBgTeZv0jy0MWAHyOmmPI6ZPZXCbMJsTt4Jn2OWDBQ3tko0rEOe1Oj6QYuW56wAML7/Tkf1sPpNf90Irf2LNmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785861226; c=relaxed/simple;
	bh=KI4gJLaAB9Pct9SYBApqteAB6MIKKVtWKQGLciV5Ggw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aAFcftRQKmmdbzoGTL5n64MxqDgNyVi6rk4ngLIvssF+uZyKee4E44gBNefJq35TMycTaJDmut4C44Y/dBD8DmWKN7m4mvwJAvhKpLAVD1KYpNOGVY9TpNLTACUfRR38qQzlQMm3zC2bPdlLK3ScAT0soqi8YuZcXhIkKU5NaGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BUJ30dG7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BUJ30dG7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D860B1F00A3E;
	Tue,  4 Aug 2026 16:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785861210;
	bh=OjlU4DjE1SSyEcXTu6D/lSLgLALVT2v+30oTRqoJGEo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BUJ30dG704bV4PSUhGimDQqwDuGJpz3PYv+y7aCNjeBzJ0ZCLQE+TuytD70O7QP8n
	 itEra/30cWlDXVVeMK3CevKAbUyFibXAfutTI7RwNknsRJ4QgMCs3RrJZisOY11QAb
	 pg0QerXewg+Qy+q2mheubcH1v+FKqEINR2KcpPe+fb5l9tLek7VgN6wA4SO+erR5AO
	 +rTLD2N4l6BW1eT6WQH2SWYZB90CRLHMA/Zqw0T+If2U4S8YyHKKpM7f3HWiqj7vIS
	 vREPyx9739cngndkRpvkl6MTYzKatV/S2xlEzBERhSUrtz+hZgESrX5ZcR3mpmpJMu
	 aQQnR8g+Vqduw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 1/1] rust: pci: add extended capability and SR-IOV
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhi Wang" <zhiw@nvidia.com>
Cc: linux-pci@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <20260804161612.776752-2-zhiw@nvidia.com>
References: <20260804161612.776752-1-zhiw@nvidia.com>
 <20260804161612.776752-2-zhiw@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 16:33:29 +0000
Message-Id: <20260804163329.D860B1F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The struct `ExtSriovVfBars` is instantiated without the required `/=
/ INVARIANT:` comment.
--

--- Patch [1]: [PATCH v7 1/1] rust: pci: add extended capability and SR-IOV=
 support ---
commit d31d2864003dad095e7db8d9a4e992599ece9365
Author: Zhi Wang <zhiw@nvidia.com>

rust: pci: add extended capability and SR-IOV support

This commit adds Rust abstractions for PCIe extended capabilities, specific=
ally
adding support for finding and parsing the SR-IOV extended capability and i=
ts
VF BARs.

Link: https://lore.kernel.org/rust-for-linux/20260730182954.783568-1-zhiw@n=
vidia.com/

> diff --git a/rust/kernel/pci/cap.rs b/rust/kernel/pci/cap.rs
> new file mode 100644
> index 0000000000000..c49de8682f6dd
> --- /dev/null
> +++ b/rust/kernel/pci/cap.rs

[ ... ]

> +struct ExtSriovVfBars {
> +    slots: [u32; NUM_VF_BARS],
> +    config_slot: usize,
> +}
> +
> +impl ExtSriovVfBars {
> +    fn new(slots: [u32; NUM_VF_BARS]) -> Result<Self> {
> +        let mut config_slot =3D 0;
> +
> +        while config_slot < NUM_VF_BARS {

[ ... ]

> +            if is_64bit {
> +                if config_slot + 1 >=3D NUM_VF_BARS {
> +                    return Err(EINVAL);
> +                }
> +
> +                config_slot +=3D 2;
> +            } else {
> +                config_slot +=3D 1;
> +            }
> +        }
> +
> +        Ok(Self {
> +            slots,
> +            config_slot: 0,
> +        })

[Severity: Low]
This isn't a bug, but is it missing the required // INVARIANT: comment here?

According to the Rust subsystem coding guidelines, when a struct with an
# Invariants documentation section is constructed, the code should have an
// INVARIANT: comment explaining why the invariants are satisfied, similar
to a // SAFETY: comment.

> +    }
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804161612.7767=
52-2-zhiw@nvidia.com?part=3D1
