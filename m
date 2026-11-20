Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795182538;
	b=SgEa/QHCxA1CBTfJg6eaUvghiDrigSdRdDYNRC+QK1Hdr4M9I5KR0j8/DfAIg1hIQG2v
	 ZWmPK/B3lYC9T5fi5OnCWwEBUkZxxj/JPnm2ip8IAw7aGyI1Sd0gmO9jzFv5JZ8QgPW6O
	 HfAvZghqEOKjl0TUXwR1bN9yxbFEzLbKsbEiKuc6iCUrTL45AZ0cL4wr2zXjomS2wztE3
	 vPOxi5pjAX0HswQBt9aEdWmugZyaO6ABekNy+sxVAY9dGiXRYKM1a75Wgy3k+Hok4vqh2
	 s039GEVpenX5ww4SYQMCniR9HSquyzdZx7P/cZlm4aQM2e2/5FVbALZvIzdzv1vammg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795182538;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=42UB2Ic2p8chc4kqJqDtCJDrMo+9cfKrWSIsAADlNUU=;
	b=rV8IDXQI1suT6ilrEPLrrA5OSOtr9mODbUOrbxcPRk9kqovspY4CtLZ/qk5gsk4QOGw5
	 dK8NAIQX0iscLtxqyKhn1GoPQyS7opkOVX5hsqwQ1ToqrIVlMPS+3aKt02JWM9hufJ1UN
	 zKBBQqfs7pQusWqVhM9Ypim3FYYuMxBv7Y1uzu1KLTzepalTHKY/zCBwQM2KT6YorjYMk
	 7BcppcBiOmYO0zO7kciNOv4uU/+vw1LK87m/Bmb3yrwz2fogVjsUQoNYdUn7SfcAsFI95
	 uEv1feuKLSF2CIWlmZVyyJndG9KrKF0O7vjrtNyvLIo5gS9Y5xZ+qTbEXz4PRAm3iqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LKP7hg+0;
	arc=none smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE87606A320;
	Fri, 20 Nov 2026 13:48:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ADE87606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LKP7hg+0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795182538; x=1826718538;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Pu805/VB9qgTUs1axHvJxUAA75GgIK9upAu8081ANSg=;
  b=LKP7hg+0u2Ey0bBCK9nqRAs8+SXrDldwJ6fFZjJv45NoEIAxMopeamVq
   SFXl1ScCRpkjN2CfGInY0LXjnk16m1XpuVQS7XOmlieaRmb5vSyE3Yltr
   +iMhq+EH9d0n0CjA+yL5bjH6Au8XAirJVmT7mlayoCtlkusHDkFXwO86O
   pUgjjegVFeWGgIxcuV8nvP7guz1n8QK0IPVYBVL4xN5BBpFYsi4OD3CP1
   fIFCay9xX/pfpJEisLPvAYIFtinPfRTtEhfjp5klPbhih111i5wkqPYlt
   w9tjnofbGR9nQukpSiiC9PJs/Pyh4jcOIkwjxKkAM6fHH0t6OQHr1EvNR
   Q==;
X-CSE-ConnectionGUID: KqU5ny63Qi6IGFMvkhBxLQ==
X-CSE-MsgGUID: USgW64ecTXKcPIE8e0aACg==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="4063944"
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="4063944"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 05:48:58 -0800
X-CSE-ConnectionGUID: zB+RFflgQnGgPQf0I55Q6w==
X-CSE-MsgGUID: R35LzDKWSAScN94e2NZ8wQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="10785339"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.16])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 05:48:53 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	"Rafael J. Wysocki (Intel)" <rafael@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 09/16] EDAC/i82875p: Convert to pci_assign_unassigned_bus_resources()
Date: Fri, 20 Nov 2026 15:47:04 +0200
Message-ID: <20261120134716.3027-10-ilpo.jarvinen@linux.intel.com>
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

The i82875p_edac driver scans a single device and then attempts to
assign its resources using pci_bus_assign_resources(). That function
makes bridge window sizing disjoint from the assignment phase and is
going to be removed.

Convert pci_bus_assign_resources() to
pci_assign_unassigned_bus_resources() which is likely a no-op in this
case as it looks like bridges are not involved here.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/edac/i82875p_edac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/edac/i82875p_edac.c b/drivers/edac/i82875p_edac.c
index 869de8e372b3..59a92a209dea 100644
--- a/drivers/edac/i82875p_edac.c
+++ b/drivers/edac/i82875p_edac.c
@@ -290,7 +290,7 @@ static int i82875p_setup_overfl_dev(struct pci_dev *pdev,
 		if (dev == NULL)
 			return 1;
 
-		pci_bus_assign_resources(dev->bus);
+		pci_assign_unassigned_bus_resources(dev->bus);
 		pci_bus_add_device(dev);
 	}
 
-- 
2.47.3

