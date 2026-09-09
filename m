Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E57245FFBB;
	Wed,  9 Sep 2026 08:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788941462; cv=none; b=RVwcfNZL/G3xS0YzNhmBaCLB9nxXmTnGQWGimVKd4H7dBpHP6abqoES5BJDYc9mqKaanLGZAx4FQEeavjx3BFaGQ1NmoKzmmFLwp6bUDNnkbO7MftxH8YWxzR1Dyo1bFG2QOsgTsG7rqcHegmq3cNI27IDN5f2jTwNzhqSyy7+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788941462; c=relaxed/simple;
	bh=ahODOWm2NRNjSDVaYVxuG3vASsCNyJkL4sP1836ApWc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bkMf7m91UPF89BV0aRkYNEKeLab2kvuuCFlHZcjlzNij4ukRazkPVXsfvQgfBnJkLKg6ca9OB1JHhnz+YABICO5AixwX5ESkfdgqJURB+C4QOIm0sryXj7ambjuVez7kyT7WFRirekV4TUBT3ucBw1H2RfnYVKGzgCxArJnLPrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aEOtMatj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aEOtMatj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3BCD1F00A3D;
	Wed,  9 Sep 2026 08:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788941460;
	bh=ahODOWm2NRNjSDVaYVxuG3vASsCNyJkL4sP1836ApWc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aEOtMatj6r829yEfT29oZiFwkbvt+SI1UY7bQUjIL7WyJr3GwC6MLmeg7VBRbCa/e
	 iLBEpOi64c2RMP0bmEpeCifs6oOEVyrXbQ62cFJ8gAzW3TuaSOLQsakCF3YzYoenUG
	 DRwm22Vn/KCaUw5W6IFRMQPPKPwfJYsSst12Rs5++tmeBVDe3LKlPZDXzS3NTDGUHT
	 IjrQpUxBuNdk42sTvvlIxk8gIVcsiZ5J7x1k7kk7Oa+5+BX3tUhdtg0jDqVG4zxb6V
	 4pim2RDGJFVfkORQfNtjNbQpb5y4JtBJJwcXY68bhzUWtlfcgar+04Sfa6o8MrAPsE
	 O9fnVr4VPOCUw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 02/10] drivers: core: Use fw_devlink_set_device()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Herve Codina" <herve.codina@bootlin.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260909080114.591938-3-herve.codina@bootlin.com>
References: <20260909080114.591938-1-herve.codina@bootlin.com>
 <20260909080114.591938-3-herve.codina@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 08:11:00 +0000
Message-Id: <20260909081100.A3BCD1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The code set directly fwnode->dev field.
>=20
> Use the dedicated fw_devlink_set_device() helper to perform this
> operation.
>=20
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909080114.5919=
38-1-herve.codina@bootlin.com?part=3D2

