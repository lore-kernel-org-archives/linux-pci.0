Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414AD414DEE
	for <linux-pci@vger.kernel.org>; Fri,  7 Aug 2026 19:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786130915; cv=pass; b=A1mfaTkjrG3ZJXs+wqUkwIsCyymmKkgnXX+2PI+HLr/MGfS80rqm4u65HJNtOiWwL2K2zE51VI/wcmSY0OLCvSWDHt53hmXSeVg70msob5mablHjeUaiiht7DZDBC4p+mWiMrSJaXWCjs7bV2d2n1+EG6cKPVnslR+LjrpBey10=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786130915; c=relaxed/simple;
	bh=6m677e77vjSXWEEleS3MZi++Z9g0Zva0SuXly+l1xBI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BSvn/flZxRzfrUl27iQXj4PewXBZw7AdtHXqQaMaYw9wL63/WTyLVrXSR9Wcx8YCH5srnKvhUGcE+sXdCrZ5bMhqgjPqHV23y9+K+MKCDoh0N5bLpjc9LNvyVr7wdZmtdXlKtLjO7+gn7v9dvRPAHGWxI7/XUbW7FQeO88tE22M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EHniQNey; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=I6g6J+nG; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EHniQNey";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="I6g6J+nG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786130909;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4KXnm5daW43PMdIJwN6t0SaJU5TGJy0uCt3G3xA9ZL8=;
	b=EHniQNeyhnBIFxSe0siiH8pVcJLoJ2+fyHJxYu2lFDLeRtPw2vbc/jVnzvpZao1X1Kg+mf
	m/fCtAuiqtQbQ5gJ9hy1+tbCV/kAqVgmd2nWWMZww2RoHIKaFkKC3EGJLDYlCylqCf7bWT
	RozzuRmp/uESgpSEm/Vet2yqqKJBPGk=
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-184-6swjLFabMmGqs8r4ICm3Wg-1; Fri, 07 Aug 2026 15:28:02 -0400
X-MC-Unique: 6swjLFabMmGqs8r4ICm3Wg-1
X-Mimecast-MFC-AGG-ID: 6swjLFabMmGqs8r4ICm3Wg_1786130881
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-737d34a0dc8so2904550137.1
        for <linux-pci@vger.kernel.org>; Fri, 07 Aug 2026 12:28:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786130881; cv=none;
        d=google.com; s=arc-20260327;
        b=R4+MSlV2qXjU9iWJLfyK0jMWDEpTKd+LaR3aRQb81WJYV5t5kT1VL0DlhR6CblJt2W
         QpZB9YRVavyM2BpixkFfIoMGPEiJo2MGf0761N8Lv8jNn6oAXgza4mLo+xxOH7lsR9Pl
         are/8Hb5hkZCR9zjEWHid2dUCmiTYh6WH4hpepOgOjo4T1g5OOxokyrJuQaZythbDddo
         jfINFlsGskyopO+PmfoAfE0ng+rl+oHlR85iN17N8aFD69sA56j95yFeJ+BtfDkAWPIR
         N3hvofxSBEDf8QGnMmwyji/T87euVGf++yqN0MAR1EYZhDewQuJx6YwDZVer47OjCH8C
         iqxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4KXnm5daW43PMdIJwN6t0SaJU5TGJy0uCt3G3xA9ZL8=;
        fh=BBh29UpzIVQD1zrwe7/txxoUzaG/ygBFA6v9zUNmqRI=;
        b=sqNEc2gfAyM7aj+XdzuStvPjSedYhZBw1Wg55VHDryOv6riSppOBEqDIwoFQuAVrgC
         bG1hxfbadrR1h95IP0cxwPRHlpSXD7+B8QHMqkLuCljmv7cgTwS+FSQX9/VxeasmX3yY
         K41veZ6TRQ2N5K3v4PCSXxUE4cYqe8/sjgPxNMS0FyPnc08tA6pd7cDeawzDqCdWEGiV
         HjeNWMQmtXxFYUwWVCBMYUikANOZgcbIynQEC5vPA5Qmcn6tY/DqNH+DP4XQIgMR8OQa
         T2+eUxC7RehmYZUmTHYc+P4znFG6MQoNQoYnpvYSeY0xWw8oo88TYoWMdnoAULvh9tfA
         sIvg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786130881; x=1786735681; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4KXnm5daW43PMdIJwN6t0SaJU5TGJy0uCt3G3xA9ZL8=;
        b=I6g6J+nGkYeSir4t5oCknW4Rdx7XO+S3Fsq70SesRJrC/KBAQx53pD9caCwdQhXmRg
         GBvpMPOyZk/6TFjW59M17hO+04/B3d3mhi+5b5Wq+DuWugdTWKak9OwaCl46vNJ8O66f
         5QLMGAKTks9wj4DH7+b5MjDsOwwzAW2lE5PfkydpfzH96qSpwsd+e5RKxD/Y+JgQ5bG3
         chFIKMAWrQPSWOVh7dFdPLvW5TGMQB13jSJ0Eeh07ZlsIE3rOt0Ib2m2Zr3NEYHdj8cO
         o8hutpefLs+r+pz1IB7fFZYf0NsH3Wi2wV8MOrbS6W+lxrVKY3rO63J50/v91Tk+2Vf+
         A26Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786130881; x=1786735681;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4KXnm5daW43PMdIJwN6t0SaJU5TGJy0uCt3G3xA9ZL8=;
        b=GaZKeKrX6Aw4fOatPqpGLexnE15wDePHCk4X/tk42yjM0bzYo1GE7TqZjQBxT4+n+2
         4PomdkM2q5U1rTFsFwzE4+tIepzIs1rK9slvIxLO/Zk5QbPXnJoLPa8n4EZCbdMBWv3O
         KTbUlQVelcMPY0Cz6Xl10oHZMvpNFbf6VOa2m96qDMDcmpWnPfCkUkY3m1pV3od+XjEJ
         nmXvEIpgNn0MDLAn9JhKxEx092Il0vs79kOG3ncpHUIqiL6QZ30aTWJQSbfLy3YnOMKD
         YwM/45kowGPTJtpWScij5QPRPR0DQpyic2ZmQ7akxaeyK05uqgpKXrf6biyHHqybTjZA
         MQXg==
X-Forwarded-Encrypted: i=1; AHgh+Ro5EcvYdIPTO5Wjykm+x17F9MthsfxxVjrpzZX9EjZFxnpyjrcJUYlJ83Jk7rMoKM9yqNTlajAsjoQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/gHRMvGZNU4kqXGWz+m7XQ4c7dE/YrV/yMJCBgssfAmRaPz9U
	EO8V5+sZ5/4mMEFd7k4u+PJear/cq5s4rwjvaPWO90tpqFq8XPF16NnytcGgZewbINjX6P5EiD9
	d6ENLDxMDQXfGnCtwubcr+rxAInuyInx5PdAYRFlj7egpPO2jdkMIluUzNutuNSpZucX1f2+wf3
	g8/VkcB0wsEtZSeFdXNMDoyOA3gwp87K5b4cQUsOLVCDjS
X-Gm-Gg: AR+sD13r5D2ELFeKML59G7B4fY9Pp4MlZOx4FY5ho+MuhUgSxZygwYtVtVoR7avwSUm
	/E8XIAyyOKBfSSF/7QTkxs5EwxnaWICc/dZzXWVW2I3okWJjFemi0+TrlXQbhwSwtJKLpfvCZ9m
	WwVQdq8Rdbv69ji/D6I8mUmzXWFhcI9rlu9dePzDOjgRYFBnnxTLkczeQxrZR/U2q5c2iiUw9KN
	Ptf1Zs85IX2qIjeMkQW97tWkr1UXSeh4vWpRpBjOidVpVwQbbjSteGgaqmCu7UHIqc5r8WXtIg=
X-Received: by 2002:a05:6102:32d3:b0:6c5:d55d:c093 with SMTP id ada2fe7eead31-760e8720f3cmr7627855137.8.1786130881342;
        Fri, 07 Aug 2026 12:28:01 -0700 (PDT)
X-Received: by 2002:a05:6102:32d3:b0:6c5:d55d:c093 with SMTP id
 ada2fe7eead31-760e8720f3cmr7627838137.8.1786130880913; Fri, 07 Aug 2026
 12:28:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260726093200.146111-1-rihyeon8648@gmail.com> <20260726093200.146111-2-rihyeon8648@gmail.com>
In-Reply-To: <20260726093200.146111-2-rihyeon8648@gmail.com>
From: David Jeffery <djeffery@redhat.com>
Date: Fri, 7 Aug 2026 15:27:48 -0400
X-Gm-Features: AUfX_mwHv-Gj9I1U2ZFOL4BIb4TKaHYMrvWq7Yq-J6jRc2rj0hucgkpAfnIL7OY
Message-ID: <CA+-xHTEb3=oNLZ_spLL9wLEFpaN44+K+_hSnrMKuY7A1zHLDKA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] PCI: Handle dev_set_name() failure in pci_setup_device()
To: Rihyeon Kim <rihyeon8648@gmail.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, 
	tarunsahu@google.com, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 26, 2026 at 5:32=E2=80=AFAM Rihyeon Kim <rihyeon8648@gmail.com>=
 wrote:
>
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
>          */
>         dev->msi_addr_mask =3D DMA_BIT_MASK(64);
>
> -       dev_set_name(&dev->dev, "%04x:%02x:%02x.%d", pci_domain_nr(dev->b=
us),
> -                    dev->bus->number, PCI_SLOT(dev->devfn),
> -                    PCI_FUNC(dev->devfn));
> +       err =3D dev_set_name(&dev->dev, "%04x:%02x:%02x.%d",
> +                          pci_domain_nr(dev->bus), dev->bus->number,
> +                          PCI_SLOT(dev->devfn), PCI_FUNC(dev->devfn));
> +       if (err) {
> +               pci_release_of_node(dev);
> +               return err;
> +       }
>
>         class =3D pci_class(dev);
>
> --
> 2.43.0
>

Looks good, thanks for doing this.

Reviewed-by: David Jeffery <djeffery@redhat.com>

