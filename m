Return-Path: <SRS0=OWH4=2B=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C812C00454
	for <linux-pci@archiver.kernel.org>; Wed, 11 Dec 2019 16:03:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 595A220836
	for <linux-pci@archiver.kernel.org>; Wed, 11 Dec 2019 16:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576080188;
	bh=nj7LlROC8TI5OK1/cknxOFNUCZdg690AQh9eYAuhSvU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cZlahHBdc40mfWtBga//jAQmaFl3vs8PoCRm2xmsPR6vj9GLOpoFPIgq1uPcVjJM3
	 Zwsl8fZJ6cv/8TOFkiiTV+BoYQcwbae2rfA43o2GQi0egUFwH+1QcC0ngIRWvVCAPB
	 4GpNZV9SyTWe76RpnE3MnQ1pi1vZQg8opBFd3mgg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388755AbfLKQDH (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 11 Dec 2019 11:03:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:35932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731326AbfLKPNF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 11 Dec 2019 10:13:05 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC4252467E;
        Wed, 11 Dec 2019 15:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576077184;
        bh=nj7LlROC8TI5OK1/cknxOFNUCZdg690AQh9eYAuhSvU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vZiEzAWCMArPlkfIh4EJzo8bTcWZlDi/eXKkh/ow2sJ2LNBCJCvvVgDXrukMLs/Q+
         OPlHr14VchMjvSH1Lydc31U3qk889UPqw+BtG0BrrwW6MWDzIjf2hOuy7kkb6XgLBK
         8ySuipKrNq4RGdJL6Kz6mbWANtsvrDxmUGFEGTy8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tyrel Datwyler <tyreld@linux.ibm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>, linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 068/134] PCI: rpaphp: Correctly match ibm, my-drc-index to drc-name when using drc-info
Date:   Wed, 11 Dec 2019 10:10:44 -0500
Message-Id: <20191211151150.19073-68-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191211151150.19073-1-sashal@kernel.org>
References: <20191211151150.19073-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Tyrel Datwyler <tyreld@linux.ibm.com>

[ Upstream commit 4f9f2d3d7a434b7f882b72550194c9278f4a3925 ]

The newer ibm,drc-info property is a condensed description of the old
ibm,drc-* properties (ie. names, types, indexes, and power-domains).
When matching a drc-index to a drc-name we need to verify that the
index is within the start and last drc-index range and map it to a
drc-name using the drc-name-prefix and logical index.

Fix the mapping by checking that the index is within the range of the
current drc-info entry, and build the name from the drc-name-prefix
concatenated with the starting drc-name-suffix value and the sequential
index obtained by subtracting ibm,my-drc-index from this entries
drc-start-index.

Signed-off-by: Tyrel Datwyler <tyreld@linux.ibm.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/1573449697-5448-10-git-send-email-tyreld@linux.ibm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/hotplug/rpaphp_core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/hotplug/rpaphp_core.c b/drivers/pci/hotplug/rpaphp_core.c
index abb10b3c0b70f..32eab1776cfea 100644
--- a/drivers/pci/hotplug/rpaphp_core.c
+++ b/drivers/pci/hotplug/rpaphp_core.c
@@ -248,9 +248,10 @@ static int rpaphp_check_drc_props_v2(struct device_node *dn, char *drc_name,
 		/* Should now know end of current entry */
 
 		/* Found it */
-		if (my_index <= drc.last_drc_index) {
+		if (my_index >= drc.drc_index_start && my_index <= drc.last_drc_index) {
+			int index = my_index - drc.drc_index_start;
 			sprintf(cell_drc_name, "%s%d", drc.drc_name_prefix,
-				my_index);
+				drc.drc_name_suffix_start + index);
 			break;
 		}
 	}
-- 
2.20.1

