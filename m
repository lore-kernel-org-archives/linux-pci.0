Return-Path: <jonathan.derrick@intel.com>
Return-Path: <jonathan.derrick@intel.com>
Date: Wed, 21 Sep 2016 10:39:08 -0600
From: Jon Derrick <jonathan.derrick@intel.com>
To: helgaas@kernel.org
Cc: keith.busch@intel.com, linux-pci@vger.kernel.org
Subject: Re: [RFC] PCI/Hotplug: Clear power fault detected when servicing
 faults
Message-ID: <20160921163908.GA6133@localhost.localdomain>
References: <1474409437-20464-1-git-send-email-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1474409437-20464-1-git-send-email-jonathan.derrick@intel.com>
List-ID: <linux-pci.vger.kernel.org>

I was far too eager with this one. Found a case this morning which resulted in a soft lockup. Please kill this for now.

On Tue, Sep 20, 2016 at 04:10:37PM -0600, Jon Derrick wrote:
> A slot is allowed to implement power fault detection without having a
> power controller present. Current code can set the controller's
> power_fault_detected when seeing a power fault interrupt, but cannot
> clear the flag without a power controller present. This patch clears the
> flag when the power fault event is serviced by the interrupt event
> handler.
