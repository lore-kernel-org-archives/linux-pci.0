Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01421A682E
	for <linux-pci@vger.kernel.org>; Wed,  5 Aug 2026 16:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785948109; cv=none; b=ZheXPVDSJcg2XlNjcJYyqX6+VeMsxdcdRZQafN6AC6BZ0XVIjH+xg6/yXkgSqG4mvPRtyoLbUhdSZYFl3LpTIaZbn3T3KRaQ4/5BYi3lqIP1r5ZjxTQ8NGGoLYgIWUcgi2Qmrg+J+Y1X2N5VS9GlgZJOa4datuVN+r4UY/DmtIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785948109; c=relaxed/simple;
	bh=yFp5WNzl2/dKTZxUV7aGN8xz2+UL0u25qQ9ptHT17GA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TeiCtAsbb/jrT9ItQfm7OXnMS+sV/9ZenersbdUmn4C3TUyate16P8kmwxIwpgbCCZSMAP3KP6euOhAFYvugZYvvJ0YqEQDFkXRjX5fPfI1YwW940XvuVxmGrlNrIct1BW72bC79wA+7JImfi4r9qqQP97Q47e+qRHn+L7Vv/H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NEONJF6S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NEONJF6S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C5EA1F00A3A;
	Wed,  5 Aug 2026 16:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785948108;
	bh=yFp5WNzl2/dKTZxUV7aGN8xz2+UL0u25qQ9ptHT17GA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NEONJF6SVrcgHyYM+5lDHQIOcg3Qyu8/X9mQ7JHPjxtpWXklJoR6sXDdNrWae+AUi
	 3IYatbHAbIfxlB39ZxiNV7aSA8tIBWvvr/IUddwU1HVFKZ5h2peeEUZc0HPVQQLqbC
	 g8CuXKqW5G9/s49UVpgkK6zwwHEo5rWREQelrw2KJ1//Dbb55Aw5+UDEJ39MWDaVe6
	 5o/AWz41mT7yMkzrf9mXDHAD5g/RFm5Xmo3mEbjdH2xRXmgfYS+2Lp9RnkUb+IN2QH
	 UHBPRHmsdE5ruRkkNPhzVCzEhKH1yo6IV2fngGyUocPWpQsNQyyBRuTn7u1D9V+10N
	 8nVuv+tNtT28A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 09/16] samples: rust: pci: specify base type for
 registers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: linux-pci@vger.kernel.org, "Alexandre Courbot" <acourbot@nvidia.com>, ojeda@kernel.org, dri-devel@lists.freedesktop.org, "Danilo
 Krummrich" <dakr@kernel.org>
In-Reply-To: <20260805-typed_register-v2-9-c3ca142220a0@garyguo.net>
References: <20260805-typed_register-v2-0-c3ca142220a0@garyguo.net>
 <20260805-typed_register-v2-9-c3ca142220a0@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 16:41:47 +0000
Message-Id: <20260805164148.2C5EA1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The `register!` macro is going to require explicit base type, specify it
> for both `register!` usages in PCI sample driver.
>=20
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805-typed_regi=
ster-v2-0-c3ca142220a0@garyguo.net?part=3D9

