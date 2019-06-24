Return-Path: <SRS0=Q0Wt=UX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47741C4646C
	for <linux-pci@archiver.kernel.org>; Mon, 24 Jun 2019 10:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20F812146E
	for <linux-pci@archiver.kernel.org>; Mon, 24 Jun 2019 10:57:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728761AbfFXK5a (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 24 Jun 2019 06:57:30 -0400
Received: from mga05.intel.com ([192.55.52.43]:11126 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728477AbfFXK5a (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 24 Jun 2019 06:57:30 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jun 2019 03:57:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,411,1557212400"; 
   d="scan'208";a="182612908"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 24 Jun 2019 03:57:26 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 24 Jun 2019 13:57:25 +0300
Date:   Mon, 24 Jun 2019 13:57:25 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Keith Busch <keith.busch@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] PCI / ACPI: Use cached ACPI device state to get
 PCI device power state
Message-ID: <20190624105725.GD2640@lahna.fi.intel.com>
References: <20190618161858.77834-1-mika.westerberg@linux.intel.com>
 <CAJZ5v0hfCnyuAA7kC5-fXRo-Mf0jvGZQASV9T4iK8QxsqHMN_g@mail.gmail.com>
 <20190621130920.GB82584@google.com>
 <4163488.7S8HHuhOPg@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4163488.7S8HHuhOPg@kreacher>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Jun 22, 2019 at 10:51:28AM +0200, Rafael J. Wysocki wrote:
> > Thanks, this is all very helpful!  Do you by any chance add
> > lore.kernel.org links to commit logs when applying patches?  This is a
> > case where I think the discussion could be useful in the future.
> > 
> > Link: https://lore.kernel.org/r/20190618161858.77834-2-mika.westerberg@linux.intel.com
> 
> Agreed, and thanks for the URL.
> 
> I guess Mika can add this tag to the patch changelog.

Sure I'll add it.
