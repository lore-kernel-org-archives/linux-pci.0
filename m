Return-Path: <SRS0=8YRl=UM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17A36C31E45
	for <linux-pci@archiver.kernel.org>; Thu, 13 Jun 2019 22:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E30F62147A
	for <linux-pci@archiver.kernel.org>; Thu, 13 Jun 2019 22:57:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727432AbfFMW5N (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 13 Jun 2019 18:57:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45000 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727273AbfFMW5N (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 13 Jun 2019 18:57:13 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E093237F43;
        Thu, 13 Jun 2019 22:57:06 +0000 (UTC)
Received: from gimli.home (ovpn-116-190.phx2.redhat.com [10.3.116.190])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 61B1319C67;
        Thu, 13 Jun 2019 22:56:57 +0000 (UTC)
Subject: [PATCH 0/2] PCI/IOV: Resolve regression in SR-IOV VF cfg_size
From:   Alex Williamson <alex.williamson@redhat.com>
To:     linux-pci@vger.kernel.org
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        KarimAllah Ahmed <karahmed@amazon.de>,
        Hao Zheng <yinhe@linux.alibaba.com>, bhelgaas@google.com,
        linux-kernel@vger.kernel.org, nanhai.zou@linux.alibaba.com,
        quan.xu0@linux.alibaba.com, ashok.raj@intel.com,
        keith.busch@intel.com, mike.campin@intel.com
Date:   Thu, 13 Jun 2019 16:56:57 -0600
Message-ID: <156046609596.29869.5839964168034189416.stgit@gimli.home>
User-Agent: StGit/0.19-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Thu, 13 Jun 2019 22:57:13 +0000 (UTC)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The commit reverted in the first patch introduced a regression where
only the first VF reports the correct config space size, subsequent VFs
report 256 bytes of config space.  Replace this in the second patch
with an assumption that all VFs support extended config space by virtue
of the SR-IOV spec requiring a PCIe capability and reachability of the
PF extended config space already being proven by the existence of the
VF.  Thanks,

Alex

---

Alex Williamson (2):
      Revert: PCI/IOV: Use VF0 cached config space size for other VFs
      PCI/IOV: Assume SR-IOV VFs support extended config space.


 drivers/pci/iov.c   |    2 --
 drivers/pci/pci.h   |    1 -
 drivers/pci/probe.c |   26 ++++++++++++--------------
 3 files changed, 12 insertions(+), 17 deletions(-)
