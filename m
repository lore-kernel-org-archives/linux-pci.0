Return-Path: <SRS0=55Kx=PI=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF8B5C43387
	for <linux-pci@archiver.kernel.org>; Mon, 31 Dec 2018 10:56:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9587421871
	for <linux-pci@archiver.kernel.org>; Mon, 31 Dec 2018 10:56:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727167AbeLaK4w (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 31 Dec 2018 05:56:52 -0500
Received: from mga05.intel.com ([192.55.52.43]:54637 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726988AbeLaK4w (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 31 Dec 2018 05:56:52 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Dec 2018 02:56:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,422,1539673200"; 
   d="scan'208";a="102761776"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by orsmga007.jf.intel.com with SMTP; 31 Dec 2018 02:56:47 -0800
Received: by lahna (sSMTP sendmail emulation); Mon, 31 Dec 2018 12:56:46 +0200
Date:   Mon, 31 Dec 2018 12:56:46 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH RFC] PCI/PME: fix PME runtime PM handling
Message-ID: <20181231105646.GD2469@lahna.fi.intel.com>
References: <1e0c3baa-c2bb-0a91-19ca-65f4784b1424@gmail.com>
 <20181231093207.GZ2469@lahna.fi.intel.com>
 <2ac489b3-a091-bfce-32f1-b6fc86f3337c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ac489b3-a091-bfce-32f1-b6fc86f3337c@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Dec 31, 2018 at 11:37:20AM +0100, Heiner Kallweit wrote:
> After reading again your commit message for adding the PME runtime PM
> callbacks: It seems that you focused on root ports only when adding
> this functionality. Should there be a check whether port is a root port?

This particular PME functionality (native PCIe PME) is present only on
root ports and the pcie_pme driver only binds to those.
