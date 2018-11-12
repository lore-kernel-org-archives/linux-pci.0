Return-Path: <SRS0=qbZn=NX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16074C43441
	for <linux-pci@archiver.kernel.org>; Mon, 12 Nov 2018 18:12:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5F2022419
	for <linux-pci@archiver.kernel.org>; Mon, 12 Nov 2018 18:12:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5F2022419
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728832AbeKMEGi (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 12 Nov 2018 23:06:38 -0500
Received: from bmailout3.hostsharing.net ([176.9.242.62]:36337 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727247AbeKMEGi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Nov 2018 23:06:38 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 58B7B100DA1DF;
        Mon, 12 Nov 2018 19:12:15 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id BA7C04D2DB; Mon, 12 Nov 2018 19:12:14 +0100 (CET)
Date:   Mon, 12 Nov 2018 19:12:14 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Christian Kellner <ckellner@redhat.com>,
        Mario.Limonciello@dell.com,
        Anthony Wong <anthony.wong@canonical.com>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] PCI / iommu / thunderbolt: IOMMU based DMA protection
Message-ID: <20181112181214.xaahc5wni4vuwl6h@wunner.de>
References: <20181112160628.86620-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181112160628.86620-1-mika.westerberg@linux.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 12, 2018 at 07:06:24PM +0300, Mika Westerberg wrote:
> Recent systems shipping with Windows 10 version 1803 or newer may be
> utilizing IOMMU to prevent DMA attacks via Thunderbolt ports. This is
> different from the previous security level based scheme because the
> connected device cannot access system memory outside of the regions
> allocated for it by the driver.
> 
> When enabled the BIOS makes sure no device can do DMA outside of RMRR
> (Reserved Memory Region Record) regions. This means that during OS boot,
> before it enables IOMMU, none of the connected devices can bypass DMA
> protection for instance by overwriting the data structures used by the
> IOMMU. The BIOS communicates support for this to the OS by setting a new
> bit in ACPI DMAR table [1].
> 
> Because these systems utilize an IOMMU to block possible DMA attacks,
> typically (but not always) the Thunderbolt security level is set to "none"
> which means that all PCIe devices are immediately usable. This also means
> that Linux needs to follow Windows 10 and enable IOMMU automatically when
> running on such system otherwise connected devices can read/write system
> memory pretty much without any restrictions.

What if the system is booted from a Thunderbolt-attached disk?
Won't this suddenly break with these patches?  That would seem like a
pretty significant regression.  What if the only GPU in the system is
Thunderbolt-attached?  Is it possible to recognize such scenarios and
automatically exempt affected devices from IOMMU blocking?

Thanks,

Lukas
