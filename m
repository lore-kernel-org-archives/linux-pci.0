Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A3647045E;
	Mon,  7 Sep 2026 11:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788780706; cv=none; b=JlH7q1xL37pHbaENkKEapr8lcGYQ35C1YUMGKj6xkjNKSrk1Ly6DLg5/b1TcUiy3BR1OuyUqWzPmed5s7TsN6Fk5oMYHlXc0Zl8HARHm21nCvWked/Ut7oI9E5wzssKsW0XhgWzytZ5GTM0wiQH0/LKQyIwnnEd56lwu5+t8Hf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788780706; c=relaxed/simple;
	bh=h+q39KQ38n1uisRnaMCaXjuKwGgshFmVGcWms2lavHo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=i10rjhKfeVoowKhyCRQzMw3cvD+qzJQrReF5qHx1QJR1UuLdwFYLN9+d6HvZByRry97OuHEj5r66U5HqBjGDFwQTAIRcuRp6z760Yusxbpj+7opJTvGUnrNsmtIVpIkIl5ESRc8yZL8R2A2zHWIPP4c2N7XN0cXrrcsEmBHPqbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LMwLA/oe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LMwLA/oe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9542C1F00A3D;
	Mon,  7 Sep 2026 11:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788780703;
	bh=h+q39KQ38n1uisRnaMCaXjuKwGgshFmVGcWms2lavHo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LMwLA/oek406ih7MFr2B7nERFSsg9f4ExSpiGDHk6ggBDBmmGcU4zEPgLXoyBpbxe
	 IFNtxG5B6XrhQDXM084Gg2MvobyiAzlCL90Yob6zlrTMC9xCzCqj337UpQyeNJVNVV
	 TrfD5+8dYpug1FAWPYicC2eZb8k+wqKk17GGa58FuySCgGQrQMo/LB3DiguYj+8+8Z
	 rvJ25tATtu5IIATi0JmXldodtaUfPh4zEfzoABw3GEGzTAyBc5IOP9vDw0o62FhwK6
	 7zkREZDcm7CEb5aAhf0DDfSUGN0LQgu165Epe47Xq7deiA7TQxC7brc+AbZ98ygsNj
	 Ad8JUJa4A5Snw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/6] PCI: spacemit-k1: Add device id update helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Inochi Amaoto" <inochiama@gmail.com>
Cc: linux-pci@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260907112606.465778-4-inochiama@gmail.com>
References: <20260907112606.465778-1-inochiama@gmail.com>
 <20260907112606.465778-4-inochiama@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 11:31:43 +0000
Message-Id: <20260907113143.9542C1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Both K1 and K3 need to set vendor id and device id, add a helper function
> to simplify this.
>=20
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907112606.4657=
78-1-inochiama@gmail.com?part=3D3

