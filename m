Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B24D45560D;
	Tue, 29 Sep 2026 08:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790671359; cv=none; b=hiA+TYbqkL1SqVudN1j2r5Ah/28xRhD1oMVdX26BCcr4Y2wPYxQ5R9CG3x849DYhiUCQNcnF9CBTWxXPvPJvYRsy09Iv8X81GHcUxufwvD5TIvY4a3ibVoOWCcqTVS1LyDPlL18/VW6vExikxygrOD/tOLjVJg1XgvCaGUsh+f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790671359; c=relaxed/simple;
	bh=WJof7csVK2fzwUaKDUs9UquK0JsK5/SPuBdemYt9Kr0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Jt7KO7EydPO5H303Ga2yhAwo6YJ9sjnpgUlAsrnEag1MA9PjZOMgx15jOLtMCr7SU/e+lZHqRCN+WoqnitgL+qBkZ3LEEqObl9OrE9od9bJAAxarrbiqy/FGdVCf4XpPmTP4I3qZfAMmWOrVt59L6tqCrq36+4pfXfG1NBHxa0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O0fBZLn0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O0fBZLn0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54A151F0089B;
	Tue, 29 Sep 2026 08:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790671357;
	bh=WJof7csVK2fzwUaKDUs9UquK0JsK5/SPuBdemYt9Kr0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=O0fBZLn0nW3aAdTkNpem1Xnym3kHCH2HkOENEDP9/bSY81nvpmXgZz+6G/G+39Mak
	 lVRfciiLyhZxQACGZ7ZodqUFkRoyEgbOw5pOFtyX3/b1O8D8rXvh/6USPb2N0NHNRq
	 o84n+qBerkEzYEV9OCXeZvrGg+JzqPKpcXiv+E8QjBbxN1vtBx/Fh9vsndGRbjC1hr
	 SO2CYzjkCtLBDPnyBLWyQuDh/orYflW5/Ay0SMEOSBL2GDgassS6JTInAHGpnBjEjL
	 0OBekhDrtU+KWQ0IXpTWeZEmkZjAK9RLU3uEsR/0Y73J22GWk/29PjhOlau3TJGfZo
	 TM0enk5cU/epA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 3/6] PCI: spacemit-k1: Add device id update helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Inochi Amaoto" <inochiama@gmail.com>
Cc: robh@kernel.org, conor+dt@kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260929083755.458238-4-inochiama@gmail.com>
References: <20260929083755.458238-1-inochiama@gmail.com>
 <20260929083755.458238-4-inochiama@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 08:42:36 +0000
Message-Id: <20260929084237.54A151F0089B@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929083755.4582=
38-1-inochiama@gmail.com?part=3D3

