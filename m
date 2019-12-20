Return-Path: <SRS0=oNFn=2K=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF7B4C43603
	for <linux-pci@archiver.kernel.org>; Fri, 20 Dec 2019 10:18:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B84B42467F
	for <linux-pci@archiver.kernel.org>; Fri, 20 Dec 2019 10:18:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727184AbfLTKSu (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 20 Dec 2019 05:18:50 -0500
Received: from mga05.intel.com ([192.55.52.43]:51159 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727129AbfLTKSu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 20 Dec 2019 05:18:50 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Dec 2019 02:18:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,335,1571727600"; 
   d="scan'208";a="222470644"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 20 Dec 2019 02:18:47 -0800
Received: by lahna (sSMTP sendmail emulation); Fri, 20 Dec 2019 12:18:46 +0200
Date:   Fri, 20 Dec 2019 12:18:46 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH v12 0/4] PCI: Patch series to improve Thunderbolt
 enumeration
Message-ID: <20191220101846.GV2913417@lahna.fi.intel.com>
References: <PSXP216MB043840E2DE9B81AC8797F63A80530@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
 <20191220000358.GA126443@google.com>
 <PSXP216MB043888F94710A361E4D84DFF802D0@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PSXP216MB043888F94710A361E4D84DFF802D0@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Dec 20, 2019 at 08:50:14AM +0000, Nicholas Johnson wrote:
> Mika, what would you have written if you had to do this?

Heh, I'm not the best person to ask :) Something like below maybe?

  Improve PCI resource allocation on systems with Thunderbolt
  add-in-card but no support from BIOS side.

I think that's what your series is about.
