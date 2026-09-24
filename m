Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A2C402BA1
	for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2026 19:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790277422; cv=none; b=ppedJyocAhXLsn/fpoIBs/Dbyf/qh6VcqM3rV+2tvEmMZm4yZvArOSN3UxOxOCDtzB+Do+nWfj/fgeG1sdcOehMqwoc/5MCzIYQ4ijuyu1N7FsTNdmpAQA15NN59FPxqMKHxChxBN6pj06w1ScVxoJS/sQ48mIVX0C1wr1oj+hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790277422; c=relaxed/simple;
	bh=Xb1WnNCdhkMaXQ1qEvTUt6yUOI2B1I0Bw1lu4WsVdFQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tYIUbn82VCQKJxSDjrXw3f6jG0kgGJnsQ7uKaOJsPAp6cLWryS3JzaOro8jL47m0rOftYpSkQ8RcPVHMdORDqT1x+v+omFIBgBEEVM69mDCiZZUMl98NI+3ZXwcuOmg6LkQvTSzvuhycIW/+5lvBq4c/IhVuBFHazmjbORwtJew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V8M41PiS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V8M41PiS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 141891F000FF;
	Thu, 24 Sep 2026 19:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790277421;
	bh=Xb1WnNCdhkMaXQ1qEvTUt6yUOI2B1I0Bw1lu4WsVdFQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V8M41PiS1MDBUzYrNkZ224pSNTG4d5Ql+fHBsbw4EUoM+O3wlE+8IPN+e+6U7yX9K
	 dOrGB1ECdlnit0ptB/ULCcNmqd8Zr2AxHvbCOcJYemfhOpPZxyxMzAw9wTqcbyKA4l
	 NXjKe+wWbFixK6vJlpsopkspimNe7b/O54a6IotGkx5SpqmZVZ44crWK4Wb5CDHyd4
	 lAxN9Coo2E3IJMTRydpoG7Dr5ayStDFU0gPFAqPpjQGma5+I44xvdRJ+wIX5WNEVeW
	 L/l5bA3Py1MRK/SvdqQIfD0AIBLu11LG6EzTwHht8iKRLpZXG1g+5m8f3gAQjuQVJU
	 Jgj114GX2j49Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/1] PCI/TPH: Validate the firmware Steering Tag
 response
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wei Huang" <wei.huang2@amd.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260924190543.3424792-1-wei.huang2@amd.com>
References: <20260924190543.3424792-1-wei.huang2@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 19:17:00 +0000
Message-Id: <20260924191701.141891F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> TPH _DSM returns an eight-byte Steering Tag information buffer.
> Checking only the ACPI object type allows a short firmware response
> to be read beyond the end of its buffer.
>=20
> For safety, require a non-NULL buffer containing the complete value
> before copying it. Use memcpy() so that reading the response does not
> depend on the alignment of the firmware buffer.
>=20
> Fixes: d2e8a34876ce ("PCI/TPH: Add Steering Tag support")
> Signed-off-by: Wei Huang <wei.huang2@amd.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924190543.3424=
792-1-wei.huang2@amd.com?part=3D1

