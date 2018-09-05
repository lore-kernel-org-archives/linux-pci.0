Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:49532 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727575AbeIEO22 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 5 Sep 2018 10:28:28 -0400
Date: Wed, 5 Sep 2018 12:58:47 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: Add ACS quirk for Intel 300 series chipset
Message-ID: <20180905095847.GJ2283@lahna.fi.intel.com>
References: <20180427104423.2203-1-mika.westerberg@linux.intel.com>
 <20180815152139.4e469fd4@t450s.home>
 <20180815164308.6ad5dd39@t450s.home>
 <20180816061015.GD2343@lahna.fi.intel.com>
 <20180816091303.69ce8e45@t450s.home>
 <20180816192805.GN2343@lahna.fi.intel.com>
 <20180816142504.4e3d121c@t450s.home>
 <20180817093716.GS2343@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180817093716.GS2343@lahna.fi.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Aug 17, 2018 at 12:37:16PM +0300, Mika Westerberg wrote:
> Before going there, I would like to get some definitive answer from our
> PCIe people regarding this (currently waiting for their reply).

Sorry for the delay.

I finally got confirmation and indeed this issue is fixed in 300 series
chipset. The datasheet has outdated information but it will be fixed as
well.

I will send a revert soon.
