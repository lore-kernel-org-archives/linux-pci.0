Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793418330;
	b=s84O5uNwwEESDycPwTLua047ej83hfo1SOYM1Ee/Rpb/R6VzBzMAKqsL+OSPHyWeiZiP
	 hFTJaEWjkQSX64WFrpIyMAy5YICJyTq+gfkTZajGJ5IF6/Zz3z8a42/OcInFtZZJJxZ1q
	 +gZLwtPslktOL1SxAYOEeZNPlTGgEG9KHrq+RuQf1AOXLDELo8A1qqOlT8PwoeIKcDYYh
	 nFgHWFQ0jtnULFYvYgSKdENB2bfqqpKkqQFOBwQuSqeqYJaj4113GUbgxjDAx9S/6Kt8P
	 XR2PzNGmdejwx+McnfzWB8kCtQO5pSSo924HX2Acwt+2yezrugdqKiqAmTD+m0eIUDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793418330;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=qN4Fd4zzwBbwyOegE9lt2T174txPcd75DjJVV/zWs+A=;
	b=XB2efCRbz+w0iA58Gy0IZEWls7/DjShnFIPsL47yUYzJEG3BOzp7DGwrvlaw1h1Oyrbx
	 /irgDU2xv4F5HeHpnhBAzFTLXtKKT57+IwjuEqmQaLuwvYlerGqb/G/CX5I0iMe3VrKPv
	 oglACdFUaO/qsVq0srnJkGI3wLgaDXK9N40CtcEgTvsywcEaesBNjFoo8nXsZ7JH4ul99
	 LADdKHT5MK/l+ZRqaz/OjxEqc7cyz7PgDxwAr0lpE/cleMPzIk4NhOS3/NsoE+inVXebX
	 egQyv4vEWjTDcC+tfyY+jyZ5NREJSIyLBM2LcL1t1kN7N77/nBUYg4Wg5orD3svbHLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mVoMvhqq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60718606A31A
	for <linux-pci@vger.kernel.org>; Sat, 31 Oct 2026 03:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mVoMvhqq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1BEE1F000C1;
	Sat, 31 Oct 2026 03:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793418329;
	bh=qN4Fd4zzwBbwyOegE9lt2T174txPcd75DjJVV/zWs+A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mVoMvhqqrq3xq4T9noXTHjqtIYqWFYnSYjdsaYD2s5YdHLoPgMmJ00v4/x8+gRwtt
	 BP/VSgOEgaHNZVbkgAueZ5rvwCch/xLfMazoCmMA69tN1LaaDJPyU5LDKdGIiBB1De
	 6mZLsvquiu2QCKi7I86BISshSTF3yoev1iX/6tJXmOsulSrm+XN9gHt8DnyL+w0qv4
	 nLopLY2wLvKRLAL/moTwLfK4Ew/BnX6EA6m8xQs+tZiyjBzZPQcZ02T4H1OyU0RX/N
	 UL2ccI7si2A1tgfclHhKkb5mUAYEORCTaKiH4kXM51e1WWA6iNTUTVUSUG9Een06uk
	 Pq0K2TOXN1WPA==
Message-ID: <sashiko-outbox-191730@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: Do not cache Immediate Readiness from a failed
 config read
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QmFlayBLeXUsIEtpbQ==?= <pocj8ur4in@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261031034201.161511-1-pocj8ur4in@gmail.com>
References: <20261031034201.161511-1-pocj8ur4in@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 31 Oct 2026 03:45:29 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> pci_imm_ready_init() uses PCI_STATUS even if pci_read_config_word() fails.
> The failed access leaves an all-ones response, whose Immediate Readiness
> bit is set. A later FLR then skips the wait even after config space has
> become accessible again, so early config restoration can be lost.
>=20
> Leave imm_ready clear when the read fails or returns all ones. Keep the
> existing fast path for a valid status that advertises Immediate Readiness.
>=20
> Fixes: d6112f8def51 ("PCI: Add support for Immediate Readiness")
> Signed-off-by: Baek Kyu, Kim <pocj8ur4in@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261031034201.1615=
11-1-pocj8ur4in@gmail.com?part=3D1

