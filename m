Return-Path: <linux-pci-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A867C7EE29
	for <linux-pci@archiver.kernel.org>; Fri,  9 Jun 2023 22:25:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbjFIWZM (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 9 Jun 2023 18:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231722AbjFIWZL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Jun 2023 18:25:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8556A359D
        for <linux-pci@vger.kernel.org>; Fri,  9 Jun 2023 15:25:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 00CAC6574B
        for <linux-pci@vger.kernel.org>; Fri,  9 Jun 2023 22:25:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34BA4C433EF;
        Fri,  9 Jun 2023 22:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686349509;
        bh=ArSUjXtwMY8JAQSM+vWzDmPvqzEks0B+YGHU8T9S9As=;
        h=From:To:Cc:Subject:Date:From;
        b=mIGqlVy9wPR+74f+em3wNY+xD9MuemFpYCtxUpPYdKnkH5h0ZpeTR+XK9/bRKYlVL
         TFk4hQrwEuBjfHWArMJVPmEfwzvT9ZMLckGdTPglMFUt0LxBLzkP8gn1bmODBpAfys
         SlL9cw9MXGkjFZrNrET1InDsdQPQTOEmysbw6noqISpaTKj7ru70NKjpqhCKEwCDID
         MVQTyRFK3FtJyAV9TAmO4GbX2Cs2PG9rjkJqOg/mF8ZsGJJkX+3b4Ke3qZJMtgW4bw
         K+ferxcPmZch+Hiy4y5bqDc043CUBEQlm3AcWwWCj1Gww/DOSTmO5YHFN9r1Tcq14W
         Qc42mlbrIV++A==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Dave Jiang <dave.jiang@intel.com>, Stefan Roese <sr@denx.de>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lukas Wunner <lukas@wunner.de>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2 0/4] PCI: AER updates
Date:   Fri,  9 Jun 2023 17:24:56 -0500
Message-Id: <20230609222500.1267795-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Patch 2 ("Drop recommendation to configure AER Capability") was previously
posted at https://lore.kernel.org/r/20230214172831.GA3046378@bhelgaas and
is unchanged here.

The others have not been posted previously.

Bjorn Helgaas (4):
  PCI: Unexport pci_save_aer_state()
  Documentation: PCI: Drop recommendation to configure AER Capability
  Documentation: PCI: Update cross references to .rst files
  Documentation: PCI: Tidy AER documentation

 Documentation/PCI/pci-error-recovery.rst |   2 +-
 Documentation/PCI/pcieaer-howto.rst      | 183 ++++++++---------------
 drivers/pci/pci.h                        |   4 +
 include/linux/aer.h                      |   4 -
 4 files changed, 70 insertions(+), 123 deletions(-)

-- 
2.34.1

