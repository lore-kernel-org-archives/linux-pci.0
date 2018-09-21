Return-Path: <SRS0=H68a=MD=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B2F8C433F4
	for <linux-pci@archiver.kernel.org>; Fri, 21 Sep 2018 14:11:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC74A21567
	for <linux-pci@archiver.kernel.org>; Fri, 21 Sep 2018 14:11:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC74A21567
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728384AbeIUUAu (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 21 Sep 2018 16:00:50 -0400
Received: from mga05.intel.com ([192.55.52.43]:20682 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728365AbeIUUAu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 21 Sep 2018 16:00:50 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Sep 2018 07:11:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,285,1534834800"; 
   d="scan'208";a="71841742"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.44])
  by fmsmga007.fm.intel.com with ESMTP; 21 Sep 2018 07:11:36 -0700
Date:   Fri, 21 Sep 2018 08:13:34 -0600
From:   Keith Busch <keith.busch@intel.com>
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@01.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [pci:pci/hotplug 15/24] bus.c:(.text+0x358): multiple definition
 of `pci_save_dpc_state'
Message-ID: <20180921141333.GA1157@localhost.localdomain>
References: <201809211041.8FEIzMUy%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201809211041.8FEIzMUy%fengguang.wu@intel.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 21, 2018 at 10:06:44AM +0800, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/hotplug
> head:   64ab39d38d17e5d53434d949681c3ff3ec0f79d3
> commit: d17964c0d81fc38c733fc5281436d2b262306a33 [15/24] PCI/DPC: Save and restore config state
> config: m68k-m5475evb_defconfig (attached as .config)
> compiler: m68k-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout d17964c0d81fc38c733fc5281436d2b262306a33
>         # save the attached .config to linux build tree
>         GCC_VERSION=7.2.0 make.cross ARCH=m68k 
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/pci/bus.o: In function `pci_save_dpc_state':
> >> bus.c:(.text+0x358): multiple definition of `pci_save_dpc_state'
>    drivers/pci/access.o:access.c:(.text+0x1114): first defined here
>    drivers/pci/bus.o: In function `pci_restore_dpc_state':
> >> bus.c:(.text+0x35a): multiple definition of `pci_restore_dpc_state'

Appropriate fix to be sent:

---
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index a244bd0c5ca7..eb3125decffe 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -402,8 +402,8 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info);
 void pci_save_dpc_state(struct pci_dev *dev);
 void pci_restore_dpc_state(struct pci_dev *dev);
 #else
-void pci_save_dpc_state(struct pci_dev *dev) {}
-void pci_restore_dpc_state(struct pci_dev *dev) {}
+static inline void pci_save_dpc_state(struct pci_dev *dev) {}
+static inline void pci_restore_dpc_state(struct pci_dev *dev) {}
 #endif
 
 #ifdef CONFIG_PCI_ATS
--
