Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga04-in.huawei.com ([45.249.212.190]:5504 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751793AbdHaOVV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 31 Aug 2017 10:21:21 -0400
From: Zhou Wang <wangzhou1@hisilicon.com>
Subject: [Question] PCI ACS is broken for ARM SMMU v3?
To: Alex Williamson <alex.williamson@redhat.com>,
        Will Deacon <will.deacon@arm.com>
CC: <linux-arm-kernel@lists.infradead.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        <wangzhou1@hisilicon.com>
Message-ID: <59A81B4C.3020402@hisilicon.com>
Date: Thu, 31 Aug 2017 22:21:00 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Will and Alex,

pci_request_acs is called in drivers/iommu/arm-smmu-v3.c to set pci_acs_enable.

PCI subsystem tries to enable ACS as below:

	pci_device_add
		--> pci_init_capabilities
			--> pci_enable_acs

in ACPI PCI driver. However, ACPI PCI driver will be called before SMMU v3 driver,
which will lead pci_enable_acs to return directly as pci_acs_enable is not set
before SMMU v3 driver loading.

I think this is a bug, what do you think about this problem?

Best,
Zhou
