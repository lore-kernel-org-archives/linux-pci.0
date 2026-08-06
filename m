Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BFF1CEADB;
	Thu,  6 Aug 2026 13:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786022374; cv=none; b=TvZa2UroVgeEKvpVEMb0Y45tCVYCSscFluNIAiT7tEwrIcDuyLE4iIYITR5lw+MOqJRXGYqQRDE5+wD+xIqLJ1gCwWrS+VdJUY9wWk5HhFXt/nVOSVDhA8c3teYSJ6nNpj5VB5LLVZ/3J+HuUQffoNmNoGps86d1TLsw9SMbyxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786022374; c=relaxed/simple;
	bh=aAlpC53BvxqcWVxTMHsq4k18TBokrrycgeE2Ij9anUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ma/cPbEhDgj/KR4P2WXjjlNy73CW1LRdZb5BMwDNxz/4VeVEP1qdoXEEKZ7EOtAx6ZJgm2Urb2xs7fWZ8WqHmADcc2x0jQYI7j0gNJVhF/Eict77a6c2lSn/QwQFnFi0s3ZkWgnxAfcvx4NxHOjb3AVW5sWmXlLRIGKO2zztzZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O/L+8KOK; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O/L+8KOK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786022367; x=1817558367;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aAlpC53BvxqcWVxTMHsq4k18TBokrrycgeE2Ij9anUM=;
  b=O/L+8KOKjjfQ1lDphG4grTP2pnXigpH0i/wJWmU/RnJxDVoo2VAyySIp
   qOykaKs4eCMVFvbkN3q9wzZ/ZUEiZ/mdtotnd/HLQHoVATumTX2Ujll0p
   23PdehHuSgYqj+GGQETWMMF/NZrM4gf9y3yh2966nxKKzhnXn6/wVhQow
   XTe1RKRJrCiR+mV4pN2XeLDA3iIASwnKlnXcI7NePsvzqJDyESgUDV95p
   8pWPoD12zGw0ZfWfjs/kl13tQKkK7JAWp/76KINFJkNkyBMCqcGzRPNeA
   DrA0x80Ol9Ec1Us0JfkPRGwgc/MOhOvBJBr+B9MQJD9zyR/OLmJDNtvTd
   g==;
X-CSE-ConnectionGUID: M1MdpKrtRx+PMruut42AGg==
X-CSE-MsgGUID: fXyHN+k3RfKhxy+bjCiXVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="74149558"
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; 
   d="scan'208";a="74149558"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 06:19:20 -0700
X-CSE-ConnectionGUID: mSUQJ4j3R4e+2ONLuus+NQ==
X-CSE-MsgGUID: 9Hoa0CYlR1aicsUq9ldLsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; 
   d="scan'208";a="260338128"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO ahunter6-desk) ([10.245.244.200])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 06:19:17 -0700
From: Adrian Hunter <adrian.hunter@intel.com>
To: alexandre.belloni@bootlin.com
Cc: Frank.Li@nxp.com,
	akhilrajeev@nvidia.com,
	mukesh.savaliya@oss.qualcomm.com,
	rafael@kernel.org,
	linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH V4 04/14] i3c: master: Fix use-after-free of master->this
Date: Thu,  6 Aug 2026 16:18:47 +0300
Message-ID: <20260806131857.119830-5-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260806131857.119830-1-adrian.hunter@intel.com>
References: <20260806131857.119830-1-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit

sysfs attribute callbacks for the master controller device dereference
master->this.  However, master->this is freed in
i3c_master_detach_free_devs() before the master device itself is
released.

As a result, sysfs accesses can dereference a freed master->this
pointer, leading to a use-after-free.

Keep master->this alive until i3c_masterdev_release(), which is called
after the master device and its sysfs state are being torn down. Do not
free master->this as part of the normal device detach path.

On the error path in i3c_master_set_info(), reset master->this and
bus.cur_master to NULL before freeing the allocated device.

Fixes: 3a379bbcea0a ("i3c: Add core I3C infrastructure")
Cc: stable@vger.kernel.org
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---


Changes in V4:

	Also reset master->this and bus.cur_master to NULL on the
	i3c_master_set_info() error path before freeing the allocated
	device.  Tidied up the commit message wording.

Changes in V3:

	New patch


 drivers/i3c/master.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index abb582645a2e..2357874bb9d6 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -842,6 +842,11 @@ static struct attribute *i3c_masterdev_attrs[] = {
 };
 ATTRIBUTE_GROUPS(i3c_masterdev);
 
+static void i3c_master_free_i3c_dev(struct i3c_dev_desc *dev)
+{
+	kfree(dev);
+}
+
 static void i3c_masterdev_release(struct device *dev)
 {
 	struct i3c_master_controller *master = dev_to_i3cmaster(dev);
@@ -854,6 +859,8 @@ static void i3c_masterdev_release(struct device *dev)
 	i3c_bus_cleanup(bus);
 
 	fwnode_handle_put(dev->fwnode);
+
+	i3c_master_free_i3c_dev(master->this);
 }
 
 static const struct device_type i3c_masterdev_type = {
@@ -1125,11 +1132,6 @@ static void i3c_device_release(struct device *dev)
 	kfree(i3cdev);
 }
 
-static void i3c_master_free_i3c_dev(struct i3c_dev_desc *dev)
-{
-	kfree(dev);
-}
-
 static struct i3c_dev_desc *
 i3c_master_alloc_i3c_dev(struct i3c_master_controller *master,
 			 const struct i3c_device_info *info)
@@ -2266,6 +2268,8 @@ int i3c_master_set_info(struct i3c_master_controller *master,
 	return 0;
 
 err_free_dev:
+	master->bus.cur_master = NULL;
+	master->this = NULL;
 	i3c_master_free_i3c_dev(i3cdev);
 
 	return ret;
@@ -2286,7 +2290,8 @@ static void i3c_master_detach_free_devs(struct i3c_master_controller *master)
 					i3cdev->boardinfo->init_dyn_addr,
 					I3C_ADDR_SLOT_FREE);
 
-		i3c_master_free_i3c_dev(i3cdev);
+		if (i3cdev != master->this)
+			i3c_master_free_i3c_dev(i3cdev);
 	}
 
 	list_for_each_entry_safe(i2cdev, i2ctmp, &master->bus.devs.i2c,
-- 
2.53.0

