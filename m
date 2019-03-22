Return-Path: <SRS0=nTPQ=RZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DATE_IN_PAST_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 167B2C43381
	for <linux-pci@archiver.kernel.org>; Fri, 22 Mar 2019 23:35:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D20C0218D3
	for <linux-pci@archiver.kernel.org>; Fri, 22 Mar 2019 23:35:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbfCVXfQ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 22 Mar 2019 19:35:16 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45080 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726896AbfCVXfP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Mar 2019 19:35:15 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2MNSwDt090676
        for <linux-pci@vger.kernel.org>; Fri, 22 Mar 2019 19:35:14 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rd4pyjhbq-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-pci@vger.kernel.org>; Fri, 22 Mar 2019 19:35:14 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pci@vger.kernel.org> from <tyreld@linux.vnet.ibm.com>;
        Fri, 22 Mar 2019 23:35:14 -0000
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 22 Mar 2019 23:35:12 -0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2MNZA2i17432684
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Mar 2019 23:35:10 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E0BB9112062;
        Fri, 22 Mar 2019 23:35:09 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 750F3112061;
        Fri, 22 Mar 2019 23:35:09 +0000 (GMT)
Received: from linux-xej6.aus.stglabs.ibm.com (unknown [9.40.195.184])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 22 Mar 2019 23:35:09 +0000 (GMT)
From:   Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Subject: [PATCH 1/2] pci: rpadlpar: fix leaked device_node references in add/remove paths
Date:   Fri, 22 Mar 2019 13:27:21 -0500
X-Mailer: git-send-email 2.12.3
X-TM-AS-GCONF: 00
x-cbid: 19032223-2213-0000-0000-00000368DB32
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010797; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000282; SDB=6.01178238; UDB=6.00616426; IPR=6.00958937;
 MB=3.00026118; MTD=3.00000008; XFM=3.00000015; UTC=2019-03-22 23:35:13
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032223-2214-0000-0000-00005DC39711
Message-Id: <20190322182722.8255-1-tyreld@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-22_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903220167
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The find_dlpar_node() helper returns a device node with its reference
incremented. Both the add and remove paths use this helper for find the
appropriate node, but fail to release the reference when done.

Annotate the find_dlpar_node() helper with a comment about the incremented
reference count, and call of_node_put() on the obtained device_node in the
add and remove paths. Also, fixup a reference leak in the find_vio_slot()
helper where we fail to call of_node_put() on the vdevice node after we
iterate over its children.

Signed-off-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
---
 drivers/pci/hotplug/rpadlpar_core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/hotplug/rpadlpar_core.c b/drivers/pci/hotplug/rpadlpar_core.c
index e2356a9c7088..182f9e3443ee 100644
--- a/drivers/pci/hotplug/rpadlpar_core.c
+++ b/drivers/pci/hotplug/rpadlpar_core.c
@@ -51,6 +51,7 @@ static struct device_node *find_vio_slot_node(char *drc_name)
 		if (rc == 0)
 			break;
 	}
+	of_node_put(parent);
 
 	return dn;
 }
@@ -71,6 +72,7 @@ static struct device_node *find_php_slot_pci_node(char *drc_name,
 	return np;
 }
 
+/* Returns a device_node with its reference count incremented */
 static struct device_node *find_dlpar_node(char *drc_name, int *node_type)
 {
 	struct device_node *dn;
@@ -306,6 +308,7 @@ int dlpar_add_slot(char *drc_name)
 			rc = dlpar_add_phb(drc_name, dn);
 			break;
 	}
+	of_node_put(dn);
 
 	printk(KERN_INFO "%s: slot %s added\n", DLPAR_MODULE_NAME, drc_name);
 exit:
@@ -439,6 +442,7 @@ int dlpar_remove_slot(char *drc_name)
 			rc = dlpar_remove_pci_slot(drc_name, dn);
 			break;
 	}
+	of_node_put(dn);
 	vm_unmap_aliases();
 
 	printk(KERN_INFO "%s: slot %s removed\n", DLPAR_MODULE_NAME, drc_name);
-- 
2.12.3

