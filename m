Return-Path: <SRS0=u0zl=SM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8BF4C10F11
	for <linux-pci@archiver.kernel.org>; Wed, 10 Apr 2019 12:34:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 751EE2083E
	for <linux-pci@archiver.kernel.org>; Wed, 10 Apr 2019 12:34:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730681AbfDJMeh (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 10 Apr 2019 08:34:37 -0400
Received: from mga02.intel.com ([134.134.136.20]:52996 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728821AbfDJMeh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 10 Apr 2019 08:34:37 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Apr 2019 05:34:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,332,1549958400"; 
   d="scan'208";a="159913965"
Received: from scymds02.sc.intel.com ([10.82.195.37])
  by fmsmga002.fm.intel.com with ESMTP; 10 Apr 2019 05:34:36 -0700
Received: from scvm10.sc.intel.com (scvm10.sc.intel.com [10.82.195.27])
        by scymds02.sc.intel.com
        with ESMTP id x3ACYZEJ016434;
        Wed, 10 Apr 2019 05:34:35 -0700
Received: from scvm10.sc.intel.com (localhost [127.0.0.1])
        by scvm10.sc.intel.com with ESMTP id x3ACYYId027271;
        Wed, 10 Apr 2019 05:34:34 -0700
Subject: [PATCH for-next 0/2] Allow drivers to configure AER registers
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
To:     bhelgaas@google.com
Cc:     Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Andriy Shevchenko <andriy.shevchenko@intel.com>, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
        "Michael J. Ruhl" <michael.j.ruhl@intel.com>, dledford@redhat.com,
        Kamenee Arumugam <kamenee.arumugam@intel.com>
Date:   Wed, 10 Apr 2019 05:34:34 -0700
Message-ID: <20190410123253.26818.37261.stgit@scvm10.sc.intel.com>
User-Agent: StGit/0.17.1-18-g2e886-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Folks,

Here is a set of patches from Kamenee that adds an API for
configuring AER registers. At least one driver needs to be able to change the
default settings and a patch (2/2) is included here. Sending both to linux-pci
since there really isn't a reason for the first to exist without a user.
However normally changes to the hfi1 driver would flow through linux-rdma.

This series is based on the PCI branch 'next' but I expect would apply the same
to rdma-next as well if we wanted to go that route.

---

Kamenee Arumugam (2):
      PCI/AER: Helper function for configuring AER registers
      IB/hfi1: Make Unsupported Request error non-fatal


 drivers/infiniband/hw/hfi1/pcie.c |    1 +
 drivers/pci/pcie/aer.c            |   33 +++++++++++++++++++++++++++++++++
 include/linux/aer.h               |   17 +++++++++++++++++
 3 files changed, 51 insertions(+), 0 deletions(-)

--
-Denny
