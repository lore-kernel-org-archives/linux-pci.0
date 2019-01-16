Return-Path: <SRS0=IDzV=PY=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0DBBC43387
	for <linux-pci@archiver.kernel.org>; Wed, 16 Jan 2019 13:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C88E2206C2
	for <linux-pci@archiver.kernel.org>; Wed, 16 Jan 2019 13:56:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733254AbfAPN4N (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 16 Jan 2019 08:56:13 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:52784 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727935AbfAPN4N (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 16 Jan 2019 08:56:13 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id BE81E2B175610BBC9578;
        Wed, 16 Jan 2019 21:56:10 +0800 (CST)
Received: from linux-ioko.site (10.71.200.31) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.408.0; Wed, 16 Jan 2019 21:56:02 +0800
From:   Dongdong Liu <liudongdong3@huawei.com>
To:     <helgaas@kernel.org>, <lukas@wunner.de>,
        <lorenzo.pieralisi@arm.com>
CC:     <linux-pci@vger.kernel.org>, <linuxarm@huawei.com>,
        <john.garry@huawei.com>, Dongdong Liu <liudongdong3@huawei.com>
Subject: [RFC PATCH] PCI: hotplug: Fix surprise removal report card present and link failed
Date:   Wed, 16 Jan 2019 22:31:04 +0800
Message-ID: <1547649064-19019-1-git-send-email-liudongdong3@huawei.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.200.31]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The lspci -tv topology is as below.
 +-[0000:80]-+-00.0-[81]----00.0  Huawei Technologies Co., Ltd. Device 3714
 |           +-02.0-[82]----00.0  Huawei Technologies Co., Ltd. Device 3714
 |           +-04.0-[83]----00.0  Huawei Technologies Co., Ltd. Device 3714
 |           +-06.0-[84]----00.0  Huawei Technologies Co., Ltd. Device 3714
 |           +-10.0-[87]----00.0  Huawei Technologies Co., Ltd. Device 3714

Then surprise removal 87:00.0 NVME SSD card. The message is as below.

pciehp 0000:80:10.0:pcie004: Slot(36): Link Down
iommu: Removing device 0000:87:00.0 from group 12
pciehp 0000:80:10.0:pcie004: Slot(36): Card present
pcieport 0000:80:10.0: Data Link Layer Link Active not set in 1000 msec
pciehp 0000:80:10.0:pcie004: Failed to check link status

Then lspci -s 80:10.0 -vvv|grep -i SltSta
SltSta:Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock
We can see the card is not present (PresDet-).

pciehp 0000:80:10.0:pcie004: Slot #36 AttnBtn- PwrCtrl- MRL- AttnInd+
PwrInd+ HotPlug+ Surprise+ Interlock- NoCompl- LLActRep+

The NVME SSD card is permited to surprise removal with slot power on
on the D06 board. The hotplug port's POWER_CTRL(ctrl) is false.

Data link layer state changed (link down) event reported prior to presence
detect changed (card is not present) when surprise removal.

Current code pciehp_handle_presence_or_link_change() handle link down event,
then check the card present, but at this time presence detect state have
not updated, so have such issue. If surprise removal and power controller
present is not implemented, wait for at least 1 second before checking
card present to fix the issue.

Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>
---
 drivers/pci/hotplug/pciehp_ctrl.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
index 3f3df4c..ef8952d 100644
--- a/drivers/pci/hotplug/pciehp_ctrl.c
+++ b/drivers/pci/hotplug/pciehp_ctrl.c
@@ -216,6 +216,7 @@ void pciehp_handle_disable_request(struct controller *ctrl)
 void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
 {
 	bool present, link_active;
+	bool safe_removal = SAFE_REMOVAL;
 
 	/*
 	 * If the slot is on and presence or link has changed, turn it off.
@@ -236,6 +237,7 @@ void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
 			ctrl_info(ctrl, "Slot(%s): Card not present\n",
 				  slot_name(ctrl));
 		pciehp_disable_slot(ctrl, SURPRISE_REMOVAL);
+		safe_removal = SURPRISE_REMOVAL;
 		break;
 	default:
 		mutex_unlock(&ctrl->state_lock);
@@ -244,6 +246,15 @@ void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
 
 	/* Turn the slot on if it's occupied or link is up */
 	mutex_lock(&ctrl->state_lock);
+	/*
+	 * if surprise removal and power controller present is not implemented,
+	 * wait for at least 1 second before checking card present as
+	 * data link layer state changed (link down) event reported
+	 * prior to presence detect changed (card is not present).
+	 */
+	if (!safe_removal && !POWER_CTRL(ctrl))
+		msleep(1000);
+
 	present = pciehp_card_present(ctrl);
 	link_active = pciehp_check_link_active(ctrl);
 	if (!present && !link_active) {
-- 
1.9.1

