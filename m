Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768832EEE86;
	Mon, 28 Sep 2026 01:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790560016; cv=none; b=tR5S02Y04f4wIYlnpejMkwJBZA/BWSaouXg5xkvhSWuNhJAPcZJCq8ObqH2O+j5AL8SiaP97m3fIAG5YvGRG2bBM9HUiaTgrjJNWx/qzipacDge1cpiPlo7+7RAhT5uLXFxkbj48kmeM/3g0xhfnsjnf96MYC4jRn0qO/qU11gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790560016; c=relaxed/simple;
	bh=6jIYWaX2EfqAWIPF604zabs00IiTcC5ObBsvBSJr1zw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=q/2RcQ+5//qKbbdsxGU5h59TFum7ICIm69b917wDViaBLgFdAr1uvIlQZX5exWinbj6D/p5yahN5yakOWynNCyQI+syjMq8/1SkkwenqPuoQ1ZTGZwMdelGMJ74m7OWr7CRbNWSCEYtl2q5YiwmyHcP6NGMTkDPUCtdhuwwDwUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SLQ2YjK6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SLQ2YjK6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A15841F000FF;
	Mon, 28 Sep 2026 01:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790560015;
	bh=1GemqDvwaGeOH6uyFygMS7OrNWgD4v0CgKpSkWwpadU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SLQ2YjK69k13/YlbFAM3V0cP7UmdwUE4fzJAgTC26Um1pFaN7J6F0zjs1DMHQAS8A
	 DJew7jSHKNrrGwAS/MMyn7CST2b7yWuIeQ8Zj9M5jpecv0nEtC4GCxcayKgJuz5kBe
	 N6aUdxK/gc5oUbmGErvHx0GLZ01lpSi4HOrF/DgmL9PU/1+cgHJpfawurqnH/g77sw
	 3hRX5TyxsB3mrqNrz3yF1BntapcpfhF5sQW6e0QUaCmzOTk8SM2L9pgN9t/eobTYwq
	 bOnaAPAu2YeDwCd9QKzH2HWOIiEnmdUV6Boyi4rEc+eldUwOYNNlvEP5g/zyRrpBPB
	 CJ3vmrJXqJk5Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 22/22] lib: rspdm: Support SPDM challenge
Reply-To: sashiko-reviews@lists.linux.dev
To: alistair23@gmail.com
Cc: ojeda@kernel.org, gary@garyguo.net, linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260928013123.566184-4-alistair.francis@wdc.com>
References: <20260928011123.450800-1-alistair.francis@wdc.com>
 <20260928013123.566184-1-alistair.francis@wdc.com>
 <20260928013123.566184-4-alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 01:46:54 +0000
Message-Id: <20260928014654.A15841F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] rspdm: missing CertChainHash verification in CHALLENGE_AUTH resp=
onse
--

commit eee76c6b536b5164eade967b244ae4e6193db601
Author: Alistair Francis <alistair@alistair23.me>

lib: rspdm: Support SPDM challenge

This commit adds support for the CHALLENGE SPDM command. It introduces the
state handling and response validation for SPDM challenges to authenticate
the responder.

> diff --git a/lib/rspdm/state.rs b/lib/rspdm/state.rs
> index 9f7f6d0ffac65..d6ece65a6fc05 100644
> --- a/lib/rspdm/state.rs
> +++ b/lib/rspdm/state.rs

[ ... ]

> @@ -907,4 +957,165 @@ pub(crate) fn validate_cert_chain(&mut self, slot: =
u8) -> Result<(), Error> {

[ ... ]

> +    pub(crate) fn challenge(&mut self, slot: u8) -> Result<(), Error> {

[ ... ]

> +        let mut response: ChallengeRsp =3D
> +            Untrusted::new(response_vec.as_slice()).validate(&*self)?;
> +
> +        if request.context !=3D response.context {
> +            pr_err!("Mismatched challenge context response\n");
> +            return Err(EIO);
> +        }
> +
> +        self.transcript
> +            .extend_from_slice(response_vec.get(..response.len()).ok_or(=
EIO)?, GFP_KERNEL)?;
> +
> +        match self.verify_signature(&mut response.signature) {

[Severity: Medium]
Does this code skip the verification of the certificate chain hash?

The SPDM specification (e.g., DSP0274 Section 11.2) explicitly mandates that
the requester must verify that the response cert_chain_hash matches the hash
of the certificate chain that the requester possesses for the specified slo=
t.

Since response.cert_chain_hash is ignored here instead of being verified
against the expected hash of self.certs[slot], could this allow protocol
confusion or downgrade attacks if a responder uses a different certificate
chain for the signature than the one the requester holds?

> +            Ok(()) =3D> {
> +                pr_info!("Authenticated with certificate slot {slot}\n");
> +                Ok(())
> +            }
> +            Err(e) =3D> {
> +                pr_err!("Cannot verify challenge_auth signature: {e:?}\n=
");
> +                Err(EPROTO)
> +            }
> +        }
> +    }
>  }

> diff --git a/lib/rspdm/validator.rs b/lib/rspdm/validator.rs
> index f4e9485179d01..9992679f7c8a3 100644
> --- a/lib/rspdm/validator.rs
> +++ b/lib/rspdm/validator.rs

[ ... ]

> @@ -946,3 +943,149 @@ fn validate(unvalidated: &[u8], context: &'c SpdmSt=
ate<'c>) -> Result<Self, Self

[ ... ]

> +impl<'a, 'c> Validate<'c, Untrusted<&'a [u8]>> for ChallengeRsp {

[ ... ]

> +        let mut cert_chain_hash =3D KVec::new();
> +        cert_chain_hash.extend_from_slice(
> +            unvalidated
> +                .get(mem::size_of::<SpdmHeader>()..nonce_offset)
> +                .ok_or(EIO)?,
> +            GFP_KERNEL,
> +        )?;

This isn't a bug in the extraction itself, but the cert_chain_hash is parsed
from the response here, confirming it is available to the requester, yet it
appears to be ultimately left unused in SpdmState::challenge().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928011123.4508=
00-1-alistair.francis@wdc.com?part=3D22
