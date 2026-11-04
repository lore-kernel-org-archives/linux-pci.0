Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793794835;
	b=HHHUKaLvNuBCay1YdCz+cHVo/p0d8ruHeLlpt8x6N0VmzqQs/rnC0rXdB9WNHB2wZfdv
	 5oLW5230qZ08Wo+mybwflIBzCR9agqgrNz+PVgqAq0+1OrD8jTfR8pA2UmjtRyLfDw1E3
	 qK00Sf0ON0+NJ2v5+aTJUW98pPOXAqyaejGsvJ3XBMbUAB+MU4xQieeuN9C2JV1CHmJpl
	 rRm1ECNlKSFYwtMgZAgL33jD5s/HiJAfhd/srESAz198fFDD7f5Q0jdMAVxcLcWMRe/zE
	 81CH0a/lY7uas1OwtO4TvjRM+12+XK7vv/rYOEEXQsr16PvqWYYRAcnPdmRHRGLrK7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793794835;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=fN0W2KODWrSOKqxl0cnxzh4Og2UL1ngDgS+SLul+Y9E=;
	b=Fm+thUTdMSKtZkN8Af589lwfcFJV2ubDgtQ/Gz9Is5YHfnEtxJhTCcUe44qWRhFUs+vF
	 Hxz3bNYpO50rFNP+PBzzc7blXNiG1TueCqsTSwwBZ95pOmy3NhVlvY4y73EPH8IXVTYFu
	 C4krYALIAdzXAystjhK0f7duQo4lXfQl3a1wDnWNKLBUNLjme1qkOx/xKELE1pbCOK9rC
	 tB7qTWM5agnYOI3xtJ2ZxJ+hRjzQLMCwD5PY0seuwVPS4r83yZOw1xJLJT73t5RBVU8PQ
	 91SBI8VySirhVANmEHqilKKucCmkLN5kcqKSzbe5hWZpJteVatSk4RkFj8XYlB8CIOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PWterILR;
	arc=none smtp.remote-ip=198.175.65.11
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CA8606A31B;
	Wed,  4 Nov 2026 12:20:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23CA8606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PWterILR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793794836; x=1825330836;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0De81WFMgE7eJXrQgylmhw9l6QAO/VhnOS1D6Ft7hIQ=;
  b=PWterILRkGUKq0DbaHWw1g2wdotgHiaJDwrheVJLgOOvM/Y0YDXjYIpQ
   PzTMoCDcFHjoqDF/tCmWmiwcS7e+l+/qLE8a63cEg4to2qKuHZpHfgdQJ
   5tx/i1RDK/Bn+dI40TNisAmvCOocuYoSj4f0B6J47bPOq5ajTbgBzv8h7
   NT97R4h1NUKsmq43SCT3ePPw9XVSbNUmIMf9J/iI79wIG/RswcZFr7hIF
   MvhUfQsJNsg8/weyIpB8cx/WCIzBj/TcNRXcO5WdUIMVB0OhMr00M9bAQ
   EmQDPW/u0Mauu/leCYPfkbBRI2TylQKiP8wVryJLXWeBWteJnHSNK+wt/
   Q==;
X-CSE-ConnectionGUID: 7Jealv/TQVGAi+EjOo5OJw==
X-CSE-MsgGUID: z3UJn2R6Re63fXqD9MwN3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2424879"
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="2424879"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 04:20:35 -0800
X-CSE-ConnectionGUID: uCGWQ0muSLCE4UmiKieRqg==
X-CSE-MsgGUID: wwcPExDhTsKopqVkcAOgjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="6605361"
Received: from liyifan1-desk.bj.intel.com ([10.238.152.46])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 04:20:33 -0800
From: Li Yifan <yifan2.li@intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Wentao Liang <vulab@iscas.ac.cn>,
	Li Lili <lili.li@intel.com>,
	Wang Jie <jie.wang@intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] PCI/PTM: Keep ptm_enable_cnt balanced when pci_enable_ptm() fails
Date: Wed,  4 Nov 2026 20:14:57 +0800
Message-ID: <20261104121457.2108515-1-yifan2.li@intel.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit e1092d5e15e6 ("PCI/PTM: Do not enable PTM automatically
for Root and Switch Upstream Ports"), pci_enable_ptm() takes a
reference on the device and on each port of the upstream path, and
pci_disable_ptm() releases them. If pci_enable_ptm() fails, the counts
can become incorrect in two ways:

1. pci_disable_ptm() decrements dev->ptm_enable_cnt without a check.
   Many drivers ignore the return value of pci_enable_ptm() and call
   pci_disable_ptm() unconditionally, for example mlx5 and bnxt. If
   pci_enable_ptm() failed, for example because the upstream port does
   not support PTM, the count becomes -1 and stays negative after the
   driver unbinds. Then pcie_ptm_enabled() returns true, and
   pci_resume_ptm() can enable PTM on the device after a resume,
   although the upstream path does not support PTM. Before
   e1092d5e15e6, pci_disable_ptm() did nothing if PTM was not enabled.

2. If __pci_enable_ptm() fails for the device after the upstream path
   is enabled, pci_enable_ptm() drops the reference on the device, but
   it keeps the references on the upstream ports. For example, this
   occurs if the device has no PTM Capability and its upstream port
   has one. Callers that check pcie_ptm_enabled() before
   pci_disable_ptm() never release these references, so the upstream
   ports keep PTM enabled with no user. Callers that call
   pci_disable_ptm() unconditionally release them only through the
   underflow in 1.

Fix both problems in one change, because a fix for only one of them
makes the other one worse. Release the upstream references when
__pci_enable_ptm() fails. Make pci_disable_ptm() do nothing if PTM is
not enabled for the device, and use atomic_dec_if_positive() so that
the check and the decrement are one atomic operation.

The fix for 2 is based on a patch from Wentao Liang [1].

Fixes: e1092d5e15e6 ("PCI/PTM: Do not enable PTM automatically for Root and Switch Upstream Ports")
Cc: stable@vger.kernel.org
Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
Link: https://lore.kernel.org/r/20261102222817.GA983941@bhelgaas
Link: https://lore.kernel.org/r/20260616141733.1688264-1-vulab@iscas.ac.cn # [1]
Signed-off-by: Li Yifan <yifan2.li@intel.com>
---
Wentao's patch [1] fixes only problem 2, and it is not applied. It
does not build on v7.4-rc1 ("parent" is declared inside the
"if (!dev->ptm_root)" block), and with only that fix, callers that
call pci_disable_ptm() unconditionally release the upstream
references twice. This patch includes his fix with the build fix.
Wentao, if you agree, please reply with your Signed-off-by, and I will
add you as Co-developed-by.

Tested on v7.2.7 with this patch (it applies without change), on a Nova
Lake-S system with an I226-LM (81:00.0, no driver bound) behind Root
Port 80:1d.0. A test module calls pci_enable_ptm() and
pci_disable_ptm() three times and reads ptm_enable_cnt of both devices.
It makes pci_enable_ptm() fail in two ways: it hides the PTM Capability
of the Root Port (no upstream PTM), or it clears ptm_requester of the
I226 (the device fails after the upstream path is enabled). "Guarded"
means that pci_disable_ptm() is called only if pcie_ptm_enabled().

                                  without patch        with patch
  enable succeeds                 dev 1/0, RP 1/0      same
  no upstream PTM, unconditional  dev -1, -2, -3       dev 0
  no upstream PTM, guarded        dev 0                dev 0
  device fails, unconditional     dev -1, -2, -3       dev 0, RP 0
  device fails, guarded           RP 1, 2, 3 (PTM on)  dev 0, RP 0

 drivers/pci/pcie/ptm.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pcie/ptm.c b/drivers/pci/pcie/ptm.c
index bd3bd39f6372..522975c87bd9 100644
--- a/drivers/pci/pcie/ptm.c
+++ b/drivers/pci/pcie/ptm.c
@@ -171,6 +171,7 @@ static int __pci_enable_ptm(struct pci_dev *dev)
  */
 int pci_enable_ptm(struct pci_dev *dev)
 {
+	struct pci_dev *parent = NULL;
 	int rc;
 	char clock_desc[8];
 
@@ -183,8 +184,6 @@ int pci_enable_ptm(struct pci_dev *dev)
 	 * we can enable PTM.
 	 */
 	if (!dev->ptm_root) {
-		struct pci_dev *parent;
-
 		parent = pci_upstream_ptm(dev);
 		if (!parent)
 			return -EINVAL;
@@ -201,6 +200,9 @@ int pci_enable_ptm(struct pci_dev *dev)
 	rc = __pci_enable_ptm(dev);
 	if (rc) {
 		atomic_dec(&dev->ptm_enable_cnt);
+		/* Release the references taken on the upstream path above */
+		if (parent)
+			pci_disable_ptm(parent);
 		return rc;
 	}
 
@@ -240,13 +242,18 @@ static void __pci_disable_ptm(struct pci_dev *dev)
  * pci_disable_ptm() - Disable Precision Time Measurement
  * @dev: PCI device
  *
- * Disable Precision Time Measurement for @dev.
+ * Disable Precision Time Measurement for @dev.  Do nothing if PTM is not
+ * enabled for @dev, for example because pci_enable_ptm() failed.
  */
 void pci_disable_ptm(struct pci_dev *dev)
 {
 	struct pci_dev *parent;
+	int cnt;
 
-	if (atomic_dec_and_test(&dev->ptm_enable_cnt))
+	cnt = atomic_dec_if_positive(&dev->ptm_enable_cnt);
+	if (cnt < 0)
+		return;
+	if (cnt == 0)
 		__pci_disable_ptm(dev);
 
 	parent = pci_upstream_ptm(dev);

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.43.0

