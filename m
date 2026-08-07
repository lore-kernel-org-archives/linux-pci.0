Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ADA241DDF3
	for <linux-pci@vger.kernel.org>; Fri,  7 Aug 2026 15:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786115643; cv=none; b=toYc5Uj+R7NSpc3YQB/wCPkWPTQlFRkKCaE6BBkFGJNzSAtElripJ+iF/r/GwQO6qCxF7lbcHXVilzPPMTw32xmMCTWpxvchiNw+lVjpbWubi3n3fKhsH51gHL9FzItJvV9MhSC4EpK4HorVVBdz3UnXO7Zjo05EdhuyXSVg+N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786115643; c=relaxed/simple;
	bh=UO01WflE6dFaN1f8ivnoJjK2eyJH32/59M80sagQhpY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oaTJHAJjZ+C4QoLdfuR1XwcNP1EwtxczSpWj1n3IDmttNTMai20nOKYIjNNup/a8RmEPDkUScFkkRTFjjckZf6C1NEBg8AMk+Nv/qZlL3W7VckjacxxCfJt+TBW3JLW0ZvrAKg7KpL9xTsVOntGX/SKlCCrea4bboqGjk9q+TFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V47o/WVl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V47o/WVl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ACEF1F00A3D;
	Fri,  7 Aug 2026 15:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786115641;
	bh=DhdB/UGVLYJ89IcMlowUAfjwOsMPFcyVrvw9QolcNno=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V47o/WVlHMz+xbJYF8F+RIZRy6049k0qQeRN9/GM3/1FKgzyJDl9HH6Qr+tCnGHxz
	 ab9ajQgP4SlLrmRW5Sifkp0z+og3bJ5Ol+kVcHZFczzRcRR68Kole9josJ6al9NyHF
	 vc1n/LffZZcq/uDBDrjgZzbnLgiGKYtCqkcCJ1xn6t1ERYXkalVossTUF/12veoC0a
	 Qv/0JkRpDjyucwasEJvPHHVGgitCH/snDjwcGyp3CKY9L2JtU5TJIfKkyJtO+Pefef
	 SsVrxRombemPEQLLjx6eMB8NGJ0KTrFURgJx0H3qSB+Y2jLcCuHb4pEiwlBl6cOzOc
	 DalNIx8TMg9ag==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V5 04/14] i3c: master: Fix use-after-free of
 master->this
Reply-To: sashiko-reviews@lists.linux.dev
To: "Adrian Hunter" <adrian.hunter@intel.com>
Cc: linux-pci@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, linux-i3c@lists.infradead.org, Frank.Li@kernel.org
In-Reply-To: <20260807145638.168865-5-adrian.hunter@intel.com>
References: <20260807145638.168865-1-adrian.hunter@intel.com>
 <20260807145638.168865-5-adrian.hunter@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 15:14:00 +0000
Message-Id: <20260807151401.8ACEF1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Pre-existing devres lifetime mismatch causing Use-After-Free in i3=
c_masterdev_release(), exacerbated by the patch's newly added kfree().
- [High] Pre-existing IDR state corruption due to missing error handling ar=
ound i3cbus->id in probe failure path.
--

--- Patch [4]: [PATCH V5 04/14] i3c: master: Fix use-after-free of master->=
this ---
commit aad15513dbf2d559bf893789d55a331f522383d1
Author: Adrian Hunter <adrian.hunter@intel.com>
Subject: i3c: master: Fix use-after-free of master->this

The patch fixes a use-after-free by keeping master->this alive until
i3c_masterdev_release(). It also resets master->this and bus.cur_master to
NULL on the error path in i3c_master_set_info() before freeing the
allocated device.

Cc: stable@vger.kernel.org

> diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
> index abb582645a2ed..2357874bb9d6a 100644
> --- a/drivers/i3c/master.c
> +++ b/drivers/i3c/master.c
> @@ -842,6 +842,11 @@ static struct attribute *i3c_masterdev_attrs[] =3D {
>  };
>  ATTRIBUTE_GROUPS(i3c_masterdev);
> =20
> +static void i3c_master_free_i3c_dev(struct i3c_dev_desc *dev)
> +{
> +	kfree(dev);
> +}
> +
>  static void i3c_masterdev_release(struct device *dev)
>  {
>  	struct i3c_master_controller *master =3D dev_to_i3cmaster(dev);
> @@ -854,6 +859,8 @@ static void i3c_masterdev_release(struct device *dev)
>  	i3c_bus_cleanup(bus);

[Severity: High]
This isn't a bug introduced by this patch, but does the error path in probe
corrupt the IDR if idr_alloc() fails?

If idr_alloc() fails in i3c_bus_init(), i3cbus->id is not updated and remai=
ns
at its kzalloc-initialized value of 0.

The error path in i3c_master_register() calls put_device(&master->dev), whi=
ch
invokes this i3c_masterdev_release() callback.

That unconditionally calls i3c_bus_cleanup(bus), which executes
idr_remove(&i3c_bus_idr, i3cbus->id). This effectively deletes ID 0 from the
IDR, even though that ID might belong to another successfully initialized b=
us.

> =20
>  	fwnode_handle_put(dev->fwnode);
> +
> +	i3c_master_free_i3c_dev(master->this);

[Severity: High]
This is a pre-existing issue, but can this devres lifetime mismatch lead
to a use-after-free when sysfs files are held open?

The i3c_master_controller struct is typically allocated via devm_kzalloc()
by the parent driver. If an unprivileged user holds a sysfs file open (like
the mode or current_master attributes), device_unregister() drops a
reference, but the sysfs node prevents the kobject from being released.

When the driver is unbound and remove() returns, devres frees the master
struct.

Later, when the sysfs file is closed, the refcount drops to 0 and
i3c_masterdev_release() executes, dereferencing the already-freed master
struct to access master->wq, bus, and the newly added
i3c_master_free_i3c_dev(master->this).

>  }

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807145638.1688=
65-1-adrian.hunter@intel.com?part=3D4
