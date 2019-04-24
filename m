Return-Path: <SRS0=9smm=S2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3582C282CE
	for <linux-pci@archiver.kernel.org>; Wed, 24 Apr 2019 14:58:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B35DF2089F
	for <linux-pci@archiver.kernel.org>; Wed, 24 Apr 2019 14:58:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733105AbfDXO6c (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:58:32 -0400
Received: from mga14.intel.com ([192.55.52.115]:6226 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733108AbfDXO6Y (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 24 Apr 2019 10:58:24 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Apr 2019 07:58:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,390,1549958400"; 
   d="scan'208";a="167511098"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 24 Apr 2019 07:58:20 -0700
Received: by lahna (sSMTP sendmail emulation); Wed, 24 Apr 2019 17:58:19 +0300
Date:   Wed, 24 Apr 2019 17:58:19 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Alexander Fomichev <fomichev.ru@gmail.com>,
        linux-pci@vger.kernel.org, linux@yadro.com,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH RESEND] PCI: disable runtime PM for PLX switches
Message-ID: <20190424145819.GL2654@lahna.fi.intel.com>
References: <20190415135903.wiyw34faiezdnbbs@yadro.com>
 <20190415141554.GL126710@google.com>
 <20190423215340.GH14616@google.com>
 <20190424100102.iyxogbsa4l7dyusb@yadro.com>
 <20190424141148.GA244134@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190424141148.GA244134@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 24, 2019 at 09:11:48AM -0500, Bjorn Helgaas wrote:
>   - Maybe the PCI sysfs accessors (pci_mmap_resource(), etc) should
>     turn off runtime PM?  If we allow mmap of a BAR and then put the
>     device in D3hot, that seems like a bug that could affect lots of
>     things.  But maybe that's already done magically elsewhere?

IIRC there is no PM magic happening for MMIO userspace accesses.

What you suggest above sounds like a good way to fix it. We already do
similar for config space access from userspace (if the device is in
D3cold) so definitely makes sense to do the same for MMIO. However, I
don't think we need to disable runtime PM - it should be enough to
increase the reference count (pm_runtime_get_sync() and friends) during
the time the MMIO resource is mmapped.
