Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:43654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753156AbeB0Ol7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Feb 2018 09:41:59 -0500
Date: Tue, 27 Feb 2018 08:41:57 -0600
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
        Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH v11 3/7] PCI/ERR: add mutex to synchronize recovery
Message-ID: <20180227144157.GA112033@bhelgaas-glaptop.roam.corp.google.com>
References: <1519374244-20539-1-git-send-email-poza@codeaurora.org>
 <1519374244-20539-4-git-send-email-poza@codeaurora.org>
 <20180223234525.GQ14632@bhelgaas-glaptop.roam.corp.google.com>
 <34e4c9a98a9ed3494a0295d00e181fe9@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <34e4c9a98a9ed3494a0295d00e181fe9@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Feb 27, 2018 at 10:46:34AM +0530, poza@codeaurora.org wrote:
> On 2018-02-24 05:15, Bjorn Helgaas wrote:
> > On Fri, Feb 23, 2018 at 01:54:00PM +0530, Oza Pawandeep wrote:
> > > This patch protects pci_do_recovery with mutex.
> > 
> > pcie_do_recovery()
> > 
> > Please explain why the mutex is necessary.  What bad things happen
> > without the mutex?
> > 
> > You named (some) of the other things "pcie"; maybe use "pcie" in the
> > mutex name as well so they look the same.
> > 
> 
> PCIe specification: 6.2.10
> When DPC is triggered due to receipt of an uncorrectable error Message, the
> Requester ID from the Message is recorded in the DPC Error Source ID
> register and that Message is discarded and not forwarded Upstream.
> 
> So, having said that, what we think is we dont need Mutex, because in DPC
> enabled system either AER or DPC can be triggered, not both.
> so right now there is no need of guarding pcie_do_recovery() with mutex.
> 
> but I was in a thought that; since pcie_do_recovery is supposed to be used
> by error clients,
> from sw architecture point of view, adding mutex takes care of concurrency
> if it exists (in corner cases, faulty hw where both AER and DPC triggered
> etc..)
> 
> We can choose to drop this patch, since we dont require mutex.
> Bjorn, please advise.

I'm not trying to convince you that we don't need the mutex.  My
point is that if we *do* need it, the changelog needs to say *why*
(and ideally the code will either have a comment or it will be obvious
from the code why it's necessary).

If we don't have a clear indication that it's required, I guess I
would omit it.

> > > Signed-off-by: Oza Pawandeep <poza@codeaurora.org>
> > > 
> > > diff --git a/drivers/pci/pcie/pcie-err.c b/drivers/pci/pcie/pcie-err.c
> > > index fcd5add..f830975 100644
> > > --- a/drivers/pci/pcie/pcie-err.c
> > > +++ b/drivers/pci/pcie/pcie-err.c
> > > @@ -20,6 +20,8 @@
> > >  #include <linux/pcieport_if.h>
> > >  #include "portdrv.h"
> > > 
> > > +static DEFINE_MUTEX(pci_err_recovery_lock);
> > > +
> > >  struct aer_broadcast_data {
> > >  	enum pci_channel_state state;
> > >  	enum pci_ers_result result;
> > > @@ -283,6 +285,8 @@ void pcie_do_recovery(struct pci_dev *dev, int
> > > severity)
> > >  	pci_ers_result_t status, result = PCI_ERS_RESULT_RECOVERED;
> > >  	enum pci_channel_state state;
> > > 
> > > +	mutex_lock(&pci_err_recovery_lock);
> > > +
> > >  	if (severity == AER_FATAL)
> > >  		state = pci_channel_io_frozen;
> > >  	else
> > > @@ -326,9 +330,11 @@ void pcie_do_recovery(struct pci_dev *dev, int
> > > severity)
> > >  				report_resume);
> > > 
> > >  	dev_info(&dev->dev, "Device recovery successful\n");
> > > +	mutex_unlock(&pci_err_recovery_lock);
> > >  	return;
> > > 
> > >  failed:
> > >  	/* TODO: Should kernel panic here? */
> > >  	dev_info(&dev->dev, "Device recovery failed\n");
> > > +	mutex_unlock(&pci_err_recovery_lock);
> > >  }
> > > --
> > > Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
> > > Technologies, Inc.,
> > > a Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
> > > a Linux Foundation Collaborative Project.
> > > 
