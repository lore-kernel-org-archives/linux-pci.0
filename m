Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:42852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727434AbeGML5r (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 13 Jul 2018 07:57:47 -0400
Date: Fri, 13 Jul 2018 06:43:26 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Yinghai Lu <yinghai@kernel.org>, Sinan Kaya <okaya@kernel.org>,
        linux-pci@vger.kernel.org, Greg Kroah-Hartman <greg@kroah.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mayurkumar Patel <mayurkumar.patel@intel.com>,
        Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
        Stefan Roese <sr@denx.de>, Rajat Jain <rajatja@google.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Andreas Noever <andreas.noever@gmail.com>
Subject: Re: [PATCH 00/32] Rework pciehp event handling & add runtime PM
Message-ID: <20180713114326.GH28466@bhelgaas-glaptop.roam.corp.google.com>
References: <cover.1529173804.git.lukas@wunner.de>
 <20180712222816.GF28466@bhelgaas-glaptop.roam.corp.google.com>
 <20180713075449.GA27516@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180713075449.GA27516@wunner.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jul 13, 2018 at 09:54:49AM +0200, Lukas Wunner wrote:
> On Thu, Jul 12, 2018 at 05:28:16PM -0500, Bjorn Helgaas wrote:

> > These patches all showed up in random order in my inbox, I think
> > because they were sent with zero delay between them, which made them a
> > bit of a hassle to read and apply via email.
> 
> I habitually use a 20 second delay between each message, but I got
> unlucky and the mail servers delivered them in an incorrect order.

Strange, I wonder what happened.

> > If you repost these (I think I saw something about an issue with
> > patch 3), can you use a second or two of delay between them?
> 
> Would you like me to resend the whole series?  The ones at the
> beginning of the series (with the exception of patch 3) are probably
> uncontroversial, I was hoping that you could maybe apply some of them,
> or comment on some of the patches in the series so that I can rework
> them before reposting, thereby avoiding spamming everyone with identical
> patches a second time.

No need to resend for that, I had already sorted (but I didn't think to use
mutt sorting, so thanks for that!) and applied them on a test branch (see
https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/log/?h=pci/06-16-lukas-pciehp)
