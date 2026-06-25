Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E224B3CE084
	for <linux-pci@vger.kernel.org>; Thu, 25 Jun 2026 10:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782383144; cv=none; b=Dqlj+SbO7loau08MH1S7zOKIYcVyPJ0nuOvkXD2aQiEN7j9zs0Gr9gabPhtcru/l+CVNmMjF2NBqPOytBkx2+wq/TP8RYcVNJ0ZNC/HbjOc/TYh1OYbpAsPPjIi4GKn4ve+9lWMSx8LWNUaY6w8FlXeNKSqB0ItGeF8T8LHiNGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782383144; c=relaxed/simple;
	bh=nwfhREsaeoMCVs34ExxN5XdHNIUIvpDO0RGXdUbaHkY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Qig2f9DC3PwZXRSA0K3cgnpy1UTzxMD0EM8LorOu95WNpYWxR3uc1SOihDB8Am2fS8SJaJA+GfvoAztjPDgognGeBwHzqokLBxq4vGxBo1XNJXwHnN/H/pAuVKaT8rsdiUcmxx855VOPjzIiMMWrKLCp0W86+piqe02XFLQQkxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iJJMJrkT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iJJMJrkT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3686F1F000E9;
	Thu, 25 Jun 2026 10:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782383143;
	bh=nwfhREsaeoMCVs34ExxN5XdHNIUIvpDO0RGXdUbaHkY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iJJMJrkTrhpWMalOjNkqBX2u9zCNQJNQ0Sdm/4OUgmMU7GW/k5ZYbO+i/ZLWC6jK/
	 fZAag2B9gh87mOtoaU8y0QJjA/7Vupizylj+dqqIcTH7tqHazeS+F66JaKugywN2QI
	 +BD/k0kGxw1nKGgsqj82nAP2f5yahBvtr/jERfqVMdVw2v2TmaoOmPtGxBLzxuPT63
	 SOyEvd8rYBDXGiK52CknMK6bHwGHi2+9WnVg+tFgZzP5SGhRwvbc3JEmu1Z0kXhvEz
	 GUgu/LgzqHLScXRvg9nytO2f9lj2Mo+qODPC8wzKuhbVbUIUPylvnQygYIKhgwngfU
	 4lh+7hVyFnHMg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v18 4/8] rust: page: convert to `Ownable`
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andreas Hindborg" <a.hindborg@kernel.org>
Cc: dri-devel@lists.freedesktop.org, ojeda@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260625-unique-ref-v18-4-4e06b5896d47@kernel.org>
References: <20260625-unique-ref-v18-0-4e06b5896d47@kernel.org>
 <20260625-unique-ref-v18-4-4e06b5896d47@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 10:25:42 +0000
Message-Id: <20260625102543.3686F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Asahi Lina <lina@asahilina.net>
>=20
> This allows Page references to be returned as borrowed references,
> without necessarily owning the struct page.
>=20
> Remove `BorrowedPage` and update users to use `Owned<Page>`.
>=20
> Signed-off-by: Asahi Lina <lina@asahilina.net>
> [ Andreas: Fix formatting and add a safety comment, update users. ]
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625-unique-ref=
-v18-0-4e06b5896d47@kernel.org?part=3D4

