Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE4870836;
	Mon, 20 Jul 2026 10:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784542890; cv=none; b=BjirE1anMHg61f4b+GO+HT9yBQl3ejUGsAH0qzXJVwzomuKQc2T6rn5W+T/mdgh4cCjC3YQVilYqlH2rLqclewpHAZ6H54JOoyhJDr2CuGfXq+wKhTUN42RfNCiCzWXC4qNVAVjd7wzSAwsIaKAsmnzXADSNZ0pqltL0IpGaYv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784542890; c=relaxed/simple;
	bh=IEYtAhDP9AKyw2q9dM8dBIwi4SqLMEN62hUkjQb9GPg=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=HB12UAK4AHROq3HwwCxzKpu7X4HhTdzpu5p6tMsuWk967jYRGLWv6cYfW6cr4qDCdbyGuje9vOQ+dbbvKxRm590rAN52xyR4QOvGs/0N6nZVBfu2kLchdjcnXGzwaGAS/x/s+a9sFnVEOgcyR9ZCEhlzEmfcBt3D0GaMCvQpLoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QBER/Eh+; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QBER/Eh+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784542888; x=1816078888;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=IEYtAhDP9AKyw2q9dM8dBIwi4SqLMEN62hUkjQb9GPg=;
  b=QBER/Eh++AXAWUmuxV6M2YfeZZchV+eH5oV19MWgeN4PDoc1qIP7ey6/
   0lL63gmGf9xirfRi2YejGv5o6mdeSl8VGwmNsqbfSM9yV1+2fRNhnlacU
   f/EXJdygl6bP4ie3D1iR2ltA2i4sYWtoG2EPZlTBrbVEGo83O7VmohqWp
   +4DhFr0N9wH/7Dzp//30dOuWOukRwFXYkvrVkwSb4Wq0fo+MLeCgeHnTQ
   M/khNvsRB+PNu0+awLFI7/1irjwsRwethT3+HMt1mZXk1Xm6WiWgUocyh
   bJDURi77ur5FPIrPHXuYn43VUwlkvE6S037mWwnuvFmFw5rCAU0F+4ro7
   A==;
X-CSE-ConnectionGUID: 3zHVcrEPQsq2acLLrKOx+Q==
X-CSE-MsgGUID: FvGWD9kXRCaCiyncbaPnHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11851"; a="85070423"
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; 
   d="scan'208";a="85070423"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 03:21:28 -0700
X-CSE-ConnectionGUID: mE56SO8BQ7G4ptpgXi3GVg==
X-CSE-MsgGUID: Tt5Z+EJWRj2IgUuLXJ5pdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; 
   d="scan'208";a="260984730"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.144])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 03:21:25 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 20 Jul 2026 13:21:22 +0300 (EEST)
To: "Rafael J. Wysocki" <rafael@kernel.org>
cc: Linux ACPI <linux-acpi@vger.kernel.org>, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    Linux PCI <linux-pci@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
    Bjorn Helgaas <helgaas@kernel.org>, Hans de Goede <hansg@kernel.org>
Subject: Re: [PATCH v2 1/4] ACPI: PCI: Use a mutex guard to simplify
 acpi_get_pci_dev()
In-Reply-To: <3056272.e9J7NaK4W3@rafael.j.wysocki>
Message-ID: <ab954902-7449-b466-717b-ded704b720bb@linux.intel.com>
References: <12935400.O9o76ZdvQC@rafael.j.wysocki> <3056272.e9J7NaK4W3@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1960098908-1784542882=:1163"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1960098908-1784542882=:1163
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 16 Jul 2026, Rafael J. Wysocki wrote:

> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
>=20
> Use a mutex guard in acpi_get_pci_dev() for the physical_node_lock
> locking and drop local variable pci_dev that becomes redundant after
> that change.
>=20
> No intentional functional impact.
>=20
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>=20
> v1 -> v2:
>    * Add cleanup.h include to pci_root.c (Andy)
>=20
> ---
>  drivers/acpi/pci_root.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index 4c06c3ffd0cb..d0dafc38b0cf 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -8,6 +8,7 @@
> =20
>  #define pr_fmt(fmt) "ACPI: " fmt
> =20
> +#include <linux/cleanup.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/init.h>
> @@ -307,24 +308,20 @@ struct pci_dev *acpi_get_pci_dev(acpi_handle handle=
)
>  {
>  =09struct acpi_device *adev =3D acpi_fetch_acpi_dev(handle);
>  =09struct acpi_device_physical_node *pn;
> -=09struct pci_dev *pci_dev =3D NULL;
> =20
>  =09if (!adev)
>  =09=09return NULL;
> =20
> -=09mutex_lock(&adev->physical_node_lock);
> +=09guard(mutex)(&adev->physical_node_lock);
> =20
>  =09list_for_each_entry(pn, &adev->physical_node_list, node) {
>  =09=09if (dev_is_pci(pn->dev)) {
>  =09=09=09get_device(pn->dev);
> -=09=09=09pci_dev =3D to_pci_dev(pn->dev);
> -=09=09=09break;
> +=09=09=09return to_pci_dev(pn->dev);
>  =09=09}
>  =09}
> =20
> -=09mutex_unlock(&adev->physical_node_lock);
> -
> -=09return pci_dev;
> +=09return NULL;
>  }
>  EXPORT_SYMBOL_GPL(acpi_get_pci_dev);

Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-1960098908-1784542882=:1163--
