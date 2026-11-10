Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794296127;
	b=3RZ9NIZXs+EFp2GNHacA0CELwCIpA7pXfA4vun1ZgX0wezA3okcP7RpE9ngUzxdJrqU5
	 C/uqxG6OlUd89WEYZ+AQ615sqeRQ4aTuUR2w6G1fmMoc8RosH4ns+IcrK8ANg6exFb1sN
	 udAtJnUBrmCxtvLbbz9Td5R0Uhr+3/Mhx0ZCdquXTWP+2ifZUwhYI9B0Uu9PLjxRNlPry
	 X2BhiH+OdUJOm4JceB87pHpHgiwyKCK2jYfQgS09h7ychxTmgNlS/ntphYgGfWXZvBCmP
	 wA06PoiFkE0u1MmD6vunTh31576H2zn55sI3cokg50vtePKfNaXQG1+hc7xVYpF9lVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794296127;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=5zAUHZbIQn/FmPE6LMNqEqfMmdzBT3LM8gMR4UsTGWc=;
	b=f7stGt41dYkqG99ZRAbcvdFV0E4wSVZCu0sfAtDEa0+7rPkFzwU6StulJVjlRN2BGc7N
	 JdaLZawDPaLzM0yAy9AovWIyY+LPeYhRfG5EEKm490ztEJysq4t6ZTWLZkYfFwFgWa40B
	 0zZmVEUYKEZ3Yxhj6CHB7Yak6Qpu1tvzecJ6h4mPcOtk7PdomIylBGKUXVqlxuXpc8HXj
	 FBDph/ofdvfweTIToCOdy8S9O8oqIpxweZbm/Ngd7jVDFICWdIB/k8kYH/47skoq8nKp5
	 +N8XsXiSFAMpYQ3EkFEHe6oYiGIV2CJxDf+1mBy09DyAu8dmutWLjU7DSAzL6GJPmKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KhnZKvmy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6183A60A5BDE;
	Tue, 10 Nov 2026 07:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KhnZKvmy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDD981F008A4;
	Tue, 10 Nov 2026 07:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794296127;
	bh=5zAUHZbIQn/FmPE6LMNqEqfMmdzBT3LM8gMR4UsTGWc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KhnZKvmyxBVn9Rah8jrnuUyfbe54EfBwtLO4nL8x0Nh9bM2y5cuBe3g3+mkRS1Vty
	 OlY1IIFX38+UFMwKWduitfaY30K+ieZwTV7DK9W0QIPS/A2vXACeINWBP+f20BfUHA
	 fjsv40cMasdh2JCcam9aj6xVgtGQmSqmhBqVvIvUTALL8dVuN5/6/KxZSNOjJd5R61
	 k3ckXKdQQmI+bPEdYav1g7T4nRmKRXK0MwOkjBPchN0qpwCAKsT6JgUnkg/xgs4KsZ
	 jVV2xyUfjTpg5KejwWDEEJIDO+gCNwO/XGEJ0C7uKWNhW6jxY3pCIufkaz1kIJuZPS
	 KGJlNFMK3DopQ==
Message-ID: <sashiko-outbox-206519@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 19/19] USB: Authorize devices and interfaces through
 device trust
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org, linux-pci@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261109-device-trust-core-v2-19-3b12d9a9f861@nvidia.com>
References: <20261109-device-trust-core-v2-0-3b12d9a9f861@nvidia.com>
 <20261109-device-trust-core-v2-19-3b12d9a9f861@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 07:35:26 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 9 potential
issues to consider:
- [High] usb: core: usb_resume_device() fails with -ENOTCONN on
  trust-disabled devices
- [High] usb: core: missing usb_notify_remove_device() on unbound
  disconnect
- [Medium] usb: core: probing deauthorized device or interface
  prematurely commits trust
- [Medium] usb: core: usb_driver_claim_interface() rejects disabled
  sibling before driver rule
- [Medium] usb: core: usb_authorize_device() drops device lock and races
  with deauthorize
- [Medium] usb: core: usb_device_authorized() true before driver
  admission
- [Medium] usb: core: usb_set_configuration() drops parent adversarial
  policy
- [Medium] usb: core: race in usb_authorize_interface() with
  deauthorization
- [Low] usb: core: missing device_trust_init() in usb_alloc_dev()
--

commit b35772e1cb354ec9df9404c1711878235a7ba8c8
Author: Leon Romanovsky <leon@kernel.org>

USB: Authorize devices and interfaces through device trust

This commit integrates USB device and interface authorization with device
trust by mapping the default authorization policies to
DEVICE_TRUST_POLICY_DISABLED and requesting DEVICE_TRUST_POLICY_FULL when
authorizing via sysfs.

> diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
> index 04b77691fbd7d..2ebd05d3855f4 100644
> --- a/drivers/usb/core/driver.c
> +++ b/drivers/usb/core/driver.c
> @@ -334,10 +334,10 @@ static int usb_probe_interface(struct device *dev)
>  	if (usb_device_is_owned(udev))
>  		return error;
> =20
> -	if (udev->authorized =3D=3D 0) {
> +	if (!usb_device_authorized(udev)) {
>  		dev_info(&intf->dev, "Device is not authorized for usage\n");
>  		return error;
> -	} else if (intf->authorized =3D=3D 0) {
> +	} else if (!usb_interface_authorized(intf)) {
>  		dev_info(&intf->dev, "Interface %d is not authorized for usage\n",
>  				intf->altsetting->desc.bInterfaceNumber);
>  		return error;

[Severity: Medium]
Does rejecting a deauthorized device or interface inside
usb_probe_interface() (or usb_generic_driver_probe()) happen too late to
avoid committing its trust level?

When an interface starts with interface_authorized_default enabled
(trust_state =3D=3D DEVICE_TRUST_SELECTABLE) and is deauthorized before any
driver binds, intf->authorized is cleared to 0 while intf->dev.trust_policy
stays DEVICE_TRUST_POLICY_DEFAULT.  Because usb_device_match() does not che=
ck
authorization, a subsequent driver load or reprobe enters really_probe() and
runs device_trust_prepare() before usb_probe_interface() is called:

drivers/base/dd.c:really_probe() {
    ...
re_probe:
	ret =3D device_trust_prepare(dev, drv);
	if (ret) {
    ...
}

device_trust_prepare() permanently sets dev->p->trust_state to
DEVICE_TRUST_COMMITTED before usb_probe_interface() returns -ENODEV, and
device_trust_clear() in the probe failure path does not revert trust_state.
User space can then no longer change trust_policy on the deauthorized
interface and gets -EBUSY.

> @@ -560,13 +560,9 @@ int usb_driver_claim_interface(struct usb_driver *dr=
iver,
>  		return -EBUSY;
> =20
>  	/* reject claim if interface is not authorized */
> -	if (!iface->authorized)
> +	if (!usb_interface_authorized(iface))
>  		return -ENODEV;
> =20
> -	if (!device_is_registered(dev) &&
> -	    dev->trust_policy =3D=3D DEVICE_TRUST_POLICY_DISABLED)
> -		return -EPERM;
> -
>  	dev->driver =3D &driver->driver;
>  	usb_set_intfdata(iface, data);
>  	iface->needs_binding =3D 0;

[Severity: Medium]
Does checking usb_interface_authorized(iface) here break claiming sibling
interfaces when interfaces start disabled by default and a driver is
authorized via a device_trust.driver=3D boot rule?

When interface_authorized_default is 0 or device_trust.default=3Ddisabled is
set, each interface starts with iface->dev.trust_policy set to
DEVICE_TRUST_POLICY_DISABLED.  Driver rules from device_trust.driver=3D are
only applied when device_trust_prepare() runs inside device_bind_driver() or
device_add() later in usb_driver_claim_interface().  Testing
usb_interface_authorized(iface) up front sees DEVICE_TRUST_POLICY_DISABLED =
on
the sibling interface and returns -ENODEV before device_trust_prepare() can
evaluate the driver rule.

> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> index 199d3f535a891..086b8db36f51a 100644
> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c

[ ... ]

> @@ -2786,7 +2786,22 @@ int usb_authorize_device(struct usb_device *usb_de=
v)
>  {
>  	int result =3D 0, c;
> =20
> +	/* Authorizing a device that its trust policy holds back admits it */
> +	if (device_policy_is_disabled(&usb_dev->dev)) {
> +		result =3D device_trust_set_policy(&usb_dev->dev,
> +						 DEVICE_TRUST_POLICY_FULL);
> +		if (result)
> +			return result;
> +	}
> +
>  	usb_lock_device(usb_dev);
> +	if (!usb_dev->dev.driver) {
> +		/* Binding the generic driver configures the device */
> +		usb_dev->authorized =3D 1;
> +		usb_unlock_device(usb_dev);
> +		result =3D device_attach(&usb_dev->dev);
> +		return result < 0 ? result : 0;
> +	}
>  	if (usb_dev->authorized =3D=3D 1)
>  		goto out_authorized;

[Severity: Medium]
Can a concurrent usb_deauthorize_device() race with usb_authorize_device()
across the unlocked windows between device_trust_set_policy(),
usb_lock_device(), and device_attach()?

Because usb_alloc_dev() initializes usb_dev->authorized to 1,
usb_device_authorized(usb_dev) becomes true as soon as
device_trust_set_policy() sets DEVICE_TRUST_POLICY_FULL and drops the device
lock:

CPU0                                  CPU1
usb_authorize_device(usb_dev)
  device_trust_set_policy(..., FULL)
    device_lock(&usb_dev->dev)
    usb_dev->dev.trust_policy =3D FULL
    device_unlock(&usb_dev->dev)
                                      usb_deauthorize_device(usb_dev)
                                        usb_lock_device(usb_dev)
                                        usb_dev->authorized =3D 0
                                        usb_set_configuration(usb_dev, -1)
                                        usb_unlock_device(usb_dev)
  usb_lock_device(usb_dev)
  if (!usb_dev->dev.driver)
    usb_dev->authorized =3D 1
    usb_unlock_device(usb_dev)
    device_attach(&usb_dev->dev)  <-- configures deauthorized device

A deauthorization that completed on CPU1 is silently overwritten, leaving t=
he
device authorized and configured.  If usb_deauthorize_device() instead runs
between usb_unlock_device() and device_attach(), device_attach() still binds
usb_generic_driver and commits DEVICE_TRUST_FULL on the deauthorized device.

> diff --git a/drivers/usb/core/message.c b/drivers/usb/core/message.c
> index 2d75b85b2d139..ddede900dace8 100644
> --- a/drivers/usb/core/message.c
> +++ b/drivers/usb/core/message.c

[ ... ]

> @@ -1872,16 +1872,27 @@ void usb_deauthorize_interface(struct usb_interfa=
ce *intf)
>   * usb_authorize_interface - authorize an USB interface
>   *
>   * @intf: USB interface structure
> + *
> + * Return: 0 on success, or the error of the trust policy request.
>   */
> -void usb_authorize_interface(struct usb_interface *intf)
> +int usb_authorize_interface(struct usb_interface *intf)
>  {
>  	struct device *dev =3D &intf->dev;
> +	int ret;
> +
> +	/* Authorizing an interface that its trust policy holds back admits it =
*/
> +	if (device_policy_is_disabled(dev)) {
> +		ret =3D device_trust_set_policy(dev, DEVICE_TRUST_POLICY_FULL);
> +		if (ret)
> +			return ret;
> +	}
> =20
>  	if (!intf->authorized) {
>  		device_lock(dev);
>  		intf->authorized =3D 1; /* authorize interface */
>  		device_unlock(dev);
>  	}
> +	return 0;
>  }

[Severity: Medium]
Can usb_authorize_interface() race with a concurrent
usb_deauthorize_interface() when device_trust_set_policy() and
intf->authorized =3D 1 run in separate critical sections without
device_lock(dev->parent)?

CPU0                                  CPU1
usb_authorize_interface(intf)
  device_trust_set_policy(..., FULL)
    device_lock(dev)
    dev->trust_policy =3D FULL
    device_unlock(dev)
                                      usb_deauthorize_interface(intf)
                                        device_lock(dev->parent)
                                        device_lock(dev)
                                        intf->authorized =3D 0
                                        device_unlock(dev)
                                        usb_forced_unbind_intf(intf)
                                          intf->needs_binding =3D 1
  if (!intf->authorized)
    device_lock(dev)
    intf->authorized =3D 1  <-- clobbers deauthorization and races on bitfi=
eld
    device_unlock(dev)
                                        device_unlock(dev->parent)

Because intf->authorized starts at 1, usb_interface_authorized(intf) becomes
true as soon as device_trust_set_policy() drops device_lock(dev).  If
usb_deauthorize_interface() runs at that point, usb_authorize_interface()
then sees !intf->authorized and sets intf->authorized back to 1 without
holding device_lock(dev->parent), undoing the deauthorization and racing wi=
th
usb_forced_unbind_intf() writing intf->needs_binding in the same bitfield
word.

[ ... ]

> @@ -2173,7 +2184,10 @@ int usb_set_configuration(struct usb_device *dev, =
int configuration)
>  		intfc =3D cp->intf_cache[i];
>  		intf->altsetting =3D intfc->altsetting;
>  		intf->num_altsetting =3D intfc->num_altsetting;
> -		intf->authorized =3D !!HCD_INTF_AUTHORIZED(hcd);
> +		/* The authorization default is the interface's initial trust policy */
> +		if (!HCD_INTF_AUTHORIZED(hcd))
> +			intf->dev.trust_policy =3D DEVICE_TRUST_POLICY_DISABLED;
> +		intf->authorized =3D 1;
>  		kref_get(&intfc->ref);

[Severity: Medium]
When a USB device is authorized with the "adversary" trust policy, does
usb_set_configuration() fail to propagate that policy to its child
interfaces?

Documentation/usb/authorization.rst explains that writing "adversary" to a
device's trust_policy before writing 1 to authorized operates the device as
an adversary, and boot rules such as device_trust=3Dusb:1-2=3Dadversary set=
 the
policy on the struct usb_device as well.  However, usb_set_configuration()
leaves intf->dev.trust_policy at DEVICE_TRUST_POLICY_DEFAULT whenever
HCD_INTF_AUTHORIZED(hcd) is set, and usb_bus_type does not propagate parent
adversarial trust to child interfaces.  As a result, USB interface drivers
bind to intf->dev with DEVICE_TRUST_FULL and device_is_adversarial(&intf->d=
ev)
returns false.

> diff --git a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
> index 2559a180fdeec..8b427209bcc02 100644
> --- a/drivers/usb/core/usb.c
> +++ b/drivers/usb/core/usb.c
> @@ -747,7 +747,10 @@ struct usb_device *usb_alloc_dev(struct usb_device *=
parent,
>  	dev->active_duration =3D -jiffies;
>  #endif
> =20
> -	dev->authorized =3D usb_dev_authorized(dev, usb_hcd);
> +	/* The authorization default is the device's initial trust policy */
> +	if (!usb_dev_authorized(dev, usb_hcd))
> +		dev->dev.trust_policy =3D DEVICE_TRUST_POLICY_DISABLED;
> +	dev->authorized =3D 1;

[Severity: High]
When a USB device is held with DEVICE_TRUST_POLICY_DISABLED so
usb_generic_driver does not bind, does usb_resume_device() fail with
-ENOTCONN after the device is suspended?

Previously, an unauthorized USB device still bound usb_generic_driver during
device_add(), so udev->dev.driver was non-NULL.  With udev->dev.driver now
NULL on a trust-disabled device, usb_suspend_device() falls back to
usb_generic_driver and suspends the port, setting udev->state to
USB_STATE_SUSPENDED, but usb_resume_device() rejects unbound devices:

drivers/usb/core/driver.c:usb_resume_device() {
    ...
	/* Can't resume it if it doesn't have a driver. */
	if (udev->dev.driver =3D=3D NULL) {
		status =3D -ENOTCONN;
		goto done;
	}
    ...
}

System sleep resume and runtime resume therefore fail with -ENOTCONN, leavi=
ng
the upstream port suspended and udev->state stuck in USB_STATE_SUSPENDED, a=
nd
subsequent authorization via usb_authorize_device() fails when trying to
configure the device over the suspended port.

[Severity: High]
Does leaving udev->dev.driver NULL on a trust-disabled USB device also skip
usb_notify_remove_device() when the device is disconnected before being
authorized?

usb_disconnect() relies on the bound device driver's disconnect callback to
invoke the remove-device notifier chain during device_del(&udev->dev), and
usb_generic_driver_disconnect() is the only caller of
usb_notify_remove_device(udev).  While a device is held back by device trus=
t,
its /dev/bus/usb/BBB/DDD node still exists and can be opened via
usbdev_open().  If the device is unplugged without ever binding
usb_generic_driver, usb_notify_remove_device() and usbdev_remove() are never
called, so processes blocked in poll() or usbfs ioctls on that file
descriptor are never woken up and hang indefinitely.

>  	trace_usb_alloc_dev(dev);
>  	return dev;
>  }

[Severity: Low]
Should usb_alloc_dev() call device_trust_init(&dev->dev) before
trace_usb_alloc_dev(dev)?

trace_usb_alloc_dev() and the early trace_usb_set_device_state() calls prior
to device_add() record usb_device_authorized(udev).  Because
device_trust_init(&dev->dev) has not been called yet, those tracepoints log
the HCD default policy rather than any boot policy from device_trust.defaul=
t=3D
or device_trust=3D.

> diff --git a/include/linux/usb.h b/include/linux/usb.h
> index 825f03b290670..2ead3234b1301 100644
> --- a/include/linux/usb.h
> +++ b/include/linux/usb.h

[ ... ]

> @@ -747,6 +753,15 @@ struct usb_device {
> =20
>  #define to_usb_device(__dev)	container_of_const(__dev, struct usb_device=
, dev)
> =20
> +/*
> + * A device is authorized when its trust policy lets it bind and user sp=
ace has
> + * not deauthorized it since.
> + */
> +static inline bool usb_device_authorized(const struct usb_device *udev)
> +{
> +	return udev->authorized && !device_policy_is_disabled(&udev->dev);
> +}

[Severity: Medium]
Does usb_device_authorized() report true as soon as trust_policy is changed
from disabled, even before the device has been authorized or bound to a
driver?

Because usb_alloc_dev() initializes udev->authorized to 1, writing
"adversary" to trust_policy (as Documentation/usb/authorization.rst instruc=
ts
before writing 1 to authorized) makes device_policy_is_disabled(&udev->dev)
false and usb_device_authorized(udev) true while udev->dev is still unbound
and unadmitted.  At that point, reading sysfs authorized already returns 1,
and writing to bConfigurationValue (or issuing USBDEVFS_SETCONFIGURATION)
passes the !usb_device_authorized(dev) check in usb_set_configuration() and
configures the device and binds interface drivers while udev->dev.driver is
still NULL and udev->dev's trust level is still DEVICE_TRUST_DISABLED.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109-device-tru=
st-core-v2-0-3b12d9a9f861@nvidia.com?part=3D19
