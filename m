Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout3.hostsharing.net ([176.9.242.54]:51215 "EHLO
        mailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753312AbcIMQUg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Sep 2016 12:20:36 -0400
Date: Tue, 13 Sep 2016 18:20:52 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Mayurkumar Patel <mayurkumar.patel@intel.com>,
        Rajat Jain <rajatja@google.com>, linux-pci@vger.kernel.org,
        Rafael J Wysocki <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org, Keith Busch <keith.busch@intel.com>,
        Luis Antonio Tarazona-Duarte
        <luis.antonio.tarazona-duarte@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        mika.westerberg@linux.intel.com
Subject: Re: [PATCH v2 0/8] PCI: pciehp: Rework hotplug interrupt routine
Message-ID: <20160913162052.GA1343@wunner.de>
References: <20160912210507.22258.63097.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160912210507.22258.63097.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Sep 12, 2016 at 04:08:47PM -0500, Bjorn Helgaas wrote:
> This is mostly Mayurkumar's work from [1] and [2].  I split [2] into two
> patches and reworked it to keep the enclosing loop around the pciehp ISR.
> 
> The patches I added are trivial ones to clarify variable names, make dmesg
> messages consistent, and remove useless code.
> 
> [1] 1471554479-42083-1-git-send-email-mayurkumar.patel@intel.com
> [2] 92EBB4272BF81E4089A7126EC1E7B28466598F35@IRSMSX101.ger.corp.intel.com

I've tested this series with Thunderbolt on the Mac, seems to work fine,
no regressions. I'll keep it on my branch and will shout if I do come
across issues over time.

Tested-by: Lukas Wunner <lukas@wunner.de>


Thanks,

Lukas
