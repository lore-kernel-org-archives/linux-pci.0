Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96204C43334
	for <linux-pci@archiver.kernel.org>; Thu,  7 Jul 2022 13:14:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235457AbiGGNOu (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 7 Jul 2022 09:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234888AbiGGNOt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Jul 2022 09:14:49 -0400
X-Greylist: delayed 454 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 07 Jul 2022 06:14:44 PDT
Received: from mint-fitpc2.mph.net (unknown [81.168.73.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C4E08167E5;
        Thu,  7 Jul 2022 06:14:44 -0700 (PDT)
Received: from palantir17.mph.net (unknown [192.168.0.4])
        by mint-fitpc2.mph.net (Postfix) with ESMTP id CFAC13201AE;
        Thu,  7 Jul 2022 14:07:07 +0100 (BST)
Received: from localhost ([::1] helo=palantir17.mph.net)
        by palantir17.mph.net with esmtp (Exim 4.95)
        (envelope-from <habetsm.xilinx@gmail.com>)
        id 1o9RDn-0007Kf-9I;
        Thu, 07 Jul 2022 14:07:07 +0100
Subject: [PATCH net-next v2 0/2] sfc: Add EF100 BAR config support
From:   Martin Habets <habetsm.xilinx@gmail.com>
To:     davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        edumazet@google.com
Cc:     netdev@vger.kernel.org, ecree.xilinx@gmail.com,
        linux-pci@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Date:   Thu, 07 Jul 2022 14:07:07 +0100
Message-ID: <165719918216.28149.7678451615870416505.stgit@palantir17.mph.net>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The EF100 NICs allow for different register layouts of a PCI memory BAR.
This series provides the framework to switch this layout at runtime.

Subsequent patch series will use this to add support for vDPA.

v2: Include PCI and virtio maintainers.
---

Martin Habets (2):
      sfc: Add EF100 BAR config support
      sfc: Implement change of BAR configuration


 drivers/net/ethernet/sfc/ef100_nic.c |   80 ++++++++++++++++++++++++++++++++++
 drivers/net/ethernet/sfc/ef100_nic.h |    6 +++
 2 files changed, 86 insertions(+)

--
Martin Habets <habetsm.xilinx@gmail.com>


