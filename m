Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4F928E0
	for <linux-pci@vger.kernel.org>; Fri,  7 Aug 2026 15:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786116056; cv=none; b=tYewyHmezP6uQ2J3L3m0dTrBgBbFbKKaXcn/Msai2YlrSglKRQJt2aUPJ7F4ZZcsiSUj88pNCFrsoSvXYiLkkIT6udDAJ9Td5FL5kS5iXwpUrE9oZmoY1WBhMipE4dH/OOvcZNF0ZdLR0mM/WdFGCji/q2MQOwEXJCNHSZtifBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786116056; c=relaxed/simple;
	bh=o1Hn7stDY9Rit/5dBErU0ShIjBp+nVPwsyDrY1tiMl0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iCkiv1z081jUF3N2Nip43Zj98O1OVoz/Kg4AXbMwsJ6ZY8u4+iho1SxA4cONGp2FiG4IbHx0vWvkmnIEI/1CbOIFz3W3gX/I70y702h6EFoqEr5a5HdlL3jZ1GfE/4A6610LJAeQ41AM3g1peZTNePKkWnVOzQ72QbMArbhKlDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EW9UUFsP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EW9UUFsP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A05921F00A3A;
	Fri,  7 Aug 2026 15:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786116055;
	bh=Vcnpw3Ndben+HKH7Or8CpUZ/+7w7p/mmJG/vNPw/V9M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EW9UUFsPD5RRAXPY91RoCuKR6tcLQEA/8eDvPieFdkySw7c5454sMEF2qDmIrdSDA
	 +0hE8nb6jYUKnzsUnMCiL7FkWeK05YKmL1VZ/BqHeYJCrg3GK5J/TJ2nJvSyUBdujx
	 +VkRs6mVsXFtVtFDvUf5NCN6pVxya+W7W4PHJg2GY6R5gogqe8y5+eLDLZ1CswzSuO
	 XwkEK11kmfm6ukmVlhttZp+LUkejG0OCQUYOZqIbKGuz+CB9LhINUAvB2O7XK4HzI4
	 K1lG3o+3g3ai1dWa4QGuVCHQW3SoyTbb7BF+zu1njEI85Sv2rGnfi0g73OHoiT9KP3
	 nqvCDmM+bRwKA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V5 05/14] i3c: Make dev->desc locking assumptions
 explicit
Reply-To: sashiko-reviews@lists.linux.dev
To: "Adrian Hunter" <adrian.hunter@intel.com>
Cc: linux-pci@vger.kernel.org, Frank.Li@kernel.org, linux-i3c@lists.infradead.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20260807145638.168865-6-adrian.hunter@intel.com>
References: <20260807145638.168865-1-adrian.hunter@intel.com>
 <20260807145638.168865-6-adrian.hunter@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 15:20:53 +0000
Message-Id: <20260807152054.A05921F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Use-After-Free and potential information leak in `i3c_device_ueven=
t()` due to missing locks during concurrent device descriptor replacement.
--

--- Patch [5]: [PATCH V5 05/14] i3c: Make dev->desc locking assumptions exp=
licit ---
commit 278282a9eadd6c355b60a12ba9af4c6b5982e144
Author: Adrian Hunter <adrian.hunter@intel.com>

i3c: Make dev->desc locking assumptions explicit

This commit removes an unnecessary NULL pointer check in
i3c_device_get_info() since the descriptor pointer is guaranteed
valid under the bus normal-use lock.

> diff --git a/drivers/i3c/device.c b/drivers/i3c/device.c
> index a3778282e84c2..5e6df6de02834 100644
> --- a/drivers/i3c/device.c
> +++ b/drivers/i3c/device.c
> @@ -101,8 +101,7 @@ void i3c_device_get_info(const struct i3c_device *dev,
>  		return;
> =20
>  	i3c_bus_normaluse_lock(dev->bus);
> -	if (dev->desc)
> -		*info =3D dev->desc->info;
> +	*info =3D dev->desc->info;
>  	i3c_bus_normaluse_unlock(dev->bus);

[Severity: High]
This is a pre-existing issue, but does the same locking rule need to be
applied to i3c_device_uevent() in drivers/i3c/master.c?

It appears that i3c_device_uevent() currently reads i3cdev->desc without
holding the normal-use bus lock:

drivers/i3c/master.c:i3c_device_uevent() {
        struct i3c_device_info devinfo;
        ...
        if (i3cdev->desc)
                devinfo =3D i3cdev->desc->info;
        ...
}

Could this sequence cause a use-after-free if a concurrent device discovery
or hot-join occurs? For example, if __i3c_master_add_i3c_dev_locked()=20
replaces and frees the descriptor while the device is still accessible=20
via sysfs uevents:

drivers/i3c/master.c:__i3c_master_add_i3c_dev_locked() {
        ...
        i3c_master_detach_i3c_dev(olddev);
        i3c_master_free_i3c_dev(olddev);
        ...
}

Also, if i3cdev->desc evaluates to NULL during the uevent, could this
leave the devinfo stack variable uninitialized and expose kernel stack
memory to user space via the modalias string?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807145638.1688=
65-1-adrian.hunter@intel.com?part=3D5
