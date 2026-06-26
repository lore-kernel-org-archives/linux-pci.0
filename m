Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475E33F44EA
	for <linux-pci@vger.kernel.org>; Fri, 26 Jun 2026 12:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782475607; cv=none; b=lqdQtBe3TqUfslWfJwhBoNFFpnOqdkppfjB160ud1+JcMdgCfIoWdvaCmvDMDXrxLWa+LrTy0V7WNGehSKDsGSvOPRG1huhGV+ckexMjPXOIxdG1hTInb0CcGLZIeZCxnnrmvhdpCTgF+Z2UM5j+6PjifvbM7EQY660T8yWrc2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782475607; c=relaxed/simple;
	bh=3Cp+zAMVjeKDEka3rJrQCQCb/mhqNc4x0V6VUIvUTXE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UrtxDBXjGxcxvPDXI3BXAAi8LTMtxRON2iHtZkDrIQ+NrkyE4L02Vy4jtSpvPjKq/Luv/Lq+ox9v+iLmNFUQ2QlHPbzpvkIiEVzBen6azbYMH8aeyEpvZmoc4Yp6Us+hzKYMDX9wZVVZzNiaiqfMYeVVv4i2NIEc8vhmlxI51qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PSk1VX0j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PSk1VX0j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8D301F00A3A;
	Fri, 26 Jun 2026 12:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782475606;
	bh=iQHll4fNCXfd6f4+kL5wZcP/YzHyRXJ8oW0X4JpAqbU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PSk1VX0jaM8kR5QJp+2sod5/S55T6+E/BVptY3mPRtxWoGJy+srdMEn90F5l3t7lO
	 0dZatOFhftEYd5jns+gL+rum4Axu6HVe/bbdztBIyYH2vkdvzPyTQsJCl+phFJHtMV
	 ogJUbPBuQ3Ezk+ZabiU3BduC2BWtIIbYCiiiiZNtuFUUVbgYOXsVRCaYt+vEz6r8hg
	 it/9QF3ingtAHrqw/tH2uwW/0YoBGYXNmtbLvqJRHLYdSANQWKVwC2GwPTVWcZBFFz
	 VdCty6A7ut/T2/wKlgjG99jgjgWoxiqznuWLiVAfjE8gvfTn2VeipqzgFX4k4e6R6E
	 klVe81UQ87zsA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 7/8] rust: Add `OwnableRefCounted`
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andreas Hindborg" <a.hindborg@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <20260626-unique-ref-v19-7-2607ca88dfdf@kernel.org>
References: <20260626-unique-ref-v19-0-2607ca88dfdf@kernel.org>
 <20260626-unique-ref-v19-7-2607ca88dfdf@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 12:06:45 +0000
Message-Id: <20260626120645.B8D301F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Oliver Mangold <oliver.mangold@pm.me>
>=20
> Types implementing one of these traits can safely convert between an
> `ARef<T>` and an `Owned<T>`.
>=20
> This is useful for types which generally are accessed through an `ARef`
> but have methods which can only safely be called when the reference is
> unique, like e.g. `block::mq::Request::end_ok()`.
>=20
> Signed-off-by: Oliver Mangold <oliver.mangold@pm.me>
> [ Andreas: Fix formatting, update documentation, fix error handling in
>   examples. ]
> Co-developed-by: Andreas Hindborg <a.hindborg@kernel.org>
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626-unique-ref=
-v19-0-2607ca88dfdf@kernel.org?part=3D7

