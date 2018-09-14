Return-Path: <SRS0=PQBU=L4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91C6CFC6182
	for <linux-pci@archiver.kernel.org>; Fri, 14 Sep 2018 08:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5849520853
	for <linux-pci@archiver.kernel.org>; Fri, 14 Sep 2018 08:16:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5849520853
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728131AbeINNaA (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 14 Sep 2018 09:30:00 -0400
Received: from mga11.intel.com ([192.55.52.93]:2618 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726883AbeINN37 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 14 Sep 2018 09:29:59 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Sep 2018 01:16:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,372,1531810800"; 
   d="scan'208";a="83459529"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by orsmga003.jf.intel.com with SMTP; 14 Sep 2018 01:16:34 -0700
Received: by lahna (sSMTP sendmail emulation); Fri, 14 Sep 2018 11:16:33 +0300
Date:   Fri, 14 Sep 2018 11:16:33 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Len Brown <lenb@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Keith Busch <keith.busch@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Mario Limonciello <Mario.Limonciello@dell.com>,
        Anthony Wong <anthony.wong@canonical.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Linux PCI <linux-pci@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v2 01/10] PCI: Do not skip power managed bridges in
 pci_enable_wake()
Message-ID: <20180914081633.GU14465@lahna.fi.intel.com>
References: <20180913143322.77953-1-mika.westerberg@linux.intel.com>
 <20180913143322.77953-2-mika.westerberg@linux.intel.com>
 <153688100.j3IOAyprJL@aspire.rjw.lan>
 <20180914080621.GT14465@lahna.fi.intel.com>
 <CAJZ5v0gzacxkV+6gbY+paq6=h71KWpRM4pG5ko-Fu3ROdJ2AXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gzacxkV+6gbY+paq6=h71KWpRM4pG5ko-Fu3ROdJ2AXQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org
Message-ID: <20180914081633.8AbuxM2S8Dnu-5fcNkhV9M27O5xbZ2igCpJOpdMmWlA@z>

On Fri, Sep 14, 2018 at 10:11:25AM +0200, Rafael J. Wysocki wrote:
> You may need to resend for Patchwork to pick it up, though.  Depends
> on Bjorn I suppose.

OK, I'll resend it just in case :)
