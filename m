Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795116569;
	b=hpPDGL1+fZFJHZRH0UfyG/Ke4BIR4s23xuTra78S9gl+lfqcVZcGmA0mz1na3XS+EXMQ
	 DcdwGC08WJ82wF9ClvdghzXjL3vkdhtobDZtcx2NeIhDlnMTbbMLKo5v27hODkRYWwlhH
	 pQooh9GNtgLJjWS//MDCTBV5dpxStKztJTIVlmBNMsJ/y5YefJpaEtB/UgFc0GF5CXU30
	 sXS3lKEfJmugr/fe2GrdvJnrJnh+Zj99u5QBOuwSqowz1seA9vfaQQra2v1n9ih6mv0NJ
	 XEE8veBC2xh/Bxkz6zhW8RPX/aHslAyuyHKrDqw8QTZFDjvDl1JtPJODHFdFCbxPwfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795116569;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=l7AVhcwuGl1PXj6hXzEWXwBm2rxgoAoDA2jTKI3Qvqk=;
	b=nr3Ib3XSJS5HqbDlSupXT9UKdrnLFfLizRWeTtnMFRwPOeuLk6XMiRqgEYhNUZerEY0R
	 Zsg/zk3FNMhBmwVZXvADtVEskqYC1YfpX9zbSu9906cI22ZpBQY81RDuINGSHRm6tjiTC
	 un+JB83Y9xPcvXBP65n9IpZ4zSYAxXZY4K8NtkcEQzz9TUmkJVP5gK5IMYoLHHyPppsJi
	 ujoPOIe+6Ssdx/WLxWFb1rn68dANpXE+u8NW9GLDKCQDYt6/RPI+YtjOc1Ej20xSLtxE8
	 mP14mynQZIB+7Yp+3Dcdp5XDF4MYvgYZ4vWAcu4Fhenai96BbdFJrYXzja66Lslfbpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iHA9zobk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63A460A2606;
	Thu, 19 Nov 2026 19:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iHA9zobk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BD711F000C4;
	Thu, 19 Nov 2026 19:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795116569;
	bh=l7AVhcwuGl1PXj6hXzEWXwBm2rxgoAoDA2jTKI3Qvqk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iHA9zobkukderofckPlIzb4A9U/kBB2V9y0pyMje15LATMvrxSg/XqPibm1RwKsZz
	 e/WbJjL6PCbGKFFRurRzQeJ7HNwIOE7WWmlEpuMNuzE5QSHVk6IaDqe5cLGTMUVBuB
	 nxRn3Kv3zqiYuWqbva79DGtO8kpOQH1hgTcAHlz2txd6cdg0chbHK/pW9ba8gIrFIR
	 5PKy7jBpgn49fYlXA40/gqhWhNbjxhll7pvt7jERlNpEuR1akuSJXmdlqSLzTWGriQ
	 nf9ymKAptBt0LQ1sMZ6sYwzZ+TTaulrAV4LHsQB8N56GsIEj4SzwAfGu2txUTKXct2
	 ZqO9UCY2jkrsA==
Message-ID: <sashiko-outbox-223897@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 11/31] USB: Unwind interface claims after
 registration or binding failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org, linux-pci@vger.kernel.org, linux-sound@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261118-device-trust-core-v3-11-d655875c4bfb@nvidia.com>
References: <20261118-device-trust-core-v3-0-d655875c4bfb@nvidia.com>
 <20261118-device-trust-core-v3-11-d655875c4bfb@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 19:29:29 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] USB: unbound claim missed in usb_set_configuration() when
  autoprobe is off
- [Medium] usb: core: failed interface claim unwind skips altsetting 0
  reset
--

commit 5e9d278c3fe83635c408aabb0f7fdb4a22c1316b
Author: Leon Romanovsky <leon@kernel.org>

USB: Unwind interface claims after registration or binding failure

This commit unwinds pre-claimed USB interfaces when device_add() fails or
driver binding does not complete during usb_set_configuration(), and releas=
es
remaining unregistered interface claims in usb_disable_device().

> diff --git a/drivers/usb/core/message.c b/drivers/usb/core/message.c
> index 306978caaf1ef..b2e5ed35a4a59 100644
> --- a/drivers/usb/core/message.c
> +++ b/drivers/usb/core/message.c

[ ... ]

> @@ -2270,6 +2292,7 @@ int usb_set_configuration(struct usb_device *dev, i=
nt configuration)
>  	 */
>  	for (i =3D 0; i < nintf; ++i) {
>  		struct usb_interface *intf =3D cp->interface[i];
> +		struct device_driver *claimant;
>  		struct module *claim_owner;
> =20
>  		if (intf->dev.of_node &&
> @@ -2285,6 +2308,7 @@ int usb_set_configuration(struct usb_device *dev, i=
nt configuration)
>  			intf->cur_altsetting->desc.bInterfaceNumber);
>  		device_enable_async_suspend(&intf->dev);
>  		device_lock(&intf->dev);
> +		claimant =3D intf->dev.driver;
>  		claim_owner =3D xchg(&intf->claim_owner, NULL);
>  		device_unlock(&intf->dev);
>  		ret =3D device_add(&intf->dev);
> @@ -2293,7 +2317,22 @@ int usb_set_configuration(struct usb_device *dev, =
int configuration)
>  			intf->unregistering =3D 1;
>  			device_unlock(&intf->dev);
>  		}

[Severity: Medium]
Does setting intf->unregistering =3D 1 before calling
usb_driver_release_refused_claim() prevent usb_unbind_interface() from
resetting the interface back to altsetting 0?

When a driver such as cdc_ncm claims a sibling data interface and switches =
it
to a non-zero alternate setting during probe(), a later device_add() failure
on that sibling sets intf->unregistering =3D 1 before
usb_driver_release_refused_claim() runs usb_unbind_interface().  Inside
usb_unbind_interface(), driver->disconnect() releases the control interface
and usb_set_interface() is called to restore altsetting 0, but
usb_set_interface() rejects the request with -ENODEV because
iface->unregistering is already set.  Since disconnect() released the sibli=
ng
claim, usb_has_claimant() returns false and the device stays configured with
the failed interface and its HCD bandwidth stuck on the non-zero altsetting.

> -		module_put(claim_owner);
> +		if (claimant && (ret || !intf->dev.driver) &&
> +		    usb_driver_release_refused_claim(intf, claimant)) {
> +			bool unconfigure =3D usb_has_claimant(dev, claimant);
> +
> +			get_device(&intf->dev);
> +			if (unconfigure)
> +				usb_set_configuration(dev, -1);
> +			module_put(claim_owner);
> +			put_device(&intf->dev);
> +			if (unconfigure) {
> +				usb_autosuspend_device(dev);
> +				return ret ? ret : -ENODEV;
> +			}
> +		} else {
> +			module_put(claim_owner);
> +		}

[Severity: Medium]
Can checking (ret || !intf->dev.driver) without device_lock(&intf->dev) miss
an unbound claim when drivers_autoprobe is disabled?

If an unregistered sibling interface was claimed during an earlier probe() =
and
bus autoprobing is disabled before device_add() runs device_initial_probe(),
__device_attach() is skipped:

drivers/base/dd.c:device_initial_probe() {
	if (sp->drivers_autoprobe) {
		ret =3D __device_attach(dev, true);
		if (ret =3D=3D 2)
			__device_attach(dev, false);
	}
}

device_add() then returns 0 with intf->dev.driver still pointing to claimant
while device_is_bound(&intf->dev) is false.  Because (ret ||
!intf->dev.driver) is false, usb_set_configuration() skips
usb_driver_release_refused_claim() and drops claim_owner in the else branch.
When usb_disable_device() later runs, device_is_registered(&interface->dev)=
 is
true, so device_del() is called before usb_release_unregistered_interface()
and __device_release_driver() calls klist_remove(&dev->p->knode_driver) on =
an
unattached klist_node, causing a NULL pointer dereference in klist_put().

Checking !device_is_bound(&intf->dev) under device_lock(&intf->dev) inside
usb_driver_release_refused_claim() instead of the unlocked !intf->dev.driver
check would catch this case.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118-device-tru=
st-core-v3-0-d655875c4bfb@nvidia.com?part=3D11
