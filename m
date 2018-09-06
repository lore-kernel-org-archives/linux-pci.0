Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:43614 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729247AbeIFXZN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 6 Sep 2018 19:25:13 -0400
Date: Thu, 6 Sep 2018 12:49:53 -0600
From: Keith Busch <keith.busch@intel.com>
To: Thomas Tai <thomas.tai@oracle.com>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Sinan Kaya <okaya@kernel.org>, poza@codeaurora.org,
        Lukas Wunner <lukas@wunner.de>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCHv2 16/20] PCI/pciehp: Implement error handling callbacks
Message-ID: <20180906184953.GC31024@localhost.localdomain>
References: <20180905203546.21921-1-keith.busch@intel.com>
 <20180905203546.21921-17-keith.busch@intel.com>
 <367ae8b0-1a42-0b26-7865-e7398c62e403@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <367ae8b0-1a42-0b26-7865-e7398c62e403@oracle.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Sep 06, 2018 at 02:23:19PM -0400, Thomas Tai wrote:
> On 09/05/2018 04:35 PM, Keith Busch wrote:
> > +	if (changed) {
> > +		pciehp_request(ctrl, PCI_EXP_SLTSTA_PDC);
> > +		__pci_walk_bus(parent, pci_dev_set_disconnected, NULL);
> 
> error: ‘parent’ undeclared.
> 
> Shouldn't it be __pci_walk_bus(dev->port->bus, pci_dev_set_disconnected,
> NULL);

Indeed. I've pointed git send-email to the wrong directory, but looks
like this is the only discrepency.
