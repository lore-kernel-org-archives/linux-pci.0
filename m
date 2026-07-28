Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F83545D1AC;
	Tue, 28 Jul 2026 15:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785254016; cv=none; b=hTLVCuZ1gW90g4W43fXQSyzDrgpfynfn/D/xct7se5WeIbXoCukzv6+oF+tMKt50pToCREEujv/bOG8nP+0D76/I8jltNs9C3+V86w6NCBZOadUSPWgxgRSW+MHVWmLtw4c3F97BNgFGNHLLzqlA0uY8nAHTDSHNXXDBX7n3s4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785254016; c=relaxed/simple;
	bh=rO+1oXbRS/1cKuocy8W6yeeY69MDmp/5QmFdib0LGGI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AE/kB5p8iCYc6UIIxV3e2GRvgxD7cjdMDLkB9PJqF7btm9+MUv6M86ndsSMhKbhrEZ4NWk7YDIXTzxnNZKw1kbcz5jgFqzj5NK8a6UYcG7OKH10EKuL10tNnnTmZbqfZ3N9WBdGesXI1jBM8gP4wILZtSsOLdUYl5RJ7sf8da00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lPObcxuK; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lPObcxuK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785254014; x=1816790014;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rO+1oXbRS/1cKuocy8W6yeeY69MDmp/5QmFdib0LGGI=;
  b=lPObcxuKhpK8Q+q61UoZeZVFC+dvx2DGQkdOKL4nH4wmHlFj7hnMoRuT
   L7EE+EBwO+xsh3Okhx+ID/CcpWu+KnXztyewqedgDVkUCP1SkaTBYiEqw
   LHmClgx0Omdcay26+V3lPoPg8nExQ4NNmbh7u8spoAhvDxriKrmeMF4Iq
   WGJBdmHT63U6kLvwC1iU9tq6zxY2qkwN5g/Cumuz0I3Ok7emqfBCkfikR
   3RVsMQnhvB8yW3n6VhF/QK6+8xflSKg7Z/T7hAar+BPX40zEv4bglEaFB
   MOsY6m+AGPzhPNRw1+H4S1PV7AtlSawW74embLFvfcMBeygaQsT/eXTtx
   w==;
X-CSE-ConnectionGUID: VaOjkRIrRbyUqRXuNHQ9jA==
X-CSE-MsgGUID: V8KYQJ17RaKXymBUCm2gDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="85696727"
X-IronPort-AV: E=Sophos;i="6.25,190,1779174000"; 
   d="scan'208";a="85696727"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2026 08:53:34 -0700
X-CSE-ConnectionGUID: t4H56CiJQWWtdo8CtqHesg==
X-CSE-MsgGUID: lwFcZmrWQYuhOXcItqzcBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,190,1779174000"; 
   d="scan'208";a="255817662"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO ahunter6-desk) ([10.245.244.126])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2026 08:53:32 -0700
From: Adrian Hunter <adrian.hunter@intel.com>
To: alexandre.belloni@bootlin.com
Cc: Frank.Li@nxp.com,
	rafael@kernel.org,
	linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH V2 6/8] i3c: mipi-i3c-hci-pci: Propagate I3C wakeup requirements to PCI
Date: Tue, 28 Jul 2026 18:53:06 +0300
Message-ID: <20260728155308.142713-7-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260728155308.142713-1-adrian.hunter@intel.com>
References: <20260728155308.142713-1-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit

Keep the PCI wakeup state aligned with the wakeup requirements of the
devices served by the controller(s).

The PCI function is the wakeup source for HCI instances exposed beneath
it.  However, wakeup is only needed when at least one attached I3C device
is enabled as a wakeup source.

During suspend, check whether any HCI instance has a wakeup-enabled I3C
device and enable wakeup for the PCI function only in that case.
Otherwise leave PCI wakeup disabled.

Note, the suspend callback is used for both system and runtime suspend.
Although this change may update the PCI wakeup state during runtime
suspend, it does so only when the required wakeup state changes.
Moreover, PCI wakeup-capable devices already have PME wakeup armed for
runtime suspend, so changing the wakeup-enabled state does not affect
runtime PM wakeup behavior.

Note also, since the PCI wakeup state is derived from the wakeup
configuration of the attached I3C devices, the PCI device power/wakeup
sysfs attribute no longer provides independent wakeup control.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---


Changes in V2:

	None


 .../master/mipi-i3c-hci/mipi-i3c-hci-pci.c    | 23 +++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/i3c/master/mipi-i3c-hci/mipi-i3c-hci-pci.c b/drivers/i3c/master/mipi-i3c-hci/mipi-i3c-hci-pci.c
index 5a9e2a43eff8..2b3bf6fa74f2 100644
--- a/drivers/i3c/master/mipi-i3c-hci/mipi-i3c-hci-pci.c
+++ b/drivers/i3c/master/mipi-i3c-hci/mipi-i3c-hci-pci.c
@@ -265,6 +265,8 @@ static bool mipi_i3c_hci_pci_is_operational(struct device *dev, bool update)
 struct mipi_i3c_hci_pci_pm_data {
 	struct device *dev[INST_MAX];
 	int dev_cnt;
+	bool can_wakeup;
+	bool may_wakeup;
 };
 
 static bool mipi_i3c_hci_pci_is_mfd(struct device *dev)
@@ -272,6 +274,13 @@ static bool mipi_i3c_hci_pci_is_mfd(struct device *dev)
 	return dev_is_platform(dev) && mfd_get_cell(to_platform_device(dev));
 }
 
+static bool mipi_i3c_hci_pci_any_wakeup_enabled(struct device *dev)
+{
+	struct i3c_hci *hci = dev_get_drvdata(dev);
+
+	return i3c_master_any_wakeup_enabled(&hci->master);
+}
+
 static int mipi_i3c_hci_pci_suspend_instance(struct device *dev, void *data)
 {
 	struct mipi_i3c_hci_pci_pm_data *pm_data = data;
@@ -287,6 +296,9 @@ static int mipi_i3c_hci_pci_suspend_instance(struct device *dev, void *data)
 
 	pm_data->dev[pm_data->dev_cnt++] = dev;
 
+	if (pm_data->can_wakeup && mipi_i3c_hci_pci_any_wakeup_enabled(dev))
+		pm_data->may_wakeup = true;
+
 	return 0;
 }
 
@@ -317,12 +329,19 @@ static int mipi_i3c_hci_pci_suspend(struct device *dev)
 	if (!hci->info->control_instance_pm)
 		return 0;
 
+	pm_data.can_wakeup = device_can_wakeup(dev);
+
 	ret = device_for_each_child_reverse(dev, &pm_data, mipi_i3c_hci_pci_suspend_instance);
-	if (ret)
+	if (ret) {
 		for (int i = 0; i < pm_data.dev_cnt; i++)
 			i3c_hci_rpm_resume(pm_data.dev[i]);
+		return ret;
+	}
 
-	return ret;
+	if (device_may_wakeup(dev) != pm_data.may_wakeup)
+		device_set_wakeup_enable(dev, pm_data.may_wakeup);
+
+	return 0;
 }
 
 static int mipi_i3c_hci_pci_resume(struct device *dev)
-- 
2.53.0

