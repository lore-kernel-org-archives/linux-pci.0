Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794286291;
	b=frEBtgeXNqIGdXOnZ1U+4cMa7kOt1Tsf///3MBSx8IeHqa5YhGxkPOpP7A5d+9UA6HOF
	 vC37ASK/IviXOyeEPrZp0IB07UlxRuWW44sOh5MFqWrKQGlyGgRfpAtR1zbjZVdXxwHdf
	 JaL2kOL9oVMCHU/dK6Fw3P95l/aR9S6kvgPkP7SDyXo17t/sBHb2p44dzWgq0CkM9hG61
	 qMBkwHM/j7DkImC5KRhqs1ILQaR4gHsebn2Xud7P+gqptrB5EAxkuEvx7jQoeLdLjZAUT
	 0uUW90RFb+HM+qzQKSB1Ot/tawL9DcBfxo/UVgXDxjtcYpzmiarcXabTXQZWtladQaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794286291;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=PaUnml60sDU9T/UZQrWb1WHz8r24CzmyOxTkkys6Scc=;
	b=Thh6LcV5PbEP6vNN5f3wk63V+QaEEqq5w1Z7pefLc/a3ez5sKeKUXtTfmA5WX9zvUQah
	 UZuhEc3iP/gHKAxGwHUvQHkyccMPHhUpFX5RuQzwkd4QJRpX5mSyIC/SdkqF+XIQAVU+k
	 WPtFHTFUjHZnQSEojgYK6XdhYTDQDeTxNYbwBOWOB+iS790X/CTwXFNVXqCa+8Ni9NvbF
	 VQpZr40WcA94pfjYcBqnY6rB6KYnalnUxXtRJlz9RGSZeUAXGAr63wJJ1d+H0vPxqGPHp
	 +Ed0Vv+Yc3HztbQ2xnPx8t5l6Xg6QIfQLBnue1gm97o2Asuw7o2hgXlQg0+095OqLQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RHE3fV05;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1FD606A31C;
	Tue, 10 Nov 2026 04:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RHE3fV05
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12D3D1F0089F;
	Tue, 10 Nov 2026 04:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794286291;
	bh=PaUnml60sDU9T/UZQrWb1WHz8r24CzmyOxTkkys6Scc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RHE3fV052B8RmK2qXSWmOqSoQKI+en9a/73lp9ATirf8K0eFGl/bWjWgGXLNUFfME
	 YXHIJktJ//THG7KVcgrZhN1LGu1nxgHqPUFa+ERl1xfQkVufQXW87zwv9df2MIoRNU
	 HggbLPhkcofEc4vTDiVPZR6dfhffinWjqim2yF0iBp9Z+RfRU2/wG5jBVh80xgL4uu
	 GjB2b1+nWnjpsANi7BSnf26mZgqpQAtqTAOAVOehQAbQDDZgrlWHo4K5brPDp4L7d7
	 8355OKR3TlUtU/on+S4/uSf2JFsrfWcvJRQ1W2OgyBZj0d1kJXuEK0EknW9X4HU+y2
	 RCbwP0N/aAUYQ==
Message-ID: <sashiko-outbox-206245@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 23/25] lib: rspdm: Support SPDM certificate
 validation
Reply-To: sashiko-reviews@lists.linux.dev
To: alistair23@gmail.com, linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
Cc: ojeda@kernel.org, gary@garyguo.net
In-Reply-To: <20261110041832.1730924-24-alistair.francis@wdc.com>
References: <20261110041832.1730924-1-alistair.francis@wdc.com>
 <20261110041832.1730924-24-alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 04:51:30 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] rspdm: premature take_public_key() before validate in
  validate_cert_chain()
- [Medium] rspdm: missing leaf key algorithm and size check in
  validate_cert_chain()
--

commit 90c6956b70972b83efecdd912863a7121463499f
Author: Alistair Francis <alistair.francis@wdc.com>

lib: rspdm: Support SPDM certificate validation

This commit adds certificate chain digest verification, X.509 chain
signature validation, and leaf public key extraction to the Rust SPDM
implementation.

> diff --git a/lib/rspdm/state.rs b/lib/rspdm/state.rs
> index f1a55da1f1cfa..dfe2f8becfb74 100644
> --- a/lib/rspdm/state.rs
> +++ b/lib/rspdm/state.rs

[ ... ]

> @@ -593,9 +604,164 @@ pub(crate) fn get_certificate(&mut self, slot: u8) =
-> Result<(), Error> {

[ ... ]

> +        let Some(mut leaf) =3D prev_cert.take() else {
> +            return Err(EPROTO);
> +        };
> +
> +        let flags =3D leaf.key_ext_flags()?;
> +        if flags.is_ca() || !flags.digital_signature() {
> +            dev_err!(&self.dev, "Invalid leaf certificate constraints\n"=
);
> +            return Err(EKEYREJECTED);
> +        }

[Severity: Medium]
Should validate_cert_chain() verify that leaf.pkey_algo() and
leaf.pkey_len() match the session's negotiated self.base_asym_alg?

Without checking the leaf key's algorithm and size against
self.base_asym_alg, a responder that negotiated a strong algorithm in
NEGOTIATE_ALGORITHMS (for example ECDSA P-384 or RSA-4096) can supply a
leaf certificate with a different or weaker key accepted by the X.509
parser, and validate_cert_chain() will accept the chain and store the
mismatched key in self.leaf_key.

> +
> +        // The leaf key is the same for all slots (MULT_KEY_CAP =3D=3D 0=
),
> +        // so just store the first one.
> +        if self.leaf_key.is_none() {
> +            self.leaf_key =3D leaf.take_public_key();
> +        }
> +
> +        if let Some(validate) =3D self.validate {
> +            // SAFETY: Call the `validate` function provided with a valid
> +            // certificate pointer, which the callback must not modify or
> +            // free.
> +            let rc =3D unsafe { validate(self.dev.as_raw(), slot, leaf.a=
s_raw()) };
> +            to_result(rc)?;
> +        }
> +
> +        Ok(())
> +    }
>  }

[Severity: Medium]
Does calling leaf.take_public_key() before invoking self.validate pass a
struct x509_certificate with a NULL pub pointer to the callback on the
first slot?

Certificate::take_public_key() transfers ownership of the key by clearing
cert->pub to NULL in place:

rust/kernel/x509.rs:Certificate::take_public_key() {
    ...
        unsafe {
            (*self.cert.as_ptr()).pub_ =3D ptr::null_mut();
        }
    ...
}

As a result, on the first validated slot a validate callback that inspects
leaf_cert->pub will dereference a NULL pointer, and if the callback
rejects the certificate, self.leaf_key remains populated with the rejected
certificate's key.  Moving the self.leaf_key assignment after the
self.validate check avoids both issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110041832.1730=
924-1-alistair.francis@wdc.com?part=3D23
