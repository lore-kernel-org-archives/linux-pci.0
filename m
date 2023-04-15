Return-Path: <linux-pci-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 893F1C77B72
	for <linux-pci@archiver.kernel.org>; Sat, 15 Apr 2023 02:35:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbjDOCf5 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 14 Apr 2023 22:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbjDOCf4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Apr 2023 22:35:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2426F1BDB
        for <linux-pci@vger.kernel.org>; Fri, 14 Apr 2023 19:35:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A5F7461730
        for <linux-pci@vger.kernel.org>; Sat, 15 Apr 2023 02:35:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4C64C433D2;
        Sat, 15 Apr 2023 02:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681526154;
        bh=cX80ud/WhHTVycg2SPu+RpTJFPUlrMDoGUp79KlHQzI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kov4Lq3A36oNNVGxiu0dJ5XEt1YCSoDPqozhP2EnA8inkhBX4jpPJUoppl3VNwNCr
         l4LzYQ+AtCOzuPPi3DzWU86Avc7r6Z+GZfvGMImKlkP+LbcjO2LO+5CZCIghc08hNi
         h7JfRrOZER9rloF2N0eoEiZuSxUDNleOPWM0S38O3JxZwX44HOElrdIoufR1DDQTjS
         G1E7floDy75xH1fYwR+SD1tNRiXiKo0L4+Ua10jRcj2TTLV9uVbXEaMsUxKOYJU8lD
         /5mX3VfBMFroWBL621JwEPzrUhXNsPRb83Itu7zwF9U2xWwCWyiwJlkpYdraOUtwzF
         A6ZXtbBUHjxYg==
From:   Damien Le Moal <dlemoal@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc:     Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v5 05/17] PCI: epf-test: Use dmaengine_submit() to initiate DMA transfer
Date:   Sat, 15 Apr 2023 11:35:30 +0900
Message-Id: <20230415023542.77601-6-dlemoal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230415023542.77601-1-dlemoal@kernel.org>
References: <20230415023542.77601-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Instead of an open coded call to the tx_submit() operation of struct
dma_async_tx_descriptor, use the helper function dmaengine_submit().
No functional change is introduced with this.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index dbea6eb0dee7..7cdc6c915ef5 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -163,7 +163,7 @@ static int pci_epf_test_data_transfer(struct pci_epf_test *epf_test,
 	epf_test->transfer_chan = chan;
 	tx->callback = pci_epf_test_dma_callback;
 	tx->callback_param = epf_test;
-	epf_test->transfer_cookie = tx->tx_submit(tx);
+	epf_test->transfer_cookie = dmaengine_submit(tx);
 
 	ret = dma_submit_error(epf_test->transfer_cookie);
 	if (ret) {
-- 
2.39.2

