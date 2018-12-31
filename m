Return-Path: <SRS0=55Kx=PI=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A00EC43387
	for <linux-pci@archiver.kernel.org>; Mon, 31 Dec 2018 09:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D946B21726
	for <linux-pci@archiver.kernel.org>; Mon, 31 Dec 2018 09:32:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbeLaJcL (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 31 Dec 2018 04:32:11 -0500
Received: from mga01.intel.com ([192.55.52.88]:34310 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726457AbeLaJcK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 31 Dec 2018 04:32:10 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Dec 2018 01:32:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,422,1539673200"; 
   d="scan'208";a="307811308"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga005.fm.intel.com with SMTP; 31 Dec 2018 01:32:07 -0800
Received: by lahna (sSMTP sendmail emulation); Mon, 31 Dec 2018 11:32:07 +0200
Date:   Mon, 31 Dec 2018 11:32:07 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH RFC] PCI/PME: fix PME runtime PM handling
Message-ID: <20181231093207.GZ2469@lahna.fi.intel.com>
References: <1e0c3baa-c2bb-0a91-19ca-65f4784b1424@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e0c3baa-c2bb-0a91-19ca-65f4784b1424@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Heiner,

On Sun, Dec 30, 2018 at 12:06:14PM +0100, Heiner Kallweit wrote:
> I face the issue that no PME is generated if the network cable is
> re-plugged. To explain that in a little more detail:
> r8169 driver enters runtime suspend 10 seconds after cable is detached.
> LinkUp detection is armed and device enters D3hot. When the cable is
> re-plugged Linkup should generate a PME and device is resumed.
> But system receives no PME from the device.
> 
> Wake-on-LAN from S3 works perfectly fine and generates a PME.
> 
> After checking the pcie pme code and some experiments I found that
> the following fixes the issue for me. Now system receives the PME
> and properly runtime-resumes the network device.
> 
> But I'm no expert in PCIe and PME, therefore I'm not sure whether
> the fix is correct. Please advise.
>
> Adding also Mika as author of 0e157e528604 ("PCI/PME: Implement
> runtime PM callbacks").

The root port cannot trigger an interrupt when it is in D3 (hot or cold)
so there needs to be a way to "wakeup" the hierarchy first which is
typically done by using sideband signal called WAKE#. Once the hierarchy
is brought back to communicating state the PME message is propagated to
the root port and the interrupt triggers (now the root port is in D0).
For some reason this does not seem to happen in your case and to
understand why we would need to gather a bit more information.

Can you file a kernel bug about this on bugzilla.kernel.org? Then attach
there acpidump and output of 'sudo lspci -vv'.

Thanks!
