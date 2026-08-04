Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D8343849B
	for <linux-pci@vger.kernel.org>; Tue,  4 Aug 2026 13:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785850271; cv=none; b=tKlj5TIR5JxVI4aacxcvCkse+K4Sxj5rTROS3wNqY1nVTGehZi5cB8BH9FXPuSJCurD5lYoswyjXYKomJjzCgVR1YFceXDA9p08JfjlE9AqThbtRc/5N2GCFnejEog3jw4EvMnhqzE8fmz6L8aLC/MPw8iRqdT0SHDO4MXFYxp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785850271; c=relaxed/simple;
	bh=dHe6hFKUiPx1NwjcvhZwwCq4ahAyTLRZM00WXff3YfY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sZnq3guy2Yca8psYHMh2mVRoAfwo3/+ZUpicUkZtatHsQ2+/LHxAWLChohti2PaXKFDXd+z9vt6tNzRWBgsFblW4tDNGlU0QLik293RyakgDw8FsSIcx+awny5+VhnNrlv2AMHbcb1U1Uj+laL8ihKmlJEXmdOPr2bUU2u9daZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OTkIRQz2; arc=none smtp.client-ip=209.85.218.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OTkIRQz2"
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c15eb4015e7so425904466b.3
        for <linux-pci@vger.kernel.org>; Tue, 04 Aug 2026 06:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785850268; x=1786455068; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PFR8gEiHLck6mqB8cHj4+FSK3ntr9JI1+jIZkdbZdrg=;
        b=OTkIRQz2cHkVvTkx3V//ezyCkJku/syMTnBHvPPVCnCzTBSby7s/PUgavqG0umK/vC
         hdbBU39kLEXjt5JOOKIP+q8NDBi49vLgY3SzyePrfe603t4q+cP6obmEKPX1d7Fv0K+Q
         wOGv55vyp0W6JlzdFOIikGUcsgoqbz9Uxvo1STxowthdMNFZXboxZhXs0YKTowmmr+AJ
         NxOWNdeUa5r/s/cKeEjTz07oEMKWpKraxlYBl2RDJos0YAhxbn0X31SxPYCc56fa+ZoR
         L2rono3So5nZ15dgbt1UqYdNAO3jMXDpu5GAVwUGmTiRdlW7CqhJjNX5i8UiBBjZ7z6v
         5lDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785850268; x=1786455068;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PFR8gEiHLck6mqB8cHj4+FSK3ntr9JI1+jIZkdbZdrg=;
        b=FhswBn7IK2jazH11XJzTaaDhefVHkZo2Iy3W2bkFENdWtkWHPbW5Kx5qP7KVwFC2u9
         9VWRwZC2R/dYEPAwb9xAUeM//ydLHdr3FeCSQjxbksgtOhIh2SiXRWdPXNTBbJ1I0iHP
         8Ovc9Cyhf5VYnNK6DWMQe4V8axjIuDNOT4PFCdgU/LTDETg5/S3xNYMbu95IcisuH4QM
         jhfKMFRcM3OhbgrAJD3v5fZSMQ6piLK/pTLVM/9wsag2dGvenvejhKlgWTA6evTRpSUX
         aVuOzcz4WrYocX/ITDv4K8Xt29aUTz3kRGl2p9ivf3zN6mFl6smgrRDBua6TOjECWkYS
         yzjg==
X-Gm-Message-State: AOJu0YywAiK9e6loifWsRcYlOMUMlIXsQZYznJlG768oh3NZ+qLcS7JM
	PkwQ9xGAft9UIVpRuOvS7RR2Y5JmqKrPqiBCSEzlqSWSJQU6y0mfJQ2Uiv28B/qiImP9uYXszyP
	x7blLpIuDG5nLQRJ5Zw==
X-Received: from edse18.prod.google.com ([2002:aa7:d7d2:0:b0:69f:a77c:6456])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:906:ee8e:b0:c1f:7c45:2dfa with SMTP id a640c23a62f3a-c1ff2ea19d8mr1021988166b.7.1785850267802;
 Tue, 04 Aug 2026 06:31:07 -0700 (PDT)
Date: Tue, 04 Aug 2026 13:31:06 +0000
In-Reply-To: <20260726093200.146111-2-rihyeon8648@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260726093200.146111-1-rihyeon8648@gmail.com> <20260726093200.146111-2-rihyeon8648@gmail.com>
Message-ID: <9huz1pcem2qt.fsf@tarunix.c.googlers.com>
Subject: Re: [PATCH v2 1/2] PCI: Handle dev_set_name() failure in pci_setup_device()
From: tarunsahu@google.com
To: Rihyeon Kim <rihyeon8648@gmail.com>, bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	gregkh@linuxfoundation.org, djeffery@redhat.com, 
	"Krzysztof =?utf-8?Q?Wilc?= =?utf-8?Q?zy=C5=84ski?=" <kwilczynski@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable


Hi,

Thanks for this resolution!
Sashiko's comment seems valid and related to what we are resolving
in this series. So We can add one more to resolve the other issue.

Feel free to add:
Reviewed-by: Tarun Sahu <tarunsahu@google.com>

Rihyeon Kim <rihyeon8648@gmail.com> writes:

> pci_setup_device() calls dev_set_name() but ignores its return value.
> dev_set_name() calls kobject_set_name_vargs(), which in turn allocates th=
e
> name with kvasprintf_const() and can fail, leaving dev->dev.kobj.name NUL=
L.
>
> Enumeration then continues with an unnamed device.  device_add() rejects
> it with -EINVAL because dev_name() returns NULL and pci_bus_type has no
> ->dev_name callback, but pci_device_add() only warns about that failure:
>
>   pci (null): [8086:2934] type 00 class 0x0c0300 conventional PCI endpoin=
t
>   pci (null): BAR 4 [io  0xc0e0-0xc0ff]
>   ------------[ cut here ]------------
>   ret < 0
>   WARNING: drivers/pci/probe.c:2768 at pci_device_add+0x133b/0x1810
>   Call Trace:
>    pci_scan_single_device+0x1d0/0x240
>    pci_scan_slot+0x1c9/0x7c0
>    pci_scan_child_bus_extend+0x6b/0x7b0
>    pci_rescan_bus+0x18/0x40
>    rescan_store+0xfb/0x130
>
> The device was already added to bus->devices before device_add() ran and
> is not removed from it, so pci_bus_add_devices() later in the same
> pci_rescan_bus() call finds it and passes it to __device_attach(), which
> dereferences dev->p.  device_add() freed dev->p on its error path, so thi=
s
> is a NULL pointer dereference:
>
>   Oops: general protection fault, probably for non-canonical address ...
>   KASAN: null-ptr-deref in range [0x0000000000000108-0x000000000000010f]
>   RIP: 0010:__device_attach+0xb0/0x4d0
>   Call Trace:
>    device_initial_probe+0xaf/0xd0
>    pci_bus_add_device+0xc5/0x100
>    pci_bus_add_devices+0x9a/0x1f0
>    pci_rescan_bus+0x2a/0x40
>    rescan_store+0xfb/0x130
>   Kernel panic - not syncing: Fatal exception
>
> Check the return value and propagate the error instead.  pci_setup_device=
()
> already returns int, and both callers, pci_scan_device() and
> pci_iov_scan_device(), already release the device when it fails.  Release
> the OF node first, like the existing unknown header type path does, and
> update the kernel-doc for the new return value.
>
> Fixes: 1fa5ae857bb1 ("driver core: get rid of struct device's bus_id stri=
ng array")
> Reported-by: syzbot+87bb32e345aa80c0554b@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D87bb32e345aa80c0554b
> Tested-by: syzbot+87bb32e345aa80c0554b@syzkaller.appspotmail.com
> Reviewed-by: Krzysztof Wilczy=C5=84ski <kwilczynski@kernel.org>
> Assisted-by: Claude:claude-opus-5 sparse
> Signed-off-by: Rihyeon Kim <rihyeon8648@gmail.com>
> ---
> The reproducer is the one from the syzbot report, unmodified.  Tested on
> 48a5a7ab8d6a with syzbot's config for this bug (x86_64, KASAN,
> CONFIG_FAILSLAB), under QEMU with "-machine q35 -usb" so that the
> 0000:00:1d.0 it removes and rescans exists.  Without the patch it gives t=
he
> WARNING and then the panic quoted above; with it the allocation still fai=
ls
> in dev_set_name(), enumeration skips the device, and the device comes bac=
k
> on the next rescan.  syzbot tested it as well.
>
> The report also has an arm64 crash at 0000:00:01.0 with a virtio device, =
so
> this is not specific to that controller.
>
> v2:
>  - Fixes: points at 1fa5ae857bb1 rather than eebfcfb52ce7 (Krzysztof)
>  - update the kernel-doc for the new return value (Krzysztof)
>  - say kvasprintf_const() rather than kvasprintf() in the commit log
>    (Krzysztof)
>  - pick up Reviewed-by
>
>  drivers/pci/probe.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index dd0abbc63e18..3e6f0eb7d456 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2010,8 +2010,9 @@ static const char *pci_type_str(struct pci_dev *dev=
)
>   * Initialize the device structure with information about the device's
>   * vendor,class,memory and IO-space addresses, IRQ lines etc.
>   * Called at initialisation of the PCI subsystem and by CardBus services=
.
> - * Returns 0 on success and negative if unknown type of device (not norm=
al,
> - * bridge or CardBus).
> + * Returns 0 on success, -ENOMEM if the device name could not be allocat=
ed,
> + * and -EIO if the device is of an unknown type (not normal, bridge or
> + * CardBus).
>   */
>  int pci_setup_device(struct pci_dev *dev)
>  {
> @@ -2052,9 +2053,13 @@ int pci_setup_device(struct pci_dev *dev)
>  	 */
>  	dev->msi_addr_mask =3D DMA_BIT_MASK(64);
> =20
> -	dev_set_name(&dev->dev, "%04x:%02x:%02x.%d", pci_domain_nr(dev->bus),
> -		     dev->bus->number, PCI_SLOT(dev->devfn),
> -		     PCI_FUNC(dev->devfn));
> +	err =3D dev_set_name(&dev->dev, "%04x:%02x:%02x.%d",
> +			   pci_domain_nr(dev->bus), dev->bus->number,
> +			   PCI_SLOT(dev->devfn), PCI_FUNC(dev->devfn));
> +	if (err) {
> +		pci_release_of_node(dev);
> +		return err;
> +	}
> =20
>  	class =3D pci_class(dev);
> =20
> --=20
> 2.43.0
