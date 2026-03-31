Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE11728CF4A
	for <linux-pci@vger.kernel.org>; Tue, 31 Mar 2026 03:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774927810; cv=pass; b=q8/Lu45ooTbZqy0flgbDiZy7M7pt+JCSuErK5lQ+UW502bKaRGvgBGD3dgZVdvQ9STSdcUuDxMwJ88z535JogVABllZb2ze4f5SD/MoRBhhFcdwEnG9zT5fvMcoxdiOWdooONIhP0up3DYkrHPUYR1BZNkcGGljJuhXD4AjalOU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774927810; c=relaxed/simple;
	bh=Vqz0wbjll/hAJPEOie6RM4KJSz7Fs7lEo3U/R+kG3UI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZOv4yLlI8Yfdl6npiqFMwLttwt9WfhRWH9WSRBAClkreDb361GTlInpq7uTCRl3H2CAFEZRmvRsKUbpCI4enGTCfP1QzM0vH5aYmA49+QyllBqR+YLAKp/Ug7FUNK0AoEoCfbMzmXZ/VXzISQs/DDCkdVfco/8iuWjzl7Y0PL7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qL3DKFk+; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qL3DKFk+"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-66bb7e098b1so1948586a12.3
        for <linux-pci@vger.kernel.org>; Mon, 30 Mar 2026 20:30:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774927807; cv=none;
        d=google.com; s=arc-20240605;
        b=kry0jN3yY8ZkqZWi/lEDTVqe9P0KWnT8aghm9ZJzJ3N4GgVgUHmC8PJUKmTlHd3ONa
         37WjLnLtedx9jlhG0Hpv6OwRmc2oefMofgOfZeLDaCEdWp5909C0O8YGPkT91xxvLe3j
         VttDmsSD9HbCOA1QlptbcrFkxbFiJqTHHsyoAembl9tX0kJ9oKNFaAdHSSdH8l0gpTqb
         hNYuAjdrBgVPWj8MsDsZw1eNYGuW3vSwcA9EqHyX93E+ktKLASdDbaPgdRm0Yuui9zP5
         5sFDpYMCUipxie0sHyOmKunB1XsJQ0KExsGuKUAcsg39C0h8JoO9XlTtW8v/to9PqKl1
         THcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Fbhm8CzZ4y2XM5LEjJUdYiChU7X46Cm6Ehudfb4QOfU=;
        fh=j/AYXpoJuso8iMVgG7rABDXSUQ8qALk5XoVkBGsuQZI=;
        b=iyADUSXE3wZC5yMYgtBTBwrhvCAOl4zvjL5sykRUlfHCTy6wiOo1QeQ+E1VYQY6BFN
         TSGNECb+YgW7+9z9tO0UM3aXrPugcZwIki6txHxnCz5qYfjfSutuzIj3mRJdx6k6Km05
         NBDLbacDnyWwkIKFG9YEVkW8UMHi/DTemSrmsDRhLTWk4GgTpJscE8uHRi9M143cuif0
         8XZ0QH3ZHhpBb7tjtJDIWqqQ4Mnh9H7xYkWe8FrSYoO5Dsl4VpU5exPfgOgpI0nBqO4v
         cZ4qFwoS2cc11PD+r1tR/GXXMblq5hTlXC08r4JwS37jlv6F7K+ZjHYqrvTWnpvZHqQq
         DbDQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774927807; x=1775532607; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fbhm8CzZ4y2XM5LEjJUdYiChU7X46Cm6Ehudfb4QOfU=;
        b=qL3DKFk+AhxNLVrweVLdebsnnRL9yHRQeoFEHbsvv1taablyE0qarKkxBnvyyTohil
         FPUvBCQhQGD038uilYe2wdk8ltY0bLN24EHzpAD7lt2E+BGM4BSnyr1OV0oZxmIM9hzu
         ieIwmT0HCSSt4efkdPce+/r3JoIcPr7Ge4Vx2oIuj1sYidoJPOcZa1Py1B0vbQNgqJCV
         36b+0pp7T7bZcBYWPRxeylvpvThyzgfyEp/gQNCBILusQyVwBzumnwSXCojJLHCw1BEk
         fYP53d3nwguQ72eQZe/dYgX/7ByXbfVfFIxT/USqvJWU6hFt63Ny3gjiefeIQ72VmlGT
         GGoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774927807; x=1775532607;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Fbhm8CzZ4y2XM5LEjJUdYiChU7X46Cm6Ehudfb4QOfU=;
        b=srxrhoE0iIj1rK9VhmGIetoDlJj2eUdgr6tX+Ar99gvzzGeO+OjvpAa8eMBS6rwdJG
         VUEMze/gUrZRRBLg1wHxvRhCbg9Zeda8183jGJrlRzXvibLOPNnZN9XV7eDXRLTTaIUQ
         2hrPw2Ur2Mxvtdayfcy8grRXf23X25Kxms194H86mBOjT8cJM2UJ55ykfEV4fQqXNHqu
         c+yHmvD9mXbkXZY8CR2Knhlt1w0XV/IRD8ruTwdmPhwNSCOqjvMsNJ8w5ssC0b5HMsR4
         2OvhjQJR66alIMRCfVOt4hYBkC2RdL/luWzoUvaoDUReJ/VEfUQZHteToSPA2QbmpYQ0
         Zzcg==
X-Forwarded-Encrypted: i=1; AJvYcCXZkk/mstcVViT1IclRmLBnIfq0T8TNRiZeLLBIGcmbx9AbjB35vO72z5gVAIYqXKBHWFGWDLVqDoM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwOmQyCBpKEM5TScCVo1h9H95sM131HOgmu9vdSa6K7UJcs768
	i+KEmyLts4xBryXxRQCUuhV9GgLkQJzNSmrK4C++6n9gTo+f/iBLrkJanvl+p9jU96qG3cEdeFK
	y5v2flSkmb+a/LMsXyl3YWkWYj4kDUoo=
X-Gm-Gg: ATEYQzxZznentFLd7KubUegklUDV17+1IeeRfawXd8Mq6BUaNAyDFwem+f1+KBNQzx2
	trodq2/33IMM4myeTfFt9LIlPkF/jmEgxlb4OW5RlLsVqITFgwxc6l7ABKcJpdbzI+PXC9bdoyB
	Dkxd9RqFI/o68BRJMGpZD1r4TQQjMyJXeBU+6M3gbo0iSZFTstOc7iPB6QCTw6gPASvACnT2dlh
	wEqKIxZMXMb3jJfXRUyvYRUIUncApaErsI6oH5S+pnJ2S67HL4E+RTYTtotEoYVMkub0gN90oNB
	Hg4t22P5h1hIpZWu176CBntvxcEY9gt6Z2te6Q==
X-Received: by 2002:a17:906:208f:b0:b98:132e:ca97 with SMTP id
 a640c23a62f3a-b9b5094c6femr664652066b.47.1774927806887; Mon, 30 Mar 2026
 20:30:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260211032935.2705841-1-alistair.francis@wdc.com>
 <20260211032935.2705841-23-alistair.francis@wdc.com> <20260303150040.00007458@huawei.com>
In-Reply-To: <20260303150040.00007458@huawei.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 31 Mar 2026 13:29:40 +1000
X-Gm-Features: AQROBzBc83sivh6UcNOP_l8RUTr7K-DmfbPtqXOhOGreZW7lZXTka_jt4qB4WZ8
Message-ID: <CAKmqyKM6CBucDEo0aKZVWrKtozbT_ddk0PaZFtHyEMMMx558JA@mail.gmail.com>
Subject: Re: [RFC v3 22/27] lib: rspdm: Support SPDM certificate validation
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: bhelgaas@google.com, lukas@wunner.de, rust-for-linux@vger.kernel.org, 
	akpm@linux-foundation.org, linux-pci@vger.kernel.org, 
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, 
	alex.gaynor@gmail.com, benno.lossin@proton.me, boqun.feng@gmail.com, 
	a.hindborg@kernel.org, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	tmgross@umich.edu, ojeda@kernel.org, wilfred.mallawa@wdc.com, 
	aliceryhl@google.com, Alistair Francis <alistair@alistair23.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 4, 2026 at 1:00=E2=80=AFAM Jonathan Cameron
<jonathan.cameron@huawei.com> wrote:
>
> On Wed, 11 Feb 2026 13:29:29 +1000
> alistair23@gmail.com wrote:
>
> > From: Alistair Francis <alistair@alistair23.me>
> >
> > Support validating the SPDM certificate chain.
> >
> > Signed-off-by: Alistair Francis <alistair@alistair23.me>
>
> Only minor thing inline + observation on the code that I think we want to=
 remove
> for now wrt to checking the root cert.
>
> > diff --git a/lib/rspdm/state.rs b/lib/rspdm/state.rs
> > index 1e5656144611..728b920beace 100644
> > --- a/lib/rspdm/state.rs
> > +++ b/lib/rspdm/state.rs
>
> > @@ -743,4 +746,92 @@ pub(crate) fn get_certificate(&mut self, slot: u8)=
 -> Result<(), Error> {
> >
> >          Ok(())
> >      }
> > +
> > +    pub(crate) fn validate_cert_chain(&mut self, slot: u8) -> Result<(=
), Error> {
> > +        let cert_chain_buf =3D &self.certs[slot as usize];
> > +        let cert_chain_len =3D cert_chain_buf.len();
> > +        let header_len =3D 4 + self.hash_len;
> > +
> > +        let mut offset =3D header_len;
> > +        let mut prev_cert: Option<*mut bindings::x509_certificate> =3D=
 None;
> > +
> > +        while offset < cert_chain_len {
> > +            let cert_len =3D unsafe {
> > +                bindings::x509_get_certificate_length(
> > +                    &cert_chain_buf[offset..] as *const _ as *const u8=
,
> > +                    cert_chain_len - offset,
> > +                )
> > +            };
> > +
> > +            if cert_len < 0 {
> > +                pr_err!("Invalid certificate length\n");
> > +                to_result(cert_len as i32)?;
> > +            }
> > +
> > +            let _is_leaf_cert =3D if offset + cert_len as usize =3D=3D=
 cert_chain_len {
> > +                true
> > +            } else {
> > +                false
> > +            };
> Same as the following?
>                let _is_leaf_cert =3D offset + cert_len as usize =3D=3D ce=
rt_chain_len;

Yep, same thing. My way is the Rust-y way to do it

Although _is_leaf_cert is unused, so I'll just remove it

>
>
> > +
> > +            let cert_ptr =3D unsafe {
> > +                from_err_ptr(bindings::x509_cert_parse(
> > +                    &cert_chain_buf[offset..] as *const _ as *const c_=
void,
> > +                    cert_len as usize,
> > +                ))?
> > +            };
> > +            let cert =3D unsafe { *cert_ptr };
> > +
> > +            if cert.unsupported_sig || cert.blacklisted {
> > +                to_result(-(bindings::EKEYREJECTED as i32))?;
> > +            }
> > +
> > +            if let Some(prev) =3D prev_cert {
> > +                // Check against previous certificate
> > +                let rc =3D unsafe { bindings::public_key_verify_signat=
ure((*prev).pub_, cert.sig) };
> > +
> > +                if rc < 0 {
> > +                    pr_err!("Signature validation error\n");
> > +                    to_result(rc)?;
> > +                }
> > +            } else {
> > +                // Check aginst root keyring
> So this is the check that Dan and Jason are proposing we drop (for now).
>
> Works for me as easy to bring back later and lets us move forward
> in the meantime. As long as userspace gets nothing to indicate
> that we have in any way checked this root cert we are making no false cla=
ims.

Will do!

Alistair

>
> > +                let key =3D unsafe {
> > +                    from_err_ptr(bindings::find_asymmetric_key(
> > +                        self.keyring,
> > +                        (*cert.sig).auth_ids[0],
> > +                        (*cert.sig).auth_ids[1],
> > +                        (*cert.sig).auth_ids[2],
> > +                        false,
> > +                    ))?
> > +                };
> > +
> > +                let rc =3D unsafe { bindings::verify_signature(key, ce=
rt.sig) };
> > +                unsafe { bindings::key_put(key) };
> > +
> > +                if rc < 0 {
> > +                    pr_err!("Root signature validation error\n");
> > +                    to_result(rc)?;
> > +                }
> > +            }
> > +
> > +            if let Some(prev) =3D prev_cert {
> > +                unsafe { bindings::x509_free_certificate(prev) };
> > +            }
> > +
> > +            prev_cert =3D Some(cert_ptr);
> > +            offset +=3D cert_len as usize;
> > +        }
> > +
> > +        if let Some(prev) =3D prev_cert {
> > +            if let Some(validate) =3D self.validate {
> > +                let rc =3D unsafe { validate(self.dev, slot, prev) };
> > +                to_result(rc)?;
> > +            }
> > +
> > +            self.leaf_key =3D unsafe { Some((*prev).pub_) };
> > +        }
> > +
> > +        Ok(())
> > +    }
> >  }
>
>
