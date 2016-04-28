Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:60212 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750923AbcD1PjE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 28 Apr 2016 11:39:04 -0400
Date: Thu, 28 Apr 2016 18:38:58 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Lukas Wunner <lukas@wunner.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Qipeng Zha <qipeng.zha@intel.com>,
	Qi Zheng <qi.zheng@intel.com>, Dave Airlie <airlied@gmail.com>,
	Mathias Nyman <mathias.nyman@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andreas Noever <andreas.noever@gmail.com>,
	Linux PCI <linux-pci@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v4 4/4] PCI: Add runtime PM support for PCIe ports
Message-ID: <20160428153858.GG32610@lahna.fi.intel.com>
References: <1461578004-129094-1-git-send-email-mika.westerberg@linux.intel.com>
 <1461578004-129094-5-git-send-email-mika.westerberg@linux.intel.com>
 <20160428142216.GA18211@wunner.de>
 <20160428151356.GF32610@lahna.fi.intel.com>
 <CAJZ5v0h7n669VkzV23FA3YSQDFR5weWWVKrFBHF0XuCigGeMSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAJZ5v0h7n669VkzV23FA3YSQDFR5weWWVKrFBHF0XuCigGeMSA@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Apr 28, 2016 at 05:31:58PM +0200, Rafael J. Wysocki wrote:
> > Hmm, PM core calls pci_pm_runtime_resume() for PCI drivers which then
> > delegates to driver->runtime_resume() if set. However, if it is missing
> > it just returns -ENOSYS and does not put the device back to D0.
> >
> > So if I'm reading this right we actually need to provide
> > pcie_port_runtime_resume().
> 
> You do, but it could just return 0.
> 
> The suggestion seems to be that pm_runtime_mark_last_busy() is not
> needed as the core will invoke it anyway.

Ah, got it now. Thanks for the clarification!
