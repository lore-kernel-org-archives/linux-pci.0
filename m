Return-Path: <SRS0=UcfF=MX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2BC9C32788
	for <linux-pci@archiver.kernel.org>; Thu, 11 Oct 2018 15:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63C2C20841
	for <linux-pci@archiver.kernel.org>; Thu, 11 Oct 2018 15:26:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="r9/fxo6I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63C2C20841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728094AbeJKWxw (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 11 Oct 2018 18:53:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:55464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726189AbeJKWxw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 11 Oct 2018 18:53:52 -0400
Received: from localhost (unknown [204.56.7.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE1392075C;
        Thu, 11 Oct 2018 15:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539271572;
        bh=lvJmWIe/0qA8rlxDpPZU/UsUIqEb1n3JICEn8DBIPH4=;
        h=Subject:From:To:Cc:Date:From;
        b=r9/fxo6IxFr2hBzPjM/x0tFD0XEZIjlP9cXVvN8xyAyNNXxTHsSVmQElcKbKQbi7H
         manWQzFhSNeaENb15lfvOG2t+dcPTnR+ZqoMdlTu2kaSbWjfrq1UgTvdQoiJf8WzIu
         X/iQ1l54pXny3etQ6hxDs07Fyfx9f+gk7lvaIJp8=
Subject: [PATCH v3] PCI/AER: Enable reporting for all ports
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jon Derrick <jonathan.derrick@intel.com>
Cc:     Dongdong Liu <liudongdong3@huawei.com>,
        Keith Busch <keith.busch@intel.com>,
        Sinan Kaya <okaya@kernel.org>,
        Oza Pawandeep <poza@codeaurora.org>,
        Matthew Wilcox <willy@infradead.org>,
        Lukas Wunner <lukas@wunner.de>, Christoph Hellwig <hch@lst.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 11 Oct 2018 10:26:11 -0500
Message-ID: <153927123657.40414.9802241131940995491.stgit@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This is another attempt to fix the AER error reporting issue reported
by Jon.  I've compiled this on x86, but can't test it myself.

If we can get this tested, I'd like to include this for v4.20.


v3: This post
    Fix the problem that v2 didn't enable error reporting on Root
    Ports, as pointed out by Dongdong

v2: https://lore.kernel.org/linux-pci/20181009231915.GC5906@bhelgaas-glaptop.roam.corp.google.com
    My attempt to move the fix to the AER service driver

v1: https://lore.kernel.org/linux-pci/1536085989-2956-1-git-send-email-jonathan.derrick@intel.com
    Jon's initial posting

---

Bjorn Helgaas (1):
      PCI/AER: Enable reporting for ports enumerated after AER driver registration


 drivers/pci/pcie/aer.c |   16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)
