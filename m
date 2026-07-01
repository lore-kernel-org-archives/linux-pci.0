Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6C83C4B68;
	Wed,  1 Jul 2026 20:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782936957; cv=none; b=K//LNywMNfUdMeWVzsFDBYHa/MyUOet3QeXDZMue4LMQR//x6ch2/jclmAHDo8TszZdrSlDxNWeJe8KpvrnT/rauQ2kPV7RE3dR8lzmFUcm7XrzILNJgXyz3AZKZcVJgTIR1TPHGggtJ9I82CbboFoeN9bT7qqAWOr+6SJqGIt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782936957; c=relaxed/simple;
	bh=XZS4HynOIQKk1VasYmcpScksdFSrsDLcowg3yXTJ4o8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O7tUq3IpvhhtnZvK3Nj5LoJ9CQfFPjKF0XH74YL5cu3VspelhUq0C7E2gN8cWta6PYW5aSq+1jj6X35bGkigreE2MjNlTDZE2BUT50KDKLImaTNA90Sl+2d1fEuWEmitiBU9TXqpRkz5lk4Sss1GQrDF/pbecvpU7F7ubJNGJVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bd7Fiz/s; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bd7Fiz/s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782936956; x=1814472956;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XZS4HynOIQKk1VasYmcpScksdFSrsDLcowg3yXTJ4o8=;
  b=Bd7Fiz/sIf1sIMbVJkNandbpUV2W9sQWjDI59B3tLFlrntV4fyw6Jz1d
   nW5iExUAitf+1gEpxeQP38H9EpAbii13zJhTFqymSuZkrjJH/npTA3LB/
   V69YsONIbDj+gzQ9In/l/P4OZ85qDNYRnPj9v0dP45s/oFJ7RSP4nIXI1
   78h3komuo55XNHgm36ICkM6nYnS0mspai6l4k679llaui/U4YtgHdji6c
   9V1piJRbucbpTv3I8w7nGn3C+3p9SLN0KlkEnp2ZgMrMGZQXiVTV22wFw
   65Wyw9E+6DBnfR0eyrZc7O6Jgzq8gQ2aE0hKIdGInjHQ4GqoijDZBhPvP
   A==;
X-CSE-ConnectionGUID: qePo2iv8SeeFuj1CdMUOyg==
X-CSE-MsgGUID: Kj8j7ogXSFus+BnR5k1ePw==
X-IronPort-AV: E=McAfee;i="6800,10657,11834"; a="82671808"
X-IronPort-AV: E=Sophos;i="6.25,142,1779174000"; 
   d="scan'208";a="82671808"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 13:15:56 -0700
X-CSE-ConnectionGUID: Tbqj64heT3SE6B+2O2dTDA==
X-CSE-MsgGUID: 4MYBu/HSRNWSkfN//tc8lw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,142,1779174000"; 
   d="scan'208";a="282737066"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO ahunter6-desk) ([10.245.244.30])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 13:15:54 -0700
From: Adrian Hunter <adrian.hunter@intel.com>
To: alexandre.belloni@bootlin.com
Cc: Frank.Li@nxp.com,
	rafael@kernel.org,
	linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH RFC RESEND 5/7] i3c: mipi-i3c-hci-pci: Propagate I3C wakeup requirements to PCI
Date: Wed,  1 Jul 2026 23:15:31 +0300
Message-ID: <20260701201533.220818-6-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260701201533.220818-1-adrian.hunter@intel.com>
References: <20260701201533.220818-1-adrian.hunter@intel.com>
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

