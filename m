Return-Path: <SRS0=6VBI=NY=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38850C43441
	for <linux-pci@archiver.kernel.org>; Tue, 13 Nov 2018 08:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06C442251A
	for <linux-pci@archiver.kernel.org>; Tue, 13 Nov 2018 08:54:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06C442251A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbeKMSvc (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 13 Nov 2018 13:51:32 -0500
Received: from 8bytes.org ([81.169.241.247]:52308 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726245AbeKMSvc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 13 Nov 2018 13:51:32 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id EE63536B; Tue, 13 Nov 2018 09:54:24 +0100 (CET)
Date:   Tue, 13 Nov 2018 09:54:24 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     iommu@lists.linux-foundation.org,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        Christian Kellner <ckellner@redhat.com>,
        Mario.Limonciello@dell.com,
        Anthony Wong <anthony.wong@canonical.com>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] PCI / iommu / thunderbolt: IOMMU based DMA protection
Message-ID: <20181113085424.GC25808@8bytes.org>
References: <20181112160628.86620-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181112160628.86620-1-mika.westerberg@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 12, 2018 at 07:06:24PM +0300, Mika Westerberg wrote:
> Lu Baolu (1):
>   iommu/vt-d: Force IOMMU on for platform opt in hint
> 
> Mika Westerberg (3):
>   PCI / ACPI: Identify external PCI devices
>   iommu/vt-d: Do not enable ATS for external devices
>   thunderbolt: Export IOMMU based DMA protection support to userspace

Looks good to me. Which tree should go this trough? In case its not the
IOMMU tree, for the iommu-parts:

	Acked-by: Joerg Roedel <jroedel@suse.de>
	Reviewed-by: Joerg Roedel <jroedel@suse.de>

Thanks,

	Joerg
