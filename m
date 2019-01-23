Return-Path: <SRS0=s0ql=P7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C899C282C0
	for <linux-pci@archiver.kernel.org>; Wed, 23 Jan 2019 19:34:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE99A218A1
	for <linux-pci@archiver.kernel.org>; Wed, 23 Jan 2019 19:34:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbfAWTeP (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 23 Jan 2019 14:34:15 -0500
Received: from mga11.intel.com ([192.55.52.93]:33597 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725976AbfAWTeP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 23 Jan 2019 14:34:15 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Jan 2019 11:34:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,512,1539673200"; 
   d="scan'208";a="118859432"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by fmsmga008.fm.intel.com with ESMTP; 23 Jan 2019 11:34:14 -0800
Date:   Wed, 23 Jan 2019 12:33:15 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Alex_Gagniuc@Dellteam.com, linux-pci@vger.kernel.org,
        bhelgaas@google.com, Austin.Bolen@dell.com
Subject: Re: PCI: hotplug: Erroneous removal of hotplug PCI devices
Message-ID: <20190123193314.GA8193@localhost.localdomain>
References: <356432a0556d4da59f8ba5cf1d750019@ausx13mps317.AMER.DELL.COM>
 <20190123184453.GB6629@localhost.localdomain>
 <20190123190204.csjedbvcxkjlr43d@wunner.de>
 <20190123190738.GC6629@localhost.localdomain>
 <20190123191527.sp44r4la5vgln4el@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190123191527.sp44r4la5vgln4el@wunner.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 23, 2019 at 08:15:27PM +0100, Lukas Wunner wrote:
> On Wed, Jan 23, 2019 at 12:07:38PM -0700, Keith Busch wrote:
> > Right, so in Alex's case, it looks like we are observing
> > pcie_wait_for_link() returning true before the PDC event.
> > 
> > I'm wondering about PDS because if the link is up but Presence reports an
> > empty slot, does that matter for any implementations? Or is it perfectly
> > fine to enumerate an active link on an empty slot? An empty slot and
> > active link doesn't make a lot of sense, but that observation appears to
> > be what is reported here.
> 
> We allow enumeration with an active link of an allegedly empty slot
> because some hardware hardwires PDS to zero, see commit 80696f991424
> ("PCI: pciehp: Tolerate Presence Detect hardwired to zero").
> 
> The brokenness of PCIe hotplug implementations found in the wild is
> astonishing.

Heh, sounds like Alex's proposal may work until we find a slot
implementation that doesn't do DLLSC as expected. :)
