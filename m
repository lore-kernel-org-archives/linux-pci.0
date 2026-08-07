Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA27D4749C6
	for <linux-pci@vger.kernel.org>; Fri,  7 Aug 2026 15:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786117108; cv=none; b=Kl+L/oz9A7ySr/cmERPd6utQv7+OkFqBN3jYCqCnmL332dYbhYsPa/KrNyvB6GDa20nWaXK3IAjyiD+MCAs8tOvuug66ct+/upU93QBFSDKdC8xW34nGm0Gj2Jr8jUVu30wzC6X/zP7joJaduJIrVsk/KgXjKXKIgy3/tKJg4oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786117108; c=relaxed/simple;
	bh=cV1QgGCFy2l4WDm+WmRY86Rd1B2k0Gq3H/jBDj8QVfQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pYTyhMlvlYbWjatGALiVOtuUzYY+vhoDxE4TFtk7qFeqOO8cef512Pmb8nLBROamjnzEwtV4lsAgkgVlzWUreojCRmlyraK+Xyl5+6LiX9snt1r24lLh8NQOYwViBYi5w61gSHieFwlkzBJ3KjlYgMIa7YlIb1jlXJiul/XceoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UqyvEgKc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UqyvEgKc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A1551F00A3A;
	Fri,  7 Aug 2026 15:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786117106;
	bh=wX8wnn5tWZD1NDyCyctGWv4IdM5dnIRcbylzvy8b18g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UqyvEgKcQ3k7sLhs1kaiJYmklIYdBwG8i3AIFbswCkGb594vTGA4vj/uEsXXIr15l
	 PrEAgf6chOU2t9zPfqzB5sYWwOSJ1Pi3HCXpJoU9cXtDJ5f6XjMcPgxACjBqggDjr9
	 Fi6ZReHtzQGJUT3NGOA+XNaALhz9j3r6k/xNThmEbsF9Ff31f41lmNpS1TiywHbpGq
	 yxaSt4oFZ0aUtA06Qw9bZTER0j0qR+ruN23myetoaBqE3CJ5AVnwKq4GrKBJOQg90o
	 aGI5c88cXXmFTzZd1HR7rgDuAu4ynOzZxcOooAjM+KnC5SHFFPzBC30j+LdDNyqJFC
	 r5PtPy+6XMTfg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V5 12/14] i3c: mipi-i3c-hci-pci: Propagate I3C wakeup
 requirements to PCI
Reply-To: sashiko-reviews@lists.linux.dev
To: "Adrian Hunter" <adrian.hunter@intel.com>
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>, linux-i3c@lists.infradead.org, Frank.Li@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260807145638.168865-13-adrian.hunter@intel.com>
References: <20260807145638.168865-1-adrian.hunter@intel.com>
 <20260807145638.168865-13-adrian.hunter@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 15:38:25 +0000
Message-Id: <20260807153826.4A1551F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] AB-BA deadlock between I3C subsystem locks (bus.lock / ibi_lock) a=
nd PCI runtime suspend.
- [Medium] Dynamically modifying user-controlled sysfs wakeup attribute dur=
ing suspend.

Pre-existing issues:
- [High] Missing child driver bound check and PM API bypass leads to NULL p=
ointer dereferences.
--

--- Patch [12]: [PATCH V5 12/14] i3c: mipi-i3c-hci-pci: Propagate I3C wakeu=
p requirements to PCI ---
commit 84ca2ce77fe5f7e3e2fb196059be4ac7c80842fc
Author: Adrian Hunter <adrian.hunter@intel.com>
Subject: i3c: mipi-i3c-hci-pci: Propagate I3C wakeup requirements to PCI

This patch aligns the PCI controller's wakeup state with the wakeup
requirements of its attached I3C devices. During suspend, it enables PCI
wakeup only if at least one I3C device has wakeup enabled.

> diff --git a/drivers/i3c/master/mipi-i3c-hci/mipi-i3c-hci-pci.c b/drivers=
/i3c/master/mipi-i3c-hci/mipi-i3c-hci-pci.c
> index 5a9e2a43eff8d..42c172e82622f 100644
> --- a/drivers/i3c/master/mipi-i3c-hci/mipi-i3c-hci-pci.c
> +++ b/drivers/i3c/master/mipi-i3c-hci/mipi-i3c-hci-pci.c

[ ... ]

> @@ -272,6 +274,13 @@ static bool mipi_i3c_hci_pci_is_mfd(struct device *d=
ev)
>  	return dev_is_platform(dev) && mfd_get_cell(to_platform_device(dev));
>  }
> =20
> +static bool mipi_i3c_hci_pci_any_wakeup_enabled(struct device *dev)
> +{
> +	struct i3c_hci *hci =3D dev_get_drvdata(dev);
> +
> +	return i3c_master_has_wakeup_enabled_devs(&hci->master);
> +}
> +

[Severity: High]
This is a pre-existing issue, but does this code dereference the driver data
without checking if it is NULL?

If the child mipi-i3c-hci driver fails to probe or is unbound by a user via
sysfs, dev_get_drvdata() returns NULL.

The parent PCI driver iterates over child devices during suspend and checks
if the hardware is running:

mipi_i3c_hci_pci_suspend_instance()
    if (!mipi_i3c_hci_pci_is_mfd(dev) ||
        !mipi_i3c_hci_pci_is_operational(dev, true))
        return 0;

Because the hardware can still be operational even if unbound, the code
proceeds to call i3c_hci_rpm_suspend() and now
mipi_i3c_hci_pci_any_wakeup_enabled(), both of which blindly dereference
the unverified driver data.

>  static int mipi_i3c_hci_pci_suspend_instance(struct device *dev, void *d=
ata)
>  {

[ ... ]

> @@ -287,6 +296,9 @@ static int mipi_i3c_hci_pci_suspend_instance(struct d=
evice *dev, void *data)
> =20
>  	pm_data->dev[pm_data->dev_cnt++] =3D dev;
> =20
> +	if (pm_data->can_wakeup && mipi_i3c_hci_pci_any_wakeup_enabled(dev))
> +		pm_data->may_wakeup =3D true;
> +

[Severity: High]
Is there a potential AB-BA deadlock between the I3C subsystem locks and the
PCI runtime suspend lock here?

The new i3c_master_has_wakeup_enabled_devs() function is called during the
PCI device's suspend, acquiring bus.lock and ibi_lock:

mipi_i3c_hci_pci_suspend_instance()
  mipi_i3c_hci_pci_any_wakeup_enabled()
    i3c_master_has_wakeup_enabled_devs()
      i3c_bus_normaluse_lock(&master->bus);
      guard(mutex)(&desc->ibi_lock);

However, other I3C core paths take these locks first before triggering a PM
operation that requires the PM lock:

i3c_device_free_ibi()
  i3c_bus_normaluse_lock(dev->bus);
  mutex_lock(&dev->desc->ibi_lock);
  i3c_dev_free_ibi_locked(dev->desc);
    ...
    i3c_master_rpm_get()
      pm_runtime_resume_and_get()

If an IBI is freed concurrently while the PCI parent enters autosuspend, one
thread holds bus.lock waiting for the PM lock, while the suspend path holds
the PM lock waiting for bus.lock.

>  	return 0;
>  }
> =20
> @@ -317,12 +329,19 @@ static int mipi_i3c_hci_pci_suspend(struct device *=
dev)
>  	if (!hci->info->control_instance_pm)
>  		return 0;
> =20
> +	pm_data.can_wakeup =3D device_can_wakeup(dev);
> +
>  	ret =3D device_for_each_child_reverse(dev, &pm_data, mipi_i3c_hci_pci_s=
uspend_instance);
> -	if (ret)
> +	if (ret) {
>  		for (int i =3D 0; i < pm_data.dev_cnt; i++)
>  			i3c_hci_rpm_resume(pm_data.dev[i]);
> +		return ret;
> +	}
> =20
> -	return ret;
> +	if (device_may_wakeup(dev) !=3D pm_data.may_wakeup)
> +		device_set_wakeup_enable(dev, pm_data.may_wakeup);
> +

[Severity: Medium]
Does this directly overwrite the user-controlled sysfs wakeup attribute
during suspend?

The official driver API guidelines mandate that device drivers should not
call device_set_wakeup_enable() directly, as this field is reserved for
sysfs user policy.

Should the driver align its hardware PME registers directly without modifyi=
ng
the generic PM subsystem's sysfs toggle?

> +	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807145638.1688=
65-1-adrian.hunter@intel.com?part=3D12
