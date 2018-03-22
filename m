Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:29338 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751586AbeCVQxV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 22 Mar 2018 12:53:21 -0400
Date: Thu, 22 Mar 2018 18:53:17 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Keith Busch <keith.busch@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH 1/2] PCI/DPC: Disable interrupt generation during suspend
Message-ID: <20180322165317.GI2703@lahna.fi.intel.com>
References: <20180314114125.71132-1-mika.westerberg@linux.intel.com>
 <CAJZ5v0gOrQhXzLHDnABEYHxGbHVY89Nij9uQzqx-oyYmFwzuSg@mail.gmail.com>
 <20180314120547.GB2703@lahna.fi.intel.com>
 <20180314123332.GC19651@wunner.de>
 <20180320104508.GF2703@lahna.fi.intel.com>
 <20180320113556.GA24197@wunner.de>
 <20180322104517.GA20389@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180322104517.GA20389@wunner.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Mar 22, 2018 at 11:45:17AM +0100, Lukas Wunner wrote:
> Now I've thought of one.
> 
> The port may have more children besides the port service devices,
> namely all the PCI devices below the port.  The PM core doesn't
> impose a specific ordering on suspend/resume but will try to
> parallelize among all the children.
> 
> Usually that's not what you want.  On resume, you want to resume
> the port itself (including its port services) *before* resuming
> the PCI child devices.  And the other way round on suspend.

That's a good point.

So I guess there is no way avoiding adding suspend_late/resume_early
callbacks to the pcie port service structure. I'll do that in the next
revision.
