Return-Path: <SRS0=L200=SY=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	TVD_PH_BODY_ACCOUNTS_PRE autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48F52C10F11
	for <linux-pci@archiver.kernel.org>; Mon, 22 Apr 2019 22:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20C2F20811
	for <linux-pci@archiver.kernel.org>; Mon, 22 Apr 2019 22:43:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729963AbfDVWne (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 22 Apr 2019 18:43:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51068 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728965AbfDVWne (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 22 Apr 2019 18:43:34 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2E5B23091786;
        Mon, 22 Apr 2019 22:43:34 +0000 (UTC)
Received: from gimli.home (ovpn-116-122.phx2.redhat.com [10.3.116.122])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0D3095C28D;
        Mon, 22 Apr 2019 22:43:30 +0000 (UTC)
Subject: [PATCH] PCI/LINK: Account for BW notification in vector calculation
From:   Alex Williamson <alex.williamson@redhat.com>
To:     bhelgaas@google.com, helgaas@kernel.org, mr.nuke.me@gmail.com,
        linux-pci@vger.kernel.org
Cc:     austin_bolen@dell.com, alex_gagniuc@dellteam.com,
        keith.busch@intel.com, Shyam_Iyer@Dell.com, lukas@wunner.de,
        okaya@kernel.org, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 22 Apr 2019 16:43:30 -0600
Message-ID: <155597243666.19387.1205950870601742062.stgit@gimli.home>
User-Agent: StGit/0.19-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Mon, 22 Apr 2019 22:43:34 +0000 (UTC)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On systems that don't support any PCIe services other than bandwidth
notification, pcie_message_numbers() can return zero vectors, causing
the vector reallocation in pcie_port_enable_irq_vec() to retry with
zero, which fails, resulting in fallback to INTx (which might be
broken) for the bandwidth notification service.  This can resolve
spurious interrupt faults due to this service on some systems.

Fixes: e8303bb7a75c ("PCI/LINK: Report degraded links via link bandwidth notification")
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---

However, the system is still susceptible to random spew in dmesg
depending on how the root port handles downstream device managed link
speed changes.  For example, GPUs like to scale their link speed for
power management when idle.  A GPU assigned to a VM through vfio-pci
can generate link bandwidth notification every time the link is
scaled down, ex:

[  329.725607] vfio-pci 0000:07:00.0: 32.000 Gb/s available PCIe bandwidth,
limited by 2.5 GT/s x16 link at 0000:00:02.0 (capable of 64.000 Gb/s with 5
GT/s x16 link)
[  708.151488] vfio-pci 0000:07:00.0: 32.000 Gb/s available PCIe bandwidth,
limited by 2.5 GT/s x16 link at 0000:00:02.0 (capable of 64.000 Gb/s with 5
GT/s x16 link)
[  718.262959] vfio-pci 0000:07:00.0: 32.000 Gb/s available PCIe bandwidth,
limited by 2.5 GT/s x16 link at 0000:00:02.0 (capable of 64.000 Gb/s with 5
GT/s x16 link)
[ 1138.124932] vfio-pci 0000:07:00.0: 32.000 Gb/s available PCIe bandwidth,
limited by 2.5 GT/s x16 link at 0000:00:02.0 (capable of 64.000 Gb/s with 5
GT/s x16 link)

What is the value of this nagging?

 drivers/pci/pcie/portdrv_core.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index 7d04f9d087a6..1b330129089f 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -55,7 +55,8 @@ static int pcie_message_numbers(struct pci_dev *dev, int mask,
 	 * 7.8.2, 7.10.10, 7.31.2.
 	 */
 
-	if (mask & (PCIE_PORT_SERVICE_PME | PCIE_PORT_SERVICE_HP)) {
+	if (mask & (PCIE_PORT_SERVICE_PME | PCIE_PORT_SERVICE_HP |
+		    PCIE_PORT_SERVICE_BWNOTIF)) {
 		pcie_capability_read_word(dev, PCI_EXP_FLAGS, &reg16);
 		*pme = (reg16 & PCI_EXP_FLAGS_IRQ) >> 9;
 		nvec = *pme + 1;

