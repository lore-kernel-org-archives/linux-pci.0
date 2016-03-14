Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:25194 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752138AbcCNI4K (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 14 Mar 2016 04:56:10 -0400
Date: Mon, 14 Mar 2016 10:56:02 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Qipeng Zha <qipeng.zha@intel.com>,
	Qi Zheng <qi.zheng@intel.com>, linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH 1/6] PCI: No need to set d3cold_allowed to PCIe ports
Message-ID: <20160314085602.GZ1796@lahna.fi.intel.com>
References: <1456750566-116248-1-git-send-email-mika.westerberg@linux.intel.com>
 <1456750566-116248-2-git-send-email-mika.westerberg@linux.intel.com>
 <20160312000111.GJ4725@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160312000111.GJ4725@localhost>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Mar 11, 2016 at 06:01:11PM -0600, Bjorn Helgaas wrote:
> On Mon, Feb 29, 2016 at 02:56:01PM +0200, Mika Westerberg wrote:
> > PCIe ports are already skipped by the PCI core so they are never moved to
> > D3 (or D3cold) anyway. No need to set the field.
> 
> A pointer to where the PCI core skips these ports would be helpful.
> pci_pm_runtime_suspend() is the only place I see that tests d3cold_allowed,
> and I don't see that it checks anything about PCIe ports.

Right, sorry about that. The changelog should say that the PCI core
skips PCI bridges and PCIe ports.

The relevant code is in drivers/pci/pci-driver.c:pci_pm_suspend_noirq():

        if (!pci_dev->state_saved) {
                pci_save_state(pci_dev);
                if (!pci_has_subordinate(pci_dev))
                        pci_prepare_to_sleep(pci_dev);
        }

It checks if the device has subordinate devices if not moves the device
to low power state.
