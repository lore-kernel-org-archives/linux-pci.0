Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD6E403EA1;
	Tue, 30 Jun 2026 10:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782817028; cv=none; b=HZXbpwQyZzbVf3reXJ9FvGQGARLeuVWUQzWFtz/D8GX47fm73CUorjFwH1EZCfr9lsGs/3lJC912tt7TWdL0XfplAaSL5rP0UzCDjDTvXE4qroxYhPmZ6lSNG6NjO2K78H0qffOBOk02LJVmUM9N5sev0W/8EUByh6BjUDXDshg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782817028; c=relaxed/simple;
	bh=4w+OuL7AZ3Qu7rkrOsXZRHw9D2nLkky9bB3PCKRgcKc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NAvimq49/A5e8c/wvsao/+WiQDu6eymxA4YCCL/3DXE9AvRx27F+DJQqii4IzVsjMaA/YFM8hzHJS0Xwnl+aVNuQyGEPP++v280LuNUEPTG5zRyBSUjSibqcbvzYkYN/oh2ibLFL1hwxrESJQ+vA8o+xxQZsaWSh+W7uSPGlXmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iOKpZoEs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iOKpZoEs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C0A41F000E9;
	Tue, 30 Jun 2026 10:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782817027;
	bh=4w+OuL7AZ3Qu7rkrOsXZRHw9D2nLkky9bB3PCKRgcKc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iOKpZoEsIpIvxy8kX7PMBu87YZkBfTcEyi2wrVG98n+4QgjITUaTMHfs5edRKN9CC
	 IaJJzuB+h4lKZSNz733ZbprA1+SGZMMLZh/ueed4+xh+SIixXVk0m58GbHH4XnKLww
	 hCS1Ya4fbEgWvnqmOKNJALxpd4gVj7FpqtaQ2YVwJJSbzaQbR4E60g/f30+x3Wrn9a
	 sELeAQpvYQwYjlv4jwdaCeYHW4m8KWPwzYwpbAuCa2ddmGBXy2CT3zuhbPAccpc0hn
	 qNf7OCggDWnYLkEhxENAL0RDcXOgkoiQlRhNyJ9BiFfVW/QCsCMHXA+p1jgcpFfCU/
	 ymUNqsa5LRZcQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 5/8] cxl/test: Use fw_devlink_set_device()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Herve Codina" <herve.codina@bootlin.com>
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20260630102804.413563-6-herve.codina@bootlin.com>
References: <20260630102804.413563-1-herve.codina@bootlin.com>
 <20260630102804.413563-6-herve.codina@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 10:57:06 +0000
Message-Id: <20260630105707.4C0A41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The code set directly fwnode.dev field.
>=20
> Use the dedicated fw_devlink_set_device() helper to perform this
> operation.
>=20
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630102804.4135=
63-1-herve.codina@bootlin.com?part=3D5

