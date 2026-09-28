Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276F2329E4B;
	Mon, 28 Sep 2026 01:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790559852; cv=none; b=dOitiUr6bbpyxHVeG6amP/vjaWumxBSBlhMHCv0YBe8dsqlfPmvchOy7Q6wZtyvMyN0qtkr8K0DfeuNMZKftiGy+VK/8hoWHqs6fVs+6beQf4X3pN8a7po7iNL3O2If2YKFXC7Y46QOGHRWNp/m91PxBoqGdYbrhWx+R07mylhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790559852; c=relaxed/simple;
	bh=2A7fHysPMzM1bo0gvg41rDwkRrxQiuDzHDq8PLcoMZQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HX0ifbJy5ZAqtxqS/8jftZWtXjjBGTv4RsccuvfkAVidlAthT6oxbuo7Ctl/sju8XCE2vhxcR1PottWh5oCu1HkeNvvgxjExParYCDazTUjCq8Bz7hpdIlkxPOFR/ElpE+NASSKoEx33ZjV5KMugv1IvsIkIuUBQRJ8GNFP9FGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oxedhWiv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oxedhWiv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91F261F00893;
	Mon, 28 Sep 2026 01:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790559850;
	bh=0i5Qm1ktJnboX2+CTL/BtH/36uCFxoyxaE6Xm55vEyg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oxedhWivbvjnqcUqfv7dTUr8bexZ3PgR1RumGsN8+optSA2mt+j8r/uwPYvVHtwXs
	 CKiZVPeFKFa54ITuRDfiKyK8QSbp7AVFCMids+5rpmsB1RdwKljOxtpWogRD0K4TZl
	 ed1TQeoucYA5DEVzo410+fSpLZt/X9bNkvKfMwH7AIOoa4BsZDL/mWATXibN7jlLpc
	 YvXTdCquYq699o0+r71cccTm8rLk9ZQ5HLQMN8kZN3ekKemfuP8izhPzedKF/M3aYx
	 OUJzLraq5VYORdWSJq0/ue/VDf0S708VVeGZr2Wf81ems3LrXWfxdH9xDtHxZf31JH
	 X9/zzYFcQEzVQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 14/22] PCI/CMA: Validate Subject Alternative Name in
 certificates
Reply-To: sashiko-reviews@lists.linux.dev
To: alistair23@gmail.com
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org, gary@garyguo.net, ojeda@kernel.org
In-Reply-To: <20260928011123.450800-15-alistair.francis@wdc.com>
References: <20260928011123.450800-1-alistair.francis@wdc.com>
 <20260928011123.450800-15-alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 01:44:10 +0000
Message-Id: <20260928014410.91F261F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] pci: case-sensitive SAN validation rejects uppercase hexadecimal d=
evice identities
- [High] pci: ASN.1 decoder aborts prematurely on certificates with multipl=
e CMA SANs
--

commit 8216d5120f9a26d7f0a6ec14495fd951b1a7513d
Author: Lukas Wunner <lukas@wunner.de>

PCI/CMA: Validate Subject Alternative Name in certificates

This patch introduces validation for the Subject Alternative Name (SAN) in =
PCIe
leaf certificates per PCIe r6.1 specifications. It uses an ASN.1 decoder mo=
dule
to parse and authenticate the identity encoding within the certificate's SAN
against the device's actual configuration space.

> diff --git a/drivers/pci/cma.c b/drivers/pci/cma.c
> index 6b52b129574ec..6e4eb3b921131 100644
> --- a/drivers/pci/cma.c
> +++ b/drivers/pci/cma.c

[ ... ]

> +int pci_cma_note_san(void *context, size_t hdrlen, unsigned char tag,
> +		     const void *value, size_t vlen)
> +{
> +	struct pci_cma_x509_context *ctx =3D context;
> +
> +	/* These aren't the drOIDs we're looking for. */
> +	if (ctx->last_oid !=3D OID_CMA)
> +		return 0;
> +
> +	if (tag !=3D ASN1_UTF8STR ||
> +	    vlen !=3D ctx->expected_len ||
> +	    memcmp(value, ctx->expected_name, vlen) !=3D 0) {

[Severity: High]
Will this strict memcmp() in pci_cma_note_san() fail if a device presents
a compliant SAN string using uppercase hexadecimal characters?

> +		pci_err(ctx->pdev, "Leaf certificate of slot %u "
> +			"has invalid Subject Alternative Name\n", ctx->slot);
> +		return -EINVAL;

[Severity: High]
Could returning -EINVAL here prematurely abort the ASN.1 decoding sequence
for certificates with multiple CMA SANs?

If a multi-function device shares a single leaf certificate containing
multiple Subject Alternative Name entries, aborting on the first mismatch
prevents the decoder from checking subsequent SANs that might legitimately
match the current PCIe function.

> +	}
> +
> +	ctx->found =3D true;
> +
> +	return 0;
> +}

[ ... ]

> +static unsigned int pci_cma_construct_san(struct pci_dev *pdev, char *na=
me)
> +{
> +	unsigned int len;
> +	u64 serial;
> +
> +	len =3D scnprintf(name, CMA_NAME_MAX,
> +			"Vendor=3D%04hx:Device=3D%04hx:CC=3D%06x:REV=3D%02hhx",
> +			pdev->vendor, pdev->device, pdev->class, pdev->revision);

[Severity: High]
Is it possible that using lowercase formatting (%04hx) here inadvertently
causes the validation in pci_cma_note_san() to reject valid certificates
that encode their identity using uppercase hexadecimal characters?

> +
> +	if (pdev->hdr_type =3D=3D PCI_HEADER_TYPE_NORMAL)
> +		len +=3D scnprintf(name + len, CMA_NAME_MAX - len,
> +				 ":SSVID=3D%04hx:SSID=3D%04hx",
> +				 pdev->subsystem_vendor, pdev->subsystem_device);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928011123.4508=
00-1-alistair.francis@wdc.com?part=3D14
