Return-Path: <linux-pci-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC978C41513
	for <linux-pci@archiver.kernel.org>; Thu,  3 Aug 2023 13:03:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233620AbjHCND6 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 3 Aug 2023 09:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235867AbjHCNDv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Aug 2023 09:03:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3FE61702;
        Thu,  3 Aug 2023 06:03:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 356FB61D9D;
        Thu,  3 Aug 2023 13:03:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A121C433C9;
        Thu,  3 Aug 2023 13:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691067810;
        bh=EPikV/PRmu4Q4MQ/8jF1ykyFZwdSFeXvbtsbFXlTz4I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ev0hFd6+hVftG4l0sb7Rmq5mU+by/GzZA9JwgXYabccV977W7iIosgLrttBfMHZTe
         iExkyAfso1ioOe7CpWYG1TRlWgPczVw+OAQnoFPwqoqfzG68e91XcFYZO/GfiG9+hj
         xJoE6BySP+7xlD0zRYN8UyKtCn3MFkUHrVUiiRAJtkMHzEMK9KuF6+3/ObD05Ptz80
         3/HYximGjGPNcJVnWr2Ujz40CLihWjUp4O4tmOgAVbLTBgmeCoy6vgKDA6QV9At6R9
         BQPWsn2Z1LnJKSn0mPhu6gXTCvhq7t5pAnNC89GbLGrjpUXggsADsWbywdTtj5UMcM
         s5y9nd1rphSZw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     ruanjinjie <ruanjinjie@huawei.com>, Jon Mason <jdmason@kudzu.us>,
        Sasha Levin <sashal@kernel.org>, dave.jiang@intel.com,
        allenbh@gmail.com, lpieralisi@kernel.org, kw@linux.com,
        bhelgaas@google.com, ntb@lists.linux.dev, linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 6.4 5/7] NTB: EPF: fix possible memory leak in pci_vntb_probe()
Date:   Thu,  3 Aug 2023 09:03:18 -0400
Message-Id: <20230803130321.641516-5-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230803130321.641516-1-sashal@kernel.org>
References: <20230803130321.641516-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.7
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: ruanjinjie <ruanjinjie@huawei.com>

[ Upstream commit 956578e3d397e00d6254dc7b5194d28587f98518 ]

As ntb_register_device() don't handle error of device_register(),
if ntb_register_device() returns error in pci_vntb_probe(), name of kobject
which is allocated in dev_set_name() called in device_add() is leaked.

As comment of device_add() says, it should call put_device() to drop the
reference count that was set in device_initialize()
when it fails, so the name can be freed in kobject_cleanup().

Signed-off-by: ruanjinjie <ruanjinjie@huawei.com>
Signed-off-by: Jon Mason <jdmason@kudzu.us>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index b7c7a8af99f4f..77306983ac456 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -1285,6 +1285,7 @@ static int pci_vntb_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	return 0;
 
 err_register_dev:
+	put_device(&ndev->ntb.dev);
 	return -EINVAL;
 }
 
-- 
2.40.1

