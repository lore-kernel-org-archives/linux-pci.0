Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9349817BCA
	for <linux-pci@vger.kernel.org>; Fri,  8 May 2026 04:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778214323; cv=none; b=FSHNtphyA8sQkQEa1/wOaGgekU7er2+RtGLNGDYZGJK71v3d8lZnFW5rCGOOtD7S4PV7MX4ZKvVPp9Qhc+g9iUNIyLroFQLpuWMR/nalZH5KHx89eKDvFlgHxQELbdwh6NCqfFLmVi0mxGWYl+DtLkDqm93qRyKo4W3IdS6l5ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778214323; c=relaxed/simple;
	bh=5moNjiP+glR3IeuB3JfTCJYgT19DShuteoQK3bfNoio=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ua7EyQpOAT5uFmyU35xsoyn1tjCTtC2VB6cQ8KdWf5VohcmCvjCdtkHMjqF+F7vpr1xt1vAl6y/FS4FTRWEGr6wGkAkuxsTXlFcEZCfVafMrGtstWGizIDrIM13CqcUk8iOMn1GeFP5zdmvtq0PS5W8wiYQcIYzZmj4E1FdPlos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qyK3bsFF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qyK3bsFF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10940C2BCB0;
	Fri,  8 May 2026 04:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778214323;
	bh=5moNjiP+glR3IeuB3JfTCJYgT19DShuteoQK3bfNoio=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=qyK3bsFFzueu/P2+0Pbx2Niu+tVzXkbZGHLWdVeB8Tp3oOtIBNCRhbFuWWXBDFv+0
	 pDIGYLH9GLxrTnfHImHBjC9m8LMwIgDd93bxcm47aWg1SXDQVwmQuNws760aB4Cdni
	 bIjCM194Wqpb6sadIDKv4NiubuFA6LZ9ACDwvnud8i2LLViJ/FR6xCR6ul0QDxfgau
	 KS+d4ztZKJjUb2X/JuvStLYu0zv63M+S358BrjdODty5dWyHY+/bbhpEUlebpveRGS
	 z1zW6dwxsKhXLxC+VHYZwtPBMaVLziwdnNng6UfWir3J6KXGn1nJuOUp55JmqXRSTO
	 Hg82Oey3SQXUA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 16/18] lib: rspdm: Support SPDM certificate validation
Reply-To: sashiko@lists.linux.dev
To: alistair23@gmail.com
Cc: ojeda@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260508031710.514574-17-alistair.francis@wdc.com>
References: <20260508031710.514574-17-alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 08 May 2026 04:25:22 +0000
Message-Id: <20260508042523.10940C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] validate_cert_chain overwrites `leaf_key` when validating multiple=
 provisioned slots, corrupting state and breaking authentication.
- [High] validate_cert_chain leaks dynamically allocated `x509_certificate`=
 structures on all error paths.
- [High] validate_cert_chain leaks the leaf `x509_certificate` structure up=
on successful validation.
--

commit 3ec614986c351b34141bcbc9f49c6cce87d68be8
Author: Alistair Francis <alistair@alistair23.me>

    lib: rspdm: Support SPDM certificate validation

This commit adds support for validating the SPDM certificate chain. It perf=
orms
basic sanity checks to ensure the chain is correct, uses supported signatur=
es,
and is not blacklisted in the kernel.

> diff --git a/lib/rspdm/state.rs b/lib/rspdm/state.rs
> index 69b6f67a6ef52..4c8ee553bb699 100644
> --- a/lib/rspdm/state.rs
> +++ b/lib/rspdm/state.rs

[ ... ]

> @@ -786,4 +789,68 @@ pub(crate) fn get_certificate(&mut self, slot: u8) -=
> Result<(), Error> {
> =20
>          Ok(())
>      }
> +
> +    pub(crate) fn validate_cert_chain(&mut self, slot: u8) -> Result<(),=
 Error> {

[ ... ]

> +            let cert_ptr =3D unsafe {
> +                from_err_ptr(bindings::x509_cert_parse(
> +                    &cert_chain_buf[offset..] as *const _ as *const c_vo=
id,
> +                    cert_len as usize,
> +                ))?
> +            };
> +            let cert =3D unsafe { *cert_ptr };
> +
> +            if cert.unsupported_sig || cert.blacklisted {
> +                pr_err!("Certificate was rejected\n");
> +                to_result(-(bindings::EKEYREJECTED as i32))?;
> +            }

Is it possible this code leaks the x509_certificate structure on error path=
s?

If any validation step fails (such as cert.unsupported_sig or an error in
public_key_verify_signature), returning early with the ? operator will bypa=
ss
the x509_free_certificate cleanup for both the currently parsing certificate
(cert_ptr) and the previously parsed certificate (prev_cert).

Since they are stored as raw pointers, the drop semantics do not free them.

> +
> +            if let Some(prev) =3D prev_cert {
> +                // Check against previous certificate
> +                let rc =3D unsafe { bindings::public_key_verify_signatur=
e((*prev).pub_, cert.sig) };
> +
> +                if rc < 0 {
> +                    pr_err!("Signature validation error\n");
> +                    to_result(rc)?;
> +                }
> +            }

[ ... ]

> +        if let Some(prev) =3D prev_cert {
> +            if let Some(validate) =3D self.validate {
> +                let rc =3D unsafe { validate(self.dev, slot, prev) };
> +                to_result(rc)?;
> +            }
> +
> +            self.leaf_key =3D unsafe { Some((*prev).pub_) };

Does this overwrite self.leaf_key when validating multiple provisioned slot=
s?

The caller in lib.rs iterates over all provisioned slots, calling
validate_cert_chain() for each:

    let mut provisioned_slots =3D state.provisioned_slots;
    while (provisioned_slots as usize) > 0 {
        let slot =3D provisioned_slots.trailing_zeros() as u8;

        if let Err(e) =3D state.validate_cert_chain(slot) {
            return e.to_errno() as c_int;
        }

        provisioned_slots &=3D !(1 << slot);
    }

Since self.leaf_key is a single Option, this will overwrite the previous pu=
blic
key pointer without freeing it.

If a device has multiple provisioned slots, could signature verification la=
ter
in challenge() fail because self.leaf_key holds the public key of the last
provisioned slot rather than the first?

Also, does this leak the leaf x509_certificate structure on successful
validation?

At the successful completion of the certificate chain loop, the final
certificate remains in prev_cert. The public key is extracted into
self.leaf_key, but bindings::x509_free_certificate(prev) is never called.

While spdm_destroy() later frees the public key via public_key_free(), the
x509_certificate structure itself and its internal fields appear to be leak=
ed
permanently.

> +        }
> +
> +        Ok(())
> +    }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260508031710.5145=
74-1-alistair.francis@wdc.com?part=3D16
