Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7DD2EA498
	for <linux-pci@vger.kernel.org>; Fri,  8 May 2026 03:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778211558; cv=none; b=r7U0CXj4QzdCqUEVI7qV21hZFmrn1gJvnhDxL9UCh9MyNfY29lOO6CAEUYV34y2ZPk94lApkCDT6mK/pPijIkzPyWL/cp3qRNyIIecR3CbEJirEjmKF8l8T6SsKlFCmceQpO9UyXsFoN5t634aMfoLiFb+1lzjdKAlvJVrLf5h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778211558; c=relaxed/simple;
	bh=GjsIndrYHjUJOhYNTGPYDIt1nxcj+eKWeTQ63/SkBgQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=af9gRr+7+ejnlqXL4i33Zwz0uoy/I6W3Vkrh4xZCrw5BAI8j5U1tPNEeHQnp7jbmy+3u8Bq2KjAidxX2j5XZlmDYUT01Ag+TH+btpZmA2jpRuOz5R2FujDjcu1wAdACwBcbJh2nQ9fRjifSEb2HgklpwEzLS6LObrLGPwgRgvJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QCjtCCpo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QCjtCCpo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5873C2BCB0;
	Fri,  8 May 2026 03:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778211557;
	bh=GjsIndrYHjUJOhYNTGPYDIt1nxcj+eKWeTQ63/SkBgQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=QCjtCCpoEr3dKEen1lzLPnWuE/VpS9/yD05WfMPSGnua5KQmgD5gM9gA5sjjW/tEV
	 L09xnrno0O+nVui8oFCV8RdM2s/ZuELEbHh6s1iQrjc3gnCtkIwl4HaVS29mQr515Y
	 9WXNf0QuxXB9/Og8nxZn3KGqIt2+rRAuMbFaGOCu/6lxK5uEbIsc+T8/+GXCFuAn1C
	 xbyliIWZgPwcgZlsTIlPp2WD4NJBW8lMS0GUvEny7ex0Uqmx4/MUBVWXIk/OxRzOuW
	 XOAhvAsqa2eTFf/UmVFnR4pWZzgl8VxJVSQlg7cJWTFG9hlWDV5KJODvX0LmZK4eaU
	 gN4RfXr9n2wlA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 04/18] X.509: Move certificate length retrieval into new
 helper
Reply-To: sashiko@lists.linux.dev
To: alistair23@gmail.com
Cc: linux-pci@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <20260508031710.514574-5-alistair.francis@wdc.com>
References: <20260508031710.514574-5-alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 08 May 2026 03:39:17 +0000
Message-Id: <20260508033917.B5873C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The exported helper `x509_get_certificate_length()` uses a flawed =
logical condition (`&&` instead of `||`) that fails to properly validate AS=
N.1 headers, leading to parser differentials, incorrect length calculations=
, and functional failures.
--

commit 0f604cd0b6dd899bd029f10862a9b7010589e559
Author: Lukas Wunner <lukas@wunner.de>

X.509: Move certificate length retrieval into new helper

This commit extracts the certificate length parsing logic from
x509_load_certificate_list() into a newly exported helper,
x509_get_certificate_length(), to be reused by the upcoming in-kernel
SPDM library.

> diff --git a/crypto/asymmetric_keys/x509_loader.c b/crypto/asymmetric_key=
s/x509_loader.c
> index a417413269989..25ff027fad1d3 100644
> --- a/crypto/asymmetric_keys/x509_loader.c
> +++ b/crypto/asymmetric_keys/x509_loader.c
> @@ -4,28 +4,42 @@
>  #include <linux/key.h>
>  #include <keys/asymmetric-type.h>
> =20
> +ssize_t x509_get_certificate_length(const u8 *p, unsigned long buflen)
> +{
> +	ssize_t plen;
> +
> +	/* Each cert begins with an ASN.1 SEQUENCE tag and must be more
> +	 * than 256 bytes in size.
> +	 */
> +	if (buflen < 4)
> +		return -EINVAL;
> +
> +	if (p[0] !=3D 0x30 &&
> +	    p[1] !=3D 0x82)
> +		return -EINVAL;

Does this logical condition properly enforce the expected ASN.1 header?

If an untrusted device supplies a valid certificate smaller than 256 bytes
using a 1-byte length encoding (for example p[0] =3D 0x30, p[1] =3D 0x81), =
this
check evaluates to false because p[0] is equal to 0x30. This allows the
short certificate to bypass the check.

> +
> +	plen =3D (p[2] << 8) | p[3];
> +	plen +=3D 4;

If a short certificate bypasses the check above, does this calculate an
incorrect length?

For a 1-byte length encoding, p[2] would be the actual length and p[3]
would be the first byte of the payload, resulting in a potentially very
large calculated length.

If this bogus length exceeds the buffer size, it would return an error and
cause functional failures. If the length is within the buffer size, could
it advance the offset incorrectly and cause parser desynchronization by
skipping over subsequent certificates or payload data?

> +	if (plen > buflen)
> +		return -EINVAL;
> +
> +	return plen;
> +}
> +EXPORT_SYMBOL_GPL(x509_get_certificate_length);

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260508031710.5145=
74-1-alistair.francis@wdc.com?part=3D4
