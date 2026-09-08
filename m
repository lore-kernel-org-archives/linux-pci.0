Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113E9492E26;
	Tue,  8 Sep 2026 23:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788910836; cv=none; b=PESOKMQ/pamxOMkkGSo9D2tNiaZtz08fhhrbY65dAcQpKRiN6JI9d57924kBt+E/9M/6Ym6MzpwlHMoYyKV5XcypSM6K2PxWvKNe9/17azrDCnw1W4dIP140TB4/jo5NFHWhHaTiBvavu7HWKLjvOzK6Wm2MCmDnv5IPWerz5v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788910836; c=relaxed/simple;
	bh=C51lR1h17rjxcSSVhsZFsPn0gepSvuZv0iwUACUClKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=evcSTd8QH/hOkV+Fs28wiDMrcwsXi+HV9V7P20jgMT+U/YdNV5+b8+Lg/ZhWsLpufEVgbRppii9iB4XOAOunRaLPPtj3jYVDIOf4rp7VRL7fWIPgxRG/UKukJp2eEP0aCHeqLPDBkbT1whV+pL0D/HHKfxFJ58AqpqtcRKJ4/T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CTt3R/Gx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CTt3R/Gx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 881601F00A3A;
	Tue,  8 Sep 2026 23:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788910835;
	bh=+H9g08cNdiWE5/8EwF3d1MxzFsmYfD0+SJDF7eC9Rwc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=CTt3R/Gx8YJmzcAILW5Qp0Y9Xu4GejGZW7vMKPTsOdQX1XSRu6Gc1nkOKn/dBOSOl
	 mLeb8TdWRP0J/eQoFXgtcOuOt7TwPrKnBnz2mJuhCyiYtiD5EFRZYdK7taL1GKk6Gr
	 IIVDYHqLzvb8QH1c7CpQNjvanY4dOfOYITtuN11Q2mQpMWzqgO/QEcerWbH/f+P3FM
	 zOlXFf7VX4JIBfkyJQYvGwnmbLwC6ZekNO38SDNQUpGd4r9oUVM+6H+qaKtUAU6ABK
	 ILgjFZ0Cw7Iwnbq3SZ03dljMQoQxF5mL9ETYBcuhd3ZB4WPvvFX9bcb6ShBVKJ6xqV
	 5mArWUEL5As8A==
Date: Wed, 9 Sep 2026 00:40:28 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: alistair23@gmail.com
Cc: linux-pci@vger.kernel.org, Jonathan.Cameron@huawei.com, djbw@kernel.org,
 rust-for-linux@vger.kernel.org, lukas@wunner.de, alistair@alistair23.me,
 linux-cxl@vger.kernel.org, bhelgaas@google.com, akpm@linux-foundation.org,
 linux-kernel@vger.kernel.org, gary@garyguo.net, ojeda@kernel.org,
 benno.lossin@proton.me, a.hindborg@kernel.org, wilfred.mallawa@wdc.com,
 tmgross@umich.edu, boqun.feng@gmail.com, bjorn3_gh@protonmail.com,
 alex.gaynor@gmail.com, aliceryhl@google.com
Subject: Re: [PATCH v3 14/21] lib: rspdm: Support SPDM get_version
Message-ID: <20260909004028.57117791@jic23-huawei>
In-Reply-To: <20260901010347.2614656-15-alistair.francis@wdc.com>
References: <20260901010347.2614656-1-alistair.francis@wdc.com>
	<20260901010347.2614656-15-alistair.francis@wdc.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue,  1 Sep 2026 11:03:40 +1000
alistair23@gmail.com wrote:

> From: Alistair Francis <alistair@alistair23.me>
>=20
> Support the GET_VERSION SPDM command.
>=20
> Signed-off-by: Alistair Francis <alistair@alistair23.me>
=46rom a an SPDM stand point looks good to me.
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

> diff --git a/lib/rspdm/lib.rs b/lib/rspdm/lib.rs
> index 1883579b817a..58d86ea06fd9 100644
> --- a/lib/rspdm/lib.rs
> +++ b/lib/rspdm/lib.rs
...





> @@ -234,4 +242,59 @@ pub(crate) fn spdm_exchange(
> =20
>          Ok(length)
>      }
> +
> +    /// Negotiate a supported SPDM version and store the information
> +    /// in the `SpdmState`.
> +    pub(crate) fn get_version(&mut self) -> Result<(), Error> {

...

> +
> +        for i in 0..entry_count as usize {
> +            let off =3D entries_offset + i * core::mem::size_of::<u16>();
> +            let entry =3D u16::from_le_bytes([response_vec[off], respons=
e_vec[off + 1]]);
> +            let alpha_version =3D (entry & 0xF) as u8;
> +            let version =3D (entry >> 8) as u8;
> +
> +            if alpha_version > 0 {

Can we do !=3D 0 as that matches the spec text?

> +                pr_warn!("Alpha version {alpha_version} is not specifica=
lly supported\n");
> +            }
> +
> +            if version >=3D self.version && version <=3D SPDM_MAX_VER {
> +                self.version =3D version;
> +                foundver =3D true;
> +            }
> +        }
> +
> +        if !foundver {
> +            pr_err!("No common supported version\n");
> +            return Err(EPROTO);
> +        }
> +
> +        Ok(())
> +    }
>  }


