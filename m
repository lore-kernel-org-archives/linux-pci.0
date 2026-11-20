Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795182603;
	b=v/hOo1inZouFCuZMWP2zXp2+8VyVo/mbSfPOVRceFHk5BndA9ik067i2/8XCx0eLgqsE
	 PeLDdoqbS5ARn5HI8BkdlABUSJmk3MUyg4BgvdRK+4UCDd8FDw+NTYynlZgteGKbT8zpd
	 yUq8jPO1Rcx9afDt5fltxjBMF+YkWaiHk0WzBqJcmxvFeLR9cRXYFmPaQwnUZOhR0JNbn
	 CWXX51ayR4SrBInoYwJGL7nFAvkQgsnPxfKMBcvncHU+rTbQh4vfNSuBQwX6Em5QNWaHC
	 AElOS/nFtdTf/J7j52k2jrMN5RN5umn9UPtwm6mlU+6Nae7Kmg4olHO1bBTW+7sCDnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795182603;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=LuhyowIs9SuZvKiMtBw8uINZsPfExjbAZ0lIUzgkCKc=;
	b=g1zvmmW3NtyywYo1CRHXxY4qAgIkzNi9SjsSo4CiXcdZ4NmXJIXPZiVUPIE1rJSO8u5k
	 ry2vbrdQsOqi8pKZwcCHJWzS9hKOoD7QvQXSpFBH5codII0HwwwARZicANVp11ofstAJB
	 zE2uIRpucn+CZuRJxl3tlLV7UMhA5nXTacwI5DXlM60WlZbWV5g/7N/rs2VOPbiclUY0V
	 gO2Npz1arHoqWxy2ZZyrw+TRjWOmPSJvkXEh5tb1X9nRqmrnkbsNf6rrN16SjdRFzkIJv
	 aH/HaV/5/uCoRuNaRagKJExsRNcqVaAaecTy5qfTQ9sI+yRMXyQmIBFGb3zepkBmsMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EsnDkvPu;
	arc=none smtp.remote-ip=198.175.65.12
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E6D606A32A;
	Fri, 20 Nov 2026 13:50:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4E6D606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EsnDkvPu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795182603; x=1826718603;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=deZ/ZK9VtGKYp50KpfgaLjCIo+vYibEmbudPna1q5Eo=;
  b=EsnDkvPuaZFaCCo1S7gQ5x+KRlJSzYL4TobUrQkcL2GJ1GG/VL7d13U9
   AaqV9EfguvlEl6tr5k/OuOozU68TiocJTTghHfN5YxZ0OjnhSAk3FHDcH
   xO60jefk1LjgwXyiqsiqBsG5ZIKqJkClqlKwpTGq6CJbpdu2LAb3vtisy
   A6JeoS6HxK2TypWkMlFZ1LZNxPk6H7DFVkFh1meuKbgICBbpG6O1Vaklh
   afQEb+2uOs+svwj8DLC1Otlfqa6iSwHO8Yr3J/jDfURcwzh69AAq67cl8
   Rs7Bp/30Lnuj2wPsyJ/L1ZTdR+eNWqeIpZ9lWBuvGc1ibeJmIOSWNmy6r
   Q==;
X-CSE-ConnectionGUID: oD5OMXAATKu8RxnxEAv6iw==
X-CSE-MsgGUID: xqxLRt+SS3asiVrCplWL7Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="3944472"
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="3944472"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 05:50:03 -0800
X-CSE-ConnectionGUID: vpr7u8GkRTuo+DsIXhyB6w==
X-CSE-MsgGUID: 9ZZmNeBuTOyRLPjeI50/Xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="10994195"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.16])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 05:50:00 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	"Rafael J. Wysocki (Intel)" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 16/16] PCI: Remove pci_bus_assign_resources()
Date: Fri, 20 Nov 2026 15:47:11 +0200
Message-ID: <20261120134716.3027-17-ilpo.jarvinen@linux.intel.com>
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

The pci_bus_assign_resources() interface is problematic because it makes
bridge window sizing disjoint from the assignment phase.

pci_bus_assign_resources() is now unused so remove it.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/setup-bus.c | 8 --------
 include/linux/pci.h     | 1 -
 2 files changed, 9 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index c7459662b3d5..0385d61f1b2e 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1578,14 +1578,6 @@ static void __pci_bus_assign_resources(const struct pci_bus *bus,
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

