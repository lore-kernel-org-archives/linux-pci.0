Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:40861 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753109AbbGIIAr (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 9 Jul 2015 04:00:47 -0400
Date: Thu, 09 Jul 2015 01:00:45 -0700 (PDT)
Message-Id: <20150709.010045.1327001449508270216.davem@davemloft.net>
To: jiang.liu@linux.intel.com
Cc: bhelgaas@google.com, tglx@linutronix.de, mingo@redhat.com,
	grant.likely@linaro.org, marc.zyngier@arm.com,
	stuart.yoder@freescale.com, wangyijing@huawei.com, bp@alien8.de,
	eric.snowberg@oracle.com, tony.luck@intel.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, sparclinux@vger.kernel.org
Subject: Re: [RFC Patch V1 07/12] sparc, PCI: Use helper functions to
 access fields in struct msi_desc
From: David Miller <davem@davemloft.net>
In-Reply-To: <1436428847-8886-8-git-send-email-jiang.liu@linux.intel.com>
References: <1436428847-8886-1-git-send-email-jiang.liu@linux.intel.com>
	<1436428847-8886-8-git-send-email-jiang.liu@linux.intel.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Jiang Liu <jiang.liu@linux.intel.com>
Date: Thu,  9 Jul 2015 16:00:42 +0800

> Use helper functions to access fields in struct msi_desc, so we could
> easily refine struct msi_desc later.
> 
> Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>

Acked-by: David S. Miller <davem@davemloft.net>
