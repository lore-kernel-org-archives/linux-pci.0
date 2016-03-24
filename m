Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:52666 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751035AbcCXTQ4 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 24 Mar 2016 15:16:56 -0400
Date: Thu, 24 Mar 2016 15:16:54 -0400 (EDT)
Message-Id: <20160324.151654.1707693980081136191.davem@davemloft.net>
To: babu.moger@oracle.com
Cc: bhelgaas@google.com, wangyijing@huawei.com,
	sowmini.varadhan@oracle.com, jiang.liu@linux.intel.com,
	eric.snowberg@oracle.com, yinghai@kernel.org,
	dan.j.williams@intel.com, sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	ethan.zhao@oracle.com
Subject: Re: [PATCH v3] sparc/PCI: Fix for panic while enabling SR-IOV
From: David Miller <davem@davemloft.net>
In-Reply-To: <1458772676-47866-1-git-send-email-babu.moger@oracle.com>
References: <1458772676-47866-1-git-send-email-babu.moger@oracle.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Babu Moger <babu.moger@oracle.com>
Date: Wed, 23 Mar 2016 15:37:56 -0700

> +#ifdef CONFIG_PCI_IOV
> +int pcibios_add_device(struct pci_dev *dev)
> +{
> +	struct pci_dev *pdev;
> +	/*
> +	 * Add sriov arch specific initialization here.
> +	 * Copy dev_archdata from PF to VF
> +	 */

Always have an empty line after a set of local variable declarations.

Sparc code is to have comments formatted:

	/* Like
	 * this.
	 */

> +		memcpy(&dev->dev.archdata, &pdev->dev.archdata,
> +				sizeof(struct dev_archdata));

Sparc code should indent multi-line expressions by having the second
and subsequent line be indented exactly to the column following the
openning parenthesis on the first line.

You must use the appropriate number of TAB then SPACE characters
necessary to do so.

Thanks.
