Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA6D2D2397
	for <linux-pci@vger.kernel.org>; Fri,  8 May 2026 20:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778273498; cv=none; b=OlBLeBBAoPB0+NNnYjTiWiiLO7jtzQJUPQlNSnXEuqIreNXL6nGX3mQ2Osw00oK0PWaXIpo57C0CnjXbVWjMZ+p0cU93Q/V4JIxjTAZ4Qn/JI4Vcg3KRE7rjPnwYuWYtrD5L/vGoVJKxmb0qziHcX0eKq0DPF6eVdDDapJGuqGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778273498; c=relaxed/simple;
	bh=JAxAImxrEXB3z40/otkidML1NX7C50Dd4t4wi95PeaY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=u9lep+6GdbwbhGMOrpvU9GFCM4hRy7e7SxPeGLqA6zC0/Kcnaey4majEw0YF+P8W7Vly5GJ/CANy4pNSxP4Uv2/teF1ndroz9RCsvnqCcNZkCiLJ/5YalWs5jsL55LCvdXbHETnxTC/Bs/nvlizSSH2aCBQRsWz7pXUS4cwTXRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GgYwjGWG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GgYwjGWG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61A4FC2BCB0;
	Fri,  8 May 2026 20:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778273498;
	bh=JAxAImxrEXB3z40/otkidML1NX7C50Dd4t4wi95PeaY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=GgYwjGWGiEFMqzb7jTu9HWKKooqwyJSuHM+eiJy9ZPOaZhAThsP/Iv5xrUoGSAp3N
	 1cQ3rdm0iBdGA8lcSou1k+FToVrxvbiC8xIM76DpYpd5uT2iPg9h68UrUzCIwUzpt8
	 fxK9NE/dxiwjmQ5QyqvqXVOrWrQzDUBhs9m8QRUdHMrJl0QzJKAFog2Cep8X9FD1vO
	 jcU97vWWe7lS0nOt+Sl0CLLorrn/uy0yVCjktkrj0sty8t0EZKZ3BOfNdS29b/hz3v
	 1padholiGKuU25wJT54X8YRMvFyRaHSZLLwGZ7KmujT3hUzgyr0mpe6LtF/lrPT2na
	 /6FzbPMZx6TmA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: dwc: Use DEFINE_SHOW_ATTRIBUTE for ltssm_status
 debugfs
Reply-To: sashiko@lists.linux.dev
To: "Hans Zhang" <18255117159@163.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260508133432.1964491-1-18255117159@163.com>
References: <20260508133432.1964491-1-18255117159@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 08 May 2026 20:51:37 +0000
Message-Id: <20260508205138.61A4FC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The commit message inaccurately claims 'No functional change int=
ended', while the patch implicitly fixes a memory leak and module unload ra=
ce condition.
--

commit 3ba9e0fae6d8b7784978dea48b58611a119ad5c9
Author: Hans Zhang <18255117159@163.com>

PCI: dwc: Use DEFINE_SHOW_ATTRIBUTE for ltssm_status debugfs

This commit replaces the custom open function and file operations for
the ltssm_status debugfs file with the DEFINE_SHOW_ATTRIBUTE macro to
reduce boilerplate.

> Replace the custom open function and file_operations with the
> standard DEFINE_SHOW_ATTRIBUTE macro to reduce boilerplate code.
>=20
> No functional change intended.

Is the "No functional change intended" description accurate here?

The original code used single_open() but did not provide a .release
callback, which leaks the seq_file on close:

> -static int ltssm_status_open(struct inode *inode, struct file *file)
> -{
> -	return single_open(file, ltssm_status_show, inode->i_private);
> -}

[ ... ]

> -static const struct file_operations dwc_pcie_ltssm_status_ops =3D {
> -	.open =3D ltssm_status_open,
> -	.read =3D seq_read,
> -};
> +DEFINE_SHOW_ATTRIBUTE(ltssm_status);

By migrating to DEFINE_SHOW_ATTRIBUTE(), the new file operations
automatically include .release =3D single_release and .owner =3D THIS_MODUL=
E.

Could the commit message be updated to reflect that this implicitly fixes
a seq_file memory leak and a module unload race condition?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260508133432.1964=
491-1-18255117159@163.com?part=3D1
