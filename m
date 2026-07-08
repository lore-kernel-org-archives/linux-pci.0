Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114BD399000;
	Wed,  8 Jul 2026 10:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783505801; cv=none; b=V0b5DhJyopHkPfwqEWpNWpqiRvIlJdkB4iUXDbbi351Ze0CYmGcMgj7gMj7gaH3/LCTcTkwyyrhrzPxAxnKt1opY92D8fS1s9FaTTpZfgmnM+LhkqFWMKE8eWQEwvLna0nZdNb16VdLYlFRo6diWmuER2PZt+k1rY8Qo+gXwdD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783505801; c=relaxed/simple;
	bh=H0bu4r6LvY7UK5iKYHbkKBf0GzOv6zrEQNW3z73qBF8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VQIrfPf4I6ij+ribfI2R6YPi0DVBjPd3Do0YfQ8iRK11fDkkhXWJ87QNPq94ofdEYG6j+cxLuXR/DQ8g6/ld2DOuB6FW7gJWUzd0N9Ic1zUknfmJUhdPFr3+Dzkc857tdV6DhmTU04QjNVWCpOz5P2jMkI1qIY+I8ZacIAyepNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GapJKGSx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GapJKGSx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5BAD1F000E9;
	Wed,  8 Jul 2026 10:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783505800;
	bh=H0bu4r6LvY7UK5iKYHbkKBf0GzOv6zrEQNW3z73qBF8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GapJKGSx6QPKHpJ/n85aYRQfpKOfoQ8jVwFzZeFc48pgVPl4TnT+IqUZUEQ54Su7J
	 MupofVeNpxerPBF3D9kLWZIe4UFCE9Dkunhlsu9Z+zTGF5NhCsBNCukITlgd6LtpkX
	 nfBGzE83kSK0xWHSqBOtZhJvcWYgUCnKLf2DXGsNhiSWoZuvkJKK3YtPCw0sDvgIxA
	 tx9iXXZ2HD51SyW66fsDAAlhGqYhE3MD8TzhYsIDKNLI/8+6sMc2ro9+EYmkibJI3x
	 F2kUwXr/4ZD/Z7fDgvbp8BiKSV+paXH/wa53VFIJe/JlCbxOl1vtSFsTV/avBaKqwP
	 Rdqnbb+i/K82A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 5/9] cxl/test: Use fw_devlink_set_device()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Herve Codina" <herve.codina@bootlin.com>
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20260708100302.517792-6-herve.codina@bootlin.com>
References: <20260708100302.517792-1-herve.codina@bootlin.com>
 <20260708100302.517792-6-herve.codina@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 10:16:39 +0000
Message-Id: <20260708101639.C5BAD1F000E9@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708100302.5177=
92-1-herve.codina@bootlin.com?part=3D5

