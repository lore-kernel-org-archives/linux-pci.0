Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:44805 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752585AbcDAWSC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 1 Apr 2016 18:18:02 -0400
Date: Sat, 2 Apr 2016 06:17:09 +0800
From: kbuild test robot <lkp@intel.com>
To: Jake Oshins <jakeo@microsoft.com>
Cc: kbuild-all@01.org, linux-pci@vger.kernel.org,
	gregkh@linuxfoundation.org, kys@microsoft.com,
	linux-kernel@vger.kernel.org, devel@linuxdriverproject.org,
	olaf@aepfle.de, apw@canonical.com, vkuznets@redhat.com,
	haiyangz@microsoft.com, haddenh@microsoft.com,
	Jake Oshins <jakeo@microsoft.com>
Subject: Re: [PATCH v3 6/7] drivers:hv: Record MMIO range in use by frame
 buffer
Message-ID: <201604020637.7vhdSs6i%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1459552292-1297-7-git-send-email-jakeo@microsoft.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Jake,

[auto build test WARNING on v4.6-rc1]
[also build test WARNING on next-20160401]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Jake-Oshins/drivers-hv-Ensure-that-bridge-windows-don-t-overlap/20160402-053702


coccinelle warnings: (new ones prefixed by >>)

>> drivers/hv/vmbus_drv.c:1099:15-18: ERROR: Missing resource_size with fb_mmio

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
