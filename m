Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680694E9C1F;
	Fri,  9 Oct 2026 15:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791560445; cv=none; b=PmD69/3PshgsqUDzmVyWeTpOCQ9LrahfsFTWTKgK0kD/k5wyE+MZFVWRV7Wsm80Y9EhkSnyr0dzb8/q8jqWT5hMbXLzd2V8KieUmQNsTPdf5gUlM9M2Uos++EJGCkxX9vEYXZ/nUDEftb3mmR4ZYMwh0oULt1CmLADZdfn/M7NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791560445; c=relaxed/simple;
	bh=0He91j+NLkc6ay6xB5gisdcSQfhw4mLqqGXjqh3X+wQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i/6PON9+yuLsgU4eDk8aLJRVDQcI0XyDdh7xv/pOGxF8ZL7Q8f0nJxTDbWoPJwuimNYzcajDzE8uXNZSwrJGJB6dx3hzRMBj05crXvEdclRIoJGY9OE3zwSICFbv97NlAfagWIqPx8tVWgpLwpVfKOCZjwqMmlRrAlXIb5+3Ejw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=laZe3h8O; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="laZe3h8O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791560442; x=1823096442;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0He91j+NLkc6ay6xB5gisdcSQfhw4mLqqGXjqh3X+wQ=;
  b=laZe3h8OdHwIa3DJtEqZ4cG2bGuITMoTJfnDUj0mScsD6GXqjhi4oCUV
   cj8G/p5fZjLLLo+lYP1WfiqQdVnz2Vhwg80Cg9RR3s+FenqgWOdCl2My4
   nUcH1xdwBEKkboGMMj8nvijv1F2rsmQubQyuaWsgEg6OfAZttmFDxP2Od
   PgmChXNQf0k0TUoGqfmaRAj6DH7AoSwdla/titEvMkXSxE77yhOMym0A+
   pwUkK7lH5pnEo1asNIYKU4Q4I6k4rGQDOMkOXziTvpAV9Wi04R/vn/lmq
   ZkjNUTrGaQQQWPzXlAU0MYJJFJOq4neRSnDMHsuD4U2SEx5S4uxgBU8Xx
   w==;
X-CSE-ConnectionGUID: BwQ0FHkbQ1evoexzJ2WiOQ==
X-CSE-MsgGUID: qWllO0FKTyK8507/rD7nSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="255208"
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="255208"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 08:40:37 -0700
X-CSE-ConnectionGUID: qFJgp2eVTCGPokh+9mlZ6w==
X-CSE-MsgGUID: 9n3Zv15wSuahWcl+3GSULA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="674639"
Received: from pavel-dev.sc.intel.com (HELO pepopov-mobl2.amr.corp.intel.com) ([10.3.206.11])
  by fmviesa008.fm.intel.com with ESMTP; 09 Oct 2026 08:40:36 -0700
From: Pavel Popov <pavel.e.popov@intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>
Cc: pavel.e.popov@intel.com,
	Jim Chow <jim.chow@broadcom.com>,
	Radu Rugina <radu.rugina@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	bcm-kernel-feedback-list@broadcom.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] PCI/P2PDMA: Allow P2PDMA in VMware guests on Intel hosts
Date: Fri,  9 Oct 2026 08:40:33 -0700
Message-ID: <20261009154034.82321-2-pavel.e.popov@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261009154034.82321-1-pavel.e.popov@intel.com>
References: <20261009154034.82321-1-pavel.e.popov@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Peer-to-Peer DMA (P2PDMA) between two devices requires either a shared
upstream bridge or a host bridge matching pci_p2pdma_whitelist[]. In
VMware guests, passthrough devices appear directly on virtual root
buses without host bridge devices. Consequently, P2PDMA checks
evaluate endpoint Device IDs against the host bridge whitelist,
causing P2PDMA requests to fail regardless of host support.

This affects discrete devices such as GPUs, NICs and NVMe drives.

The P2PDMA host bridge check does not work in a VMware guest. Bypass it on
Intel hosts under VMware, starting with Skylake-SP, the first Xeon
Scalable generation. Xeon Scalable introduced UPI and is whitelisted for
P2PDMA without restrictions. AMD Zen and newer are already covered by
cpu_supports_p2pdma(), so the bypass is implemented for Intel hosts only.

Tested with the Intel Level Zero P2P benchmark (ze_peer) on Arc Pro B60
cards in a Linux guest on VMware ESXi 9.0 (Emerald Rapids host).

Reviewed-by: Jim Chow <jim.chow@broadcom.com>
Signed-off-by: Pavel Popov <pavel.e.popov@intel.com>
---
 drivers/pci/p2pdma.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 9334eb314663..d96f44d0738a 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -21,6 +21,12 @@
 #include <linux/seq_buf.h>
 #include <linux/xarray.h>
 
+#ifdef CONFIG_X86
+#include <asm/cpu_device_id.h>
+#include <asm/hypervisor.h>
+#include <asm/intel-family.h>
+#endif
+
 struct pci_p2pdma {
 	struct gen_pool *pool;
 	bool p2pmem_published;
@@ -532,6 +538,19 @@ static bool cpu_supports_p2pdma(void)
 	return false;
 }
 
+static bool hypervisor_supports_p2pdma(void)
+{
+#ifdef CONFIG_X86
+	/* Hypervisor hides host topology, allow p2pdma on Skylake and newer */
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL &&
+	    boot_cpu_data.x86_vfm >= INTEL_SKYLAKE_X &&
+	    hypervisor_is_type(X86_HYPER_VMWARE))
+		return true;
+#endif
+
+	return false;
+}
+
 static const struct pci_p2pdma_whitelist_entry {
 	unsigned short vendor;
 	int device;
@@ -781,6 +800,7 @@ calc_map_type_and_dist(struct pci_dev *provider, struct pci_dev *client,
 
 map_through_host_bridge:
 	if (!cpu_supports_p2pdma() &&
+	    !hypervisor_supports_p2pdma() &&
 	    !host_bridge_whitelist(provider, client, acs_redirects)) {
 		if (verbose)
 			pci_warn(client, "cannot be used for peer-to-peer DMA as the client and provider (%s) do not share an upstream bridge or whitelisted host bridge\n",
-- 
2.53.0

