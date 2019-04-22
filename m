Return-Path: <SRS0=L200=SY=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DC65C10F11
	for <linux-pci@archiver.kernel.org>; Mon, 22 Apr 2019 21:24:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB74920643
	for <linux-pci@archiver.kernel.org>; Mon, 22 Apr 2019 21:24:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728906AbfDVVYz (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 22 Apr 2019 17:24:55 -0400
Received: from mga11.intel.com ([192.55.52.93]:4085 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728484AbfDVVYz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 22 Apr 2019 17:24:55 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Apr 2019 14:24:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,383,1549958400"; 
   d="gz'50?scan'50,208,50";a="164069336"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 22 Apr 2019 14:19:53 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1hIgLx-0005Ix-3X; Tue, 23 Apr 2019 05:19:53 +0800
Date:   Tue, 23 Apr 2019 05:19:48 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Alexandru Gagniuc <mr.nuke.me@gmail.com>
Cc:     kbuild-all@01.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <helgaas@kernel.org>
Subject: [pci:pci/hotplug 4/5] include/linux/pci_hotplug.h:145:1: error:
 expected identifier or '(' before '{' token
Message-ID: <201904230541.l1Tz6i3p%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="gKMricLos+KVdGMg"
Content-Disposition: inline
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/hotplug
head:   d98ba96a72ca1a1dd9d2f3a321e64bac3d94bd39
commit: 93395b9ebeb0cfee5e5c617ec44d249d19439126 [4/5] PCI / ACPI: Remove the need for 'struct hotplug_params'
config: xtensa-common_defconfig (attached as .config)
compiler: xtensa-linux-gcc (GCC) 8.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 93395b9ebeb0cfee5e5c617ec44d249d19439126
        # save the attached .config to linux build tree
        GCC_VERSION=8.1.0 make.cross ARCH=xtensa 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


All errors (new ones prefixed by >>):

   In file included from drivers/pci/pci.c:30:
>> include/linux/pci_hotplug.h:145:1: error: expected identifier or '(' before '{' token
    {
    ^

vim +145 include/linux/pci_hotplug.h

e22b73501 drivers/pci/hotplug/pci_hotplug.h Kenji Kaneshige   2006-05-02  132  
783c49fc5 drivers/pci/hotplug/pci_hotplug.h Kristen Accardi   2006-03-03  133  #ifdef CONFIG_ACPI
8b48463f8 include/linux/pci_hotplug.h       Lv Zheng          2013-12-03  134  #include <linux/acpi.h>
93395b9eb include/linux/pci_hotplug.h       Alexandru Gagniuc 2019-04-19  135  int pci_acpi_program_hp_params(struct pci_dev *dev,
93395b9eb include/linux/pci_hotplug.h       Alexandru Gagniuc 2019-04-19  136  			       const struct hotplug_program_ops *hp_ops);
5352a44a5 include/linux/pci_hotplug.h       Mika Westerberg   2018-05-23  137  bool pciehp_is_native(struct pci_dev *bridge);
6f77fa494 include/linux/pci_hotplug.h       Mika Westerberg   2018-05-23  138  int acpi_get_hp_hw_control_from_firmware(struct pci_dev *bridge);
90cc0c3cc include/linux/pci_hotplug.h       Mika Westerberg   2018-05-31  139  bool shpchp_is_native(struct pci_dev *bridge);
e8c331e96 include/linux/pci_hotplug.h       Kenji Kaneshige   2008-12-17  140  int acpi_pci_check_ejectable(struct pci_bus *pbus, acpi_handle handle);
7f5386693 include/linux/pci_hotplug.h       Alex Chiang       2009-09-10  141  int acpi_pci_detect_ejectable(acpi_handle handle);
8838400db include/linux/pci_hotplug.h       Bjorn Helgaas     2009-09-14  142  #else
93395b9eb include/linux/pci_hotplug.h       Alexandru Gagniuc 2019-04-19  143  int pci_acpi_program_hp_params(struct pci_dev *dev,
93395b9eb include/linux/pci_hotplug.h       Alexandru Gagniuc 2019-04-19  144  			       const struct hotplug_program_ops *hp_ops);
8838400db include/linux/pci_hotplug.h       Bjorn Helgaas     2009-09-14 @145  {
8838400db include/linux/pci_hotplug.h       Bjorn Helgaas     2009-09-14  146  	return -ENODEV;
8838400db include/linux/pci_hotplug.h       Bjorn Helgaas     2009-09-14  147  }
96a621e01 include/linux/pci_hotplug.h       Mika Westerberg   2018-05-24  148  

:::::: The code at line 145 was first introduced by commit
:::::: 8838400db5193c37588813c2eb1249b821781950 PCI hotplug: add pci_configure_slot()

:::::: TO: Bjorn Helgaas <bjorn.helgaas@hp.com>
:::::: CC: Jesse Barnes <jbarnes@virtuousgeek.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--gKMricLos+KVdGMg
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--gKMricLos+KVdGMg--
