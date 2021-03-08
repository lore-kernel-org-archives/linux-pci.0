Return-Path: <SRS0=jBgi=IG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CDBBC432C3
	for <linux-pci@archiver.kernel.org>; Mon,  8 Mar 2021 12:21:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E40A4651D1
	for <linux-pci@archiver.kernel.org>; Mon,  8 Mar 2021 12:21:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbhCHMUy (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 8 Mar 2021 07:20:54 -0500
Received: from mga12.intel.com ([192.55.52.136]:52723 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230200AbhCHMUq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 8 Mar 2021 07:20:46 -0500
IronPort-SDR: WcsGZ0fUP7OqWpiiUJm6eisZGqFbyogryTKrtMOFsPz6LR2t+sgbfWBH6fLqb4pJ8bB5kJZGB0
 328cfDu41oYw==
X-IronPort-AV: E=McAfee;i="6000,8403,9916"; a="167288061"
X-IronPort-AV: E=Sophos;i="5.81,232,1610438400"; 
   d="scan'208";a="167288061"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2021 04:20:45 -0800
IronPort-SDR: HxtkUSl7Fa96ngvtiUC0yKB5VSTApmkbym0/6Ml2L4t+ZxMXFLJWSKGfbLtHZO5XYKWJvnEhQl
 Jz/kciUykF9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,232,1610438400"; 
   d="scan'208";a="447120657"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 08 Mar 2021 04:20:37 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E253AF4; Mon,  8 Mar 2021 14:20:37 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Jean Delvare <jdelvare@suse.de>,
        Lee Jones <lee.jones@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Tan Jui Nee <jui.nee.tan@intel.com>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Jonathan Yong <jonathan.yong@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc:     Jean Delvare <jdelvare@suse.com>, Peter Tyser <ptyser@xes-inc.com>,
        hdegoede@redhat.com, henning.schild@siemens.com
Subject: [rfc, PATCH v1 0/7] PCI: introduce p2sb helper
Date:   Mon,  8 Mar 2021 14:20:13 +0200
Message-Id: <20210308122020.57071-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

There are a few users and even at least one more is coming
that would like to utilize p2sb mechanisms like hide/unhide
a device from PCI configuration space.

Here is the series to deduplicate existing users and provide
a generic way for new comers.

It also includes a patch to enable GPIO controllers on Apollo Lake
when it's used with ABL bootloader w/o ACPI support.

Please, comment on the approach and individual patches.

(Since it's cross subsystem, the PCI seems like a main one and
 I think it makes sense to route it thru it with immutable tag
 or branch provided for the others).

Andy Shevchenko (5):
  PCI: Introduce pci_bus_*() printing macros when device is not
    available
  PCI: Convert __pci_read_base() to __pci_bus_read_base()
  mfd: lpc_ich: Factor out lpc_ich_enable_spi_write()
  mfd: lpc_ich: Switch to generic pci_p2sb_bar()
  i2c: i801: convert to use common P2SB accessor

Jonathan Yong (1):
  PCI: New Primary to Sideband (P2SB) bridge support library

Tan Jui Nee (1):
  mfd: lpc_ich: Add support for pinctrl in non-ACPI system

 drivers/i2c/busses/Kconfig    |   1 +
 drivers/i2c/busses/i2c-i801.c |  40 +++-------
 drivers/mfd/Kconfig           |   1 +
 drivers/mfd/lpc_ich.c         | 135 +++++++++++++++++++++++++++++-----
 drivers/pci/Kconfig           |   8 ++
 drivers/pci/Makefile          |   1 +
 drivers/pci/pci-p2sb.c        |  89 ++++++++++++++++++++++
 drivers/pci/pci.h             |  13 +++-
 drivers/pci/probe.c           |  81 ++++++++++----------
 include/linux/pci-p2sb.h      |  28 +++++++
 include/linux/pci.h           |   9 +++
 11 files changed, 313 insertions(+), 93 deletions(-)
 create mode 100644 drivers/pci/pci-p2sb.c
 create mode 100644 include/linux/pci-p2sb.h

-- 
2.30.1

