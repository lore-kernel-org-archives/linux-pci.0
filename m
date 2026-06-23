Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9FF3A7F7A;
	Tue, 23 Jun 2026 05:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782192112; cv=none; b=kxXSi6VlPCCyhtHn6SSNKf3r64Oj6zwlLH5jr+u7doPU7RR7CckxO5ajYiHmmHRJfMD7q+40Fwiu5a67+NNvZdvDh2pBb/hZ0mMZcts6eZiUCIGntU4UyYq8zUiPiDF5ZRBSkLK5bSAazEcbP5gf2r6pWtl7MK4/g9gkjnXbjQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782192112; c=relaxed/simple;
	bh=3C2y0QfB3qKB88m4XXTSgjNDLJX88WW/3hrE2IP6Wvc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RkKpBXf/prxEpfGTGHDAz5+0EBPGplYP+TzuYhtY3HwjLh3XyfEKktMm2Y0FuN7NZJ82fIpgtbqu2CSNiMuZQMkijDOGFi+C7Vok+HNzAFxvk3IhHBIDIl/8Ohl679y2s75ZMWVHHXH1WYBS8nvNSoP0fD03aTSiKbJkpvZSEE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gzvp26Co; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gzvp26Co"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D80CD1F000E9;
	Tue, 23 Jun 2026 05:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782192111;
	bh=0fupVfkN5bCOLxQJFpW+jMm3qtBbnao+Lt1JpiV5zfY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Gzvp26CoIjweg9KG1gpImvvLM41eZ140Xbpw1Jet0wS/4ur0JF3AgykNBmp6HGgG9
	 fqunsUJa42zSJKM8pUyykCNbzPF3RNR4M0lJD+IWkbOBK11bLIniBGOwFwpECN/rNC
	 T42gjlhrmjfAtr4OI2B79Nc4voAHRNSVfyKGi6UcfOyI8y3P8s7raBKSc4GP4PW9fe
	 peeX9vj8pIfPj/qObZenv25eKNHSS2S4uQIG35Ym72DjfkBJRPx7zsELl3QUf/UoC4
	 XkvenUjW1H8MV9AVAxASbHcR/jFgu+oKh8etA+1adCf8Lm73if/SbVttx6zHcFPDjp
	 BmdDvomLd1t+g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 21/21] lib: rspdm: Support SPDM challenge
Reply-To: sashiko-reviews@lists.linux.dev
To: alistair23@gmail.com
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <20260623045406.2589547-22-alistair.francis@wdc.com>
References: <20260623045406.2589547-1-alistair.francis@wdc.com>
 <20260623045406.2589547-22-alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 05:21:50 +0000
Message-Id: <20260623052150.D80CD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] A truncated SPDM capability response causes a kernel panic due to =
an out-of-bounds slice access.
- [High] Incorrect zero-padding placement in the SPDM 1.2+ combined prefix =
causes signature verification failure.
- [High] Incorrect memory layout passed to allocator when dropping `KVec` c=
onstructed via `from_raw_parts`.
--

commit 60ad79ffc915550973efe94b73f27dbe90a466d5
Author: Alistair Francis <alistair@alistair23.me>

lib: rspdm: Support SPDM challenge

Support the CHALLENGE SPDM command.

> diff --git a/lib/rspdm/state.rs b/lib/rspdm/state.rs
> index e381cf3f75f9e..7341d9d8a9310 100644
> --- a/lib/rspdm/state.rs
> +++ b/lib/rspdm/state.rs
[ ... ]
> @@ -463,12 +498,15 @@ pub(crate) fn get_capabilities(&mut self) -> Result=
<(), Error> {
>          let rc =3D self.spdm_exchange(request_buf, response_vec.as_mut_s=
lice())? as usize;
> =20
>          // The transport must report a length within the buffer we provi=
ded.
> -        if rc > response_vec.len() {
> +        if rc > response_vec.len() || rc > rsp_sz {
>              pr_err!("Overflowed capabilities response\n");
>              return Err(EIO);
>          }
>          response_vec.truncate(rc);
> =20
> +        self.transcript
> +            .extend_from_slice(&response_vec[..rsp_sz], GFP_KERNEL)?;

[Severity: High]
If spdm_exchange() returns a smaller rc than rsp_sz, response_vec will be
truncated to rc elements. Will the slice &response_vec[..rsp_sz] then panic
due to being out of bounds?

[ ... ]
> @@ -971,4 +1028,175 @@ pub(crate) fn validate_cert_chain(&mut self, slot:=
 u8) -> Result<(), Error> {
[ ... ]
> +            let major =3D self.version >> 4;
> +            let minor =3D self.version & 0xF;
> +
> +            let output =3D CString::try_from_fmt(fmt!("dmtf-spdm-v{major=
:x}.{minor:x}.*dmtf-spdm-v{major:x}.{minor:x}.*dmtf-spdm-v{major:x}.{minor:=
x}.*dmtf-spdm-v{major:x}.{minor:x}.*"))?;
> +            let mut buf =3D output.into_vec();
> +            let zero_pad_len =3D SPDM_COMBINED_PREFIX_SZ - SPDM_PREFIX_S=
Z - SPDM_CONTEXT.len() - 1;
> +
> +            buf.extend_with(zero_pad_len, 0, GFP_KERNEL)?;
> +            buf.extend_from_slice(SPDM_CONTEXT.as_bytes(), GFP_KERNEL)?;

[Severity: High]
Does this code append the zero padding before the context string?

According to the SPDM 1.2+ specification (DSP0274), the combined prefix
format should be VersionPrefix || 0x00 || ContextString || ZeroPadding.
Could placing the zero padding before SPDM_CONTEXT cause the transcript hash
to mismatch the signature provided by the device?

[Severity: High]
Additionally, there appears to be a memory layout mismatch regression when
dropping the shash_desc context in SpdmState::drop() and
update_response_algs():

lib/rspdm/state.rs:SpdmState::drop() {
    let desc_vec =3D unsafe { KVec::from_raw_parts(desc, desc_len, desc_len=
) };
    drop(desc_vec);
}

Is the generic parameter T incorrectly inferred as bindings::shash_desc
instead of u8? Since desc_len is a byte count, would this pass the wrong
layout to the allocator during drop, assuming desc_len elements of type
shash_desc instead of desc_len bytes?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623045406.2589=
547-1-alistair.francis@wdc.com?part=3D21
