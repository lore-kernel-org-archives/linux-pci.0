Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0859397E8B;
	Wed, 17 Jun 2026 20:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781727927; cv=none; b=a+9qbn/o7OzMm1rFgc5ktPPQmd1Pq7ZTOUU6JITSjC11L71Lx1ae0nqT2PJb4xgRlM9tckENQ2m9YvHCLknc+/QTTIyg/7zQ4WZXHJtboy3ln/6735T2dRJnojzKzsLixvcN9ptNARuS7UjSoBxMxoZhtyChbJchnQhh3RVGwYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781727927; c=relaxed/simple;
	bh=6iej/hQl+0QYeiLQHxqYbBMPbJEyZ5TXZc78+bT7JuQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oFSQ/ovG0r+w2ACXURO/6dee5Wg2gIbuZ5Bbsu43s8cZiLe68qq6roMFMy3iA2nPTtpwpkczZxPi+Lv3UEkr4Fmc2U17oo+DFf7WeHHye1Qiw5M9vcmBNJ+jnzqOEulCz03XOqwpjbBgvC5n0z/bjqnwEif8TfbKfyvxBcF+IPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ERh2GKso; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ERh2GKso"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DA651F00A3A;
	Wed, 17 Jun 2026 20:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781727926;
	bh=6iej/hQl+0QYeiLQHxqYbBMPbJEyZ5TXZc78+bT7JuQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ERh2GKsouxhE02ePsZAeiQN9yo7F9Lz5z0Qf2+2PY8tip73ti6S5lLws05OynCfJa
	 nFvf7z50qUIg4Ry1luogaFozal9GDL0/v8R+LB3uKkixMemOMAAK52Dzy84A6/Fukx
	 zYq8CyJhQ9w2YYccq4/+QnFBc8DmMyEUGb6OskHA+ku60cXeRSVZOKTmX4POeUZTF9
	 UlBBLd9zwbZh89TM0XmdOrt4YrkBTgeyzzI4dBiesWOKdTsucgbBN3r7mDBY9hrO2i
	 AOwmVoPGGbtQZ++Apse2qS3HyIObWVPK7q5ePNiesBNv2p0JkSq6Wkhbipjv+UlsER
	 O7rVocvYdByow==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 1/4] dt-bindings: pci: Strictly distinguish C0 from
 C1-C5
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thierry Reding" <thierry.reding@kernel.org>
Cc: robh@kernel.org, devicetree@vger.kernel.org, linux-pci@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260617-tegra264-pcie-v7-1-eae7ae964629@nvidia.com>
References: <20260617-tegra264-pcie-v7-0-eae7ae964629@nvidia.com>
 <20260617-tegra264-pcie-v7-1-eae7ae964629@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 Jun 2026 20:25:26 +0000
Message-Id: <20260617202526.7DA651F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Thierry Reding <treding@nvidia.com>
>=20
> Instead of using the ECAM registers as the first entry, strictly make a
> distinction between C0 and C1-C5. This is needed because otherwise the
> unit address doesn't match the first "reg" entry. We also cannot change
> the ordering of these nodes to follow the ECAM addresses because that
> would put them outside of their "control bus" hierarchy since the ECAM
> address space is a global one outside of any of the control busses.
>=20
> Signed-off-by: Thierry Reding <treding@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260617-tegra264-p=
cie-v7-0-eae7ae964629@nvidia.com?part=3D1

