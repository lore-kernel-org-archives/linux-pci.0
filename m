Return-Path: <SRS0=0+aG=3F=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36774C47409
	for <linux-pci@archiver.kernel.org>; Thu, 16 Jan 2020 18:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09D5D206E6
	for <linux-pci@archiver.kernel.org>; Thu, 16 Jan 2020 18:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579201173;
	bh=9HczM8KMjOh+/adQ1ElIg7yf0eKRvEpuG1TERGMTVsU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DKJk3hLsF8wp0zDwNlhOiAhydBhoeKYBelvM9Fp+91c3GkME00MBLDdE3/1B8i3vY
	 2aoUab45NZCNx2ae6rn0yK4/huGAK3WMhPPlmFoPQvHR58GrLLHBA7TzRXZz/qQTAw
	 ++8fhE3ie7ZyGxGgkaEILUOUABB0H3wh1D3cQhn0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388953AbgAPRGf (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:06:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:36950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388952AbgAPRGf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 16 Jan 2020 12:06:35 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ADD6321D56;
        Thu, 16 Jan 2020 17:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579194394;
        bh=9HczM8KMjOh+/adQ1ElIg7yf0eKRvEpuG1TERGMTVsU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iSrXDm60fG4ibhKWeBwnYiAtPD6gnH5Dk43R9oE+JAXUG9UPegJ+nVUjD7BWmEYst
         aKEKjALcZ8jEH2DZQcPUSJoEuhECAX1EUjXN8xTW8TGimS/fCvGxvBfQh8fsx+JiRY
         4H07OV9ya256uoqz2KX7VHl6WIia9BApPncQEh+k=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Srinath Mannam <srinath.mannam@broadcom.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ray Jui <ray.jui@broadcom.com>,
        Sasha Levin <sashal@kernel.org>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 321/671] PCI: iproc: Enable iProc config read for PAXBv2
Date:   Thu, 16 Jan 2020 11:59:19 -0500
Message-Id: <20200116170509.12787-58-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116170509.12787-1-sashal@kernel.org>
References: <20200116170509.12787-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Srinath Mannam <srinath.mannam@broadcom.com>

[ Upstream commit 8cff995405eb0b563e7a0d2c49838611ea3f2692 ]

iProc config read flag has to be enabled for PAXBv2 instead of PAXB.

Fixes: f78e60a29d4f ("PCI: iproc: Reject unconfigured physical functions from PAXC")
Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Reviewed-by: Ray Jui <ray.jui@broadcom.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/pcie-iproc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-iproc.c b/drivers/pci/controller/pcie-iproc.c
index c20fd6bd68fd..9d5cbc75d5ae 100644
--- a/drivers/pci/controller/pcie-iproc.c
+++ b/drivers/pci/controller/pcie-iproc.c
@@ -1347,7 +1347,6 @@ static int iproc_pcie_rev_init(struct iproc_pcie *pcie)
 		break;
 	case IPROC_PCIE_PAXB:
 		regs = iproc_pcie_reg_paxb;
-		pcie->iproc_cfg_read = true;
 		pcie->has_apb_err_disable = true;
 		if (pcie->need_ob_cfg) {
 			pcie->ob_map = paxb_ob_map;
@@ -1356,6 +1355,7 @@ static int iproc_pcie_rev_init(struct iproc_pcie *pcie)
 		break;
 	case IPROC_PCIE_PAXB_V2:
 		regs = iproc_pcie_reg_paxb_v2;
+		pcie->iproc_cfg_read = true;
 		pcie->has_apb_err_disable = true;
 		if (pcie->need_ob_cfg) {
 			pcie->ob_map = paxb_v2_ob_map;
-- 
2.20.1

