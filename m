Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:63928 "EHLO
	mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750999AbcGLFJt (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 12 Jul 2016 01:09:49 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id u6C58kAa141751
	for <linux-pci@vger.kernel.org>; Tue, 12 Jul 2016 01:09:48 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
	by mx0b-001b2d01.pphosted.com with ESMTP id 243eddcd3m-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 12 Jul 2016 01:09:48 -0400
Received: from localhost
	by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <xyjxie@linux.vnet.ibm.com>;
	Tue, 12 Jul 2016 15:09:45 +1000
Subject: Re: [PATCH v3 0/7] PCI: Add support for enforcing all MMIO BARs not
 to share PAGE_SIZE
To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-doc@vger.kernel.org,
	bhelgaas@google.com
References: <1467283993-3185-1-git-send-email-xyjxie@linux.vnet.ibm.com>
Cc: nikunj@linux.vnet.ibm.com, zhong@linux.vnet.ibm.com,
	corbet@lwn.net, aik@ozlabs.ru, gwshan@linux.vnet.ibm.com,
	warrier@linux.vnet.ibm.com, alex.williamson@redhat.com,
	paulus@samba.org
From: Yongji Xie <xyjxie@linux.vnet.ibm.com>
Date: Tue, 12 Jul 2016 13:09:38 +0800
MIME-Version: 1.0
In-Reply-To: <1467283993-3185-1-git-send-email-xyjxie@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <7df769a2-4dbb-ade4-532f-3a61197c14d1@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

Any comment on V3?

Thanks,

Yongji


On 2016/6/30 18:53, Yongji Xie wrote:
> This series aims to add an option for PCI resource allocator to
> force BARs not to share PAGE_SIZE. This would make sense to VFIO
> driver. Because current VFIO implementation disallows to mmap
> sub-page(size < PAGE_SIZE) MMIO BARs which may share the same page
> with other BARs for security reasons. Thus, we have to handle mmio
> access to these BARs in QEMU emulation rather than in guest which
> will cause some performance loss.
>
> To achieve that, we would like to make use of the existing
> resource_alignment kernel parameter and force a minimum alignment
> of PAGE_SIZE. It's flexible. And we can enable it by default on
> some archs which may easily hit the performance issue because of
> their 64K page.
>
> In this series, patch 1,2,3 fixed bugs of using resource_alignment;
> patch 4,5 tried to add a new option for resource_alignment to use
> IORESOURCE_STARTALIGN to specify the alignment of PCI BARs; patch 6
> modified resource_alignment to support syntax which can be used to
> enforce the alignment of all MMIO BARs to be at least PAGE_SIZE;
> patch 7 enabled this feature by default on PowerNV platform.
>
> Changelog v3:
> - Ignore enforced alignment to fixed BARs
> - Fix issue that disabling memory decoding when reassigning the alignment
> - Only enable default alignment on PowerNV platform
>
> Changelog v2:
> - Ignore enforced alignment to VF BARs on pci_reassigndev_resource_alignment()
>
> Yongji Xie (7):
>    PCI: Ignore enforced alignment when kernel uses existing firmware setup
>    PCI: Ignore enforced alignment to VF BARs
>    PCI: Do not disable memory decoding in pci_reassigndev_resource_alignment()
>    PCI: Add a new option for resource_alignment to reassign alignment
>    PCI: Do not use IORESOURCE_STARTALIGN to identify bridge resources
>    PCI: Add support for enforcing all MMIO BARs to be page aligned
>    PCI: Add a macro to set default alignment for all PCI devices
>
>   Documentation/kernel-parameters.txt |    7 +-
>   arch/powerpc/include/asm/pci.h      |    4 ++
>   drivers/pci/pci.c                   |  123 +++++++++++++++++++++++++++--------
>   drivers/pci/setup-bus.c             |    9 ++-
>   4 files changed, 111 insertions(+), 32 deletions(-)
>

