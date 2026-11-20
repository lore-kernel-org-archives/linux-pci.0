Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795182557;
	b=Zat875T0PlWG95sECnZDoHqxIEeJst2t5+Nz8w0vpPUfVCQ3D1z9SzWYpvcNm84GjlWG
	 osmSUJclFA+cCLUZNXaU47c5YfeLu7eTWObjQ1TrpSSxFJu8M6XLgeOwQQT9XntNL/LyV
	 ap6fkrcOnIBv1OsXopkaiOgRLZtALlxcg17e+eDDJGwWpqS7WEVRmX1skqMzvOs89sbUl
	 8o+rJeJo0qmFTsfW10Z7cPeotIndmBHvSuLpuFezWSvU9AFIlF3+R0w9KvompimuwJOKt
	 nTIgtoJUaIY16dPCTrA0AWR662qSaUk6QPT/4GfARbglhZMwInvXlY4b4a6gQnv+HQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795182557;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=MP9QmMsbXTFQPJ9QU5BlnHOkG+ttWI/OWTZJkSNJFiM=;
	b=VOQeWWD4/kvVhKADTRDIo/gozREaYOvFC6GVD0OXGfU1XCOevw+Eo5tSppAYnqVvAiBK
	 WU5phYAO6TfTmOOtlYToHYngc/PCbUswQJusiaJMV+Ev1jMhODnElh8PGgjmJjV8HBCWg
	 3Mdbkque/64rKiIcELy9q2eyKiwH9ErfGM5yP7hBtK94nzARglTp1kmSUuaOF8I2hwXVC
	 yE4LGLc38S2KviC7coNqcRCR9kQvUvQftMD7K7RCOxwT9yGGDY9torCApVo2Qox73bgDY
	 b5oKIGtnxNKgM1nx9WEJ3QO+VWObpgMYzLb2NN8AaZQ1eX0tteXbn9hWjc6++wHpjzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=I8QfDasD;
	arc=none smtp.remote-ip=198.175.65.11
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B47606A326;
	Fri, 20 Nov 2026 13:49:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60B47606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=I8QfDasD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795182558; x=1826718558;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=7n4D/gGCRkctEY4AUuCZquiJxQ5vpZYZeGUMpBWFGEg=;
  b=I8QfDasD9dTwXyCqnY2xLFIvvEX19ROyvYpGL6PWPwomV5GbaBdGmtwq
   CCHrI4BbJvcta72hibsNxvVvFpG7pXEMtWUzsbapkVkNy6vsQU7D7itCw
   CoAqzRLU34PsKGWJwkSXg4mOHAJm47secyQ0GMkq52gKz+ASb85U1BHmO
   5SlkU/cYgGYuYoVRENc436yxgkwx0HVFUskyLXhEIMX03L765J7SHIP8R
   KB63jMtOKw7Rf5Tmrq02zzdkWWbLn8xmzSO9gtPlbx3Y4rNosRFhoD9nf
   pYFctF1icLtimDpcqF6A09dB1YFM/wNlbyUkGYRGJ2NzYGNegIG26WD1C
   g==;
X-CSE-ConnectionGUID: L12NhKVCSWiROZYd0WcvRw==
X-CSE-MsgGUID: dj0Z9Tj6RraOPUHboktkJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="3955202"
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="3955202"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 05:49:17 -0800
X-CSE-ConnectionGUID: D01x3tZpRmCL1RBu3pug2Q==
X-CSE-MsgGUID: Bbi1+SOvRUS0z+ZQOoWqQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="10971429"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.16])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 05:49:12 -0800
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
Subject: [PATCH v2 11/16] platform/x86: eeepc-laptop: Convert to pci_assign_unassigned_bus_resources()
Date: Fri, 20 Nov 2026 15:47:06 +0200
Message-ID: <20261120134716.3027-12-ilpo.jarvinen@linux.intel.com>
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

