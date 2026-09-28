Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BC418AE3;
	Mon, 28 Sep 2026 01:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790559673; cv=none; b=O5YZx0T/Imxl2YJtzqnQczytfcAJDkYajHIVNdJ/FMnf8pqWAcG9pP20gVMuoOgUFRQhR4fkkYvjTubk2eXoUYPnabPc8rYQts7wJKqXWj+8+j+ngHFP6TJQjwO9PJWKJV/9OR0Acmt5pcXYEAGcNY6S/diRSQlk9JXz705ER28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790559673; c=relaxed/simple;
	bh=ieXSfvUpX5Sofb93Y/YczxHPYxBt9wt5B6FS//upfho=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NLc7rsp91SafxvpvV0p+UZN8BVeOVKFmuPGdK2kkbNLOu8z/X/e72lwgm4O0RyC9dQcJtLF8j30Wx70hwhr3DIQsn5uYagZ/vgwyCvM9A7K0jdq3GkUpBZAAvr9PaH88fFzaNGjMsfiHsPL6dJZGTxmAc0s7sCMjak6MbliUe7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rufxeds+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rufxeds+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 507121F000FF;
	Mon, 28 Sep 2026 01:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790559672;
	bh=1kxHsnO52FgSSD4IShSJ9uAs17Tya8I/iFr6MT5AaU8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Rufxeds+g/ufDsO6IDdPUDyIyZl96ZySc7XR6pC2G/NpXoPMSbvydVXxjqiHzxofP
	 l/ce1LDbfijS0GZDhNcZslDItsqPEC+mQw1R7hFuDHnZ1Cggt2UtHApjg/QTqjzASR
	 ufD85CzcRdqbBNBzQlfuOjNztuLCUAKU2LQqAGePy4HrTa5MLQJws5yXT3xn+w54yl
	 L0PVmS+PqPPExK5tOj7GqLophjUhsvOvfyvIUT90xxdqlryONZ8htkFmfZcVZJQks3
	 Roz8ClMAEZefHXgP+hViuAx4R7jKY9vG4n26X77oxxJvZORb4yBsgU8m+5hftfry6O
	 oHW9HNgdeVHxA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 16/22] lib: rspdm: Support SPDM get_capabilities
Reply-To: sashiko-reviews@lists.linux.dev
To: alistair23@gmail.com
Cc: linux-cxl@vger.kernel.org, gary@garyguo.net, ojeda@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260928011123.450800-17-alistair.francis@wdc.com>
References: <20260928011123.450800-1-alistair.francis@wdc.com>
 <20260928011123.450800-17-alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 01:41:11 +0000
Message-Id: <20260928014112.507121F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] rspdm: spec violation and connection failure parsing SPDM 1.3 ca=
pabilities on SPDM 1.2
- [Low] rspdm: unreachable data_transfer_size boundary error path
--

commit a4f1214f54c265aa579b2a02f78463b717992311
Author: Alistair Francis <alistair@alistair23.me>

lib: rspdm: Support SPDM get_capabilities

This commit adds support for the GET_CAPABILITIES SPDM command.

> diff --git a/lib/rspdm/state.rs b/lib/rspdm/state.rs
> index 3bbe55d965f7a..fb43260f48004 100644
> --- a/lib/rspdm/state.rs
> +++ b/lib/rspdm/state.rs
[ ... ]
> @@ -290,4 +301,59 @@ pub(crate) fn get_version(&mut self) -> Result<(), E=
rror> {
[ ... ]
> +    pub(crate) fn get_capabilities(&mut self) -> Result<(), Error> {
[ ... ]
> +        let response: GetCapabilitiesRsp =3D
> +            Untrusted::new(response_vec.as_slice()).validate(&*self)?;
> +
> +        self.rsp_caps =3D response.flags;
> +        if (self.rsp_caps & SPDM_RSP_MIN_CAPS) !=3D SPDM_RSP_MIN_CAPS {
> +            pr_err!(
> +                "{:#x} capabilities are supported, which don't meet requ=
ired {:#x}\n",
> +                self.rsp_caps,
> +                SPDM_RSP_MIN_CAPS
> +            );
> +            self.rsp_caps =3D 0;
> +            return Err(EPROTONOSUPPORT);
> +        }
> +
> +        if self.version >=3D SPDM_VER_12 {
> +            if response.data_transfer_size < 42 {
> +                pr_err!(
> +                    "Invalid minimum transport size {}, must be at least=
 42\n",
> +                    response.data_transfer_size
> +                );
> +                return Err(EPROTONOSUPPORT);
> +            }

[Severity: Low]
Is this error path reachable?

It looks like the earlier validation in GetCapabilitiesRsp::validate already
enforces data_transfer_size >=3D SPDM_MIN_DATA_TRANSFER_SIZE (which is 42)
and returns EPROTO.=20

This seems to make the EPROTONOSUPPORT path in SpdmState::get_capabilities
dead code.

> +
> +            self.transport_sz =3D self.transport_sz.min(response.data_tr=
ansfer_size);
> +        }
> +
> +        Ok(())
> +    }
>  }
> diff --git a/lib/rspdm/validator.rs b/lib/rspdm/validator.rs
> index d0b6691365c0a..ca837bd9cfcc7 100644
> --- a/lib/rspdm/validator.rs
> +++ b/lib/rspdm/validator.rs
[ ... ]
> @@ -175,3 +183,302 @@ fn validate(unvalidated: &[u8], context: &'c SpdmSt=
ate) -> Result<Self, Self::Er
[ ... ]
> +impl<'a, 'c> Validate<'c, Untrusted<&'a [u8]>> for GetCapabilitiesRsp {
> +    type Err =3D Error;
> +
> +    type Context =3D &'c SpdmState;
> +
> +    fn validate(unvalidated: &[u8], context: &'c SpdmState) -> Result<Se=
lf, Self::Err> {
[ ... ]
> +        let (data_transfer_size, max_spdm_msg_size, supported_algorithms=
, length) =3D
> +            if context.version <=3D SPDM_VER_11 {
[ ... ]
> +            } else {
[ ... ]
> +                let supported_algorithms =3D if header.param1 & SPDM_CAP=
_SUPPORTED_ALGORITHMS !=3D 0 {
> +                    Some(SupportedAlgorithms::from_bytes(
> +                        unvalidated.get(GET_CAPABILITIES_RSP_SZ..).ok_or=
(EIO)?,
> +                    )?)
> +                } else {
> +                    None
> +                };

[Severity: Medium]
Can this logic incorrectly parse an SPDM 1.2 payload?

If an SPDM 1.2 responder has bit 0 of Param1 set (either by mistake or due =
to
uninitialized reserved fields), wouldn't this lack of a
context.version >=3D SPDM_VER_13 guard cause the kernel to incorrectly inte=
rpret
this SPDM 1.3 field?

It seems this would attempt to parse SupportedAlgorithms from the end of the
20-byte packet, read an empty slice, and abort the handshake with EIO.

> +
> +                let length =3D GET_CAPABILITIES_RSP_SZ
> +                    + supported_algorithms
> +                        .as_ref()
> +                        .map_or(0, |s| s.length as usize);
> +
> +                (
> +                    data_transfer_size,
> +                    max_spdm_msg_size,
> +                    supported_algorithms,
> +                    length,
> +                )
> +            };

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928011123.4508=
00-1-alistair.francis@wdc.com?part=3D16
