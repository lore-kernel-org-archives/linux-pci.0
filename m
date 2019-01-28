Return-Path: <SRS0=Vy8e=QE=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 016DCC282CD
	for <linux-pci@archiver.kernel.org>; Mon, 28 Jan 2019 16:16:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAB8421741
	for <linux-pci@archiver.kernel.org>; Mon, 28 Jan 2019 16:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548692160;
	bh=e8rBckPa6OfSFiHVUGNxCA0PN8DsslFtgy57zgJAjsA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mR/Fe03jjX3kUC9qC23/DMbjxHbznfuGncuZxfJ0Viteu/dpfuYxv12cF+iDrPhA9
	 O23teexxApaEV3rVohIo49mhKXLHJjdkX5vzRv/qdGHLNjXzRdMaK7o5DhvdWlcM5l
	 xCaEatpnNX0Neg/18gDKgK0SocvKHmV4Sreue1nc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733100AbfA1QP7 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:15:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:47160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732042AbfA1QP6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 28 Jan 2019 11:15:58 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F2D9E20879;
        Mon, 28 Jan 2019 16:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548692158;
        bh=e8rBckPa6OfSFiHVUGNxCA0PN8DsslFtgy57zgJAjsA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cn8cfUon387wZSkLcUz2y/dgpInlc+wP7ELJIVUT6XmIAlgdhi2vb6xhFb6rmYkzh
         k/qgkjTA/4EOw7OXS1IX2zUxMCAhbExiUdCvK8Uk3P7h59en0KezcCwus5vleyomUW
         KvXPufHD8JQTPD06socvLWMTFioFgzcALIoUQP5A=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Joey Zhang <joey.zhang@microchip.com>,
        Wesley Sheng <wesley.sheng@microchip.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sasha Levin <sashal@kernel.org>, linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 093/170] switchtec: Fix SWITCHTEC_IOCTL_EVENT_IDX_ALL flags overwrite
Date:   Mon, 28 Jan 2019 11:10:43 -0500
Message-Id: <20190128161200.55107-93-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128161200.55107-1-sashal@kernel.org>
References: <20190128161200.55107-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Joey Zhang <joey.zhang@microchip.com>

[ Upstream commit e4a7dca5de625018b29417ecc39dc5037d9a5a36 ]

In the ioctl_event_ctl() SWITCHTEC_IOCTL_EVENT_IDX_ALL case, we call
event_ctl() several times with the same "ctl" struct.  Each call clobbers
ctl.flags, which leads to the problem that we may not actually enable or
disable all events as the user requested.

Preserve the event flag value with a temporary variable.

Fixes: 52eabba5bcdb ("switchtec: Add IOCTLs to the Switchtec driver")
Signed-off-by: Joey Zhang <joey.zhang@microchip.com>
Signed-off-by: Wesley Sheng <wesley.sheng@microchip.com>
[bhelgaas: changelog]
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/switch/switchtec.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
index 620f5b995a12..e3aefdafae89 100644
--- a/drivers/pci/switch/switchtec.c
+++ b/drivers/pci/switch/switchtec.c
@@ -1064,6 +1064,7 @@ static int ioctl_event_ctl(struct switchtec_dev *stdev,
 {
 	int ret;
 	int nr_idxs;
+	unsigned int event_flags;
 	struct switchtec_ioctl_event_ctl ctl;
 
 	if (copy_from_user(&ctl, uctl, sizeof(ctl)))
@@ -1085,7 +1086,9 @@ static int ioctl_event_ctl(struct switchtec_dev *stdev,
 		else
 			return -EINVAL;
 
+		event_flags = ctl.flags;
 		for (ctl.index = 0; ctl.index < nr_idxs; ctl.index++) {
+			ctl.flags = event_flags;
 			ret = event_ctl(stdev, &ctl);
 			if (ret < 0)
 				return ret;
-- 
2.19.1

