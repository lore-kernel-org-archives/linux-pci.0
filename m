Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795182547;
	b=LUk2VUxP9xrTkL1ITJUSlYUuBCJySxFqU/uffLJXJnl7M9JpIalJ9eDCVEDY9gMcEeC3
	 l+rGhNhw6qEF/VnCqMWhHK5g058ktJo3FJIuBrlvxGEunLFGl6j0zmo+lmZz5lKFU+hdO
	 Hj9K8Rex1ZUiPyVGjOfFcEMcDR1rftezkWqRtE6wJ/GzNeONAMhSWnNkHARcHIasx8bJ9
	 iwlDNDNZvcYRs5Nwu2Hi2K3SDm6yNacQcV57c4bA580slIE8ie32I/3yGVfh7Y/3hX4iu
	 wVuPn1AgqIHEPWQzqlOUWr6nT/VyFVeZaOpsdmuFCwebBhUdU5y+9dj+G4kqV+Kz6pA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795182547;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=i+0u+HqeGmZLWf35gxn5eDoXSBf6DyMSKsWuaoQuICQ=;
	b=ASp705AZKQkmmYHRUpDAWAsygr+hegud++77YLpOA3ShQSNykTDcMrYv9eoZukbqQy5D
	 +T4woIvk5lN8GsZSLoRjubPC0OY1yEOxHT+rcrPjS3fTHnpVHfxJE2Bisa5cpSfPfcL0K
	 i8cQTY9MhAWwzoT9ie3evuDa/lm66ILy+5O274VGrwrMOGxo9T9zd4oe6+C0w1zRkIEgM
	 AsqKJVVvOnYtJdh08MUZJ5S1IVhGi+YsqV7NgtlnFhi73dqcXNj/vgyb+9hb81ejRRatg
	 ba2GAbtOTJHOwYAunCIm4LJ5tFxxGC64q/gWwgHLpgik2VGvEnunQIBpAvY2wnC21VQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="TVdCJ3o/";
	arc=none smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660A2606A334;
	Fri, 20 Nov 2026 13:49:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 660A2606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TVdCJ3o/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795182548; x=1826718548;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=CbIRwVJoGyc+aTQrU4rnggeB4iLRtXrYrCHBACKqLjs=;
  b=TVdCJ3o/Hvnz1TxzN9uvBtpVs8Dca1qiaVohOfPJTQfLR8JYyfBqqBVI
   aydL0f6Xmysr7QamU0jTVm/pxZphs7arfFWi2BpDPuzgQjaTcSyyCpPFI
   6kSv/lYcp3NCdPczQpLGmz4XJIMySufshRr3LzhOXj+i58j1Kojr2+E7o
   EyfLJz/SPwu7JXdaa9uXpAR3S5troFIWTOSHNSurxDhJ5iUCf5vDrrNpi
   HazPmvjL+ZLVg4M5nyKj97Ilrnw+I1J9LaFOw1RmzgBA62PSahENF73c1
   pBTApZ6h5dQcmxy0+xBd+IJHTdiZu4XMbl0gC33pW1yWC3U3QbJ9NkU//
   Q==;
X-CSE-ConnectionGUID: xBSSFAi1TiKJN3KKnaqczw==
X-CSE-MsgGUID: gIvEniqDQ9KVJF1gFWKm5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="4063954"
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="4063954"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 05:49:08 -0800
X-CSE-ConnectionGUID: +HcA6wB4QbGuVEpxu+34cg==
X-CSE-MsgGUID: 6PBaIZcVTduVPTGBaXlK0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="10785345"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.16])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 05:49:03 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	"Rafael J. Wysocki (Intel)" <rafael@kernel.org>,
	Corentin Chary <corentin.chary@gmail.com>,
	"Luke D. Jones" <luke@ljones.dev>,
	Denis Benato <denis.benato@linux.dev>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 10/16] platform/x86: asus-wmi: Convert to pci_assign_unassigned_bus_resources()
Date: Fri, 20 Nov 2026 15:47:05 +0200
Message-ID: <20261120134716.3027-11-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261120134716.3027-1-ilpo.jarvinen@linux.intel.com>
References: <20261120134716.3027-1-ilpo.jarvinen@linux.intel.com>
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

The asus-wmi driver scans a single device and then attempts to assign
its resources using pci_bus_assign_resources(). That function makes
bridge window sizing disjoint from the assignment phase and is going to
be removed.

Convert pci_bus_assign_resources() to
pci_assign_unassigned_bus_resources() which is likely a no-op in this
case as it looks like bridges are not involved here.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Denis Benato <denis.benato@linux.dev>
---
 drivers/platform/x86/asus-wmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index b33ebdb21aa2..9eb783eb53c6 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -2325,7 +2325,7 @@ static void asus_rfkill_hotplug(struct asus_wmi *asus)
 			}
 			dev = pci_scan_single_device(bus, 0);
 			if (dev) {
-				pci_bus_assign_resources(bus);
+				pci_assign_unassigned_bus_resources(bus);
 				pci_bus_add_device(dev);
 			}
 		} else {
-- 
2.47.3

