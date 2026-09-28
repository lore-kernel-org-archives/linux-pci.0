Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F9B22157B;
	Mon, 28 Sep 2026 01:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790559908; cv=none; b=jvAJivoS1pZaivUEg6cgRwQD4abC4LTx3TAaTUqBfG4LTKCY+FeRn8AqYgTLCiYSaKy90tB1S1WtUKytHndMMz+AXjBeJ1DjTjtXk94TnAYLFdMKG3f4MolM2lIADZu4HD2RedtUg939gaay0NvHEfvpfkB9FSfoZSmISAHdTms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790559908; c=relaxed/simple;
	bh=h4oAw9QehyZ5G6bRgmxk6Lf9k7RpOMRsSGPjS485vsQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dwFm4Onh+Wz4mgXXlYMzY1Hl65u+x8y8qcbD+206Od6CbNedZD/EnciUA67oZHDeJcX3LzoaqDtoxoO2dRYQ+yXEvtgnRvZEyjDCuyUOP95SKUUAkDIWCDPVmdb92HJuBsEC3TCCpsVkrKkW8M//qUAcAwdi1xge/3aLGJcgddA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R8rftJQe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R8rftJQe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C19E1F000FF;
	Mon, 28 Sep 2026 01:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790559906;
	bh=+2m2yKM0qETJptP3GWu6BuEOhgTpfRZqmNOJNXUwhSQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=R8rftJQepxbXKOD8ABDij2Vavzb9Vxj0V3xTsxerWhoO8/MIbAZnPCLpssh3CD7om
	 uuVlt+HUAfDnsG7VMW+H5YCvlzI8ProIaLZ7ijJXcFCrn5aMRax6J3BOV8e1B0cvoK
	 WaPmSI06MjZUqNkPVnjeMM7BbiAw3HZuMDhCeCuoEDnerKSWGYcRad1CArXuYyk+t8
	 6A3JUMK9+P/0HZZr+dQ8sG9sWgC+3CkKy1+HWq1svvnKavEq6BjIscAnw6hx+gaGmF
	 ymGCX/Gv/8GGMhdne5+n8U/o67AOYKSfjgIzhS1W1j2YAIbpyXprsAHy1o7gWLKyIj
	 FZ0Id77Og+SzA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 18/22] lib: rspdm: Support SPDM get_digests
Reply-To: sashiko-reviews@lists.linux.dev
To: alistair23@gmail.com
Cc: linux-cxl@vger.kernel.org, gary@garyguo.net, ojeda@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260928011123.450800-19-alistair.francis@wdc.com>
References: <20260928011123.450800-1-alistair.francis@wdc.com>
 <20260928011123.450800-19-alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 01:45:05 +0000
Message-Id: <20260928014506.5C19E1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] rspdm: GET_DIGESTS buffer truncation and invalid length breaks SPD=
M 1.3+ authentication
--

commit 302ede91b9559c0e7a23017a89574c6ce5ec60eb
Author: Alistair Francis <alistair@alistair23.me>

lib: rspdm: Support SPDM get_digests
   =20
Support the get_digests Spdm command.

> diff --git a/lib/rspdm/state.rs b/lib/rspdm/state.rs
> index 51055ea521d72..502d99eb13a66 100644
> --- a/lib/rspdm/state.rs
> +++ b/lib/rspdm/state.rs
> [ ... ]
> @@ -600,4 +618,40 @@ pub(crate) fn negotiate_algs(&mut self) -> Result<()=
, Error> {
> =20
>          Ok(())
>      }
> +
> +    pub(crate) fn get_digests(&mut self) -> Result<(), Error> {
> +        let mut request =3D GetDigestsReq::default();
> +        request.header.version =3D self.version;
> +
> +        let rsp_sz =3D core::mem::size_of::<SpdmHeader>() + SPDM_SLOTS *=
 self.hash_len;
                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^=
^^^^^^^^^^^^^

[Severity: High]
Does this allocation provide enough capacity for Spdm 1.3+ payloads?

For Spdm 1.3+, the response appends 4 bytes per provisioned slot for items
like KeyPairID, CertificateInfo, and KeyUsageMask.

If the device utilizes multiple slots, it seems the extra bytes will exceed
this capacity, causing transport errors when interacting with valid Spdm 1.3
or 1.4 responder devices.

> +
> +        let mut request_buf =3D request.to_bytes()?;
> +
> +        let mut response_vec: KVec<u8> =3D KVec::from_elem(0u8, rsp_sz, =
GFP_KERNEL)?;
> [ ... ]
> diff --git a/lib/rspdm/validator.rs b/lib/rspdm/validator.rs
> index 58f6a3d436a8b..c058dde314401 100644
> --- a/lib/rspdm/validator.rs
> +++ b/lib/rspdm/validator.rs
> [ ... ]
> @@ -697,3 +700,97 @@ fn validate(unvalidated: &[u8], context: &'c SpdmSta=
te<'c>) -> Result<Self, Self
> [ ... ]
> +        if context.version >=3D SPDM_VER_13 && (header.param2 & !header.=
param1 !=3D 0) {
> +            pr_err!("Malformed digests response\n");
> +            return Err(EPROTO);
> +        }
> +
> +        Ok(GetDigestsRsp {
> +            header,
> +            digests,
> +            length: offset,
                        ^^^^^^

[Severity: High]
Does returning only the offset for the length drop the Spdm 1.3+ suffix
fields?

In GetDigestsRsp::validate, this length only covers the header and hashes,
which appears to explicitly ignore the Spdm 1.3+ suffix fields completely.

Since this truncated response length is appended to the host transcript,
could this silently corrupt the transcript computation and cause the challe=
nge
authentication signature verification to fail?

> +        })
> +    }
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928011123.4508=
00-1-alistair.francis@wdc.com?part=3D18
