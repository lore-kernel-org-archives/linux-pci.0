Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B105139A056;
	Wed,  9 Sep 2026 08:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788941082; cv=none; b=cG0qI6G8XncmN5Rb3W6/9mtFEuXyHR85TmIrtQYE0xPYCqXMxP8jgvsO7nFtYDsjME3aGrtiPH7OLDY1sGXBTVVgQFSMchpzHxiVmpyX2zKqenfAyxApT+eptTWrFCSB7oQIDYIeMhczr4HON8cvWDDGpdmJrXtFPN3esTk2fWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788941082; c=relaxed/simple;
	bh=q6MRI5Z8Brqr5zAq3R+RU9MdJPcHRMnGmAObEXP1EB8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HblAr1OFcMbmJezysDXXoRC0/gTKNk4pSzyZZm6g5mkqnMeuB7AJPg8b544Ly5AnRo4fp7XASVbgkbNb5VnTX2kjgJKFSxprgDAh9Ddsi86yrV9hBP9yZhRvuMtzAJXwk61MftXl0Fb8bnWYs2YfSp5CSAPdMFp6oQipVfHS8Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KCNqmX+X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KCNqmX+X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C4A61F00A3D;
	Wed,  9 Sep 2026 08:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788941081;
	bh=q6MRI5Z8Brqr5zAq3R+RU9MdJPcHRMnGmAObEXP1EB8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KCNqmX+XpJtRlcq6V4ERUpVVyLQZLTvGBM3P+wOul0qc2INyZoZW7VxU5cYmprcOn
	 dpXDMuqLVMJbTUjgI+purwjNb8WwlY6Y/DPcw21yPR7CQkba21bZWXS5DlKE+mZVR5
	 hDyq5V4oZ3C12sAD7KIJ/rn1LHs99PEecWOGKBzmfeuBN8rgU0WP8QP/DolDWg7hjZ
	 PBhL/NgvbM5Zgrj3NJuTRDmMAQiNPBtpFxe1mc9XpVQ/DIgok+jSx0KD3FvgaOWALm
	 3TXUPvKEKee6c5JPApNXldON9hZDSsgLRWWH0vuVUi5gOFjVPNHCq27lM4YX7zw7Qu
	 2mF/7mvy8zThQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 04/10] cxl/test: Use device_set_node()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Herve Codina" <herve.codina@bootlin.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260909080114.591938-5-herve.codina@bootlin.com>
References: <20260909080114.591938-1-herve.codina@bootlin.com>
 <20260909080114.591938-5-herve.codina@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 08:04:40 +0000
Message-Id: <20260909080441.0C4A61F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The code set directly dev->fwnode.
>=20
> Use the dedicated helper to perform this operation.
>=20
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909080114.5919=
38-1-herve.codina@bootlin.com?part=3D4

