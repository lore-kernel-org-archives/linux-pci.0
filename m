Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:58236 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965813AbdGTWfX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 20 Jul 2017 18:35:23 -0400
Date: Thu, 20 Jul 2017 18:41:27 -0400
From: Keith Busch <keith.busch@intel.com>
To: Scott Bauer <scott.bauer@intel.com>
Cc: Jon Derrick <jonathan.derrick@intel.com>,
        linux-pci@vger.kernel.org, david.fugate@intel.com,
        bhelgaas@google.com
Subject: Re: [PATCH] PCI: vmd: Free up IRQs on suspend path
Message-ID: <20170720224126.GF1202@localhost.localdomain>
References: <20170720202858.1918-1-scott.bauer@intel.com>
 <cfc64209-82cb-432b-8ca1-c02c50d34d68@intel.com>
 <20170720213420.lxllowcwnp24gmxf@sbauer-Z170X-UD5>
 <a8fa0b4a-a918-6c98-169c-2b9c35bd8cdb@intel.com>
 <20170720215654.nyfpvgzgny2bpqny@sbauer-Z170X-UD5>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170720215654.nyfpvgzgny2bpqny@sbauer-Z170X-UD5>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jul 20, 2017 at 03:56:54PM -0600, Scott Bauer wrote:
> On Tue, Jul 25, 2017 at 08:36:10PM -0600, Jon Derrick wrote:
> > 
> > I think we'll need to do more than free the irq handlers because if an
> > interrupt occurs after that, I think it'll get kicked to handle_bad_irq.
> > I think we just need to add pci_disable_device after save and
> > pcim_enable_device after restore.
> 
> I orignally had this in the patch I was testing on SLES and took it out when
> it seemingly didn't make a difference. I didnt test yanking a drive or anything
> behind the domain while it was suspended, so I wouldn't have hit your scenario.
> 
> I'll add it back in. Also, I think I need to CC stable on this one too since
> this is missing all the way since the original inception of this driver.

I think your patch should be okay as-is. After freeing VMD's IRQs,
the kernel will automatically clear the MSI-x control bit to disable it
from firing.
