Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga04-in.huawei.com ([45.249.212.190]:5956 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753515AbdIDMdk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Sep 2017 08:33:40 -0400
Subject: Re: [Question] PCI ACS is broken for ARM SMMU v3?
To: Alex Williamson <alex.williamson@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <59A81B4C.3020402@hisilicon.com>
CC: <linux-arm-kernel@lists.infradead.org>,
        Linux PCI <linux-pci@vger.kernel.org>
From: Zhou Wang <wangzhou1@hisilicon.com>
Message-ID: <59AD4812.3020602@hisilicon.com>
Date: Mon, 4 Sep 2017 20:33:22 +0800
MIME-Version: 1.0
In-Reply-To: <59A81B4C.3020402@hisilicon.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

+to: Lorenzo

On 2017/8/31 22:21, Zhou Wang wrote:
> Hi Will and Alex,
> 
> pci_request_acs is called in drivers/iommu/arm-smmu-v3.c to set pci_acs_enable.
> 
> PCI subsystem tries to enable ACS as below:
> 
> 	pci_device_add
> 		--> pci_init_capabilities
> 			--> pci_enable_acs
> 
> in ACPI PCI driver. However, ACPI PCI driver will be called before SMMU v3 driver,
> which will lead pci_enable_acs to return directly as pci_acs_enable is not set
> before SMMU v3 driver loading.
> 
> I think this is a bug, what do you think about this problem?
> 
> Best,
> Zhou
> 
> 
> 
> 
> 
> .
> 
