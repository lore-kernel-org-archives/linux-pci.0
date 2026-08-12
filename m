Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272C248035B;
	Wed, 12 Aug 2026 17:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786555682; cv=none; b=V0FqeiwOGjN3bM/EGm+TY1jQg1gI6Ys+cCsZDhOT9Jmm6pDf9B49AG3vU43+QRRkMZY4JCtW25JqKUCJ6M3IesyZyFxk8Nszjz7aWo8NZ9u+GlVjYYZOaSUaavnw9rxSDsUnVIF/npQoKVu9d75aGocMyTbXvWKktOMy80IgORI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786555682; c=relaxed/simple;
	bh=dgqOkBtFyX/KTewdxZRdYsvKoca7NriJhKoHQEn3kyg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hNUSauJ3RFOuFIp7AWed2kYDBxq/niRL9yPKxN2GKkyTEouaqcEE6j3SSJcfU0RNqV6oxu2kJqAWMf5GkvSngG8tKtSXcvw4mQAi+tkmCnzyZPNhJkpK2/i83LX4F+Aq0/L6oz0/VFw2rgJfOE4KuZI0QYihdyuQSrZsv7lMDYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ayt+yN+j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ayt+yN+j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76E081F000E9;
	Wed, 12 Aug 2026 17:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786555680;
	bh=dgqOkBtFyX/KTewdxZRdYsvKoca7NriJhKoHQEn3kyg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ayt+yN+jcWytLP5KmqpSD3CS4xSQoNhVxLS2pu6dR7m5WumaWfXp2IYrd+0cUks5K
	 YM0rFFEoWwKv4xacFdFSZnuF0cRkvitudr24DAsvii1gkG0lWWCZi/lyUm9UL/X3/u
	 7wnWBwRYXvPIDQLSgrm+9wgRIdn0xMGUxNDQjLMS286aYGlLeFJCM4h1q4n3Kcheif
	 BJVi8H36UaNMf++0/EX9zoqeUqCTGSNdb3/Nmwo9UY7VQ7GUkjuqnKfMFXO2Rem9/t
	 Oop3Gh+zqFKPsa+mAqk22yY7ykcL7jxTe7+iZsQhWnUid2tpYS6e2EMElHdaSlNhG8
	 x2hVN7GAnreHw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/4] PCI: of: drop the reg_num argument to
 of_pci_set_address()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alex Elder" <elder@riscstar.com>
Cc: devicetree@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260812172247.276554-2-elder@riscstar.com>
References: <20260812172247.276554-1-elder@riscstar.com>
 <20260812172247.276554-2-elder@riscstar.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 17:28:00 +0000
Message-Id: <20260812172800.76E081F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The reg_num argument passed to of_pci_set_address() is always zero,
> so get rid of it.
>=20
> Reviewed-by: Herve Codina <herve.codina@bootlin.com>
> Signed-off-by: Alex Elder <elder@riscstar.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812172247.2765=
54-1-elder@riscstar.com?part=3D1

