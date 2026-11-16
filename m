Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794842734;
	b=XeQkvHrZAEgAAte9nC1eHEr7/CWC64zYa4mIfknIjIoUsF2HE2ePHCf3kv2P4OM7q0gI
	 +n3NjSasWrNYpwmh1So3IK5ufTqq1Rx9u+gAyzj/EUutyTGRJirRkrJaaQY2HVGNS9uHd
	 tKZaSoPDmiLzilTS+iBobcZVZ+BlUvi1nZ4RKKarqKUzS0iblPx9fIwbxpIC45y2t8px3
	 c+bjMLU9luCaEhRPZ6aCAiuJyKUUzk27zj6TA8MgE0VmEK/cpwVwOuwEoNA5AK5BrQO6M
	 RorDyW10nFU6qEeR5Pp1JLphFuKrQgsRtTTCm4zuiIt2cZY1AqvHOorsrmNMx3LXL/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794842734;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=U95hWLaXh//DahU5mMfEups0YHwavHNdx0fU+yaf6uE=;
	b=AtjRYiFeMg9Jd/WrIjDculCrNDbXo/2ywJrnway4p6mUHhV7sHytPRW26umrDteIBqJf
	 kN1UMaPCTlmAPBP2YYlbEkxuMC/QuQe9Z+DIHrDkVgAe+Xgfy2gSLJ01qx1xh6OADnBYd
	 A4CAfmUvYwafDYgo+6tct/+yiNcPoKFARsF3108goAUscp87ITiwz4/LIPbaTPhP1UXqN
	 uI08DvP97fefAXQ1LNOPbSZlnWO2vqfXHhuFc1mLWZZ6M/y0uSMIttSzB8vEx2/1eORzR
	 /BBHcQ6FAze/y577oFu5pk6Sigf5pXulc5IxDmGbu7y+xbm6DR0UdiY21PvWaQ0BsoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=izlRBF4F;
	arc=none smtp.remote-ip=198.175.65.13
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1C1606A8A2;
	Mon, 16 Nov 2026 15:25:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E1C1606A8A2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=izlRBF4F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794842734; x=1826378734;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=OJiLllQnSpPaZbXS1/FuwdBJuz8qcVSRSn5MsNzxFNw=;
  b=izlRBF4Ft3bAyyFPBTzQlhJ6UBxms3UrQnd5BLbPI58svfsHY465MHfx
   W1EKn5e5XrVXMLQKdDa2PnhwGr0rXhkjagT/qHEVlah5F151krPCxqAEU
   yYYl3A/CTsXkhVZVSkV1xveymB5Lv9lqK3pM1BxkZVorCg8xIfYxJpCDT
   UFjMhrL0CBvVr+GGPcXHUbGC88P3y2d6TF1Os4qkQHLksnky+Z7c7NVJQ
   kx8HsnK6co4Gf8bq0E8aRVy3O6d4eHh2+NObtWDD22P0rr/etgznEjKGi
   flqWbr7HrP0Hqr7wXrwJCBKx8L/gMECbwqtxpGeVDw8P1wHvMHG4f+TOp
   w==;
X-CSE-ConnectionGUID: hSca5uGQRwCmgrT1a5xUNw==
X-CSE-MsgGUID: SVIBQyU2Roq0XcjsvlKscw==
X-IronPort-AV: E=McAfee;i="6800,10657,11968"; a="3457432"
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="3457432"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 07:25:34 -0800
X-CSE-ConnectionGUID: ipXfrt0wTLCR2j/6SW7m7Q==
X-CSE-MsgGUID: YLHJ3GlWSd677DtiJkl6zQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="9769646"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.151])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 07:25:30 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Corentin Chary <corentin.chary@gmail.com>,
	"Luke D. Jones" <luke@ljones.dev>,
	Denis Benato <denis.benato@linux.dev>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 08/13] platform/x86: eeepc-laptop: Convert to pci_assign_unassigned_bus_resources()
Date: Mon, 16 Nov 2026 17:23:53 +0200
Message-ID: <20261116152403.2672-9-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261116152403.2672-1-ilpo.jarvinen@linux.intel.com>
References: <20261116152403.2672-1-ilpo.jarvinen@linux.intel.com>
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

The eeepc-laptop driver scans single device and then attempts to assign
its resource using pci_bus_assign_resources(). That function makes
bridge window sizing disjoint from the assignment phase and is going to
be removed.

Convert pci_bus_assign_resources() to
pci_assign_unassigned_bus_resources() which is likely no-op in this case
as it looks like bridges are not involved here.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
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

