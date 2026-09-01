Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5173AC0D5;
	Tue,  1 Sep 2026 01:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788225733; cv=none; b=oPJabaEBiWTNGolYy+DcM5CuOR8aIuX6RyOkD7cgss89jyad0+gxEGQCkm93SzdeJN2hrOsT5qBB3WKXkSCYL9N7IFz9E6Vcim3qlmbgOvjVDpt1wyfguXRd4qZQJKSZFLyfr+t6sNmsaff/nz/W69bISY9A6TVI/puSoIkvmMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788225733; c=relaxed/simple;
	bh=Iy8iVVQ8GovkwuaDRikaXJ7wDXgxeQAxklYCrGRtA+g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lcP/+yqV75n7d/2BYC9ckywH70pc9t0ajDYzM5K6X2CDqjp+n4LNITyY2Pag0UubVVxw7LCpALiTjxgDPpkJNmssRzRylrzYxOocaZxRGPFtGGouztLBBvFvKw6qyizHWLMyW8X8eD7OtPysAeNVfcooflJZs3YLlA2wGCbe0u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gKx0qmqC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gKx0qmqC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAF5C1F000E9;
	Tue,  1 Sep 2026 01:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788225730;
	bh=z5DHT7DE31S4H98PTEXcYoSC14SOad2dyDMB37ggMbc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gKx0qmqCWOX0vCSYFZHEDa3c/SGbZ0C5qnvpIXincStK+XfgbtlYheTDCmfGhcOX5
	 xGXEhbEx3pIKFDCdZZpWZqoiNmxnST/bj7vsHnpMvp1f20vmqTfzkPG+eLVKjVyPUC
	 M9808qi2NuyqckPtWmXZ7iL1G+CCtKGCgo+1R2K1JMKA9w8pceODmKHCNrTuCeFjiP
	 VxLQZ7YKDFtP2xFmmLca1s/n1mf0tPTfXs9Tp64gHsN28+RLbPJPpI4xAr/08FdgCn
	 e/uVUEZz0b+H3oBsNehDFI+IB0onLs9rap2Fk0soA692lD1PiMtbT/ZMnZvv8aD5to
	 oM7rkdWvfXvHA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 19/21] lib: rspdm: Support SPDM certificate
 validation
Reply-To: sashiko-reviews@lists.linux.dev
To: alistair23@gmail.com
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <20260901010347.2614656-20-alistair.francis@wdc.com>
References: <20260901010347.2614656-1-alistair.francis@wdc.com>
 <20260901010347.2614656-20-alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 01:22:09 +0000
Message-Id: <20260901012209.CAF5C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The SPDM implementation incorrectly assumes all certificate slot=
s share the same leaf key, violating the SPDM specification and restricting=
 support for multi-slot responders.
--

commit b0152a815fb6a558a0d32bf4c0f287cb4d4ee1a3
Author: Alistair Francis <alistair@alistair23.me>

lib: rspdm: Support SPDM certificate validation

Support validating the SPDM certificate chain. This performs basic
sanity checks on the chain, ensures supported signatures are used,
checks against the blacklist, and stores the first leaf certificate.

> diff --git a/lib/rspdm/state.rs b/lib/rspdm/state.rs
> index 1e8a4402e6342..fc7df9dd7b973 100644
> --- a/lib/rspdm/state.rs
> +++ b/lib/rspdm/state.rs

[ ... ]

> @@ -846,4 +858,136 @@ pub(crate) fn get_certificate(&mut self, slot: u8) =
-> Result<(), Error> {

[ ... ]

> +        if let Some(prev) =3D prev_cert {
> +            if let Some(validate) =3D self.validate {
> +                // SAFETY: Call the `validate` function provided.
> +                let rc =3D unsafe { validate(self.dev, slot, prev) };
> +                if let Err(e) =3D to_result(rc) {
> +                    // SAFETY: `prev_cert` is the previously parsed
> +                    // certificate from a prior loop iteration.
> +                    unsafe { bindings::x509_free_certificate(prev) };
> +                    return Err(e);
> +                }
> +            }
> +
> +            // The leaf key is the same for all slots, so just store the=
 first one.
> +            if self.leaf_key.is_none() {
> +                // SAFETY: `prev_cert` is the previously parsed
> +                // certificate from a prior loop iteration.
> +                self.leaf_key =3D unsafe { Some((*prev).pub_) };

[Severity: Medium]
Is it safe to assume all certificate slots share the same leaf key here?

According to the SPDM specification (DSP0274), devices are allowed up to 8
slots, and they can be provisioned with distinct certificate chains and
cryptographic keys (e.g., one RSA chain and one ECDSA chain).

When an SPDM responder with multiple provisioned slots connects, this logic
skips storing the leaf keys for all slots after the first one. If the respo=
nder
negotiates an algorithm that directs a challenge to a slot other than the
first one, won't authentication use the incorrect leaf key from the first s=
lot
and cause signature verification to fail?

> +                // SAFETY: `prev_cert` is the previously parsed
> +                // certificate from a prior loop iteration. We are setti=
ng
> +                // the `pub` key to null so it isn't freed below
> +                unsafe { (*prev).pub_ =3D core::ptr::null_mut() };
> +            }
> +
> +            // SAFETY: `prev_cert` is the previously parsed
> +            // certificate from a prior loop iteration.
> +            unsafe { bindings::x509_free_certificate(prev) };
> +        }
> +
> +        Ok(())
> +    }
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901010347.2614=
656-1-alistair.francis@wdc.com?part=3D19
