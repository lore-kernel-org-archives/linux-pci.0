Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:54648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966262AbeEJQ1t (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 10 May 2018 12:27:49 -0400
Date: Thu, 10 May 2018 11:27:46 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: poza@codeaurora.org
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dongdong Liu <liudongdong3@huawei.com>,
        Keith Busch <keith.busch@intel.com>, Wei Zhang <wzhang@fb.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Timur Tabi <timur@codeaurora.org>,
        linux-pci-owner@vger.kernel.org
Subject: Re: [PATCH v15 8/9] PCI/DPC: Unify and plumb error handling into DPC
Message-ID: <20180510162746.GA190385@bhelgaas-glaptop.roam.corp.google.com>
References: <1525323838-1735-1-git-send-email-poza@codeaurora.org>
 <1525323838-1735-9-git-send-email-poza@codeaurora.org>
 <20180510132222.GE173327@bhelgaas-glaptop.roam.corp.google.com>
 <29c21a3fbaeb56c0581da66b9203dfd1@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <29c21a3fbaeb56c0581da66b9203dfd1@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 10, 2018 at 07:56:00PM +0530, poza@codeaurora.org wrote:
> On 2018-05-10 18:52, Bjorn Helgaas wrote:
> > On Thu, May 03, 2018 at 01:03:57AM -0400, Oza Pawandeep wrote:
> ...

> > > -static pci_ers_result_t reset_link(struct pci_dev *dev)
> > > +static pci_ers_result_t reset_link(struct pci_dev *dev, int severity)
> > >  {
> > >  	struct pci_dev *udev;
> > >  	pci_ers_result_t status;
> > >  	struct pcie_port_service_driver *driver;
> > > +	u32 service;
> > > 
> > >  	if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
> > >  		/* Reset this port for all subordinates */
> > > @@ -196,7 +197,12 @@ static pci_ers_result_t reset_link(struct
> > > pci_dev *dev)
> > >  	}
> > > 
> > >  	/* Use the aer driver of the component firstly */
> > > -	driver = pcie_port_find_service(udev, PCIE_PORT_SERVICE_AER);
> > > +	if (severity == DPC_FATAL)
> > > +		service = PCIE_PORT_SERVICE_DPC;
> > > +	else
> > > +		service = PCIE_PORT_SERVICE_AER;
> > > +
> > > +	driver = pcie_port_find_service(udev, service);
> > 
> > This is where I was wondering about passing in "service" directly
> > instead
> > of "severity".
> 
> passing service directly instead of severity ? (I do not think you meant to
> write severity there)

I did mean "severity".

> perhaps do you mean following ?
> 
> if (severity == DPC_FATAL)
>          pcie_port_find_service(udev, PCIE_PORT_SERVICE_DPC);
> else
>          pcie_port_find_service(udev, PCIE_PORT_SERVICE_AER);

No, my thought was that most of the places that use "severity" only
use it to decide between PCIE_PORT_SERVICE_DPC and
PCIE_PORT_SERVICE_AER, so if you just passed in "service" directly,
you wouldn't need this "if" statement.

Bjorn
