Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795648280;
	b=pZCPJN8MaKQyxwL719L2NdGeme1FkvC+jAjypIQZ+9Rmqy6dtlp6UXq8vC9aqtJ3iedh
	 FWEMY5WceukFi7NWN9ASOnKP+er+Idot1MWOEvESNt2E8Dfqj1lCUPc0lg62vlbOGg9gQ
	 ++RMj8RxRwPtKD5ZdqSsE2VKWIlPSZOV/Smg0MX1ACN05qRVYaVaIJMOl3JH94JAIe6J6
	 2RSoLwdU5SOf2aUkdLQqYPvbVADAWuLr4Gc4gXmaas0MzAgkwECg9KCvJo2maHKLVP8HX
	 g/zEKi6jf0KlBX7cB9V9ApcU1RrQqXqEMaVnpkHdtgMW9d81/gtszMw9GsTfzS6+Jrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795648280;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=42UB2Ic2p8chc4kqJqDtCJDrMo+9cfKrWSIsAADlNUU=;
	b=X9hhf4JVcIu3xeXudMxoHo1ugTXTqg6x4CngcPLphQfZm1Kv3Sm2MJyJHG68E7xPpUZ/
	 qb2dtqq2cQsQ5iATYNIr9ESJeW9H3F7nOTfRUV3Cv9anllL7kH8EkL8C+/rzsmJ/G9MIR
	 IF52cE0idaveeB73FBhDY8urpmwzeGGkGJ5Gp4Ak5wUwbGxiF/S/5mdlEtCEIxkYfnW97
	 iwWlgXhE/bVsIwWyopx8mfq5kRFIJQeVzNPIs5I9lfw1znQDhh6d7afFJ1RKusNEtrvbH
	 0xT2YwijQwiWKy1MZ8pYELraEenHqQ740Avj5C1qyuNzM9+HGPv4GwOp1TMZVHa/5KA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PGDUWx+3;
	arc=none smtp.remote-ip=192.198.163.8
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8E3606A323;
	Wed, 25 Nov 2026 23:11:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F8E3606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PGDUWx+3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795648280; x=1827184280;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Pu805/VB9qgTUs1axHvJxUAA75GgIK9upAu8081ANSg=;
  b=PGDUWx+3B8HdT3Opo6eiEqYDdbdMma9SjwmP22NO2FQzdEP4ADnN+xBU
   C5jU7GzkHXyN2dBY2FlJGNeg4kBpbcE2+hM8LGICBvLo7AONnpi3QSskQ
   5/eBps2WEwOTE90HrbOdRy3bm53nm3YqHGKzyMWBcnKEeLlbuMgeg/QGr
   7zM2NjEhE4VKXFrT4UH5oMkZlDcDxoZCa7k5HOAoSb2HfhRlWaRARFss4
   +ylwf2113y5fYVP+KJXBA5fTp79/KBNLrbiFtuTEqWz8E8wnWLwH3TVwX
   fQUoc29rJN1Ta2WHlQ+MraAlVRNS0FthkrXLJXDwI5IweN4OIqE2AZq9h
   g==;
X-CSE-ConnectionGUID: J/2gQMARTAasvRgQpg4/IA==
X-CSE-MsgGUID: DwfF6Rb1QQKnV7oU1VkA9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11977"; a="4428711"
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; 
   d="scan'208";a="4428711"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 15:11:19 -0800
X-CSE-ConnectionGUID: L9sAHtZXT6SGU+D9l9gJRg==
X-CSE-MsgGUID: tYXCpHvjTPaFYeS/F9aGtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; 
   d="scan'208";a="12323314"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.96])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 15:11:15 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	David Matlack <dmatlack@google.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v3 10/17] EDAC/i82875p: Convert to pci_assign_unassigned_bus_resources()
Date: Thu, 26 Nov 2026 01:09:09 +0200
Message-ID: <20261125230925.2441-11-ilpo.jarvinen@linux.intel.com>
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

