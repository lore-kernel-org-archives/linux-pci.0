Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794258491;
	b=wJ36tmA2MnVLwjZIgiObrosgAcV2whQKJ5BH26zjQTVrBR/TwZk27+wOq6/j/Qnnx+Hf
	 nC+aFjEWKc+uqrEB7UKf7XRX5193ziVvsjCviX6F3WbOvVBullwUu2gcj/DrOpmvEO/yY
	 LcfwiqDh6CTK6z6is9TZLMhXlAb9fjXU0Jyc4rGSE9YG8Yy2mOKMTYCVUA5ZlJuj3aR4d
	 o32x2E4TuLdfHJXLJ4Ri9pUubJYIug4Vp73Y3YNwe+ncjttOuqSbz2Ae+89gcklMoLz0Z
	 SpukDAoyD/ezYQRlNamo7iPOxGDtvddHeNvy23H8CpYnMHX0FPsfJSr0sGlU5V7oqWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794258491;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=9yCHzkOqdVPAaAY7IFFzPbPj4b4bDVr2rAPVKfOvK/U=;
	b=LpaoOa2FNR7IxGVlxBrniQRi9U6W4ZRgwQMKHoRtUTDP49c1LUQN4EH2T1BaFmDkZDkX
	 uKP75cU0PyF/SIScyJDXEMtP4qzf/uDN8boZv4JA1NJE5GexcP8BNbqjxxTyoAenZF7tx
	 Sixsj6JrpXKYZ3NNDrVdPqq6AP3bpuFYXD3IO7q8qjq87xjJcCv46HFEEfhcXXpfGl5K8
	 o/gUanRf/4VPrbCG9XQXsmVC/tiaRPrwcUrX40JRLeY133Hg/7AUK/5W+2qKWngMDtl/B
	 ZDS4DcOyIYG5RcEHslKjw4Ukvf5Bp7rlZaNqM4jo6rSwXrshy1zrbyxu12rPuI3wIvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YSXQvkWA;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0595606A326;
	Mon,  9 Nov 2026 21:08:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0595606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YSXQvkWA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794258491; x=1825794491;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nqwAo52ijPgtPxhG6+9NCXI0eoCF2RzU5HasFGnT5j4=;
  b=YSXQvkWAs/LBaknYKgRFmJ5vOJSiX86HQeVI0bUzDOXOjp6UmTI78fxy
   GNs5o429iLKEKxB1WWe/pUfoniSJQFpoe9On8BM2M9Qci3hF77qV37831
   Lgar0wV+c7SbA7VdGUH4Bu3oK0xgapkovIPem1zjpI2zHruofdyJFYQRx
   cx6iL2TH2aWXb91ibvu/tXCEGGmP/CnagPyZ+e77o5FvU+zDqXomXPvb9
   GG0c9qkWj3qN4ywHkkmE5QjikeWhsQ+7JWt7fPqc2w5F5aU2cnToPA+Fd
   CktsNpUMMaCxCu7OQCJN28Igy/PnDhL9iCTw5MqBHc+OEc6wX3kNi2nBT
   A==;
X-CSE-ConnectionGUID: yzEc2LmiSPG7FXNu8EypIA==
X-CSE-MsgGUID: QAW3joENTQ6xw7t8f46GUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="3079426"
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="3079426"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 13:08:11 -0800
X-CSE-ConnectionGUID: j1OR4YS4SSumIC0AJ8ZtWg==
X-CSE-MsgGUID: bLrn/ElNQSyhs0XpmGEZnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="8016891"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.139])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 13:08:09 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 05/11] PCI: Move pci_read_bases() wrapper with BUILD_BUG_ON() to pci.h
Date: Mon,  9 Nov 2026 23:07:05 +0200
Message-ID: <20261109210714.3862-6-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261109210714.3862-1-ilpo.jarvinen@linux.intel.com>
References: <20261109210714.3862-1-ilpo.jarvinen@linux.intel.com>
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

pci_read_bases() is static in probe.c. An upcoming change moves CardBus
device setup into setup-cardbus.c, which needs to read the CardBus
BAR from outside probe.c.

Move the body of pci_read_bases() into __pci_read_bases() and keep the
BUILD_BUG_ON() check in an __always_inline pci_read_bases() wrapper in
pci.h so all callers retain the check.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/pci.h   | 10 ++++++++++
 drivers/pci/probe.c |  5 +----
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 519918e24cc5..798b31c31ae4 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -532,6 +532,16 @@ void __pci_size_stdbars(struct pci_dev *dev, int count,
 			unsigned int pos, u32 *sizes);
 int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
 		    struct resource *res, unsigned int reg, u32 *sizes);
+void __pci_read_bases(struct pci_dev *dev, unsigned int howmany, int rom);
+
+static __always_inline void pci_read_bases(struct pci_dev *dev,
+					   unsigned int howmany, int rom)
+{
+	BUILD_BUG_ON(statically_true(howmany > PCI_STD_NUM_BARS));
+
+	__pci_read_bases(dev, howmany, rom);
+}
+
 void pci_configure_ari(struct pci_dev *dev);
 
 int pci_dev_res_add_to_list(struct list_head *head, struct pci_dev *dev,
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 1c2caf3ce664..a20ceaf7307a 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -322,15 +322,12 @@ int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
 	return (res->flags & IORESOURCE_MEM_64) ? 1 : 0;
 }
 
-static __always_inline void pci_read_bases(struct pci_dev *dev,
-					   unsigned int howmany, int rom)
+void __pci_read_bases(struct pci_dev *dev, unsigned int howmany, int rom)
 {
 	u32 rombar, stdbars[PCI_STD_NUM_BARS];
 	unsigned int pos, reg;
 	u16 orig_cmd;
 
-	BUILD_BUG_ON(statically_true(howmany > PCI_STD_NUM_BARS));
-
 	if (dev->non_compliant_bars)
 		return;
 
-- 
2.47.3

