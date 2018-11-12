Return-Path: <SRS0=qbZn=NX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15BDEC43441
	for <linux-pci@archiver.kernel.org>; Mon, 12 Nov 2018 18:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D630A22513
	for <linux-pci@archiver.kernel.org>; Mon, 12 Nov 2018 18:09:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D630A22513
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729133AbeKMEDY (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 12 Nov 2018 23:03:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42368 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727247AbeKMEDY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 12 Nov 2018 23:03:24 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 75F89307D91B;
        Mon, 12 Nov 2018 18:09:03 +0000 (UTC)
Received: from t450s.home (ovpn-116-133.phx2.redhat.com [10.3.116.133])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 599E6600D7;
        Mon, 12 Nov 2018 18:09:01 +0000 (UTC)
Date:   Mon, 12 Nov 2018 11:09:00 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     iommu@lists.linux-foundation.org, Ashok Raj <ashok.raj@intel.com>,
        Mario.Limonciello@dell.com,
        Michael Jamet <michael.jamet@intel.com>,
        Christian Kellner <ckellner@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Anthony Wong <anthony.wong@canonical.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-acpi@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] iommu/vt-d: Force IOMMU on for platform opt in hint
Message-ID: <20181112110900.16cfee48@t450s.home>
In-Reply-To: <20181112160628.86620-3-mika.westerberg@linux.intel.com>
References: <20181112160628.86620-1-mika.westerberg@linux.intel.com>
        <20181112160628.86620-3-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Mon, 12 Nov 2018 18:09:04 +0000 (UTC)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 12 Nov 2018 19:06:26 +0300
Mika Westerberg <mika.westerberg@linux.intel.com> wrote:

> From: Lu Baolu <baolu.lu@linux.intel.com>
> 
> Intel VT-d spec added a new DMA_CTRL_PLATFORM_OPT_IN_FLAG flag
> in DMAR ACPI table for BIOS to report compliance about platform
> initiated DMA restricted to RMRR ranges when transferring control
> to the OS. The OS treats this as a hint that the IOMMU should be
> enabled to prevent DMA attacks from possible malicious devices.

Does this in any way suggest that there are additional recommended uses
cases from Intel for RMRRs?  My concern here is the incompatibility we
have with RMRRs and device assignment as we currently cannot assign
devices where the IOVA address space is encumbered by RMRR
requirements.  Unfortunately RMRRs do not indicate any sort or
lifespan, so firmware enabling an RMRR simply to support some boot-time
DMA encumbers the device with that RMRR for the life of that boot,
unless we have VT-d code that decides it knows better.  Thanks,

Alex
