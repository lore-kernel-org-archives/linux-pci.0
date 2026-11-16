Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794842726;
	b=P58sYg8Afbhlo1Ugk6je8VUF1TJVevgAS0C2IgdM6wdonsNRIYZs0dAHV3mAy+8LDwPY
	 9yiwrjyrDcFKv14lseEO52LDHnXalWOl0G1JHbmlfAVrIoxu3eUeuDwITWpRLVUb7h7M+
	 UHsb4lmRyxvV+kcrR6z1a527QJpheuA4ZP+DJW3KVCBZc2z45KoZOUgnSVz5M5QlJuceN
	 nBvyVVKJq/9vD64LR0fiIhh6L29Cu55MrbQ4/+sAY4Hll69WM6/Gh71JpeaCzaTD+BnA3
	 sskuOT6lso4YhwiIuZJhntMdge65IjNZA/CHmyPzU6N82MK+B9/equeskUspSZ51aMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794842726;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=P7CiCzeZqW6W4HkMqWaCiuH37dTrqVBJZlhiRcSIZNg=;
	b=UMBmS/cXH+VqFwqhnxG3z9zkMoOu+5u3HpLARvnnrvl8jX1jcp76edLzpW4kyNHxTYBX
	 8qZgz/39LRtVo/92JyXLPvHYgCdDeosfcQq0p9WLN8zFit1c4v2eZlYyC9sdOKFnyhpVm
	 Znz87miMxA5ntilfEYblDN9U1j6WBgtdjBGD326orhT7YwvBnlM8Hqh+54pu28Mv6mhgz
	 ghvUJN9ztvCXDanlWyBe7WKmy+zjsLL7BYcA0EnmzA1E8yAGV0+vX6QXfftAfyJDGD1Vi
	 tZTdyiZlMnMy624mrAZ5e5zFsBYWXLS0cRT2+5MUDHsYqDa3NYF+tjpvz0kibgoczSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ADw4HCF1;
	arc=none smtp.remote-ip=198.175.65.13
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C31606A322;
	Mon, 16 Nov 2026 15:25:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10C31606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ADw4HCF1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794842726; x=1826378726;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=VEz6TXDutA1qcIYXRFEeOZWHNXov1jEK666Uhs8dZiQ=;
  b=ADw4HCF1tzPcEIZTr0Hz6X9AlozDdD7Ofa2pIy1N45bPa8YdrLZJ+bxi
   6V8ks28ipGjm8fP0KRf2iroW7yQxvzQCpDXju0Yjgp7r5vIHBYa+jHbq9
   EL4QJk87wvuZqKcTjh8JOTKkiu1/SzESITMP2exedoJSq/Z7TzC3mfPwQ
   9f3JLkYMhHCsGh/3jt81USzZ+nhC8ubeu4x0B6OVfkWtqYDDgSTZoOHbR
   dtVztNS+yr7bP42W1oeDEuJ9uIBfRmYFHdpPY72sPkK7YUf7MFBLGR04u
   vtLiYpxKRTglmm8p5gzHglgQNVUbxgBKaBERGNv3mrYEnAN7qLqW5cSg7
   w==;
X-CSE-ConnectionGUID: HEoRrQDZS7S52wsJci61aQ==
X-CSE-MsgGUID: HDuIUD2YTvGwlilt9vKmLA==
X-IronPort-AV: E=McAfee;i="6800,10657,11968"; a="3457394"
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="3457394"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 07:25:25 -0800
X-CSE-ConnectionGUID: XJq0pCoASDGRivN4KsaTOw==
X-CSE-MsgGUID: C82BCpyHSaCPJN9hdXh7sA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="9769634"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.151])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 07:25:21 -0800
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
Subject: [PATCH 07/13] platform/x86: asus-wmi: Convert to pci_assign_unassigned_bus_resources()
Date: Mon, 16 Nov 2026 17:23:52 +0200
Message-ID: <20261116152403.2672-8-ilpo.jarvinen@linux.intel.com>
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

The asus-wmi driver scans single device and then attempts to assign its
resource using pci_bus_assign_resources(). That function makes bridge
window sizing disjoint from the assignment phase and is going to be
removed.

Convert pci_bus_assign_resources() to
pci_assign_unassigned_bus_resources() which is likely no-op in this case
as it looks like bridges are not involved here.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
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

