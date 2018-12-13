Return-Path: <SRS0=IRPw=OW=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC90AC65BAE
	for <linux-pci@archiver.kernel.org>; Thu, 13 Dec 2018 17:54:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A284120879
	for <linux-pci@archiver.kernel.org>; Thu, 13 Dec 2018 17:54:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A284120879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbeLMRyg (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 13 Dec 2018 12:54:36 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47538 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727511AbeLMRyg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Dec 2018 12:54:36 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wBDHsLaE096497
        for <linux-pci@vger.kernel.org>; Thu, 13 Dec 2018 12:54:35 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2pbrnyv24g-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-pci@vger.kernel.org>; Thu, 13 Dec 2018 12:54:35 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pci@vger.kernel.org> from <sebott@linux.ibm.com>;
        Thu, 13 Dec 2018 17:54:33 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 13 Dec 2018 17:54:29 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wBDHsS6J328046
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 13 Dec 2018 17:54:28 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AFE7F42047;
        Thu, 13 Dec 2018 17:54:28 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6C5A34203F;
        Thu, 13 Dec 2018 17:54:28 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 13 Dec 2018 17:54:28 +0000 (GMT)
From:   Sebastian Ott <sebott@linux.ibm.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Russell Currey <ruscur@russell.cc>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/2] PCI: provide pcibios_sriov_add_vfs
Date:   Thu, 13 Dec 2018 18:54:27 +0100
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20181212215453.GJ99796@google.com>
References: <20181212215453.GJ99796@google.com>
X-TM-AS-GCONF: 00
x-cbid: 18121317-0012-0000-0000-000002D8A39C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18121317-0013-0000-0000-0000210E2BC1
Message-Id: <20181213175428.87520-1-sebott@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-13_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=811 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812130154
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Move VF detection and device creation code to weak functions
such that architectures can provide a different implementation.

Signed-off-by: Sebastian Ott <sebott@linux.ibm.com>
---
 drivers/pci/iov.c   | 43 +++++++++++++++++++++++++++++++------------
 include/linux/pci.h |  2 ++
 2 files changed, 33 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 9616eca3182f..1bfdb4deafd7 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -252,6 +252,33 @@ int __weak pcibios_sriov_disable(struct pci_dev *pdev)
 	return 0;
 }
 
+int __weak pcibios_sriov_add_vfs(struct pci_dev *dev, u16 num_vfs)
+{
+	unsigned int i;
+	int rc;
+
+	for (i = 0; i < num_vfs; i++) {
+		rc = pci_iov_add_virtfn(dev, i);
+		if (rc)
+			goto failed;
+	}
+	return 0;
+failed:
+	while (i--)
+		pci_iov_remove_virtfn(dev, i);
+
+	return rc;
+}
+
+void __weak pcibios_sriov_del_vfs(struct pci_dev *dev)
+{
+	struct pci_sriov *iov = dev->sriov;
+	int i;
+
+	for (i = 0; i < iov->num_VFs; i++)
+		pci_iov_remove_virtfn(dev, i);
+}
+
 static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
 {
 	int rc;
@@ -337,21 +364,15 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
 	msleep(100);
 	pci_cfg_access_unlock(dev);
 
-	for (i = 0; i < initial; i++) {
-		rc = pci_iov_add_virtfn(dev, i);
-		if (rc)
-			goto failed;
-	}
+	rc = pcibios_sriov_add_vfs(dev, initial);
+	if (rc)
+		goto err_pcibios;
 
 	kobject_uevent(&dev->dev.kobj, KOBJ_CHANGE);
 	iov->num_VFs = nr_virtfn;
 
 	return 0;
 
-failed:
-	while (i--)
-		pci_iov_remove_virtfn(dev, i);
-
 err_pcibios:
 	iov->ctrl &= ~(PCI_SRIOV_CTRL_VFE | PCI_SRIOV_CTRL_MSE);
 	pci_cfg_access_lock(dev);
@@ -370,14 +391,12 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
 
 static void sriov_disable(struct pci_dev *dev)
 {
-	int i;
 	struct pci_sriov *iov = dev->sriov;
 
 	if (!iov->num_VFs)
 		return;
 
-	for (i = 0; i < iov->num_VFs; i++)
-		pci_iov_remove_virtfn(dev, i);
+	pcibios_sriov_del_vfs(dev);
 
 	iov->ctrl &= ~(PCI_SRIOV_CTRL_VFE | PCI_SRIOV_CTRL_MSE);
 	pci_cfg_access_lock(dev);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 11c71c4ecf75..84ca3bcdac76 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2001,6 +2001,8 @@ void pci_vf_drivers_autoprobe(struct pci_dev *dev, bool probe);
 /* Arch may override these (weak) */
 int pcibios_sriov_enable(struct pci_dev *pdev, u16 num_vfs);
 int pcibios_sriov_disable(struct pci_dev *pdev);
+int pcibios_sriov_add_vfs(struct pci_dev *dev, u16 num_vfs);
+void pcibios_sriov_del_vfs(struct pci_dev *dev);
 resource_size_t pcibios_iov_resource_alignment(struct pci_dev *dev, int resno);
 #else
 static inline int pci_iov_virtfn_bus(struct pci_dev *dev, int id)
-- 
2.16.4

