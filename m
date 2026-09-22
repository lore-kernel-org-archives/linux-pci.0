Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58E825B0B7;
	Tue, 22 Sep 2026 07:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790061929; cv=none; b=IKezKh4GaGKQFPV/3eFFz9M+b9+laqwCoW8l9c9Qecti3ctbi6vk/goXxj03Tojm0PW4r5OnBSLBNJLGFhVfySXcrye/DVxriTfo3CsszjKq6KfthM4b2CwJCLM+DZJvAP21WTdHewj+wKwwPDrYydq1lONlrfuHmruMafR5MT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790061929; c=relaxed/simple;
	bh=msjq3/uC2tZisaq/QqmtboH2Q9stbsyIN2TWlCTVY1E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SEzrQ6FvjIx8uLASwFdxtRXT1avjXiEaz/jITTKtDv5y2KFHW5/02D907qy4+K5a8RQo8V/rgc+1N8aXQocONj2ZzUoaKRtsVZubyTjMsIE9DgMyYDIZNJw56rIQo1SLxEQhKp3wBK+O9mmq8GOFPQARYz7qcgXFxqXfGtoz+E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ORSV9Y1F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ORSV9Y1F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7537E1F000FF;
	Tue, 22 Sep 2026 07:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790061928;
	bh=msjq3/uC2tZisaq/QqmtboH2Q9stbsyIN2TWlCTVY1E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ORSV9Y1Fmd0RXr+G1OCzXKuHlEVpmJDJB4PewZo8iH0GpOh3JDWaxSYrBG2nTXdRK
	 yMUrHfCOdn4Z1ZC7Jr9NORgn2Z716I+Q75/lpDQ/o8lrOZ7hRq6V3rbTwWMkhTyFyx
	 fOL5WQXfqgJUEzyLtsVz4nI8lTswTQOuyzK/qSzwfpN6hUS1WqvR2b598MVOccblVu
	 +JULsh4wCLaOpoSudAcUh3q1pZuOPHiwk4jCFMlgpgYkF3FdnrXtTunwcGDBeRP1+I
	 OIv0TY5VixJ0FKbZo7iGjckXPikmS2nk5a0v6mjcp5lOLrJox7QChV9M3eemuvTHFZ
	 oeHqzUJaRDdFw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] pci/vgaarb: pass a data pointer to be used in the
 decode callback (v2)
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dave Airlie" <airlied@gmail.com>
Cc: dri-devel@lists.freedesktop.org, kvm@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260922071807.2533884-1-airlied@gmail.com>
References: <20260922071807.2533884-1-airlied@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 07:25:27 +0000
Message-Id: <20260922072528.7537E1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Dave Airlie <airlied@redhat.com>
>=20
> This changes the vgaarb client API so that the user can pass a
> private data pointer into the register that will get used in
> the decode callback.
>=20
> This allows a bunch of pdev conversions in the drivers, and lets
> some future vfio cleanups be nicer.
>=20
> I'd like to merge this via the drm next tree but also fine with
> it going via pci.
>=20
> Signed-off-by: Dave Airlie <airlied@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922071807.2533=
884-1-airlied@gmail.com?part=3D1

