Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795648300;
	b=v/jlUb2VJn6UH9c46TRc1Dq21untnRKVtO15XYYpnMRwWpPxqEH8XAvdt2UI+eZEHhjo
	 n9hisiKPzy0kfh/m+ULBz6BjpYRw06T2XIeFsSXa4eIslw3lFNB7eJp0HlNcZxVxWelcY
	 W9VdDp+7IMghQA9g+IN4RN7zAR86pHMMX1aGOq4HYG/d9Z0UNOwWX5qvgumHco7+9h245
	 XxwV1QMtVeXp3b2I592iaXWmhGKDpqVSwqH4Y4rv5ERxu5TYwpZvtKioBpD5hkqPPxr+r
	 B9Ee1nbdKI7z+08xMMGW8BEa3vWJNHQPIZec4mQAKI28EBcgA4JNPgaSrzPwPc63XJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795648300;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=MP9QmMsbXTFQPJ9QU5BlnHOkG+ttWI/OWTZJkSNJFiM=;
	b=ylw1+d7myzOjutlXCiNrKOds6xsJYdNDwf9kuDTaR7EtFD8IH2vRC/eIUajuE26SYuax
	 MGnXIOjxM0Ltp+3VkTwpM/FwQkgVIPXqCYW1phA3tsv60K2sbh7f3vbrMHPUZTz833jem
	 FmSIJ7XJrCp/2fb+hCI/igyyvd461XDR80/gjyru713TG9tuOpAVIiQdXOh4QCGvmwrkp
	 ph7Hw5Gp0KdoOaJNeoPEOq+Zo6HTJ89EsP+k5V6tZ7V/UD1KKwpECAQGF0D7j/K8Uutc2
	 rpjWQA3WJ9gJUU5O1X2cM/tPlRhUsideXPyUVMCY7zi3c62dlXrxERWO6s4lyl+7hBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="jXIRUHO/";
	arc=none smtp.remote-ip=192.198.163.13
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95B2606A33B;
	Wed, 25 Nov 2026 23:11:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B95B2606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jXIRUHO/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795648300; x=1827184300;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=7n4D/gGCRkctEY4AUuCZquiJxQ5vpZYZeGUMpBWFGEg=;
  b=jXIRUHO/ssFFl5YsLTyTNBnqSvhxQhaRiD1BMMJH8uwRW0HwEEyxK6wn
   JADGW5lZwdVwvFWK+VLqOC5DSFXHStTAz/nEh9ekq28MQ/XmQvy/4LhUt
   JuUW21z2K4z0WL4LPn5b06FizyolEUCbA3XHSwLLABPuxVr865hE35Of2
   B3H5R8pbG7jCpvzYV12auUTv1IZ1TBlRzpsLYoVXNJU7dh6X8E7FryRSi
   iyHZP3qXHArEfeYL0nO6uVgjrFgUkTgNn+Os/gte1EX2tJIyrvHpe/nze
   B/6Y7J6FGS6WQr7Sf7tYBRO30fXxilfAJ7vgkUmIlJ1yJ3N+nYbSpxEMO
   g==;
X-CSE-ConnectionGUID: lj3l4wcmSKCxBqIx9+WKhQ==
X-CSE-MsgGUID: /aZ0lOlzQgqWDralN/lf6A==
X-IronPort-AV: E=McAfee;i="6800,10657,11977"; a="4515592"
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; 
   d="scan'208";a="4515592"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 15:11:39 -0800
X-CSE-ConnectionGUID: xl8UzVBqTfGxfH/T0JCzSw==
X-CSE-MsgGUID: kkEhdHpVTpOa9L248DYMyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; 
   d="scan'208";a="12309384"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.96])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 15:11:34 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	David Matlack <dmatlack@google.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Corentin Chary <corentin.chary@gmail.com>,
	"Luke D. Jones" <luke@ljones.dev>,
	Denis Benato <denis.benato@linux.dev>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 12/17] platform/x86: eeepc-laptop: Convert to pci_assign_unassigned_bus_resources()
Date: Thu, 26 Nov 2026 01:09:11 +0200
Message-ID: <20261125230925.2441-13-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261125230925.2441-1-ilpo.jarvinen@linux.intel.com>
References: <20261125230925.2441-1-ilpo.jarvinen@linux.intel.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The eeepc-laptop driver scans a single device and then attempts to
assign its resources using pci_bus_assign_resources(). That function
makes bridge window sizing disjoint from the assignment phase and is
going to be removed.

Convert pci_bus_assign_resources() to
pci_assign_unassigned_bus_resources() which is likely a no-op in this
case as it looks like bridges are not involved here.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Denis Benato <denis.benato@linux.dev>
---
 drivers/platform/x86/eeepc-laptop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x86/eeepc-laptop.c
index 8a640c25830a..7394221cbad1 100644
--- a/drivers/platform/x86/eeepc-laptop.c
+++ b/drivers/platform/x86/eeepc-laptop.c
@@ -609,7 +609,7 @@ static void eeepc_rfkill_hotplug(struct eeepc_laptop *eeepc, acpi_handle handle)
 		}
 		dev = pci_scan_single_device(bus, 0);
 		if (dev) {
-			pci_bus_assign_resources(bus);
+			pci_assign_unassigned_bus_resources(bus);
 			pci_bus_add_device(dev);
 		}
 	} else {
-- 
2.47.3

