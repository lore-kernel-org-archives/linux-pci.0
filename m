Return-Path: <SRS0=obOR=L7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA5A4ECE562
	for <linux-pci@archiver.kernel.org>; Mon, 17 Sep 2018 06:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79EAA2086B
	for <linux-pci@archiver.kernel.org>; Mon, 17 Sep 2018 06:13:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79EAA2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727726AbeIQLjB (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 17 Sep 2018 07:39:01 -0400
Received: from mga12.intel.com ([192.55.52.136]:56892 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726075AbeIQLjB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 17 Sep 2018 07:39:01 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Sep 2018 23:13:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,384,1531810800"; 
   d="scan'208";a="92340624"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by orsmga002.jf.intel.com with SMTP; 16 Sep 2018 23:12:18 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 17 Sep 2018 09:12:17 +0300
Date:   Mon, 17 Sep 2018 09:12:17 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Peter Anemone <peter.anemone@gmail.com>
Cc:     rjw@rjwysocki.net, lenb@kernel.org, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [REGRESSION][BISECTED] Boot stall related to
 drivers/pci/hotplug/acpiphp_glue.c
Message-ID: <20180917061217.GI14465@lahna.fi.intel.com>
References: <CAFtaAxE8G15vU40jCKzqzuwpt_-bDfVpWuaeuy6cQ-sh=Ap2XQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFtaAxE8G15vU40jCKzqzuwpt_-bDfVpWuaeuy6cQ-sh=Ap2XQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org
Message-ID: <20180917061217.WfiQfPnW5NyeSCjBLV2j1KZe6sRblzqTmapeCpEU5FY@z>

On Mon, Sep 17, 2018 at 08:58:50AM +0300, Peter Anemone wrote:
> Dear kernel developers
> I reported a bug at Bugzilla, but Greg Kroah-Hartman pointed me in
> mailing lists. Here's my bug report:
> 
> Linux has been unbootable for me from 4.18 upwards. Even the fallback
> image does not boot. This has not been fixed yet in 4.19-rc3. acpi=off
> kernel parameter lets me boot 4.18.6 and 4.19-rc3.
> 
> I used git bisect to track down the first bad commit:
> 84c8b58ed3addf17d3beb2e5037b001ffa65c5ef
> 
> The commit is about:
> "ACPI / hotplug / PCI: Don't scan bridges managed by native hotplug"
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=84c8b58ed3addf17d3beb2e5037b001ffa65c5ef
> 
> Linux 4.17 booted fine. Reverting commit
> 84c8b58ed3addf17d3beb2e5037b001ffa65c5ef makes 4.18 and 4.19-rc3
> bootable again (without the acpi=off parameter).
> 
> Information about my system:
> Model: HP 6730b laptop
> CPU: Intel Core 2 Duo P8600
> Boot manager: systemd-boot (UEFI)
> More information of my system as attachments on the bug report at Bugzilla.
> 
> Link to the bug report:
> https://bugzilla.kernel.org/show_bug.cgi?id=201127

Thanks for the report. Since there is bugzilla about the issue already,
let's continue investigation there.

Can you also attach full dmesg of the failure (if possible) to the bug?
