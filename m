Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6901A7264
	for <linux-pci@vger.kernel.org>; Thu, 14 May 2026 00:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778718671; cv=none; b=L5VZWydqBjbM2cqIG87ATCv4UMCO+4ZoRMLrCgCc4gD4l89zYTc8QAI4hTLQKKubG9W2fZ53KUq6FIgPpCb9J1ZpVclUBjJw4ApWgFEQBcKj+LPokNfbJKyJ+yXcHekFyCqK4cP2GCUXjxbYGBH9pcxTYlDeQiGLmyq843+Qp80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778718671; c=relaxed/simple;
	bh=ny0DGr1WaS4NIgror2ddRvWLPRA5lhFwfQFTvUe7MFc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lPkTyl6bZQ/8oYmai1MB1kPLC7mnSiKDlgttJHswjI6pulq7w2xlx5uSdCRCeuO/BDYn2jrg6800yrt2D3R8om3hBlvfjcgswxr27WivTGxxfsH4AFC6KzfHqBsb5PYCX3tyU5UvEhXBzID6HukZaVbSSAfh+Z/aiYEM8oTkgH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AN44Wrg7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AN44Wrg7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F10AC19425;
	Thu, 14 May 2026 00:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778718671;
	bh=ny0DGr1WaS4NIgror2ddRvWLPRA5lhFwfQFTvUe7MFc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=AN44Wrg7n4tGbgEONLwUqck4mCIBCSwVNHuyyDQOnMpPRgwjcxRiwLskAglE4uJDt
	 RyzMFxmlWj2BOiYrO2Q751XgYsMMDZuUOpOFBoyUmCLN5gpRqqLhQHC5AYeCrHmKIY
	 5HU9tdpcW6IYQEUllKvSoYf0o+s4rUcgVMeUtuZfEmrPll0DFQXfoUyOBUstlxfo0J
	 4zxiI24dSp59NU6AdZkvBXaigDecxCkc537ZxKC9fGZES3H3R+NIcpz/50iOikjlEq
	 E7dg82YsKSl7xirdtvBCR4ulAPsz95de5eKjMVraO5w/qbU8AVwgFdYlxxv9U0oI5J
	 CP8aWtqWf2krA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 02/11] PCI: liveupdate: Track outgoing preserved PCI
 devices
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Matlack" <dmatlack@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260512184846.119396-3-dmatlack@google.com>
References: <20260512184846.119396-3-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 00:31:10 +0000
Message-Id: <20260514003111.4F10AC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] Dangling pointer in dev->liveupdate.outgoing causes Use-After-=
Free memory corruption and state leaks if a device is not properly unpreser=
ved.
- [High] Missing `kho_is_enabled()` check in `pci_flb_preserve()` violates =
KHO subsystem guidelines.
--

commit f946f5d8b0614325899345e29b5315ff6d5139e9
Author: David Matlack <dmatlack@google.com>

PCI: liveupdate: Track outgoing preserved PCI devices

This patch adds APIs to allow drivers to notify the PCI core of which devic=
es
are being preserved across a Live Update. It allocates a struct pci_ser via
the KHO subsystem to track the outgoing preserved devices.

> diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
> --- a/drivers/pci/liveupdate.c
> +++ b/drivers/pci/liveupdate.c

[ ... ]

> @@ -74,27 +110,30 @@ static int pci_flb_preserve(struct liveupdate_flb_op=
_args *args)
> =20
>  	size =3D struct_size_t(struct pci_ser, devices, max_nr_devices);
> =20
> -	ser =3D kho_alloc_preserve(size);
> -	if (IS_ERR(ser))
> -		return PTR_ERR(ser);
> +	outgoing->ser =3D kho_alloc_preserve(size);

Does this allocation need to be gated by kho_is_enabled()?

If KHO is disabled, kho_alloc_preserve() will silently add tracking state
that will never be used.

> +	if (IS_ERR(outgoing->ser)) {
> +		kfree(outgoing);
> +		return PTR_ERR(outgoing->ser);
> +	}
> =20
>  	pr_debug("Preserved struct pci_ser with room for %u devices\n",
>  		 max_nr_devices);

[ ... ]

>  static void pci_flb_unpreserve(struct liveupdate_flb_op_args *args)
>  {
> -	struct pci_ser *ser =3D args->obj;
> +	struct pci_flb_outgoing *outgoing =3D args->obj;
> =20
> -	WARN_ON_ONCE(ser->nr_devices);
> -	kho_unpreserve_free(ser);
> +	WARN_ON_ONCE(outgoing->ser->nr_devices);
> +	kho_unpreserve_free(outgoing->ser);
> +	kfree(outgoing);

If a driver fails to unpreserve a device before the FLB is torn down, this
WARN_ON_ONCE triggers, but the memory is still freed.

Does this leave dev->liveupdate.outgoing pointing to freed memory?

> =20
>  	pr_debug("Unpreserved struct pci_ser\n");
>  }

[ ... ]

> +void pci_liveupdate_unpreserve(struct pci_dev *dev)
> +{
> +	struct pci_flb_outgoing *outgoing =3D NULL;
> +	struct pci_dev_ser *dev_ser;
> +	struct pci_ser *ser;
> +	int ret;
> +
> +	ret =3D liveupdate_flb_get_outgoing(&pci_liveupdate_flb, (void **)&outg=
oing);
> +
> +	if (ret || !outgoing) {
> +		pci_warn(dev, "Cannot unpreserve device without outgoing Live Update s=
tate\n");
> +		return;
> +	}
> +
> +	guard(mutex)(&outgoing->lock);
> +	ser =3D outgoing->ser;
> +
> +	guard(write_lock)(&dev->liveupdate.lock);
> +
> +	dev_ser =3D dev->liveupdate.outgoing;
> +	if (!dev_ser) {
> +		pci_warn(dev, "Cannot unpreserve device that is not preserved\n");
> +		return;
> +	}
> +
> +	pci_info(dev, "Device will no longer be preserved across next Live Upda=
te\n");
> +	ser->nr_devices--;
> +	memset(dev_ser, 0, sizeof(*dev_ser));

If dev->liveupdate.outgoing was left dangling from a previous torn-down
session, can this corrupt memory?

If a new Live Update session starts, pci_liveupdate_unpreserve() would
fetch the new outgoing FLB but operate on the old dangling
dev->liveupdate.outgoing pointer.

Does this code cause a use-after-free in the memset() here, as well as
corrupt the new session's counter when decrementing ser->nr_devices?

> +	dev->liveupdate.outgoing =3D NULL;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260512184846.1193=
96-1-dmatlack@google.com?part=3D2
