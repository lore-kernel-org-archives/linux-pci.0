Return-Path: <SRS0=eWO7=AC=huawei.com=gabriele.paoloni@kernel.org>
Return-Path: <SRS0=eWO7=AC=huawei.com=gabriele.paoloni@kernel.org>
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Linuxarm <linuxarm@huawei.com>,
        "liudongdong (C)"
	<liudongdong3@huawei.com>,
        "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] PCIe AER: report uncorrectable errors only to the
 functions that logged the errors
Date: Fri, 1 Sep 2017 11:39:35 +0000
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E40BEC81F@FRAEML521-MBX.china.huawei.com>
References: <1503054141-80272-1-git-send-email-gabriele.paoloni@huawei.com>
 <20170831200344.GF18250@bhelgaas-glaptop.roam.corp.google.com>
 <20170901044326.GG18250@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20170901044326.GG18250@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn

Many thanks for looking at this

> -----Original Message-----
> From: Bjorn Helgaas [mailto:helgaas@kernel.org]
> Sent: 01 September 2017 05:43
> To: Gabriele Paoloni
> Cc: Linuxarm; liudongdong (C); linux-pci@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH v2] PCIe AER: report uncorrectable errors only to
> the functions that logged the errors
>=20
> On Thu, Aug 31, 2017 at 03:03:44PM -0500, Bjorn Helgaas wrote:
> > On Fri, Aug 18, 2017 at 12:02:21PM +0100, Gabriele Paoloni wrote:
> > > Currently if an uncorrectable error is reported by an EP the AER
> > > driver walks over all the devices connected to the upstream port
> > > bus and in turns call the report_error_detected() callback.
> > > If any of the devices connected to the bus does not implement
> > > dev->driver->err_handler->error_detected() do_recovery() will fail
> > > leaving all the bus hierarchy devices unrecovered.
> > >
> > > However for non fatal errors the PCIe link should not be considered
> > > compromised, therefore it makes sense to report the error only to
> > > all the functions that logged an error.
> >
> > Can you include a pointer to the relevant part of the spec here?

Sure
According to section "6.2.2.2.2. Non-Fatal Errors"=20
<< Non-fatal errors are uncorrectable errors which cause a particular
transaction to be unreliable but the Link is otherwise fully functional.
Isolating Non-fatal from Fatal errors provides Requester/Receiver logic
in a device or system management software the opportunity to recover
from the error without resetting the components on the Link and
disturbing other transactions in progress. Devices not associated with
the transaction in error are not impacted by the error.>>

I will add it to the commit msg:

>=20
> Also, I forgot to ask: can you outline the problem this fixes?  I'm
> curious about why this hasn't been an issue in the past.  My guess is
> there's something new about your configuration, and the config and the
> symptoms might help connect this fix to similar problems.

I already replied about this in the previous patch...
<< In Hi1620 we have some integrated controllers that appear as PCIe EPs
under the same bus. Some of these controllers (e.g. the SATA=20
controller) are missing the err_handler callbacks.

If one device reports a non-fatal uncorrectable error with the current
AER core code the callbacks for all the devices under the same bus will
be called and, if any of the devices is missing the callback all the
devices in the subtree are left in error state without recovery...=20
This patch is needed to sort out a situation like this one.>>

Should I add this to the commit msg?

>=20
> > > This patch implements this new behaviour for non fatal errors.
> > >
> > > Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
> > > Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>
> > > ---
> > > Changes from v1:
> > >    - now errors are reported only to the fucntions that logged the
> error
> > >      instead of all the functions in the same device.
> > >    - the patch subject has changed to match the new implementation
> > > ---
> > >  drivers/pci/pcie/aer/aerdrv_core.c | 9 ++++++++-
> > >  1 file changed, 8 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/pci/pcie/aer/aerdrv_core.c
> b/drivers/pci/pcie/aer/aerdrv_core.c
> > > index b1303b3..057465ad 100644
> > > --- a/drivers/pci/pcie/aer/aerdrv_core.c
> > > +++ b/drivers/pci/pcie/aer/aerdrv_core.c
> > > @@ -390,7 +390,14 @@ static pci_ers_result_t
> broadcast_error_message(struct pci_dev *dev,
> > >  		 * If the error is reported by an end point, we think this
> > >  		 * error is related to the upstream link of the end point.
> > >  		 */
> > > -		pci_walk_bus(dev->bus, cb, &result_data);
> > > +		if (state =3D=3D pci_channel_io_normal)
> > > +			/*
> > > +			 * the error is non fatal so the bus is ok, just
> invoke
> > > +			 * the callback for the function that logged the
> error.
> > > +			 */
> > > +			cb(dev, &result_data);
> > > +		else
> > > +			pci_walk_bus(dev->bus, cb, &result_data);
> >
> > I think the concept of this change makes sense, but I don't like the
> > implicit connection of PCI_ERR_ROOT_UNCOR_RCV -> AER_NONFATAL ->
> > pci_channel_io_normal.  That makes it harder than it should be to
> read
> > the code.
> >
> > What would you think of changing the signature of do_recovery() and
> > broadcast_error_message() so they take the struct aer_err_info
> pointer
> > instead of just the severity and pci_channel_state?  Then we could
> > check directly for AER_NONFATAL here.

I think the main issue of this approach is=20
aer_recover_work_func()->do_recovery()
If we modify the signature of do_recovery() we also need to modify
struct aer_recover_entry to embed aer_err_info sub struct (and anyway
so far there is no hook to aer_err_info in ghes.c...so it seems to
me like unfeasible...)

I think we can either add a severity field to broadcast_error_message()
or move=20

	enum pci_channel_state state;

	if (severity =3D=3D AER_FATAL)
		state =3D pci_channel_io_frozen;
	else
		state =3D pci_channel_io_normal;

inside broadcast_error_message()

In both cases we make the code more readable but we add redundancy...
Thoughts?

Thanks again
Gab

> >
> > Bjorn
