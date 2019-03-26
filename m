Return-Path: <SRS0=/keI=R5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B9DBC10F05
	for <linux-pci@archiver.kernel.org>; Tue, 26 Mar 2019 15:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BFDC2075C
	for <linux-pci@archiver.kernel.org>; Tue, 26 Mar 2019 15:38:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731656AbfCZPiu (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 26 Mar 2019 11:38:50 -0400
Received: from mga14.intel.com ([192.55.52.115]:30602 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731475AbfCZPiu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 26 Mar 2019 11:38:50 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Mar 2019 08:38:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,273,1549958400"; 
   d="scan'208";a="137421126"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 26 Mar 2019 08:38:49 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1h8oA4-0002hu-Py; Tue, 26 Mar 2019 23:38:48 +0800
Date:   Tue, 26 Mar 2019 23:37:56 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     kbuild-all@01.org, linux-pci@vger.kernel.org
Subject: [pci:review/pci/resource 8/21] drivers/nvme/host/pci.c:2919:6:
 sparse: symbol 'nvme_rescan_prepare' was not declared. Should it be static?
Message-ID: <201903262317.Xf94y2xJ%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git review/pci/resource
head:   4e373408d7e45cf4ae83c9448e4653388e1174bd
commit: aad30cad086923324dfc0ec32d8e34e562b9804c [8/21] nvme-pci: Handle movable BARs
reproduce:
        # apt-get install sparse
        git checkout aad30cad086923324dfc0ec32d8e34e562b9804c
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'


sparse warnings: (new ones prefixed by >>)

   drivers/nvme/host/pci.c:1757:15: sparse: expression using sizeof(void)
   drivers/nvme/host/pci.c:1757:15: sparse: expression using sizeof(void)
   include/linux/slab.h:664:13: sparse: undefined identifier '__builtin_mul_overflow'
   drivers/nvme/host/pci.c:1985:28: sparse: expression using sizeof(void)
   drivers/nvme/host/pci.c:1984:27: sparse: expression using sizeof(void)
   drivers/nvme/host/pci.c:2005:21: sparse: expression using sizeof(void)
   drivers/nvme/host/pci.c:2005:21: sparse: expression using sizeof(void)
   drivers/nvme/host/pci.c:2168:18: sparse: expression using sizeof(void)
   drivers/nvme/host/pci.c:2292:33: sparse: expression using sizeof(void)
   drivers/nvme/host/pci.c:2295:48: sparse: expression using sizeof(void)
   drivers/nvme/host/pci.c:2295:48: sparse: expression using sizeof(void)
   drivers/nvme/host/pci.c:2350:24: sparse: expression using sizeof(void)
   drivers/nvme/host/pci.c:2350:24: sparse: expression using sizeof(void)
   include/linux/nodemask.h:265:16: sparse: expression using sizeof(void)
   include/linux/slab.h:699:13: sparse: undefined identifier '__builtin_mul_overflow'
>> drivers/nvme/host/pci.c:2919:6: sparse: symbol 'nvme_rescan_prepare' was not declared. Should it be static?
>> drivers/nvme/host/pci.c:2928:6: sparse: symbol 'nvme_rescan_done' was not declared. Should it be static?
   include/linux/slab.h:664:13: sparse: call with no type!
   include/linux/slab.h:699:13: sparse: call with no type!

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
