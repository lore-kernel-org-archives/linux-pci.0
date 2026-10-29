Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793297205;
	b=dL4ueM/yN4Qehj7b1HBcDI9fh9W8AQGiFw0E+wk6dMera4UxMPGwFC8uLUvmkCPDQzTx
	 j+SxZI3w/1aduGgubCxn27Z3n73aZUzfUTkl7rNL6A152dAl/tonvcfD39Y1qTmX4jDAL
	 ws0SeRqjrGM6MZcWw8GUIlY9joBDkHrWvRZKe4oqAgjfAEtAZ2J3znEXBim5os4mPnWIy
	 /CpO3UI4l7ugHgf6bqFEZ4iJrxboslMkJPFhtPA+DFRGYnVu8v9mrfSFrwWIEmxpdmtJi
	 lX1l68Lgu7C5pATrSmtHy6o7UV8KXogX33D1mmJ+Tcc4WoEXzeQd8BwOkrfteSETtNA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793297205;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=/Ig+VOdZjoHggEoKr5B7bwbxLSf5OSLxc9dnZMZuTIQ=;
	b=5Gr51Yv/OIWwe+0y7oxvgvpaukjKwixC7c6SMhIr8Tgyx/BIHeT7v6NMMfzaMpcNbHkT
	 LkY7Odq5VkfsAHRY16pZzki/is9qmuN4zcAFBR6oXYIV7V8mZaM3D6gRVOm+FyhyPKlT0
	 kHNsMkhSP2L0nnvtLzfSxHQFtYkAgO9xg1psRwUbMwiBZTyACCu7KfURNcU4gQg+Y0Xj0
	 IST+xASHaDZKZ/fJWoiNEOC+QVx3rB4anrRsJ/3QW9UGox27y7CQjyFow66ihlcR5A7++
	 cUuPPVDKUdAMx6s8n8TzwH1VSa0/sxasQ2nYdQlGdjRROhYWLVfPsr8eTQA1RSoYa6g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=FJpre9F2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.48
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C48606A31A
	for <linux-pci@vger.kernel.org>; Thu, 29 Oct 2026 18:06:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4C48606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=FJpre9F2
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c315869241fso391255666b.0
        for <linux-pci@vger.kernel.org>; Thu, 29 Oct 2026 11:06:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793297203; cv=none;
        d=google.com; s=arc-20260327;
        b=C68S50kpYBKYkAER1+iv0l1fHmT32Oxn4DTb4sLmZ4qMboRerVQW0gEp6Yz3fSs+gt
         fWfNUZqjSq+viuVQ9oiZKrdzZp85c0rdPZhI0NAOgfE8M5RvaJxb9kFP+r9d0Gf4yHD2
         X2Vrn4SIegnKJ08VLbHEpt0g1zL73IMDbyBrTj5x74wYXhxdtmA4KyCYBmkWWewzjB0E
         1J2oq97aKaFJP5dZqaJfM2doso9g/XKBWvmueLPs5I1g6wW+v60+qPOoD4hNyl0m35Lv
         FNoivVMtLh0TamfpWGLanDje1uSWTsPbTOyG0Q9mOkuj7x6f9wrc4kocTo+6e6lHEwhJ
         8yVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/Ig+VOdZjoHggEoKr5B7bwbxLSf5OSLxc9dnZMZuTIQ=;
        fh=Iyme8xbuc16i34NB0rynhY73ex8DV78fGGbvQQ2xBbc=;
        b=SlMalOTxZq9eIuZr4ISNs+IRNfgbWZ5S5cpcASHZ3h3fWhVYRalN0v+2I50fYJ/H6Y
         FWzBhrEnoqhs4eF9lP7M41R73j864mqmL4gbW3aAtWRinnTpsn2BCmfwF6n6H7lyKMTZ
         gAEs71JY3aQ2XH3EqlwPdmCkNhz0yvEQ7AUDsVcm/mWZXhNsFDVSS8YH/WIskdEsLmXH
         izlVB1ONzbeD8QnLzDTSnWT8Tr4OosNL1FxFwzX130ZMTqF1XAdIWW6Ga//x2O4Ip5ll
         nzKGHQ9qMqGPzlMllvDJjirhhjNLTq4uAFMunq1CnraLbOBUxUSEQfUgiDDpmX0itWkB
         QNZQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793297203; x=1793902003; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/Ig+VOdZjoHggEoKr5B7bwbxLSf5OSLxc9dnZMZuTIQ=;
        b=FJpre9F2uvUqa+EXQtN9hkCpru0N72zGWwVqLJOHWFrZhHnn3K+2K1ER3QzPNFb2fJ
         L7Tr3O1hfWcqekHamOUyIqglmvmzCCzTCotU5Ki+G5f7mDv7jBU1/eNhcRlZ3Dimv2KP
         aNfK/8MOQPuinExg8eyCbTr/UVlvEcQA1TNbWJ8EYND1X4TXII02sl5qmV9IM9Z2+6E4
         FcD8M65/qZAjG/azT9k3zQ9cub4kb9fMZQ4UlhbOfadOMBekVZ9UAIG5rnEYf2DGEnqh
         aoPBDLs3pk0mtZ++RckaXNMro62AmA58rUV6kPi8zy+fIyheNm52zTXWouvYBpCg9mvH
         F35Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793297203; x=1793902003;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/Ig+VOdZjoHggEoKr5B7bwbxLSf5OSLxc9dnZMZuTIQ=;
        b=S1wv4SLFV0jesrneqnB3xuRX/Jan07hxZPpF6PZhwwliz/fosZm//tNVXvT9o+zXx+
         kPIdNBByO4gG9g3cG/AKuo+Dgod2US9aOw32W/rM0Ob8sgIwR9yixvvP4vbn3UmcI0nF
         TOToe8kQlTe5OirmHZbQVAgp+YvO3BGCnDtsVqo5lROeC3U35zRYWOYDWqzHBMwY7/SY
         usXOpfJ26KnezTC1G2UH1h7xr1eAMYcqUQYywgrWvF5oUyhUxaRZWO5e2EA60hKRRWy7
         YaHw9RoRPRzCL5AKvVnnFmu0+iE1+r2brhmN9vbLMHVIu/aTUgY74Nl2tD0aEc/e3zPU
         LPrA==
X-Forwarded-Encrypted: i=1; AKwUvBzG2n+IgeKe9M/igf19BjlhRpy6xiw5QFNbiBnSaPr/KPnlz/ds8AV4tyPNKr6hYQwKMBQSemQ6xvY=@vger.kernel.org
X-Gm-Message-State: AFq9FYJJ0aUIwcgLqgTaTNla9jNfVuTnmX2pRuNq8/XqFP6ytDw0lDcT
	7ZZ2toKSKwTXS3RkhQhJcVUMlXZ/2w0sCsbULU4BQ47TihtdsamRPpr8QLn4Uw9LWGWvdM34f5j
	c4Ns5ZvLzmIpESvw3hoWI398GS/DIiNTJqG1m2heWxiolFhkboHSxUZgrVC96TQ==
X-Gm-Gg: AYBFou0VGduvSzxw25ONwtZWBqo5/mJldh9Ihip0oa5QuS++k5z6GEY/b7tRSJ2LHod
	4973BJ4X0qD6+lvo9C2Z1C09a2zdVA5rgMmJZ8I5T7Vvoaa1hFudBmXKKLFC3PbgSHg55cIxKXb
	Pzc9R9wVqPkgGFr9XYwqf1lMgiV6BCP0D0QHJxx5Qmhk6u6B+d0eDn9OECJnE130mr4myeSmvi5
	v7vKViu7rdxYLXY3A2/lphMRM4uRRXpyTF4MSZmZ9wC4xrdj0mdvLhzBXypAlk6HIx9hQC06tIF
	UolKXjH58lGNQ92DzpPGmfyaDokh/snIVsctlXADej9qAH6xkRDmyyrfH4bpXbNIMma7C3FrmMq
	4CL5Pr5AHi4HO88NiIgWh9HbzkW75Eom9+Z5DiQ==
X-Received: by 2002:a17:906:7953:b0:c40:b477:dfa0 with SMTP id
 a640c23a62f3a-c49bdf3e797mr571689566b.18.1793297202249; Thu, 29 Oct 2026
 11:06:42 -0700 (PDT)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019213054.3157159-1-dmatlack@google.com> <20261019213054.3157159-11-dmatlack@google.com>
In-Reply-To: <20261019213054.3157159-11-dmatlack@google.com>
From: David Matlack <dmatlack@google.com>
Date: Thu, 29 Oct 2026 11:06:15 -0700
X-Gm-Features: AclHuK_cLRpus0bFwOM3qezLRphS7L77ne14GXebvql4AuxivCEsM-6MlWYX4p4
Message-ID: <CALzav=f8+pTJ3m+99=85ntwouUePzzQBA2RJQ5Ogg23J-5rfkQ@mail.gmail.com>
Subject: Re: [PATCH 10/10] PCI: liveupdate: Avoid enabling INTx on incoming devices
To: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-pci@vger.kernel.org
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Josh Hilke <jrhilke@google.com>, Leon Romanovsky <leonro@nvidia.com>, 
	Logan Gunthorpe <logang@deltatee.com>, Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, 
	Parav Pandit <parav@nvidia.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pranjal Shrivastava <praan@google.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2026 at 2:31=E2=80=AFPM David Matlack <dmatlack@google.com>=
 wrote:
>
> Avoid clearing PCI_COMMAND_INTX_DISABLE on incoming preserved devices.
> Pass whether INTx masking is broken on each preserved device to the
> next kernel instead of probing it, and skip clearing
> PCI_COMMAND_INTX_DISABLE in do_pci_enable_device() for incoming
> devices.
>
> Clearing PCI_COMMAND_INTX_DISABLE enables INTx on the device, even if
> only temporarily. pci_intx_mask_broken() probes whether INTx masking
> works by toggling PCI_COMMAND_INTX_DISABLE during enumeration, and
> do_pci_enable_device() clears it when a device that is not using MSI or
> MSI-X is enabled. A preserved device may assert INTx at any point
> during the Live Update, before its driver in the next kernel has set up
> interrupt handling, so enabling INTx could result in interrupts that
> no handler claims, on a line that may be shared with other devices.
>
> Pass the result of probing as a new bit in the probed results in
> struct pci_dev_ser, PCI_DEV_SER_PROBED_BROKEN_INTX_MASKING, which
> reflects struct pci_dev::broken_intx_masking. If the previous kernel
> did not pass it, fall back to probing INTx masking.
>
> Drivers bound to incoming devices are responsible for enabling INTx once
> they are ready to handle it. pci_alloc_irq_vectors() already does so
> with pci_intx() when it falls back to INTx, and vfio-pci clears
> PCI_COMMAND_INTX_DISABLE itself in vfio_pci_core_enable().

Thinking about this a little more, and based on internal experience
with Live Update within Google, the kernel should reject preserving a
device with broken_intx_masking=3D1. Otherwise, there is no way to
ensure that the device does not assert its interrupt while the kexec
is ongoing. The kernel would be forced to mask it in the interrupt
controller, which means adding even more Live Update support across
the kernel, and which gets complicated when the interrupt line is
shared by multiple devices.

I will reject devices with broken_intx_masking=3D1 in v2.

> Assisted-by: LLM
> Signed-off-by: David Matlack <dmatlack@google.com>
> ---
>  drivers/pci/liveupdate.c    | 37 ++++++++++++++++++++++++++++++++++++-
>  drivers/pci/liveupdate.h    |  6 ++++++
>  drivers/pci/pci.c           |  8 ++++++++
>  drivers/pci/probe.c         | 10 ++++++++++
>  include/linux/kho/abi/pci.h |  3 +++
>  5 files changed, 63 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
> index ac4525568818..8a74762c3f7d 100644
> --- a/drivers/pci/liveupdate.c
> +++ b/drivers/pci/liveupdate.c
> @@ -216,6 +216,11 @@
>   *    bridge implements), since that would disrupt memory transactions
>   *    targeting the device or devices below it. Instead, the previous ke=
rnel
>   *    passes the results of probing in struct pci_dev_ser.
> + *
> + *  * The PCI core does not enable INTx (i.e. clear PCI_COMMAND_INTX_DIS=
ABLE)
> + *    on incoming preserved devices, neither while probing whether INTx =
masking
> + *    works nor when the device is enabled, since the device could then =
raise
> + *    interrupts before its driver is ready to handle them.
>   */
>
>  #define pr_fmt(fmt) "PCI: liveupdate: " fmt
> @@ -650,7 +655,11 @@ static void pci_liveupdate_save_bar_masks(struct pci=
_dev *dev,
>  static void pci_liveupdate_preserve_probed(struct pci_dev *dev,
>                                            struct pci_dev_ser *dev_ser)
>  {
> -       u64 supported =3D 0, probed =3D 0;
> +       u64 supported =3D PCI_DEV_SER_PROBED_BROKEN_INTX_MASKING;
> +       u64 probed =3D 0;
> +
> +       if (dev->broken_intx_masking)
> +               probed |=3D PCI_DEV_SER_PROBED_BROKEN_INTX_MASKING;
>
>         if (dev->hdr_type =3D=3D PCI_HEADER_TYPE_BRIDGE) {
>                 supported |=3D PCI_DEV_SER_PROBED_WINDOWS;
> @@ -1213,6 +1222,32 @@ int pci_liveupdate_read_bridge_windows(struct pci_=
dev *bridge)
>         return 0;
>  }
>
> +/**
> + * pci_liveupdate_intx_mask_broken() - Get whether INTx masking is broke=
n on an
> + *                                     incoming device
> + * @dev: The PCI device
> + *
> + * Get whether INTx masking is broken on @dev as determined by the previ=
ous
> + * kernel, so that INTx masking does not need to be probed.
> + *
> + * Return: 1 if INTx masking is broken, 0 if it is not, or -ENODATA if @=
dev is
> + * not incoming-preserved or the previous kernel did not pass whether IN=
Tx
> + * masking is broken on @dev.
> + */
> +int pci_liveupdate_intx_mask_broken(struct pci_dev *dev)
> +{
> +       u64 probed;
> +
> +       guard(rwsem_read)(&pci_liveupdate.rwsem);
> +
> +       if (!pci_liveupdate_read_probed(dev,
> +                                       PCI_DEV_SER_PROBED_BROKEN_INTX_MA=
SKING,
> +                                       &probed))
> +               return -ENODATA;
> +
> +       return !!probed;
> +}
> +
>  /*
>   * Check if the windows of @bridge have been read from hardware. Outside=
 of x86
>   * that does not happen during scanning.
> diff --git a/drivers/pci/liveupdate.h b/drivers/pci/liveupdate.h
> index 98d23e217308..7f86cc85deee 100644
> --- a/drivers/pci/liveupdate.h
> +++ b/drivers/pci/liveupdate.h
> @@ -22,6 +22,7 @@ bool pci_liveupdate_is_outgoing(struct pci_dev *dev);
>  int pci_liveupdate_read_bar_masks(struct pci_dev *dev, unsigned int nr_b=
ars,
>                                   u32 *bar_masks, u32 *rom_mask);
>  int pci_liveupdate_read_bridge_windows(struct pci_dev *bridge);
> +int pci_liveupdate_intx_mask_broken(struct pci_dev *dev);
>  void pci_liveupdate_claim_bus_resources(struct pci_bus *bus);
>  #else
>  static inline void pci_liveupdate_setup_device(struct pci_dev *dev)
> @@ -74,6 +75,11 @@ static inline int pci_liveupdate_read_bridge_windows(s=
truct pci_dev *bridge)
>         return -EINVAL;
>  }
>
> +static inline int pci_liveupdate_intx_mask_broken(struct pci_dev *dev)
> +{
> +       return -EINVAL;
> +}
> +
>  static inline void pci_liveupdate_claim_bus_resources(struct pci_bus *bu=
s)
>  {
>  }
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 853c84a2c782..43af72d1e5c9 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -2184,6 +2184,14 @@ static int do_pci_enable_device(struct pci_dev *de=
v, int bars)
>         if (dev->msi_enabled || dev->msix_enabled)
>                 return 0;
>
> +       /*
> +        * Leave INTx disabled on devices preserved across Live Update, s=
ince
> +        * the device could raise interrupts before its driver is ready. =
It is
> +        * up to the driver to enable INTx once it is ready.
> +        */
> +       if (pci_liveupdate_is_incoming(dev))
> +               return 0;
> +
>         pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin);
>         if (pin) {
>                 pci_read_config_word(dev, PCI_COMMAND, &cmd);
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index a53d0077a08b..badce31b34f8 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1976,6 +1976,16 @@ static u8 pci_hdr_type(struct pci_dev *dev)
>  static int pci_intx_mask_broken(struct pci_dev *dev)
>  {
>         u16 orig, toggle, new;
> +       int ret;
> +
> +       /*
> +        * Toggling PCI_COMMAND_INTX_DISABLE could let a device preserved=
 across
> +        * Live Update raise interrupts before its driver is ready, so us=
e the
> +        * result determined by the previous kernel for those devices.
> +        */
> +       ret =3D pci_liveupdate_intx_mask_broken(dev);
> +       if (ret >=3D 0)
> +               return ret;
>
>         pci_read_config_word(dev, PCI_COMMAND, &orig);
>         toggle =3D orig ^ PCI_COMMAND_INTX_DISABLE;
> diff --git a/include/linux/kho/abi/pci.h b/include/linux/kho/abi/pci.h
> index 84a1bf71eeca..badcf2f01be7 100644
> --- a/include/linux/kho/abi/pci.h
> +++ b/include/linux/kho/abi/pci.h
> @@ -95,10 +95,13 @@ struct pci_dev_ser {
>   *    window.
>   *  * PCI_DEV_SER_PROBED_PREF_64_WINDOW: The bridge's prefetchable memor=
y
>   *    window is 64-bit.
> + *  * PCI_DEV_SER_PROBED_BROKEN_INTX_MASKING: INTx masking cannot be use=
d on
> + *    the device, i.e. struct pci_dev::broken_intx_masking is set.
>   */
>  #define PCI_DEV_SER_PROBED_IO_WINDOW           BIT_ULL(0)
>  #define PCI_DEV_SER_PROBED_PREF_WINDOW         BIT_ULL(1)
>  #define PCI_DEV_SER_PROBED_PREF_64_WINDOW      BIT_ULL(2)
> +#define PCI_DEV_SER_PROBED_BROKEN_INTX_MASKING BIT_ULL(3)
>
>  /*
>   * The size of struct pci_dev_ser when this ABI was introduced. Since fi=
elds
> --
> 2.56.0.212.g129ede20d9-goog
>
