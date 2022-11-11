Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4E09C43217
	for <linux-pci@archiver.kernel.org>; Fri, 11 Nov 2022 14:27:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233817AbiKKO1e (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 11 Nov 2022 09:27:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231261AbiKKO1a (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Nov 2022 09:27:30 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 257E11AD;
        Fri, 11 Nov 2022 06:27:29 -0800 (PST)
Received: from kwepemi100025.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4N81Hg1GfHzmVpr;
        Fri, 11 Nov 2022 22:27:11 +0800 (CST)
Received: from DESKTOP-27KDQMV.china.huawei.com (10.174.148.223) by
 kwepemi100025.china.huawei.com (7.221.188.158) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 11 Nov 2022 22:27:26 +0800
From:   "Longpeng(Mike)" <longpeng2@huawei.com>
To:     <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <jianjay.zhou@huawei.com>, <zhuangshengen@huawei.com>,
        <arei.gonglei@huawei.com>, <yechuan@huawei.com>,
        <huangzhichao@huawei.com>, <xiehong@huawei.com>,
        Longpeng <longpeng2@huawei.com>
Subject: [RFC 1/4] pci/sriov: extract sriov_numvfs common helper
Date:   Fri, 11 Nov 2022 22:27:19 +0800
Message-ID: <20221111142722.1172-2-longpeng2@huawei.com>
X-Mailer: git-send-email 2.25.0.windows.1
In-Reply-To: <20221111142722.1172-1-longpeng2@huawei.com>
References: <20221111142722.1172-1-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.148.223]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi100025.china.huawei.com (7.221.188.158)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Longpeng <longpeng2@huawei.com>

Extract a common helper to set sriov nums.

Signed-off-by: Longpeng <longpeng2@huawei.com>
---
 drivers/pci/iov.c | 38 +++++++++++++++++++++++---------------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 952217572113..3b441cd92960 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -406,23 +406,9 @@ static ssize_t sriov_numvfs_show(struct device *dev,
 	return sysfs_emit(buf, "%u\n", num_vfs);
 }
 
-/*
- * num_vfs > 0; number of VFs to enable
- * num_vfs = 0; disable all VFs
- *
- * Note: SRIOV spec does not allow partial VF
- *	 disable, so it's all or none.
- */
-static ssize_t sriov_numvfs_store(struct device *dev,
-				  struct device_attribute *attr,
-				  const char *buf, size_t count)
+static int sriov_numvfs_common(struct pci_dev *pdev, u16 num_vfs)
 {
-	struct pci_dev *pdev = to_pci_dev(dev);
 	int ret = 0;
-	u16 num_vfs;
-
-	if (kstrtou16(buf, 0, &num_vfs) < 0)
-		return -EINVAL;
 
 	if (num_vfs > pci_sriov_get_totalvfs(pdev))
 		return -ERANGE;
@@ -471,6 +457,28 @@ static ssize_t sriov_numvfs_store(struct device *dev,
 exit:
 	device_unlock(&pdev->dev);
 
+	return ret;
+}
+
+/*
+ * num_vfs > 0; number of VFs to enable
+ * num_vfs = 0; disable all VFs
+ *
+ * Note: SRIOV spec does not allow partial VF
+ *	 disable, so it's all or none.
+ */
+static ssize_t sriov_numvfs_store(struct device *dev,
+				  struct device_attribute *attr,
+				  const char *buf, size_t count)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	int ret;
+	u16 num_vfs;
+
+	if (kstrtou16(buf, 0, &num_vfs) < 0)
+		return -EINVAL;
+
+	ret = sriov_numvfs_common(pdev, num_vfs);
 	if (ret < 0)
 		return ret;
 
-- 
2.23.0

