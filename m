Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:54396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751237AbdIAEna (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 1 Sep 2017 00:43:30 -0400
Date: Thu, 31 Aug 2017 23:43:26 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Gabriele Paoloni <gabriele.paoloni@huawei.com>
Cc: linuxarm@huawei.com, liudongdong3@huawei.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCIe AER: report uncorrectable errors only to the
 functions that logged the errors
Message-ID: <20170901044326.GG18250@bhelgaas-glaptop.roam.corp.google.com>
References: <1503054141-80272-1-git-send-email-gabriele.paoloni@huawei.com>
 <20170831200344.GF18250@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170831200344.GF18250@bhelgaas-glaptop.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Aug 31, 2017 at 03:03:44PM -0500, Bjorn Helgaas wrote:
> On Fri, Aug 18, 2017 at 12:02:21PM +0100, Gabriele Paoloni wrote:
> > Currently if an uncorrectable error is reported by an EP the AER
> > driver walks over all the devices connected to the upstream port
> > bus and in turns call the report_error_detected() callback.
> > If any of the devices connected to the bus does not implement
> > dev->driver->err_handler->error_detected() do_recovery() will fail
> > leaving all the bus hierarchy devices unrecovered.
> > 
> > However for non fatal errors the PCIe link should not be considered
> > compromised, therefore it makes sense to report the error only to
> > all the functions that logged an error.
> 
> Can you include a pointer to the relevant part of the spec here?

Also, I forgot to ask: can you outline the problem this fixes?  I'm
curious about why this hasn't been an issue in the past.  My guess is
there's something new about your configuration, and the config and the
symptoms might help connect this fix to similar problems.

> > This patch implements this new behaviour for non fatal errors.
> > 
> > Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
> > Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>
> > ---
> > Changes from v1:
> >    - now errors are reported only to the fucntions that logged the error
> >      instead of all the functions in the same device.
> >    - the patch subject has changed to match the new implementation
> > ---
> >  drivers/pci/pcie/aer/aerdrv_core.c | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/pcie/aer/aerdrv_core.c b/drivers/pci/pcie/aer/aerdrv_core.c
> > index b1303b3..057465ad 100644
> > --- a/drivers/pci/pcie/aer/aerdrv_core.c
> > +++ b/drivers/pci/pcie/aer/aerdrv_core.c
> > @@ -390,7 +390,14 @@ static pci_ers_result_t broadcast_error_message(struct pci_dev *dev,
> >  		 * If the error is reported by an end point, we think this
> >  		 * error is related to the upstream link of the end point.
> >  		 */
> > -		pci_walk_bus(dev->bus, cb, &result_data);
> > +		if (state == pci_channel_io_normal)
> > +			/*
> > +			 * the error is non fatal so the bus is ok, just invoke
> > +			 * the callback for the function that logged the error.
> > +			 */
> > +			cb(dev, &result_data);
> > +		else
> > +			pci_walk_bus(dev->bus, cb, &result_data);
> 
> I think the concept of this change makes sense, but I don't like the
> implicit connection of PCI_ERR_ROOT_UNCOR_RCV -> AER_NONFATAL ->
> pci_channel_io_normal.  That makes it harder than it should be to read
> the code.
> 
> What would you think of changing the signature of do_recovery() and
> broadcast_error_message() so they take the struct aer_err_info pointer
> instead of just the severity and pci_channel_state?  Then we could
> check directly for AER_NONFATAL here.
> 
> Bjorn
