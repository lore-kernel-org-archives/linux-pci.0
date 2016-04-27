Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:29548 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751019AbcD0XS4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 27 Apr 2016 19:18:56 -0400
Message-ID: <572148DD.40507@intel.com>
Date: Thu, 28 Apr 2016 07:18:53 +0800
From: "Yong, Jonathan" <jonathan.yong@intel.com>
MIME-Version: 1.0
To: linux-pci@vger.kernel.org
CC: bhelgaas@google.com
Subject: Re: [RFC v4] PCI: PTM Driver
References: <1461047358-4736-1-git-send-email-jonathan.yong@intel.com>
In-Reply-To: <1461047358-4736-1-git-send-email-jonathan.yong@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 04/19/2016 14:29, Yong, Jonathan wrote:
> Hello LKML,
>
>
> Changes since v1:
> * Moved register constants to pci_regs.h
> * Use pci_dev to hold PTM status
> * PTM initialization now done top-down hierarchy wise.
>
> Changes since v2:
> * Added missing void return in the pci_ptm_init inline stub.
>
> Changes since v3:
> * Clearing CONFIG_PCIE_PTM now completely prevents the driver from being built.
> * Renamed pci_*_ptm_sysfs to pcie_ptm_*_sysfs_dev_files for consistency.
> * Removed useless prototypes.
> * Driver no longer checks PTM capability version
> * PCI_EXT_CAP_ID_MAX updated to include PTM (0x1F)
>

Ping?

