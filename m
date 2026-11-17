Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794930803;
	b=XpY6M+nBYXnJ+aVpbaxWes/0kkJCFAzcTjmFIhxYWMjeKaTPKPNF8VtFitcD6svT34SN
	 dYKdwAUEebyzVxH4AnC1x5ZfEzX4G6WAVgLxyL+N0lKZDwzO3Cdmumtdig7o4BmvzAFk0
	 6/hBN4aA7usVPYgGSpwoRviCPc5ZaYkI/jtPXXCcezy0VbqKpbffYupEiMbL70jvD7M6Y
	 7gUjDrb8rMkxPxW9t0WzRfiBdonxwU2EocQfHndrVplIJjwfHWp5Np08GsknmWoirAzbx
	 RPuaXvpMWTcjWxVTmzLFMaBa60396TzHEvOouo3tcd3S8tmC97o/yrc/Vq6xbfnMDiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794930803;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Subject:
	 From:To:Cc:Date:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=YoGfLQzYye6iX4AGyxZoDCy4EyUcynD1nqduXP0L6nc=;
	b=5bAwUkFJ/2kZI7V/GMtFTPlhk/BmeRHOdk+V0k9sIXGbaCe/oAeapo0L+l56TPi3B2zW
	 s8MRhBixtjQ7S2hkFZIg9a5i7ezaTTc82bCMBbBg+wn1eN0VjP0VDFWccBNGDtaseNHa6
	 /RZYhLTVkEXHrsQe/753mZ2Gxoh7JjnHO9QF06ABO06m0yhRYhFnTjJ5FZplYYUFOYMjP
	 SEv8ju8JDmI/l/l4R+kU8xnEr5TN8+BjcfuD8g7qCHxhuFZszOdDmoq3WnGnrrcb0B7qw
	 H8FmZIbsiPRTTrwsymD7v+xk9BhIK23gDOul+oj9uiPIxL7Eo7Pxjj7ZgIUUl+V1pXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="YbDSVPw/";
	arc=none smtp.remote-ip=192.198.163.13
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007E2606A335;
	Tue, 17 Nov 2026 15:53:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 007E2606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YbDSVPw/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794930804; x=1826466804;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=YL8RJPhb8wIm8l/PgV/HcNdusxj7ZcxDNK3eX4ESV2g=;
  b=YbDSVPw/rQ3dbIJWqbmUWfawK9+ZjUu6IX7hXWQi/Y2Z2ju90y7A2jpP
   HjJhasnCImiOqQru5I/vycL5+pkhcrBxIFV6BdX7jDBJQcjZjViLjgYYU
   Gm5kKg37XGZdUVvmb+KTCcAGs91OxL58H5Z3h/JHBFfyUivEYshsemTli
   iqN7ohltLmDUKNmC37EZ/vANImOFnvuZGQ+rGbqDxuWMMMXooMZygV7hS
   q/3hndXa4o7vexWkQM7wVM0ZyPJxDJ8fGgojFCvnomHv+QOJBxHcqJgmo
   JDOwyAjU6nto9KASo0KRveLkELCZVSgtt40v9J3JHjQwWpacyG8M5/hSp
   Q==;
X-CSE-ConnectionGUID: 6e0lpRYWQJKkZxnpwafyCg==
X-CSE-MsgGUID: y+fkXmUYQBi2/UxpqBlRSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3696803"
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="3696803"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 07:53:23 -0800
X-CSE-ConnectionGUID: 8fPZtEuzR9KHf1veCipCiA==
X-CSE-MsgGUID: zzPu/I4SQF6KT8Zrzsqd1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="9945580"
Received: from aborzesz-mobl3.igk.intel.com ([10.237.140.67])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 07:53:19 -0800
Message-ID: <a8a4b99f7f9c600035019f52a30681d4a7a9ca0b.camel@linux.intel.com>
Subject: Re: [PATCH v1] ACPI: PM: Avoid initializing power management for
 absent devices
From: Alan Borzeszkowski <alan.borzeszkowski@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Linux ACPI
	 <linux-acpi@vger.kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, Linux PCI
 <linux-pci@vger.kernel.org>,  Mika Westerberg <westeri@kernel.org>
Date: Tue, 17 Nov 2026 16:53:16 +0100
In-Reply-To: <6047463.DvuYhMxLoT@rafael.j.wysocki>
References: <6047463.DvuYhMxLoT@rafael.j.wysocki>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Tue, 2026-11-17 at 16:32 +0100, Rafael J. Wysocki wrote:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
>=20
> Commit 2f4ddf2bd1ba ("ACPI: scan: Stop calling acpi_bus_init_power()
> early") removed a device presence check from acpi_bus_init_power()
> which
> in some cases causes power management to be initialized for an ACPI
> device object and never used going forward.=C2=A0 That in turn may preven=
t
> power management from working as expected for other devices.
>=20
> Namely, if a given ACPI device object is not enabled according to its
> _STA, find_child_checks() will return an error for it which will
> prevent
> it from being used as an ACPI companion for a PCI device.=C2=A0 Thus if
> acpi_device_init_power() initializes power management for it and its
> initial power state turns out to be different from D3cold, it may
> stay
> in that power state forever.=C2=A0 If it has power resources and they are
> "on" during the initialization, they may be reference-counted and
> never
> turned off.=C2=A0 If they are shared with other devices, they will preven=
t
> power from going down after attempting to put the other devices into
> low-power states.
>=20
> To prevent that from happening, restore the device presence check in
> acpi_bus_init_power(), but also adjust find_child_checks() to return
> an error for absent devices (instead of doing that for disabled
> devices)
> in accordance with acpi_bus_init_power() and the existing check in
> acpi_bus_attach().
>=20
> Fixes: 2f4ddf2bd1ba ("ACPI: scan: Stop calling acpi_bus_init_power()
> early")
> Reported-by: Alan Borzeszkowski <alan.borzeszkowski@linux.intel.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

Tested-by: Alan Borzeszkowski <alan.borzeszkowski@linux.intel.com>

> =C2=A0drivers/acpi/device_pm.c |=C2=A0=C2=A0=C2=A0 3 +++
> =C2=A0drivers/acpi/glue.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=
=A0 8 ++------
> =C2=A02 files changed, 5 insertions(+), 6 deletions(-)
>=20
> --- a/drivers/acpi/device_pm.c
> +++ b/drivers/acpi/device_pm.c
> @@ -360,6 +360,9 @@ int acpi_bus_init_power(struct acpi_devi
> =C2=A0	if (device->power.state !=3D ACPI_STATE_UNKNOWN)
> =C2=A0		return 0;
> =C2=A0
> +	if (!acpi_device_is_present(device))
> +		return -ENXIO;
> +
> =C2=A0	/*
> =C2=A0	 * The ACPI device power state can be only initialized
> once.=C2=A0 If this
> =C2=A0	 * fails, ACPI power management will not be used for the
> device going
> --- a/drivers/acpi/glue.c
> +++ b/drivers/acpi/glue.c
> @@ -109,14 +109,10 @@ static bool acpi_dev_has_children(struct
> =C2=A0
> =C2=A0static int find_child_checks(struct acpi_device *adev, bool
> check_children)
> =C2=A0{
> -	unsigned long long sta;
> -	acpi_status status;
> -
> =C2=A0	if (check_children && !acpi_dev_has_children(adev))
> =C2=A0		return -ENODEV;
> =C2=A0
> -	status =3D acpi_evaluate_integer(adev->handle, "_STA", NULL,
> &sta);
> -	if (status =3D=3D AE_NOT_FOUND) {
> +	if (!acpi_has_method(adev->handle, METHOD_NAME__STA)) {
> =C2=A0		/*
> =C2=A0		 * Special case: backlight device objects without
> _STA are
> =C2=A0		 * preferred to other objects with the same _ADR
> value, because
> @@ -128,7 +124,7 @@ static int find_child_checks(struct acpi
> =C2=A0		return FIND_CHILD_MIN_SCORE;
> =C2=A0	}
> =C2=A0
> -	if (ACPI_FAILURE(status) || !(sta &
> ACPI_STA_DEVICE_ENABLED))
> +	if (!acpi_device_is_present(adev))
> =C2=A0		return -ENODEV;
> =C2=A0
> =C2=A0	/*
>=20
>=20
