Return-Path: <SRS0=q0B1=N6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B9EC43441
	for <linux-pci@archiver.kernel.org>; Mon, 19 Nov 2018 10:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36F8F20831
	for <linux-pci@archiver.kernel.org>; Mon, 19 Nov 2018 10:00:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="V5Bjj6j9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36F8F20831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727538AbeKSUXe (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 19 Nov 2018 15:23:34 -0500
Received: from mail.kmu-office.ch ([178.209.48.109]:55958 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727084AbeKSUXe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Nov 2018 15:23:34 -0500
Received: from trochilidae.toradex.int (unknown [46.140.72.82])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 52EBF5C0929;
        Mon, 19 Nov 2018 11:00:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1542621624;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=u4sH42QZFsG+/4JYB0YvPqfe4PfL86ZFMDVPD+K9uGA=;
        b=V5Bjj6j94oKYYCvqktapozcLtUv7UT5LQvrKN5SrAzoO0yV9Re6Ta1QqeKCe/wD2mF5UQl
        IVq9E6xRzcteY3QvxThBAlyRwkDDwHCx6PsBx8lXPmiEfVdbOQIplNlvXpwAzAKo7L+bO4
        t5wU0yBlszS3owDNqpqOsJwqioN0WxA=
From:   Stefan Agner <stefan@agner.ch>
To:     minghuan.Lian@nxp.com, mingkai.hu@nxp.com, roy.zang@nxp.com
Cc:     lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>
Subject: [PATCH] PCI: dwc: layerscape: constify driver data
Date:   Mon, 19 Nov 2018 11:00:22 +0100
Message-Id: <20181119100022.27501-1-stefan@agner.ch>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Constify driver data since they don't get changed at runtime.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 drivers/pci/controller/dwc/pci-layerscape.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-layerscape.c b/drivers/pci/controller/dwc/pci-layerscape.c
index 3724d3ef7008..905a0ab0e6fa 100644
--- a/drivers/pci/controller/dwc/pci-layerscape.c
+++ b/drivers/pci/controller/dwc/pci-layerscape.c
@@ -222,12 +222,12 @@ static const struct dw_pcie_ops dw_ls_pcie_ops = {
 	.link_up = ls_pcie_link_up,
 };
 
-static struct ls_pcie_drvdata ls1021_drvdata = {
+static const struct ls_pcie_drvdata ls1021_drvdata = {
 	.ops = &ls1021_pcie_host_ops,
 	.dw_pcie_ops = &dw_ls1021_pcie_ops,
 };
 
-static struct ls_pcie_drvdata ls1043_drvdata = {
+static const struct ls_pcie_drvdata ls1043_drvdata = {
 	.lut_offset = 0x10000,
 	.ltssm_shift = 24,
 	.lut_dbg = 0x7fc,
@@ -235,7 +235,7 @@ static struct ls_pcie_drvdata ls1043_drvdata = {
 	.dw_pcie_ops = &dw_ls_pcie_ops,
 };
 
-static struct ls_pcie_drvdata ls1046_drvdata = {
+static const struct ls_pcie_drvdata ls1046_drvdata = {
 	.lut_offset = 0x80000,
 	.ltssm_shift = 24,
 	.lut_dbg = 0x407fc,
@@ -243,7 +243,7 @@ static struct ls_pcie_drvdata ls1046_drvdata = {
 	.dw_pcie_ops = &dw_ls_pcie_ops,
 };
 
-static struct ls_pcie_drvdata ls2080_drvdata = {
+static const struct ls_pcie_drvdata ls2080_drvdata = {
 	.lut_offset = 0x80000,
 	.ltssm_shift = 0,
 	.lut_dbg = 0x7fc,
@@ -251,7 +251,7 @@ static struct ls_pcie_drvdata ls2080_drvdata = {
 	.dw_pcie_ops = &dw_ls_pcie_ops,
 };
 
-static struct ls_pcie_drvdata ls2088_drvdata = {
+static const struct ls_pcie_drvdata ls2088_drvdata = {
 	.lut_offset = 0x80000,
 	.ltssm_shift = 0,
 	.lut_dbg = 0x407fc,
-- 
2.19.1

