Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794842779;
	b=PNqqCeCVRTEIs1bDGdvSVRJDI5jfJ4Q18QoJFx3Eb0jhyIV0jHr2cIRACfeSZFmXvw4a
	 JFUCmQ08m4cnc7444uY0lkINln2wQfIwxzElp41tn3csrrYuPEjuZkqOX90nYnrlq13wf
	 wJp/726CQXb+wsgF4KCoSyiCm7Jl9EZmffsp504OAa95HAb5C62k7JVZTwCoCf1d3VEjF
	 ct6rlhEJNQdsrRDIjWgNXyTQ0hjy+PzvRNEf2v9kQ/RtPCOBtzipO4hzlYKQsseVNUhSj
	 397fny5+jOsHPv7wDr0CKWMg4HWgKg+qEBMBuOJuqQPM/SDzNhAQAklr6PewJXUPgwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794842779;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=mgH4R7B/B7UL3kVmlTJYLWidiBNciAWNe4D+qCoXewE=;
	b=qZigh9N2uDe7xgPdvcL/fAY0k4S3A9TAqtGUZFXtEnGbiBup9SfVJocJUA10etJk/Qw0
	 jgDUgwO+7yLCl96D5o0IyIfZbKBFKunk8ZcPTWuW7sxyFW0rlCU3XbGuGvL6ExRc/i97a
	 s63EtIy9k8/YRXtlsXKjizDbGum0yn7Ki1x8UMRUii5aeoCX+roZaLKrXlGjQMR2Z+ES2
	 PdEkHg0U3EdJNjdfOoOnqEmZ8GhjP44c+59ExvrnBHVNM0kk5S7UsJQRNMMckwv2OGpWd
	 TZBiVqd8qvl2ilzTA9iAeXr1g42YhYvIaafqSEf5n4NKO40boRPwDzUy6RmmM6uG8RA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="e+XEWA8/";
	arc=none smtp.remote-ip=192.198.163.18
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F1B606A322;
	Mon, 16 Nov 2026 15:26:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9F1B606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=e+XEWA8/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794842779; x=1826378779;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/XGgUUp5Cp+6vo1XMG5uxdlFzPP8UloQOwt0PdpOt5g=;
  b=e+XEWA8/gzdRM/nfylMdmuKkJDTIQylRLA3MB75f/CzWgMStue+pQzv5
   FF9WEUF7TvsVowaPNt6cuj0+N1PkzPE4jj3+9gMPykyYvD/Sxx/CP1ud7
   FmzY9x5Ahp6nmf0tNKJ2G3Rq/GBM6+HXY/adMu1ZgNjZXq9sOCoHaGAEE
   NqIMSB01jjrZr4CeZWNYjlaq8xkNj6g9Lk0KKEbUHwOkw0aQk1q/2zD0R
   jfr29G9u6Cgpa3zV0p/kNdfJ6gBY9DzWBtuAbqAaJQ3xAzZFPydHncR2w
   fgeC8bPskr8I0eW698helmfxug0bJLI6FTyWu3oM1KY/18WytCBlgTJuY
   w==;
X-CSE-ConnectionGUID: PQBEYZAORvqDJ88jOQWlmw==
X-CSE-MsgGUID: u9Hh+0/GSTS7olfZWlaubg==
X-IronPort-AV: E=McAfee;i="6800,10657,11968"; a="3614267"
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="3614267"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 07:26:18 -0800
X-CSE-ConnectionGUID: Xk5kW3R9TIegzQ1RNvHBWw==
X-CSE-MsgGUID: ksZYac7lQFencKsROnkNNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="9504969"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.151])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 07:26:16 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 13/13] PCI: Remove pci_bus_assign_resources()
Date: Mon, 16 Nov 2026 17:23:58 +0200
Message-ID: <20261116152403.2672-14-ilpo.jarvinen@linux.intel.com>
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

The pci_bus_assign_resources() interface is problematic because it
makes bridge window sizing disjoint from assignment phase.

pci_bus_assign_resources() is now unused so remove it.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/setup-bus.c | 8 --------
 include/linux/pci.h     | 1 -
 2 files changed, 9 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 314c649c648f..547d0f920360 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1575,14 +1575,6 @@ void __pci_bus_assign_resources(const struct pci_bus *bus,
 		pci_dev_res_free_list(add_list);
 }
 
-void pci_bus_assign_resources(const struct pci_bus *bus)
-{
-	guard(mutex)(&pci_res_setup_lock);
-	guard(rwsem_read)(&pci_bus_sem);
-	__pci_bus_assign_resources(bus, NULL, NULL);
-}
-EXPORT_SYMBOL(pci_bus_assign_resources);
-
 static void pci_claim_device_resources(struct pci_dev *dev)
 {
 	int i;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index d89aeb7c9ff7..7d71ad6d89af 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1566,7 +1566,6 @@ ssize_t pci_write_vpd_any(struct pci_dev *dev, loff_t pos, size_t count, const v
 
 /* Helper functions for low-level code (drivers/pci/setup-[bus,res].c) */
 resource_size_t pcibios_retrieve_fw_addr(struct pci_dev *dev, int idx);
-void pci_bus_assign_resources(const struct pci_bus *bus);
 void pci_bus_claim_resources(struct pci_bus *bus);
 void pci_bus_size_bridges(struct pci_bus *bus);
 void pci_bus_size_and_assign_resources(struct pci_bus *bus);
-- 
2.47.3

