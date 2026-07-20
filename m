Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E0B3CF661;
	Mon, 20 Jul 2026 10:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784543593; cv=none; b=fwWiO82ef8S3IIy6WWJnGKYGceBG32PuZesOm+SLqebsFKkjzA4KI1Aa54rhLrOWOZ2sAMvXkEt04Ig8BEdLUOQSTC4EvSjfiPwuU0srXwdnDZzQ+VgA9IggrEAQnN+nxUkiIrL0xNZVzARvvluRpV0ISw+EQVPiFE5diYWnmZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784543593; c=relaxed/simple;
	bh=iW8segSJAzxLXvY6MGkdyredDaE/r0nEVFBkwIAH9tI=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=hR7KYXi/bHvUjkGUHfx5Br9TqUhhEPjYDihh0DfRuploXH/n5mDvWL3G/yoimEd38jXEn30pvqJkHL7jpuwaJ4DbcvqcxbhfJndYtsSq8FA1Pff6haYEdT04UWNV0h5dLlP1ZNSjo1Td6wLIaSlyRzRK06BnS5S85/SO3kwu0lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FpLlUTdy; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FpLlUTdy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784543592; x=1816079592;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=iW8segSJAzxLXvY6MGkdyredDaE/r0nEVFBkwIAH9tI=;
  b=FpLlUTdyPV53M7HyCilnslVKlwFR3oRxaGQTANXmHwwJpLU7LDu6Z2L0
   yuFXojOjhs8FLO7qvingI0PM0JL9BaTw9DOrqEad2MbTxBKFDwNSj3k5N
   OstrgCwucoa8GO2xXKQNaZ/WUICuPHTUNgU4W/G1av/oa2cz5JsWMKULL
   i+MMg0tcEfd+nP4eFWupN+eq7h3Iafjt1iiqK2s7bwBQF2xAcIvDhEql8
   JVq2WTnOIi4ccrMP4NLxa7xNPw/FLVuttz2ppay3aMK/XzKy1ke6aD/uN
   Uqlt543QkYFiA2Lll1nv4ribHStOuQoDmUY9D0UZ6jyXhpBt3jGunabN8
   w==;
X-CSE-ConnectionGUID: O66C4lK+R4e1QmGQX0HyYw==
X-CSE-MsgGUID: ceMzmQajTfW2gkB59jpQlw==
X-IronPort-AV: E=McAfee;i="6800,10657,11851"; a="87660202"
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; 
   d="scan'208";a="87660202"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 03:33:10 -0700
X-CSE-ConnectionGUID: lhQ0kntZR/SdiZIn8yAIeg==
X-CSE-MsgGUID: oHhk29h/RJKQaX1WyjaaHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; 
   d="scan'208";a="253475503"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.144])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 03:33:04 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 20 Jul 2026 13:33:01 +0300 (EEST)
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
    "Mario Limonciello (AMD)" <superm1@kernel.org>, linux-acpi@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, linux-i2c@vger.kernel.org, 
    linux-pci@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
    ibm-acpi-devel@lists.sourceforge.net, 
    "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
    Mika Westerberg <westeri@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, 
    Bjorn Helgaas <bhelgaas@google.com>, 
    Henrique de Moraes Holschuh <hmh@hmh.eng.br>, 
    Mark Pearson <mpearson-lenovo@squebb.ca>, 
    "Derek J. Clark" <derekjohn.clark@gmail.com>, 
    Hans de Goede <hansg@kernel.org>
Subject: Re: [PATCH v2 6/6] platform/x86: thinkpad_acpi: Convert to use
 acpi_dev_is_video_device() helper
In-Reply-To: <20260714185915.865396-7-andriy.shevchenko@linux.intel.com>
Message-ID: <d45b8ac1-d05c-7797-efaf-d0ff67cde80b@linux.intel.com>
References: <20260714185915.865396-1-andriy.shevchenko@linux.intel.com> <20260714185915.865396-7-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1215956946-1784543581=:1163"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1215956946-1784543581=:1163
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 14 Jul 2026, Andy Shevchenko wrote:

> Replace open coded variant of acpi_dev_is_video_device() helper.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/platform/x86/lenovo/thinkpad_acpi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/platform/x86/lenovo/thinkpad_acpi.c b/drivers/platfo=
rm/x86/lenovo/thinkpad_acpi.c
> index 6dd7c28fc0db..aaeada46a0e7 100644
> --- a/drivers/platform/x86/lenovo/thinkpad_acpi.c
> +++ b/drivers/platform/x86/lenovo/thinkpad_acpi.c
> @@ -774,7 +774,7 @@ static acpi_status __init tpacpi_acpi_handle_locate_c=
allback(acpi_handle handle,
>  =09if (!strcmp(context, "video")) {
>  =09=09struct acpi_device *dev =3D acpi_fetch_acpi_dev(handle);
> =20
> -=09=09if (!dev || strcmp(ACPI_VIDEO_HID, acpi_device_hid(dev)))
> +=09=09if (!acpi_dev_is_video_device(dev))
>  =09=09=09return AE_OK;

Acked-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-1215956946-1784543581=:1163--
