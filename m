Return-Path: <SRS0=+Ydv=VQ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F4B2C76188
	for <linux-pci@archiver.kernel.org>; Fri, 19 Jul 2019 04:32:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 707E32082E
	for <linux-pci@archiver.kernel.org>; Fri, 19 Jul 2019 04:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563510778;
	bh=c+iRnZ27tC9FBRyjBCfA8nzhfMEhSdTERTls/ftsW8U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jjpq4EROn6/4moebbpsbvr2/zOoaKS4uK3RAGEBGdGeFRF/HJcU42FcWOGqtt+UpT
	 VmchDEzrcKtA8DJuyOkabZyrwabPtYax7cFukAZzvN98l8mQHz3+fXYB2NE7km2hEy
	 NDwsygPbuWioVMaiVwcTKoIIxo2qf4p8LyuX01bM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730473AbfGSEDh (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 19 Jul 2019 00:03:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:35678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730538AbfGSEDg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 19 Jul 2019 00:03:36 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05F9E218BB;
        Fri, 19 Jul 2019 04:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563509015;
        bh=c+iRnZ27tC9FBRyjBCfA8nzhfMEhSdTERTls/ftsW8U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e+lR9ZBlzwxJicApcquL9mcDjrtktcJfNitKAng7ZaLhCAvzMNtFZH7Gpw6j9c4Rr
         RlJpNYQJWpqy9mlAIZPTr1Qc4CIkQINATUnGPgidpeOQCFvgvWtcw5KIz37uBmiZxi
         fqMXuPm57jS2sUy4NAinK2dHUSMWI4FKqPTVjg+o=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alan Mikhak <alan.mikhak@sifive.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Sasha Levin <sashal@kernel.org>, linux-pci@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH AUTOSEL 5.1 022/141] tools: PCI: Fix broken pcitest compilation
Date:   Fri, 19 Jul 2019 00:00:47 -0400
Message-Id: <20190719040246.15945-22-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190719040246.15945-1-sashal@kernel.org>
References: <20190719040246.15945-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Alan Mikhak <alan.mikhak@sifive.com>

[ Upstream commit 8a5e0af240e07dd3d4897eb8ff52aab757da7fab ]

pcitest is currently broken due to the following compiler error
and related warning. Fix by changing the run_test() function
signature to return an integer result.

pcitest.c: In function run_test:
pcitest.c:143:9: warning: return with a value, in function
returning void
  return (ret < 0) ? ret : 1 - ret; /* return 0 if test succeeded */

pcitest.c: In function main:
pcitest.c:232:9: error: void value not ignored as it ought to be
  return run_test(test);

Fixes: fef31ecaaf2c ("tools: PCI: Fix compilation warnings")
Signed-off-by: Alan Mikhak <alan.mikhak@sifive.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Reviewed-by: Paul Walmsley <paul.walmsley@sifive.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/pci/pcitest.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/pci/pcitest.c b/tools/pci/pcitest.c
index ec4d51f3308b..4c5be77c211f 100644
--- a/tools/pci/pcitest.c
+++ b/tools/pci/pcitest.c
@@ -47,15 +47,15 @@ struct pci_test {
 	unsigned long	size;
 };
 
-static void run_test(struct pci_test *test)
+static int run_test(struct pci_test *test)
 {
-	long ret;
+	int ret = -EINVAL;
 	int fd;
 
 	fd = open(test->device, O_RDWR);
 	if (fd < 0) {
 		perror("can't open PCI Endpoint Test device");
-		return;
+		return -ENODEV;
 	}
 
 	if (test->barnum >= 0 && test->barnum <= 5) {
-- 
2.20.1

