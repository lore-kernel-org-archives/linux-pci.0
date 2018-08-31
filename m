Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:57698 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727250AbeIACQW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 31 Aug 2018 22:16:22 -0400
Date: Fri, 31 Aug 2018 16:08:03 -0600
From: Keith Busch <keith.busch@intel.com>
To: Sinan Kaya <okaya@kernel.org>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Thomas Tai <thomas.tai@oracle.com>, poza@codeaurora.org,
        Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH 02/16] PCI: Fix pci_reset_bus
Message-ID: <20180831220802.GD9677@localhost.localdomain>
References: <20180831212639.10196-1-keith.busch@intel.com>
 <20180831212639.10196-3-keith.busch@intel.com>
 <dad1e661-679d-eb4b-8c87-b65afd5eb838@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <dad1e661-679d-eb4b-8c87-b65afd5eb838@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Aug 31, 2018 at 02:52:25PM -0700, Sinan Kaya wrote:
> On 8/31/2018 2:26 PM, Keith Busch wrote:
> > The check for slot reset capable, pci_probe_reset_slot, returns 0 when
> > slot reset is possible, but pci_reset_bus was proceeding to reset the
> > slot when the probe returned an error. This patch reverses the check to
> > fix that logic.
> > 
> > Signed-off-by: Keith Busch<keith.busch@intel.com>
> 
> Thanks, dennis.dalessandro@intel.com just posted the same patch.

Oh, he sure did! Nothing in my series depends on this duplicate patch,
so no problem to use either one.
