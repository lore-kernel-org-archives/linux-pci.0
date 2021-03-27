Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC625C433DB
	for <linux-pci@archiver.kernel.org>; Sat, 27 Mar 2021 12:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC651619C7
	for <linux-pci@archiver.kernel.org>; Sat, 27 Mar 2021 12:11:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbhC0MLR (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 27 Mar 2021 08:11:17 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:15017 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbhC0MLO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 27 Mar 2021 08:11:14 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F6yKv1mQtzPt3b;
        Sat, 27 Mar 2021 20:08:35 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.498.0; Sat, 27 Mar 2021 20:11:02 +0800
From:   Xiaofei Tan <tanxiaofei@huawei.com>
To:     <rjw@rjwysocki.net>, <lenb@kernel.org>, <rui.zhang@intel.com>,
        <bhelgaas@google.com>
CC:     Xiaofei Tan <tanxiaofei@huawei.com>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linuxarm@openeuler.org>
Subject: [PATCH v3 11/12] ACPI: sysfs: fix some coding style issues
Date:   Sat, 27 Mar 2021 20:08:23 +0800
Message-ID: <1616846904-25719-12-git-send-email-tanxiaofei@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1616846904-25719-1-git-send-email-tanxiaofei@huawei.com>
References: <1616846904-25719-1-git-send-email-tanxiaofei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Fix some coding style issues reported by checkpatch.pl, including
following types:

WARNING: Missing a blank line after declarations
WARNING: Block comments should align the * on each line
ERROR: open brace '{' following function definitions go on the next line

Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
---
 drivers/acpi/device_sysfs.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/device_sysfs.c b/drivers/acpi/device_sysfs.c
index da4ff2a..a07d4ad 100644
--- a/drivers/acpi/device_sysfs.c
+++ b/drivers/acpi/device_sysfs.c
@@ -73,6 +73,7 @@ static const struct sysfs_ops acpi_data_node_sysfs_ops = {
 static void acpi_data_node_release(struct kobject *kobj)
 {
 	struct acpi_data_node *dn = to_data_node(kobj);
+
 	complete(&dn->kobj_done);
 }
 
@@ -130,7 +131,7 @@ static void acpi_hide_nondev_subnodes(struct acpi_device_data *data)
  * Return: 0: no _HID and no _CID
  *         -EINVAL: output error
  *         -ENOMEM: output is truncated
-*/
+ */
 static int create_pnp_modalias(struct acpi_device *acpi_dev, char *modalias,
 			       int size)
 {
@@ -431,7 +432,8 @@ static DEVICE_ATTR_RO(path);
 /* sysfs file that shows description text from the ACPI _STR method */
 static ssize_t description_show(struct device *dev,
 				struct device_attribute *attr,
-				char *buf) {
+				char *buf)
+{
 	struct acpi_device *acpi_dev = to_acpi_device(dev);
 	int result;
 
@@ -456,7 +458,8 @@ static DEVICE_ATTR_RO(description);
 
 static ssize_t
 sun_show(struct device *dev, struct device_attribute *attr,
-	 char *buf) {
+	 char *buf)
+{
 	struct acpi_device *acpi_dev = to_acpi_device(dev);
 	acpi_status status;
 	unsigned long long sun;
@@ -471,7 +474,8 @@ static DEVICE_ATTR_RO(sun);
 
 static ssize_t
 hrv_show(struct device *dev, struct device_attribute *attr,
-	 char *buf) {
+	 char *buf)
+{
 	struct acpi_device *acpi_dev = to_acpi_device(dev);
 	acpi_status status;
 	unsigned long long hrv;
@@ -485,7 +489,8 @@ hrv_show(struct device *dev, struct device_attribute *attr,
 static DEVICE_ATTR_RO(hrv);
 
 static ssize_t status_show(struct device *dev, struct device_attribute *attr,
-				char *buf) {
+				char *buf)
+{
 	struct acpi_device *acpi_dev = to_acpi_device(dev);
 	acpi_status status;
 	unsigned long long sta;
-- 
2.8.1

