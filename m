Return-Path: <SRS0=TXaA=7X=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D92EC433E0
	for <linux-pci@archiver.kernel.org>; Wed, 10 Jun 2020 09:52:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F46E206F4
	for <linux-pci@archiver.kernel.org>; Wed, 10 Jun 2020 09:52:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbgFJJwV (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 10 Jun 2020 05:52:21 -0400
Received: from mga01.intel.com ([192.55.52.88]:32460 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726134AbgFJJwV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 10 Jun 2020 05:52:21 -0400
IronPort-SDR: cduVAJmSd528RDmgIk+Mld6BseDiHugEed6+7LwJJmXVKZ2ISNf7Sz1KzUlKw3aIqJMAmfXDEK
 Y8yid7HmNRZw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2020 02:52:20 -0700
IronPort-SDR: ZzvQkhgHvZvcqUrsFkdxNV042deSsHvS0fa9T3uHHvJaSIVqlnf2duh5G5SMtRJVqC7f+Ipxy2
 DRs7ZtW3wSyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,495,1583222400"; 
   d="scan'208";a="380013092"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 10 Jun 2020 02:52:18 -0700
Received: by lahna (sSMTP sendmail emulation); Wed, 10 Jun 2020 12:52:17 +0300
Date:   Wed, 10 Jun 2020 12:52:17 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@dell.com>,
        it+linux-pci@molgen.mpg.de, amd-gfx@lists.freedesktop.org
Subject: Re: close() on some Intel CNP-LP PCI devices takes up to 2.7 s
Message-ID: <20200610095217.GE247495@lahna.fi.intel.com>
References: <b0781d0e-2894-100d-a4da-e56c225eb2a6@molgen.mpg.de>
 <20200609154416.GU247495@lahna.fi.intel.com>
 <3854150d-f193-d34e-557e-41090e4f39b5@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3854150d-f193-d34e-557e-41090e4f39b5@molgen.mpg.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 10, 2020 at 08:18:07AM +0200, Paul Menzel wrote:
> Thank you for replying so quickly. Hopefully, I’ll be able to test the
> commit tomorrow.
> 
> One question though. The commit talks about resuming from suspend. I
> understand that training happens there.
> 
> In my case the system is already running. So I wonder, why link(?) training
> would still happening.

It also includes runtime PM so when the PCIe topology goes into D3cold
the links are "down" so once you run tool such as lspci the links need
to be re-trained to be able to access the devices connected to them.
