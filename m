Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795648290;
	b=m8ftiFtl4jaueGHb4Ck1iRlikC29OPqBZ+aVdsBdEaQ3MDA7E3z8uh1/wujAq5HcBnjT
	 f0J75H2zMm0/rfMGBhGAmSymACwRKS9FY7unOWlKJlprq/Wlwnyo/8eWj0hk+37CPhnzC
	 kmUJ3VWI4ppo4B5HoupzhnOUmyWGH7CBUW+lOiF6KIYpiEj9yz1YOuslVehEHf2l5/kPQ
	 libtF3ZNSbkeBysObIhh+wo21yGw+UpguFRH0owApGrRQZ2/lV6a8f0yY+moPPN4JDfzw
	 DN/V/SoMFcaLQMJheafDzfWzREBYIaLYbVvrOjOQDkhsFWtlfNUdn7LSrbB0rga0jUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795648290;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=i+0u+HqeGmZLWf35gxn5eDoXSBf6DyMSKsWuaoQuICQ=;
	b=vH1zNHZqD85V6H+fmyw0JuDuLpjoIGa2jYUeFzoTjREcIc09iAbqy0pfYk2PicWxAUQO
	 mTCLbRikKYIl801cZ/hbgExR6w+PszctGvVYbYmxL80fQZv9SuvVTZ8KOHPdvcmbWxWAi
	 bVkS8cuLyu9F0MxlHjG3Oy51Q+8XYlvn1xKigbLPP7+FTieB2gAEU+QPfe9WFMOOI3gVy
	 QyGWbzcCaoq5FZV18Fpr8djpyAelHR++NZIA6iqFou1B9p2QXIOr+PxgzKWFwq69cpDJv
	 FLX+2Aq5Yhxpj7OZGTAsSGArEeXUlFXSUp0OLhG/I2Ip+M8Tl2a4FPHj6ElBND2yGbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=XPsDlx1z;
	arc=none smtp.remote-ip=192.198.163.13
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D98606A31E;
	Wed, 25 Nov 2026 23:11:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4D98606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=XPsDlx1z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795648290; x=1827184290;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=CbIRwVJoGyc+aTQrU4rnggeB4iLRtXrYrCHBACKqLjs=;
  b=XPsDlx1z9HPc0Z+XY4epezM3If1l8tXCP1LgcFSr2Rm/ZsWBk9wKQs1c
   KICT9Bmn3oEhzrlHopVavj+orWrv2OOd8voAO0qw+ku59WTgUJd9hHuO4
   FdQYtve+uzX44yD+A+3mRK3yAAD36uWUllidgVHvKMOYlwluE5t+NyOeh
   PGhK0w1GUpJiC8FYvK78KhFcEacS5woz0XY7LTIV1n4e+DfxOsWolLZAj
   V2n5kAF2B+j8+LfocFeTdNylxZU4uMrkyomb9WXPf6GcDmvvuZC4mVhow
   0HOhsQVhKVK22fsKx+FHShqemTNYtT+jltdtqsZMMnUPI3ERWO0xOf6qg
   Q==;
X-CSE-ConnectionGUID: r1PHRXtbQRm5cP3/tzU5lA==
X-CSE-MsgGUID: hS3yg7cKSeK2GyRFyBguOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11977"; a="4515589"
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; 
   d="scan'208";a="4515589"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 15:11:29 -0800
X-CSE-ConnectionGUID: HVLI6yG4Tm64sNrUPvvzqg==
X-CSE-MsgGUID: G1yppDUXRA+sTdzAbEf6mQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; 
   d="scan'208";a="12309352"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.96])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 15:11:24 -0800
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
Subject: [PATCH v3 11/17] platform/x86: asus-wmi: Convert to pci_assign_unassigned_bus_resources()
Date: Thu, 26 Nov 2026 01:09:10 +0200
Message-ID: <20261125230925.2441-12-ilpo.jarvinen@linux.intel.com>
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

