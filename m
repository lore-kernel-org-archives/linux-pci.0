Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41EB45DF72;
	Tue,  4 Aug 2026 13:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785850713; cv=none; b=N4Ipyp5B6LhavRJLZgn+uiir71CuvxvYDnhHN3eB9aEW19psyPXYdyK2sxOuSo/okL5adCuZm/u7/pX0ICTqVjK9Q6A5ij0ex0q7Ag5BHwWkZMw+a7Jb083+wQ+nXb7MC/s0JOOSMwxFzuIvXa/krjzgQjS+CO4TFvPN/aBZLQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785850713; c=relaxed/simple;
	bh=LKC0QMMd/XJevryXpaROjCj9xdLCE4mgoSSaTfBGOkw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EZx2XcGvFWzqzXLjTVXeSmIrGmJF+qncuvcuJsVcmvdeIhPJw8sj0bf+GICDHKTpKB6ZTQTP0oEqYJsnylq8DElSvQZEiNBs6Yk+qH9LbcPc62nqRnHiONCIJ4R0SUWNd1INQ8ogIIHlo6IzCwOCNgpR4H8bgr+wiWWz80TOzpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NVv3AVg3; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NVv3AVg3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785850712; x=1817386712;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LKC0QMMd/XJevryXpaROjCj9xdLCE4mgoSSaTfBGOkw=;
  b=NVv3AVg3e020crnsEVP2jDT8vB5YIOaltOYi+WYpApzckqZLuk90BNN5
   uKn+NMvTuDaTG8qWRppQbwHCKdCUL2Q5SUQPvrVbmPwhQ1Da69QpkDpEb
   qXPpNmmORWYQwjmL2+qzsMdYC02LfvBud9p9wgFPXNrpwzJZQ9NAr0+O+
   MGij1/Feo9crgpltPbgx3XutyQZRGdgOIfcJ66CbD7WW6TwGUTlIjakAL
   hojtu6BSFceVhIxwBse+vj8UkwHI94FhqnlEWJNjTjmINetkYMjkFjCv8
   XiC6g0DdGcwliMdVm5aka12PyvKSXfnbicP+YLP7RIAIyDESBdVHRqxJc
   A==;
X-CSE-ConnectionGUID: bXxopzvwTFG42jhZpfI2fw==
X-CSE-MsgGUID: u+MdLMfkR2q46ewddF89nA==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="86410104"
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; 
   d="scan'208";a="86410104"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 06:38:31 -0700
X-CSE-ConnectionGUID: YYbXWcnOQa6ckgQl8WVVmQ==
X-CSE-MsgGUID: uFswiDBTSTqxPCk+c6eisw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; 
   d="scan'208";a="263501013"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO ahunter6-desk) ([10.245.245.132])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 06:38:29 -0700
From: Adrian Hunter <adrian.hunter@intel.com>
To: alexandre.belloni@bootlin.com
Cc: Frank.Li@nxp.com,
	akhilrajeev@nvidia.com,
	rafael@kernel.org,
	linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH V3 04/14] i3c: master: Fix use-after-free of master->this
Date: Tue,  4 Aug 2026 16:38:00 +0300
Message-ID: <20260804133810.184905-5-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260804133810.184905-1-adrian.hunter@intel.com>
References: <20260804133810.184905-1-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit

sysfs attribute callbacks for the master controller device dereference
master->this.  However, master->this is currently freed in
i3c_master_detach_free_devs(), before the master device itself is
released.

As a result, sysfs accesses can dereference a freed master->this
pointer, leading to a use-after-free.

Keep master->this alive until i3c_masterdev_release(), where all users
of the master device have gone away and the associated sysfs state is
being torn down.  Do not free master->this as part of the normal device
detach path.

Fixes: 3a379bbcea0a ("i3c: Add core I3C infrastructure")
Cc: stable@vger.kernel.org
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---


Changes in V3:

	New patch


 drivers/i3c/master.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index abb582645a2e..4839c1c186eb 100644
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
@@ -2286,7 +2288,8 @@ static void i3c_master_detach_free_devs(struct i3c_master_controller *master)
 					i3cdev->boardinfo->init_dyn_addr,
 					I3C_ADDR_SLOT_FREE);
 
-		i3c_master_free_i3c_dev(i3cdev);
+		if (i3cdev != master->this)
+			i3c_master_free_i3c_dev(i3cdev);
 	}
 
 	list_for_each_entry_safe(i2cdev, i2ctmp, &master->bus.devs.i2c,
-- 
2.53.0

