Return-Path: <SRS0=um5r=AG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA06CC433E0
	for <linux-pci@archiver.kernel.org>; Thu, 25 Jun 2020 12:16:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD2F220E65
	for <linux-pci@archiver.kernel.org>; Thu, 25 Jun 2020 12:16:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404480AbgFYMQ1 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 25 Jun 2020 08:16:27 -0400
Received: from mga18.intel.com ([134.134.136.126]:40152 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404343AbgFYMQ1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 25 Jun 2020 08:16:27 -0400
IronPort-SDR: 0Y1nujGV5mNPAVyv4tnzxDHTLOrVYUzoCq2OZaRWyRh6GJz3GL+tNM5N9s9uxoCU69nKPaX8aW
 LhOLgUqBizFw==
X-IronPort-AV: E=McAfee;i="6000,8403,9662"; a="132302332"
X-IronPort-AV: E=Sophos;i="5.75,279,1589266800"; 
   d="scan'208";a="132302332"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2020 05:16:25 -0700
IronPort-SDR: fWaSgBUWhlXYLDYK3rRqkXWDv/WZioOftV7rDKySVRLs+7vXiUofUwqy5+GSwYHmgPmjB0m7gt
 3ooekk1Ktfcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,279,1589266800"; 
   d="scan'208";a="479455359"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga006.fm.intel.com with SMTP; 25 Jun 2020 05:16:20 -0700
Received: by lahna (sSMTP sendmail emulation); Thu, 25 Jun 2020 15:16:19 +0300
Date:   Thu, 25 Jun 2020 15:16:19 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        "David E. Box" <david.e.box@linux.intel.com>, shyjumon.n@intel.com,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>
Subject: Re: [PATCH V2 1/2] PCI: Add ACPI StorageD3Enable _DSD support
Message-ID: <20200625121619.GG2795@lahna.fi.intel.com>
References: <20200612204820.20111-2-david.e.box@linux.intel.com>
 <20200624211549.GA2586552@bjorn-Precision-5520>
 <CAJZ5v0i8dCN=HMFk_+ZX-Wr73P6kdQBtV0i3FtrZrO9cegXsvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0i8dCN=HMFk_+ZX-Wr73P6kdQBtV0i3FtrZrO9cegXsvQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 25, 2020 at 01:30:53PM +0200, Rafael J. Wysocki wrote:
> It is not necessary to call acpi_pci_find_companion() from
> pci_acpi_storage_d3() as long as that function is required to be
> called by the target device's driver probe or later.
> 
> Ths acpi_pci_bridge_d3() case is different, though, AFAICS, because it
> is invoked in the pci_pm_init() path, via pci_bridge_d3_possible(),
> and that gets called from pci_device_add() *before* calling
> device_add().
> 
> Mika, is that why acpi_pci_find_companion() gets callled from
> acpi_pci_bridge_d3()?

Yes, that's correct.
