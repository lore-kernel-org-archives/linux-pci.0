Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9F3408623
	for <linux-pci@vger.kernel.org>; Fri, 14 Aug 2026 07:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786691943; cv=none; b=eYEWUTknnm40bt3eAQfPhdD+fRvshMlo8RkdosiLFcCHS615Ea8iCPW2LRhXLWIxHJ7gcdJgy7Jul5VdZwcVczNTY1CgRAieDIMR4R5QZSg0Mpx61jPUypXzqLHFKg1Y+eQcvl5M+uTV+fim00yusTblD++rw5YJXK+/UqfmDk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786691943; c=relaxed/simple;
	bh=pjoLyTFPJZ27L4+GiGEUhnm7L3vvS3eK7U+H877tGxw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jzbS3/IOpiBt9uicppAP3m0vnxbFsJY3OQWqQdHHEsf3TFd7qQ77W8TyWeQaGly2+IMEKWoUa85blOmP5uvfVrmcnRQQ2VFfdVdNHuyIql59g+QuYcFJAT4hah5D/zAxrfwOQ8fgmWPhEiqNwBJ97+IM6bSvDe19pVBZV9SwVH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l0Q65gSd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l0Q65gSd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78AA11F000E9;
	Fri, 14 Aug 2026 07:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786691941;
	bh=CKzyg6I1jNqGHxzrv5F19s2FBtWNiEGMcdNQ4pakJ8k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=l0Q65gSdVasqObZKtms6hPf6N9Hmveyc4kLAPfZst/ixhICM30+itHmDQ2c6YFAyY
	 paMzTVuHXbtOj+EDSTurpRr1VLO6ijQ3rXnK8eWjP76ljTgVhCulGdgIk6MZG1vgm3
	 Whvi9shoGcNKq1qgrpf0VSWca1i9cF+OlGbwSK3lOmLlNkI45FbgV3lOCGlwExXOCX
	 gJYaDF8EPXaGLZv8J+h3cVw+6WjrWyOntUpBmhsaejl7TXWACwJ+i0M2WMMC1bMW1C
	 Pk68FhnVHWfSSKs3Q5obhMC8JbbGKBJhIKJkcQR1Sryuay7hrDHfrhihznUlkUSVcF
	 Ik0b4stM+v8uQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/4] PCI/sysfs: Stop reporting _DSM failures as -EPERM
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260814070522.2327975-2-kwilczynski@kernel.org>
References: <20260814070522.2327975-1-kwilczynski@kernel.org>
 <20260814070522.2327975-2-kwilczynski@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 07:19:01 +0000
Message-Id: <20260814071901.78AA11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Buffer over-read in dsm_label_utf16s_to_utf8s() due to passing len=
gth in bytes instead of 16-bit characters.
--

--- Patch [1]: [PATCH 1/4] PCI/sysfs: Stop reporting _DSM failures as -EPER=
M ---
commit cd414532673d45c83fe3ca965ef9476bab4c3514
Author: Krzysztof Wilczy=C5=84ski <kwilczynski@kernel.org>

    PCI/sysfs: Stop reporting _DSM failures as -EPERM

This patch updates dsm_get_label() to return appropriate error codes (-ENOD=
EV
and -EIO) instead of the literal -1. This resolves incorrect -EPERM errors =
in
sysfs reads when ACPI companions are missing or _DSM evaluations fail.

Link: https://github.com/pciutils/pciutils/issues/175

> diff --git a/drivers/pci/pci-label.c b/drivers/pci/pci-label.c
> index 0c64465196404..255e0ecffb096 100644
> --- a/drivers/pci/pci-label.c
> +++ b/drivers/pci/pci-label.c
> @@ -160,12 +160,12 @@ static int dsm_get_label(struct device *dev, char *=
buf,
>  	int len =3D 0;
> =20
>  	if (!handle)
> -		return -1;
> +		return -ENODEV;

[ ... ]

While reviewing this patch, I noticed a pre-existing issue in the same file:

drivers/pci/pci-label.c:dsm_label_utf16s_to_utf8s() {
    ...
	len =3D utf16s_to_utf8s((const wchar_t *)obj->buffer.pointer,
			      obj->buffer.length,
			      UTF16_LITTLE_ENDIAN,
			      buf, PAGE_SIZE - 1);
    ...
}

[Severity: High]
This isn't a bug introduced by this patch, but does this code cause a buffer
over-read?

It appears utf16s_to_utf8s() expects the maximum number of 16-bit characters
as its second argument, but it is being passed obj->buffer.length in bytes.

If a PCI device with a firmware-provided ACPI _DSM returns a
non-NUL-terminated buffer of UTF-16 characters, could this read past the end
of the allocation when a user reads the world-readable sysfs label attribut=
e?

Should the length be divided by sizeof(wchar_t) to prevent reading out of
bounds?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814070522.2327=
975-1-kwilczynski@kernel.org?part=3D1
