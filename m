Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE22392807;
	Tue,  1 Sep 2026 01:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788225348; cv=none; b=hwb7amObxqtRZ5ybdpmU7DBKBnt0Z2c+0AYQezKOLnpxNrgJ7GhHmIlfg+6hXXa0OPK2GJ9/AUK+T3RtAZLgAgZYPyicTrGg0uIrNQNG6RqC6cSeTsKC5qeFvleLNajGjai8C4JYEV7jiAd1SARUqlLNUxv7/7tF4dClxvDhYhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788225348; c=relaxed/simple;
	bh=pSUXBXuC/WcF+cw6I7BTnsa4QpYFNX/Q47pKZnfYBhM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=K0JIVDfQmKZO42ThSoV12NLBTrDcLmZHPEL1aUvJQwnQVbyawkJo/JQDnl7ndgjAa6oubcxxsIN+o8U/rjCBzbPTo4kkXGx7fbU25nG8hkp9dy4y+tyySCir17azcT+QaJpPI9wUBGDGfMCD3wFlZT7fFcdn0W5JU/POnk0oqys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BYK4B9jQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BYK4B9jQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F29521F000E9;
	Tue,  1 Sep 2026 01:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788225341;
	bh=E1IluO2Kcw0Bf5799f9ryVsFKBwAsiQQ43ei50aa4EQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BYK4B9jQ6JaiBKjRQaiqqjnx3Y5gzaLuHvcd2OKQSdDER+qxU0AOIhfZx6YpRFU24
	 u24GYFPGGsrEtSwq5xfzJjfcP0qNVjiSSNIWBzRo+ee7CT1BPSlMHG0qv5RlZjn8M+
	 EzXt6VjZkXqwj4UktZXKc/ONqxKB4DiiGhmzjZWVwTxOB8KOadID2vm3wEogDTgyXC
	 c5Xu2GpFr+Kn0z24hvgNuN/+WrkXRcz8Sic1689ASW7am4eQJWw7yWfvurW2JNEKMR
	 jer57wMFtTbaHoqqzrqFac3IrkxjdINKZ7xoQA05lI/nxtRi7/fWCQt20UC5vkoa/X
	 z7piRcfe36cdg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 13/21] PCI/CMA: Validate Subject Alternative Name in
 certificates
Reply-To: sashiko-reviews@lists.linux.dev
To: alistair23@gmail.com
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <20260901010347.2614656-14-alistair.francis@wdc.com>
References: <20260901010347.2614656-1-alistair.francis@wdc.com>
 <20260901010347.2614656-14-alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 01:15:40 +0000
Message-Id: <20260901011540.F29521F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Lukas Wunner <lukas@wunner.de>
>=20
> PCIe r6.1 sec 6.31.3 stipulates requirements for Leaf Certificates
> presented by devices, in particular the presence of a Subject Alternative
> Name which encodes the Vendor ID, Device ID, Device Serial Number, etc.
>=20
> This prevents a mismatch between the device identity in Config Space and
> the certificate.  A device cannot misappropriate a certificate from a
> different device without also spoofing Config Space.  As a corollary,
> it cannot dupe an arbitrary driver into binding to it.  Only drivers
> which bind to the device identity in the Subject Alternative Name work
> (PCIe r6.1 sec 6.31 "Implementation Note: Overview of Threat Model").
>=20
> The Subject Alternative Name is signed, hence constitutes a signed copy
> of a Config Space portion.  It's the same concept as web certificates
> [ ... ]
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com> # except ASN.1
> [ Changed by AF:
>  - Fixup a few issues caught by Sashiko
> ]
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901010347.2614=
656-1-alistair.francis@wdc.com?part=3D13

