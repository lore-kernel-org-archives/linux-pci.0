Return-Path: <SRS0=vJ1S=YJ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 045CDECE599
	for <linux-pci@archiver.kernel.org>; Wed, 16 Oct 2019 19:44:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9BE621928
	for <linux-pci@archiver.kernel.org>; Wed, 16 Oct 2019 19:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571255095;
	bh=a+eVuLrgzrO9drVaHfvt7ADhX2JYoreKzv/cchTKdcQ=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=cynFc8tengOIpqjr6/cj2hRtGPqJRtmVBeNG9iE9pQbz7CiobReeS8NhptWlRrb1D
	 c2afLIjqg3T2EIoWKVTe+E6wuPVYu/pBTsvDf2Q1Ni+wLf3kzgmRsm6TbwhmiL2Jly
	 pCC7HQsLvUzlPE5ZZQ6NDoyU0Xq6D5m8unfrwLpI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729514AbfJPToz (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 16 Oct 2019 15:44:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:46124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727148AbfJPToy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 16 Oct 2019 15:44:54 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E780421835;
        Wed, 16 Oct 2019 19:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571255094;
        bh=a+eVuLrgzrO9drVaHfvt7ADhX2JYoreKzv/cchTKdcQ=;
        h=From:To:Cc:Subject:Date:From;
        b=N7P7XmA4fIAb2RTDSN/3aFMogQqqQYvmq9gt37Rv/aOR0GWsQTKokBBvpo/sQQeD1
         OK/EANIGdGZswaeiowWddtw470RJdK4eCZvHVLb7V0ogRRv55L1XD+kfXGDKZ86bHi
         IsAZDhY6XXrvSAjz7KwohX/b5JXXggeJL1k6O9DI=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] PCI/PM: Note that PME can be generated from D0
Date:   Wed, 16 Oct 2019 14:44:50 -0500
Message-Id: <20191016194450.68959-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.23.0.700.g56cf767bdb-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Per PCIe r5.0 sec 7.5.2.1, PME may be generated from D0, so update
Documentation/power/pci.rst to reflect that.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 Documentation/power/pci.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/power/pci.rst b/Documentation/power/pci.rst
index db41a770a2f5..a90e82c70a3b 100644
--- a/Documentation/power/pci.rst
+++ b/Documentation/power/pci.rst
@@ -130,8 +130,8 @@ a full power-on reset sequence and the power-on defaults are restored to the
 device by hardware just as at initial power up.
 
 PCI devices supporting the PCI PM Spec can be programmed to generate PMEs
-while in a low-power state (D1-D3), but they are not required to be capable
-of generating PMEs from all supported low-power states.  In particular, the
+while in any power state (D0-D3), but they are not required to be capable
+of generating PMEs from all supported power states.  In particular, the
 capability of generating PMEs from D3cold is optional and depends on the
 presence of additional voltage (3.3Vaux) allowing the device to remain
 sufficiently active to generate a wakeup signal.
-- 
2.23.0.700.g56cf767bdb-goog

