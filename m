Received: from pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.12.53.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE2F4A484A;
	Fri, 11 Sep 2026 17:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.12.53.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789148864; cv=none; b=XbqeQ5VW+Hhswuf9BLn4AD0UNsdCjVxh4RSZet22Xkc7Eiprh9E93t4+3oKDxO7RCo4un/Qo/a3Hp4gp52e1y9xIJyzlX+rp5pnM2GZMOB+WtvQQfNcoDK2dZinaJ/UwYB+pmTmnQmZDb774etg9Fumk7B8oyic9yxfZTOrOMHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789148864; c=relaxed/simple;
	bh=bOmqB4DT165vGlUkh4Mo3Agug0sCz6kPxVUhY41K2js=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VQBlvhm18zAlzTwBJSATHY5CyCxSNexLT7x6dospFSuASINk0BvXfHxurCQ3/rOWJw/UOtT55SMFn/ySiok52B//ts31sW0Y0Lhv095RfAkEEb9tcQ1SR3UNxY1DBi3hhSC9FGXmGxizVzoxizMTFHVDtE4JoZrt/2AMo0LcOJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=I0rjhOoo; arc=none smtp.client-ip=52.12.53.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="I0rjhOoo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1789148863; x=1820684863;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=73c2Q3ChwgfM3U9RxYpDCf/lEjkTcCr872X8hHq50Sg=;
  b=I0rjhOooBOZNERaltiZ+bkMfKcl/s4K3NP5hpDTpO1QQdmOKASnoLLsT
   pF3sLW9nRlc6V9/b4uvD7qhDALN6DIYHY7EfTfmixAxMUEUWqxmkKaT/T
   OIcRi0KHAL5tP7HvaLTQnq+PNvNUNAne7czisF1kVrN2xDe/9Kb6926Bh
   Iabzxkeg+gqGZ30udOw2bADIL9hs4kCClCycD1PEnqGdrBV6gwKbY/wMg
   u/U2SkDGXlxWoUy0R8dTHKGQlgzILN41hE2et6gCDhy1IypLzn+hVH46w
   N/BydWG0MSB4uqeEc9vCLUIhxhf7h5v6pHbtpr3xRPsdaeWEWcks5CcaS
   w==;
X-CSE-ConnectionGUID: E4dCvVnaQxqrNJJUSmCOyA==
X-CSE-MsgGUID: e8NnEEYWSX2mdI/uHM0k5g==
X-IronPort-AV: E=Sophos;i="6.27,97,1787011200"; 
   d="scan'208";a="28318161"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 17:47:42 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.51:32130]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.22.113:2525] with esmtp (Farcaster)
 id f22bb6e2-6ce1-44b4-9c36-35978ecb9669; Fri, 11 Sep 2026 17:47:42 +0000 (UTC)
X-Farcaster-Flow-ID: f22bb6e2-6ce1-44b4-9c36-35978ecb9669
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Fri, 11 Sep 2026 17:47:42 +0000
Received: from dev-dsk-sakacpav-1a-480d1124.eu-west-1.amazon.com
 (172.19.96.155) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.46; Fri, 11 Sep 2026
 17:47:39 +0000
From: Pavol Sakac <sakacpav@amazon.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tejun Heo
	<tj@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Danilo Krummrich
	<dakr@kernel.org>
CC: <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>, "Andy
 Shevchenko" <andriy.shevchenko@linux.intel.com>, Xu Yang <xu.yang_2@nxp.com>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, Bjorn Helgaas
	<bhelgaas@google.com>, <linux-pci@vger.kernel.org>, Alex Williamson
	<alex@shazbot.org>, <kvm@vger.kernel.org>, <nh-open-source@amazon.com>
Subject: [RFC PATCH 7/8] PCI/IOV: Register virtual functions through the staged sysfs path
Date: Fri, 11 Sep 2026 19:43:39 +0200
Message-ID: <20260911174414.97060-7-sakacpav@amazon.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260911-vfopt-s5-v1-0-fa4cacdb6ca8@amazon.de>
References: <20260911-vfopt-s5-v1-0-fa4cacdb6ca8@amazon.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC004.ant.amazon.com (10.13.139.246) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

SR-IOV enablement registers up to thousands of virtual functions, each
building its own sysfs directory tree under the sysfs root's
kernfs_rwsem. The sibling VF additions that an earlier patch in this
series runs concurrently within one PF, and VF enables running on several
PFs at once, all serialize on that one lock.

Opt VF registration in to staged registration by calling
dev_set_sysfs_staged() on the VF's device before pci_device_add() in
__pci_iov_add_virtfn(), the single path through which every VF is added:
the synchronous VF0 add, the async workers, and the pci_iov_add_virtfn()
wrapper. Each VF's directory is then built off the root lock and
published in one step.

Assisted-by: LLM
Signed-off-by: Pavol Sakac <sakacpav@amazon.de>
---
 drivers/pci/iov.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index ac2ddda4bf14..79258d4791a3 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -387,6 +387,8 @@ static int __pci_iov_add_virtfn(struct pci_dev *dev, struct pci_bus *bus,
 		BUG_ON(rc);
 	}
 
+	/* must precede pci_device_add(); see DEV_FLAG_SYSFS_STAGED */
+	dev_set_sysfs_staged(&virtfn->dev);
 	pci_device_add(virtfn, virtfn->bus);
 	rc = pci_iov_sysfs_link(dev, virtfn, id);
 	if (rc)
-- 
2.47.3

