Received: from smtp-bc0b.mail.infomaniak.ch (smtp-bc0b.mail.infomaniak.ch [45.157.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224213BA222
	for <linux-pci@vger.kernel.org>; Fri, 31 Jul 2026 14:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785508535; cv=none; b=KkImz2EuRZM605xbycuWge3d7RT5OPSHoGwrY4rd9MxKkD9IiM2ef1rLsRVsHE5g3ePzxpLIhGoj7zd88hISrezOa87SAI1MA8alm8CeUyqn1FxQC4xUArvVzn3SrwKo/lVWr4WM8JOtqeFEY43fXjlSh7NPrMk3vSOHkv6Iq8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785508535; c=relaxed/simple;
	bh=HK32QY2bTBz4twRlmCUK+iHtLSZj1u6rKDQuhVCulD4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=cqK3X9nWYwql/l01ZgBHAARQRvbbBAMWHlejiWP3GSEwYW1e8NMPS0PZtAdrdnrgfuqZZGxgOKSPx7naz+jT9M1Mtnn4FdRnzPvMDHXGgSjRUJ0X15G2BDOEbTtVrCMmg0Bdh1+YlsYNUAFsxuYqZrbzFejovcQxo1UVTL3KIEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ik.me; spf=pass smtp.mailfrom=ik.me; dkim=pass (1024-bit key) header.d=ik.me header.i=@ik.me header.b=nu64XEc9; arc=none smtp.client-ip=45.157.188.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ik.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ik.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ik.me header.i=@ik.me header.b="nu64XEc9"
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hBSzQ441bzkNr;
	Fri, 31 Jul 2026 16:25:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ik.me; s=20200325;
	t=1785507954; bh=Ro0OrBt7Qgvxk9SnIboKoEvZ/3a0b8ekvOKzWQC4oqo=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=nu64XEc9eQaTDP4YbSSd1aNsZD078jm4dCZ79luGoCkfl8vBrsoLhJlWjQvxx9FZp
	 w9+Jj1zuz0U1OQ5yuwvU2f+HCalOaIgkRv7xevMpr8h8XuBVXKoWxo2CoWE9jBR8mj
	 fSiNB6GjyPo/vzWv42OQI28KIEqHqMww0Zpkzqso=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4hBSzM6Hb3zCGF;
	Fri, 31 Jul 2026 16:25:51 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 31 Jul 2026 16:25:51 +0200
Message-Id: <DKCTQT2XK3O9.33AVSQ4182B9N@ik.me>
Cc: "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>, =?utf-8?q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>, "Lyude Paul" <lyude@redhat.com>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] rust: samples: add EDU PCI driver sample
From: "Ewan Chorynski" <ewan.chorynski@ik.me>
To: "Danilo Krummrich" <dakr@kernel.org>, "Maurice Hieronymus"
 <mhi@mailbox.org>
X-Mailer: aerc 0.21.0
References: <20260620-b4-rust-pci-edu-driver-v2-0-6fd6684f2c14@mailbox.org>
 <20260620-b4-rust-pci-edu-driver-v2-4-6fd6684f2c14@mailbox.org>
 <DJEQ64V8HE19.2DMBHY4XRPMG6@kernel.org>
 <DJP8UPM9XT95.102LJRRRY4P2S@kernel.org>
In-Reply-To: <DJP8UPM9XT95.102LJRRRY4P2S@kernel.org>
Feedback-ID: :dc0b6b835638593:ham:e74197f626dda86
X-Infomaniak-Routing: alpha

Hi,=20

On Fri Jul 3, 2026 at 11:12 PM CEST, Danilo Krummrich wrote:
> On Sun Jun 21, 2026 at 2:27 PM CEST, Danilo Krummrich wrote:
>> I'm going to send a patch to make the irq::Registration compatible with =
the
>> device driver lifetime rework soon. Please rebase onto that once it's se=
nt, so
>> this sample can land as idiomatic as possible.
>
> Please find the patch in [1]; purely mechanical conversion of the EDU dri=
ver for
> testing purposes in [2].
>
> [1] https://lore.kernel.org/driver-core/20260703210936.1128698-1-dakr@ker=
nel.org/
>
> [2]
>
> diff --git a/samples/rust/rust_driver_edu.rs b/samples/rust/rust_driver_e=
du.rs
> index 5f4efd514032..301b780773cb 100644
> --- a/samples/rust/rust_driver_edu.rs
> +++ b/samples/rust/rust_driver_edu.rs
> @@ -6,7 +6,6 @@
>

<snip>

> @@ -275,76 +279,61 @@ fn probe<'bound>(
>                  .alloc_irq_vectors(1, 1, IrqTypes::default().with(pci::I=
rqType::Msi))
>                  .inspect_err(|e| dev_err!(pdev, "alloc_irq_vectors faile=
d: {:?}\n", e))?;
>
> -            // State shared with the IRQ handler (the BAR and the comple=
tion the
> -            // handler signals) lives in an `Arc<EduDriverData>`. `EduDr=
iverData`
> -            // itself implements `irq::Handler`, and the registration ta=
kes an
> -            // `Arc<T>` via the `impl Handler for Arc<T>` blanket impl. =
This keeps
> -            // the handler's state out of `EduDriver` and avoids a self-=
reference.
> -            let data =3D Arc::pin_init(
> -                try_pin_init!(EduDriverData {
> -                    bar <- pdev
> -                        .iomap_region_sized(0, c"rust_driver_edu")
> -                        .and_then(|bar| bar.into_devres()),
> -                    irq_test_completion <- Completion::new(),
> -                    irq_dma_completion <- Completion::new(),
> -                    dma: ca,
> -                }),
> -                GFP_KERNEL,
> -            )?;
> -
> -            let req =3D irq::Registration::new(
> -                (*irq.start()).try_into()?,
> -                Flags::TRIGGER_NONE,
> -                c"rust_edu_irq",
> -                Ok(data.clone()),
> -            );
> +            let bar =3D pdev.iomap_region_sized::<{ regs::END }>(0, c"ru=
st_driver_edu")?;
>
> -            // Ordering matters: the handler is registered (`irq_handler=
 <- req`)
> -            // *before* the `_:` block runs the self-tests, one of which=
 raises an
> -            // interrupt and waits for the handler. Raising before the h=
andler is
> -            // registered would hang (the completion is never signalled)=
.
> -            Ok(try_pin_init!(Self {
> +            // SAFETY: The Registration is not leaked.
This comment uses the knowledge that the initializer returned by probe
won't create and leak the registration. Shouldn't the probe function be
unsafe to formalize this guarantee ?=20

> +            let req =3D unsafe {
> +                irq::Registration::new(
> +                    (*irq.start()).try_into()?,
> +                    Flags::TRIGGER_NONE,
> +                    c"rust_edu_irq",
> +                    try_pin_init!(IrqHandler {
> +                        pdev,
> +                        bar,
> +                        irq_test_completion <- Completion::new(),
> +                        irq_dma_completion <- Completion::new(),
> +                        dma: ca,
> +                    }? Error),
> +                )
> +            };
> +
> +            Ok(try_pin_init!(EduDriverData {
>                  irq_handler <- req,
> -                // Side-effect block: run the staged self-tests against =
the mapped
> -                // BAR now that the handler is live. A failure here abor=
ts probe.
> +                // Ordering matters: the handler is registered (`irq_han=
dler <- req`)
> +                // *before* the `_:` block runs the self-tests, one of w=
hich raises an
> +                // interrupt and waits for the handler. Raising before t=
he handler is
> +                // registered would hang (the completion is never signal=
led).
>                  _: {
> -                    let bar =3D data.bar.access(pdev.as_ref())?;
> -                    EduDriver::init(pdev, bar, &data)?;
> +                    let handler =3D irq_handler.handler();
> +                    EduDriver::init(pdev, &handler.bar, handler)?;
>                      dev_info!(
>                          pdev,
>                          "rust_driver_edu successfully initialized\n",
>                      );
>                  },
> -                data,
> -                pdev: pdev.into()
> +                pdev,
>              }))
>          })
>      }
>  }

Regards,
Ewan
