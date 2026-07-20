Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A6B3033E8;
	Mon, 20 Jul 2026 09:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784538258; cv=none; b=LDaBlOEcztOY/mroQK8u4yQlNp9/4SYRosg7pzQhuOE28MG+TMAnlPwuDpNIWSWikzmvFfKQyn7i1dcrGTZxArD/oj6d/WCXV1b+NYurIvDCTJu+HtSf2QWnXUDbqaIj9Y4DJv6wuPcGzYeC8elnYSu2d7PSLITZ53RraZKOLBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784538258; c=relaxed/simple;
	bh=xyCHaSjn1yOlwJ5KkBir83g/RQYScFkZE/pjrgokSTI=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=AzY7RxYzLTnFAXCn2jKqx+jlf4q6ZMrE2HiEZJmTT4e9svMIJy0Y4Yymo6yPAdtMXJKVNh7gSkZauW6O+IgFXIcAHPVVyC+RxiO0y8KYvFzf3M6D0HMqzvrKirruGYRA6howxZioeSlbvrcUPMSpoZ2hEpAomtvwo7ETAB+lrrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F3mrCNys; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F3mrCNys"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784538256; x=1816074256;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=xyCHaSjn1yOlwJ5KkBir83g/RQYScFkZE/pjrgokSTI=;
  b=F3mrCNys0IdedN91ZL5opffImXk4tu/H9YXopu0hRk7HzEc26gytBn9z
   0w9WF90aIeNWRPRLS/2PfG9dupC5Xf/+6MWHriVFnqokp1dU+XZqQ3l2X
   hXxOKEQNJrx9LE5o4+IhK3yUD4gaRUjMgrVDXfoZFJbymDrgW4dz4BRfd
   b8nx7P0kjRIvx0aHrgp9VF90Wno/epONLTJ1kpbBhVIZJUUf4M0m/iAeJ
   0XI5lzYkACIMEnJ4FOYIFJjwsuF1pKVymBiNWULoJrflSJWlLDpb5mQU2
   N+ZiJvjoOF44rJmH6/JVXE/mAbOWDR4AAsZ1DH4l1XMltlqhFTRrxG5+t
   w==;
X-CSE-ConnectionGUID: 7K/ixwX5Sf+CCOIJD8lRSg==
X-CSE-MsgGUID: MBeBW96MSCKZSigbWuAkFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11851"; a="72649849"
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; 
   d="scan'208";a="72649849"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 02:04:15 -0700
X-CSE-ConnectionGUID: Phty1itVQ8SaM4HA1Gq4lA==
X-CSE-MsgGUID: EMhUVxyxQzGYj4LjoCG1uQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; 
   d="scan'208";a="258044056"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.144])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 02:04:07 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 20 Jul 2026 12:04:04 +0300 (EEST)
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
Subject: Re: [PATCH v2 5/6] PCI/VGA: Convert to use acpi_dev_is_video_device()
 helper
In-Reply-To: <20260714185915.865396-6-andriy.shevchenko@linux.intel.com>
Message-ID: <c7c0e201-0b34-ac87-232a-548b0307969a@linux.intel.com>
References: <20260714185915.865396-1-andriy.shevchenko@linux.intel.com> <20260714185915.865396-6-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 14 Jul 2026, Andy Shevchenko wrote:

> Replace open coded variant of acpi_dev_is_video_device() helper.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/pci/vgaarb.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
> index c360eee11dd9..3de05aee7859 100644
> --- a/drivers/pci/vgaarb.c
> +++ b/drivers/pci/vgaarb.c
> @@ -575,9 +575,7 @@ static bool vga_is_firmware_default(struct pci_dev *pdev)
>  static bool vga_arb_integrated_gpu(struct device *dev)
>  {
>  #if defined(CONFIG_ACPI)
> -	struct acpi_device *adev = ACPI_COMPANION(dev);
> -
> -	return adev && !strcmp(acpi_device_hid(adev), ACPI_VIDEO_HID);
> +	return acpi_dev_is_video_device(ACPI_COMPANION(dev));
>  #else
>  	return false;
>  #endif

How about adding a stub for acpi_dev_is_video_device() if !CONFIG_ACPI 
so this code can do without ifdeffery?

-- 
 i.

