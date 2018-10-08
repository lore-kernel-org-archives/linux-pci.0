Return-Path: <SRS0=j7M/=MU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1765CC65C20
	for <linux-pci@archiver.kernel.org>; Mon,  8 Oct 2018 18:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFB602085B
	for <linux-pci@archiver.kernel.org>; Mon,  8 Oct 2018 18:19:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFB602085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbeJIBcb (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:32:31 -0400
Received: from mga06.intel.com ([134.134.136.31]:36357 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726291AbeJIBcb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 8 Oct 2018 21:32:31 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Oct 2018 11:19:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,357,1534834800"; 
   d="scan'208";a="86717218"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 08 Oct 2018 11:18:25 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1g9a6q-000BIm-GG; Tue, 09 Oct 2018 02:18:24 +0800
Date:   Tue, 9 Oct 2018 02:17:59 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Hanjie Lin <hanjie.lin@amlogic.com>
Cc:     kbuild-all@01.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Yue Wang <yue.wang@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Cyrille Pitchen <cyrille.pitchen@free-electrons.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        Yixun Lan <yixun.lan@amlogic.com>,
        Liang Yang <liang.yang@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Jian Hu <jian.hu@amlogic.com>
Subject: Re: [PATCH v4 2/2] PCI: amlogic: Add the Amlogic Meson PCIe
 controller driver
Message-ID: <201810090208.N3NrdpgK%fengguang.wu@intel.com>
References: <1538999834-156423-3-git-send-email-hanjie.lin@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1538999834-156423-3-git-send-email-hanjie.lin@amlogic.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Yue,

I love your patch! Perhaps something to improve:

[auto build test WARNING on pci/next]
[also build test WARNING on v4.19-rc7 next-20181008]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Hanjie-Lin/add-the-Amlogic-Meson-PCIe-controller-driver/20181009-001429
base:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next


coccinelle warnings: (new ones prefixed by >>)

>> drivers/pci/controller/dwc/pci-meson.c:190:1-3: WARNING: PTR_ERR_OR_ZERO can be used
   drivers/pci/controller/dwc/pci-meson.c:267:1-3: WARNING: PTR_ERR_OR_ZERO can be used

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
