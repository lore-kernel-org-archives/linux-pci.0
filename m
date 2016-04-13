Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:20799 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759663AbcDMJQy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 13 Apr 2016 05:16:54 -0400
Date: Wed, 13 Apr 2016 12:16:43 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Andreas Noever <andreas.noever@gmail.com>
Cc: Lukas Wunner <lukas@wunner.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Qipeng Zha <qipeng.zha@intel.com>,
	Qi Zheng <qi.zheng@intel.com>, Dave Airlie <airlied@gmail.com>,
	Mathias Nyman <mathias.nyman@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Linux PM list <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] PCI: Add runtime PM support for PCIe ports
Message-ID: <20160413091643.GL1714@lahna.fi.intel.com>
References: <1460111790-92836-1-git-send-email-mika.westerberg@linux.intel.com>
 <1460111790-92836-5-git-send-email-mika.westerberg@linux.intel.com>
 <20160412175203.GB13637@wunner.de>
 <20160413083352.GI1714@lahna.fi.intel.com>
 <CAMxnaaVEPYfU15OGwygsT_RHvqBFPU4NHFRNKK4Eng-TJixFkg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAMxnaaVEPYfU15OGwygsT_RHvqBFPU4NHFRNKK4Eng-TJixFkg@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Apr 13, 2016 at 11:08:37AM +0200, Andreas Noever wrote:
> > <- Now, my understanding is that Macs do not use ACPI hotplug but
> > instead this is all native, correct? When you have the controller
> > exposed all the time, of course you can get hotplug events and handle
> > them in the driver.
> >
> > However, problem arises when enumeration and configuration is actually
> > done in BIOS SMI handler, like in normal non-Mac PCs. If the port is in
> > D3 the handler is not smart enough to move it back to D0 and then
> > re-enumerate ports. It just gives up.
> Is this issue specific to the "ACPI/SMI Thunderbolt" implementations
> used in non-Mac PCs or is PCI hotplug in general done through SMI/ACPI
> instead of the native pciehp port driver? Wouldn't it make more sense
> to only disable runtime suspend on non-Mac thunderbolt ports (or ports
> using ACPI hotplug, if that is detectable).

I think it is specific to ACPI hotplug implementations (non-Mac PCs). We
should be able to detect which one is used. ACPI _OSC method is used to
allow/disallow native PCIe hotplug so I think we use that information
along with the slot capabilities to decide whether we enable or disable
runtime PM.
