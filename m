Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9D554774;
	Tue, 23 Jun 2026 05:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782191232; cv=none; b=uoajWpC2I6t/p77v0DccvhM16O8eKICUhSCpd+cFt1NlNJjUqHfqM2UtWVeU6qrfI9uZmciexcR8XClYAQtJ9WFvxPguRN/v+YzrAsENogfgOP7vG2QM2jyItH8laqvXUVlRNYElyEeZ4ReojJLevEQMp5g8MYMUc5giJsKJBDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782191232; c=relaxed/simple;
	bh=UwikfVfl5imMCyH4u2bEmSaLfA5ZBu4Qb475A0GHcHU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=V/syMimhQaT2guC6O+tcwRR1ySxK/plVOYhzpFovkg61FUuWwfV/bDNrBqjHkBeEEJEb6YCQJXSrlK8QrAK9bHPZBzY84R+qtyZ8r/seAyM5loWmADUz9hgDlsGAsqlTRuRc1/5jBUsI8R87tkd3/v9G6xW6HB8mO1761cCuQls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TQ/XfAi0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TQ/XfAi0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 388941F000E9;
	Tue, 23 Jun 2026 05:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782191231;
	bh=q1Rio9ArUGtf6G2Aqg9L5GbzOwYhUPGr7LSlhMoBktc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TQ/XfAi0tiVNa8xfmM0e8CttpEjMlW7rskOXMrc/Lzzubf4MxG7LRYjnIa+GO2XTH
	 pjXTw4JjTPnPaKSD3RihqNL5oPsxzrSE/c1+KftHDwiL92FbYsd1//aEn5n8rnZNB3
	 DN1xp03tCNhqTmroYgY79B/eZWvc3X+Tuhnj4W/aIi76hJqVznEKJimJ67y5h55fpi
	 YEE3SU4ppObX6zIWHXaaAyEfLn1QB0ldA2mhAxgnQFH3TZwqelwwDC3nWRFXhoUccp
	 Lm4TZWQcbbBrvjb4oBtI0iZtOJajjyBKSRaYV6KSrBLGAKsDdrXArL+3eNa0Vg7RlI
	 5StNd4I+slXBA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 05/21] X.509: Parse Subject Alternative Name in
 certificates
Reply-To: sashiko-reviews@lists.linux.dev
To: alistair23@gmail.com
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <20260623045406.2589547-6-alistair.francis@wdc.com>
References: <20260623045406.2589547-1-alistair.francis@wdc.com>
 <20260623045406.2589547-6-alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 05:07:10 +0000
Message-Id: <20260623050711.388941F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The X.509 parser completely ignores the `critical` flag on certifi=
cate extensions, allowing certificates with unrecognized critical constrain=
ts to be successfully validated.
--

commit b12732c2d7a7dc077f0c1d3f0be7c0a415bae376
Author: Lukas Wunner <lukas@wunner.de>

X.509: Parse Subject Alternative Name in certificates

This commit adds support for parsing the Subject Alternative Name (SAN)
extension in X.509 certificates. It stores a pointer to the SAN for later
consumption by CMA-SPDM for PCI device authentication.

> diff --git a/crypto/asymmetric_keys/x509_cert_parser.c b/crypto/asymmetri=
c_keys/x509_cert_parser.c
> index bfd10f0195e01..c3ec2846695a5 100644
> --- a/crypto/asymmetric_keys/x509_cert_parser.c
> +++ b/crypto/asymmetric_keys/x509_cert_parser.c
> @@ -596,6 +596,15 @@ int x509_process_extension(void *context, size_t hdr=
len,
>  		return 0;
>  	}
> =20
> +	if (ctx->last_oid =3D=3D OID_subjectAltName) {
> +		if (ctx->cert->raw_san)
> +			return -EBADMSG;
> +
> +		ctx->cert->raw_san =3D v;
> +		ctx->cert->raw_san_size =3D vlen;
> +		return 0;
> +	}
> +
>  	if (ctx->last_oid =3D=3D OID_keyUsage) {

[Severity: High]
This is a pre-existing issue, but while looking at how we process X.509
extensions here, does the parser ignore the critical flag on extensions?

Looking at the ASN.1 definition in crypto/asymmetric_keys/x509.asn1:

Extension ::=3D SEQUENCE {
    extnId      OBJECT IDENTIFIER ({ x509_note_OID }),
    critical    BOOLEAN DEFAULT,
    extnValue   OCTET STRING ({ x509_process_extension })
}

Because there is no action attached to the critical BOOLEAN field, its
value seems to be discarded during parsing.

At the end of x509_process_extension(), unrecognized extensions are
unconditionally ignored:

crypto/asymmetric_keys/x509_cert_parser.c:x509_process_extension() {
    ...
    if (ctx->last_oid =3D=3D OID_basicConstraints) {
        ...
        return 0;
    }
   =20
    return 0;
}

Since X.509 certificates are supplied by potentially untrusted sources
(like during SPDM authentication), could an attacker bypass required
certificate constraints by presenting unrecognized extensions marked with
the critical flag that get silently ignored and treated as a success (0)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623045406.2589=
547-1-alistair.francis@wdc.com?part=3D5
