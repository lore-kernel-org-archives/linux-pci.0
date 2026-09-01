Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3573A3B059D;
	Tue,  1 Sep 2026 01:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788226266; cv=none; b=p8+LvrpJOfzVUhZ6i6WWrvLszEe97v5CrqqNW6Sgz9D9Kvo9UNhD5h47S6Pdy37Vq/A1jKAnAYLsDDWCzOKnDCBEOYD34nCFinBZD5d0fXeRYUkqYk4PB9x6K5k36mSlr5vnQxSIRt9Syjw2TjrMS2XwfKSjk/vLQqvXnlv13Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788226266; c=relaxed/simple;
	bh=exMKPWQDxrtufl4OkcHin0IcqxyzgXesqm/VLqvjhSc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SH4w1jOIvI9iOUhr/+ZP+LuOR5zPfJbOaD01lPJ3x5y4BSxplydHIoo3/ScPRjwWysrctx4e3KuJ/wHCH9+ZB85UFg+Us8btiwMxfEPnSKn545PDoEXGgnGkmbtHPqrHQuxhg29y4zbr9v4mY49BqFM3IKOS41xzfUowag9xfKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZnEdqF7n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZnEdqF7n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EA321F000E9;
	Tue,  1 Sep 2026 01:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788226263;
	bh=P92xtBI7I/T+YVL+Ij1W6iHmZMejZNd9LTcDCtmG+7A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZnEdqF7ne5WaVFhC8BDGpgKTVqTfCo0RnVBHujQz0nffDXc8+wx05OFuhsgQaqzbH
	 gmJPkVrmeG8ele5EmuvzQC7BH5mggn3uyFOiYvnhqOQq8N6lELt4DLa9osbCm/Zq2V
	 oSiuDhVn0grmjTC698MKH1YKiNUFfG8rzYqGqHFuBZNEJ3V5hmE9hHO91Qjg6ZGRdP
	 +/ZRacKQWOvi9uKwFMwYIVNDj+QMZEW9iB4N35lXvUS+iHr8vliglxkP+fyh8FoI5c
	 qc1h6jKPdwz3ypCmkVlEzQqWwM6Su43L60z/3SAIvJ8mS2giUtqyhggpMLlktjk7zH
	 SyQQZXkb60Jjw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 21/21] lib: rspdm: Support SPDM challenge
Reply-To: sashiko-reviews@lists.linux.dev
To: alistair23@gmail.com
Cc: linux-cxl@vger.kernel.org, ojeda@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260901010347.2614656-22-alistair.francis@wdc.com>
References: <20260901010347.2614656-1-alistair.francis@wdc.com>
 <20260901010347.2614656-22-alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 01:31:03 +0000
Message-Id: <20260901013103.7EA321F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Medium] `ChallengeRsp` struct definition misrepresents the SPDM packet f=
ormat by declaring variable-sized fields in the middle of a `repr(C, packed=
)` struct.
- [Medium] Missing upper bound check on transport response length (`rc`) in=
 `challenge` function.

Pre-existing issues:
- [High] Stale `leaf_key` retention across multiple SPDM authentications ca=
uses persistent authentication failures.
--

commit fe7e9708b9e2dfbb56d50564eed90c6c3454e54e
Author: Alistair Francis <alistair@alistair23.me>

lib: rspdm: Support SPDM challenge
   =20
This commit adds support for the CHALLENGE SPDM command in the SPDM respond=
er
implementation.

> diff --git a/lib/rspdm/state.rs b/lib/rspdm/state.rs
> index fc7df9dd7b973..1fd691037fa57 100644
> --- a/lib/rspdm/state.rs
> +++ b/lib/rspdm/state.rs
[ ... ]
> +    fn verify_signature(&mut self, signature: &mut [u8]) -> Result<(), E=
rror> {
[ ... ]
> +        if let Some(leaf_key) =3D self.leaf_key {
> +            unsafe { to_result(bindings::public_key_verify_signature(lea=
f_key, &sig)) }
> +        } else {
> +            return Err(EPROTO);
> +        }
> +    }

[Severity: High]
This is a pre-existing issue, but this code in verify_signature() relies on
the cached leaf_key which can lead to persistent authentication failures.

If a device is re-authenticated and its certificates have changed,
spdm_authenticate() will fetch the new certificates, but the existing code =
in
validate_cert_chain() only sets leaf_key if it is missing.

Will verify_signature() then attempt to verify the new signature using the
stale, previously cached leaf_key, resulting in an inevitable verification
failure during the challenge sequence?

[ ... ]
> +    pub(crate) fn challenge(&mut self, slot: u8) -> Result<(), Error> {
[ ... ]
> +        let rc =3D self.spdm_exchange(request_buf, response_vec.as_mut_s=
lice())? as usize;
> +
> +        // The transport must report a length within the buffer we provi=
ded.
> +        if rc < core::mem::size_of::<ChallengeRsp>() {
> +            pr_err!("Truncated challenge response\n");
> +            return Err(EIO);
> +        }
> +        response_vec.truncate(rc);

[Severity: Medium]
Does SpdmState::challenge() miss the upper bound check on the transport
response length?

The comment notes that the transport must report a length within the buffer
provided. If a buggy transport driver returns an rc greater than
response_vec.len(), this check will pass and response_vec.truncate(rc) will
not bound the vector correctly, allowing the function to process potentially
uninitialized or out-of-bounds data later in the parsing process.

Should this also ensure that rc is less than or equal to response_vec.len()?

> diff --git a/lib/rspdm/validator.rs b/lib/rspdm/validator.rs
> index 2584bed739792..f623ac1d28606 100644
> --- a/lib/rspdm/validator.rs
> +++ b/lib/rspdm/validator.rs
[ ... ]
> +#[repr(C, packed)]
> +pub(crate) struct ChallengeRsp {
> +    pub(crate) version: u8,
> +    pub(crate) code: u8,
> +    pub(crate) param1: u8,
> +    pub(crate) param2: u8,
> +
> +    pub(crate) cert_chain_hash: __IncompleteArrayField<u8>,
> +    pub(crate) nonce: [u8; 32],

[Severity: Medium]
Does the ChallengeRsp struct definition in lib/rspdm/validator.rs misrepres=
ent
the actual wire format of the SPDM protocol by placing a variable-sized fie=
ld
before a fixed-size field?

Because __IncompleteArrayField<u8> acts as a zero-sized type, nonce and all
subsequent fields will be assigned static offsets that do not account for t=
he
actual length of cert_chain_hash. Any future code attempting to access these
fields directly from the struct would read from the wrong offsets.

Does the struct layout need to be restructured to accurately reflect the
variable length nature of the SPDM challenge response?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901010347.2614=
656-1-alistair.francis@wdc.com?part=3D21
