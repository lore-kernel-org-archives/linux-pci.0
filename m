Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lf0-f44.google.com ([209.85.215.44]:34601 "EHLO
        mail-lf0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751589AbdAYR2W (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 25 Jan 2017 12:28:22 -0500
Received: by mail-lf0-f44.google.com with SMTP id v186so132728807lfa.1
        for <linux-pci@vger.kernel.org>; Wed, 25 Jan 2017 09:28:21 -0800 (PST)
Subject: Re: [PATCH V7 10/11] iommu/arm-smmu: Clean up early-probing
 workarounds
To: Sricharan R <sricharan@codeaurora.org>, robin.murphy@arm.com,
        will.deacon@arm.com, joro@8bytes.org, lorenzo.pieralisi@arm.com,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, m.szyprowski@samsung.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org
References: <1485188293-20263-1-git-send-email-sricharan@codeaurora.org>
 <1485188293-20263-11-git-send-email-sricharan@codeaurora.org>
From: Tomasz Nowicki <tn@semihalf.com>
Message-ID: <eb2ceedf-b061-f9ea-eb2a-529bda56298c@semihalf.com>
Date: Wed, 25 Jan 2017 18:28:18 +0100
MIME-Version: 1.0
In-Reply-To: <1485188293-20263-11-git-send-email-sricharan@codeaurora.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 23.01.2017 17:18, Sricharan R wrote:
> From: Robin Murphy <robin.murphy@arm.com>
>
> Now that the appropriate ordering is enforced via profe-deferral of
> masters in core code, rip it all out and bask in the simplicity.
>
> Acked-by: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> [Sricharan: Rebased on top of ACPI IORT SMMU series]
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>

[...]

> -
> -#ifdef CONFIG_ACPI
> -static int __init acpi_smmu_v3_init(struct acpi_table_header *table)
> -{
> -	if (iort_node_match(ACPI_IORT_NODE_SMMU_V3))
> -		return arm_smmu_init();

Since we clean the code we can remove iort_node_match() from iort.c. 
There is no user for it any more. Unless Lorenzo has some plans for it.

Thanks,
Tomasz
