Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:44064 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751572AbeA3KXX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 30 Jan 2018 05:23:23 -0500
Date: Tue, 30 Jan 2018 12:23:19 +0200
From: Mika Westerberg <mika.westerberg@intel.com>
To: Kai Heng Feng <kai.heng.feng@canonical.com>
Cc: linux-pci@vger.kernel.org, Ethan Hsieh <ethan.hsieh@canonical.com>
Subject: Re: Thunderbolt PCIe card doesn't get enumerated at cold boot
Message-ID: <20180130102319.GE27654@lahna.fi.intel.com>
References: <8831781F-8027-4875-AF82-835FBE40F5F0@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <8831781F-8027-4875-AF82-835FBE40F5F0@canonical.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jan 30, 2018 at 04:32:51PM +0800, Kai Heng Feng wrote:
> Hi Mika,
> 
> Bother you again because you are the only TBT expert that I know of ;)

No problem. That's what I get paid for :-)

> We are enabling a new CFL desktop with TBT card.  The TBT card in
> question doesn’t get enumerated at cold boot, so the card isn’t listed
> under `lspci`.  Anything that does a PCI scan (# echo 1 >
> /sys/bus/pci/rescan, S3, warmboot) can make the card gets detected
> correctly.
> 
> The same TBT card doesn’t have the issue on a KBL desktop, so I not
> sure if it’s a driver issue though.

By TBT "card" do you mean TBT host add-in-card? Is it Alpine Ridge?

> Also, is there a more appropriate mailing list for TBT discussion?

I think you can use thunderbolt-software@lists.01.org as well.
