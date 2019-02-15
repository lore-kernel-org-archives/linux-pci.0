Return-Path: <SRS0=N/Da=QW=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69D5FC43381
	for <linux-pci@archiver.kernel.org>; Fri, 15 Feb 2019 08:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3945F2192C
	for <linux-pci@archiver.kernel.org>; Fri, 15 Feb 2019 08:18:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390737AbfBOIS6 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 15 Feb 2019 03:18:58 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:21816 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2389141AbfBOIS6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Feb 2019 03:18:58 -0500
X-UUID: 7631d8c42916419a88e9f47ebf2b6dc6-20190215
X-UUID: 7631d8c42916419a88e9f47ebf2b6dc6-20190215
Received: from mtkcas36.mediatek.inc [(172.27.4.250)] by mailgw01.mediatek.com
        (envelope-from <honghui.zhang@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1268244609; Fri, 15 Feb 2019 16:18:45 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS32N1.mediatek.inc
 (172.27.4.71) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 15 Feb
 2019 16:18:44 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 15 Feb 2019 16:18:43 +0800
Message-ID: <1550218723.4980.69.camel@mhfsdcap03>
Subject: Re: [pci:pci/portdrv 1/1] drivers/pci/pcie/portdrv_pci.c:187:9:
 sparse: warning: Initializer entry defined twice
From:   Honghui Zhang <honghui.zhang@mediatek.com>
To:     kbuild test robot <lkp@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>
CC:     <kbuild-all@01.org>, <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Date:   Fri, 15 Feb 2019 16:18:43 +0800
In-Reply-To: <201902151544.kWECyQ24%fengguang.wu@intel.com>
References: <201902151544.kWECyQ24%fengguang.wu@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 2019-02-15 at 15:34 +0800, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/portdrv
> head:   b4f663e35a545fbdc71b3bbf2df88ef9f124a3fa
> commit: b4f663e35a545fbdc71b3bbf2df88ef9f124a3fa [1/1] PCI/portdrv: Support PCIe services on subtractive decode bridges
> reproduce:
>         # apt-get install sparse
>         git checkout b4f663e35a545fbdc71b3bbf2df88ef9f124a3fa
>         make ARCH=x86_64 allmodconfig
>         make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'
> 
> All warnings (new ones prefixed by >>):
> 
> >> drivers/pci/pcie/portdrv_pci.c:187:9: sparse: warning: Initializer entry defined twice
>    drivers/pci/pcie/portdrv_pci.c:189:9: sparse:   also defined here
> 
> sparse warnings: (new ones prefixed by >>)
> 
>    drivers/pci/pcie/portdrv_pci.c:187:9: sparse: warning: Initializer entry defined twice
> >> drivers/pci/pcie/portdrv_pci.c:189:9: sparse:   also defined here
> 
> vim +187 drivers/pci/pcie/portdrv_pci.c
> 
> ^1da177e Linus Torvalds 2005-04-16  181  
> ^1da177e Linus Torvalds 2005-04-16  182  /*
> ^1da177e Linus Torvalds 2005-04-16  183   * LINUX Device Driver Model
> ^1da177e Linus Torvalds 2005-04-16  184   */
> ^1da177e Linus Torvalds 2005-04-16  185  static const struct pci_device_id port_pci_ids[] = { {
> ^1da177e Linus Torvalds 2005-04-16  186  	/* handle any PCI-Express port */
> ^1da177e Linus Torvalds 2005-04-16 @187  	PCI_DEVICE_CLASS(((PCI_CLASS_BRIDGE_PCI << 8) | 0x00), ~0),
> b4f663e3 Honghui Zhang  2019-02-14  188  	/* subtractive decode PCI-to-PCI bridge, class type is 060401h */
> b4f663e3 Honghui Zhang  2019-02-14 @189  	PCI_DEVICE_CLASS(((PCI_CLASS_BRIDGE_PCI << 8) | 0x01), ~0),
> ^1da177e Linus Torvalds 2005-04-16  190  	}, { /* end: all zeroes */ }
> ^1da177e Linus Torvalds 2005-04-16  191  };
> ^1da177e Linus Torvalds 2005-04-16  192  
> 
Hi, Bjorn,
Do you think drop this one, and I send a new version is a good idea? Or
will you re-consider the first version patch?

Thanks.

> :::::: The code at line 187 was first introduced by commit
> :::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2
> 
> :::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
> :::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation


