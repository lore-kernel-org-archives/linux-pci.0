Return-Path: <SRS0=17X2=A4=huawei.com=gabriele.paoloni@kernel.org>
Return-Path: <SRS0=17X2=A4=huawei.com=gabriele.paoloni@kernel.org>
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
Date: Wed, 27 Sep 2017 16:02:06 +0000
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E40C4606E@FRAEML521-MBX.china.huawei.com>
References: <1503054141-80272-1-git-send-email-gabriele.paoloni@huawei.com>
 <20170831200344.GF18250@bhelgaas-glaptop.roam.corp.google.com>
 <20170901044326.GG18250@bhelgaas-glaptop.roam.corp.google.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E40BEC81F@FRAEML521-MBX.china.huawei.com>
 <20170902173309.GH18250@bhelgaas-glaptop.roam.corp.google.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E40BFC5BD@FRAEML521-MBX.china.huawei.com>
 <20170925183405.GE15970@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20170925183405.GE15970@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn

> -----Original Message-----
> From: Bjorn Helgaas [mailto:helgaas@kernel.org]
> Sent: 25 September 2017 19:34
> To: Gabriele Paoloni
> Cc: Linuxarm; liudongdong (C); linux-pci@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH v2] PCIe AER: report uncorrectable errors only to
> the functions that logged the errors
>=20
> On Wed, Sep 06, 2017 at 10:56:42AM +0000, Gabriele Paoloni wrote:
> > Hi Bjorn
> >
> > > -----Original Message-----
> > > From: Bjorn Helgaas [mailto:helgaas@kernel.org]
> > > Sent: 02 September 2017 18:33
> > > To: Gabriele Paoloni
> > > Cc: Linuxarm; liudongdong (C); linux-pci@vger.kernel.org; linux-
> > > kernel@vger.kernel.org
> > > Subject: Re: [PATCH v2] PCIe AER: report uncorrectable errors only
> to
> > > the functions that logged the errors
> > >
> > > On Fri, Sep 01, 2017 at 11:39:35AM +0000, Gabriele Paoloni wrote:
> > > > Hi Bjorn
> > > >
> > > > Many thanks for looking at this
> > > >
> > > > > -----Original Message-----
> > > > > From: Bjorn Helgaas [mailto:helgaas@kernel.org]
> > > > > Sent: 01 September 2017 05:43
> > > > > To: Gabriele Paoloni
> > > > > Cc: Linuxarm; liudongdong (C); linux-pci@vger.kernel.org;
> linux-
> > > > > kernel@vger.kernel.org
> > > > > Subject: Re: [PATCH v2] PCIe AER: report uncorrectable errors
> only
> > > to
> > > > > the functions that logged the errors
> > > > >
> > > > > On Thu, Aug 31, 2017 at 03:03:44PM -0500, Bjorn Helgaas wrote:
> > > > > > On Fri, Aug 18, 2017 at 12:02:21PM +0100, Gabriele Paoloni
> wrote:
> > > > > > > Currently if an uncorrectable error is reported by an EP
> the
> > > AER
> > > > > > > driver walks over all the devices connected to the upstream
> > > port
> > > > > > > bus and in turns call the report_error_detected() callback.
> > > > > > > If any of the devices connected to the bus does not
> implement
> > > > > > > dev->driver->err_handler->error_detected() do_recovery()
> will
> > > fail
> > > > > > > leaving all the bus hierarchy devices unrecovered.
> > > > > > >
> > > > > > > However for non fatal errors the PCIe link should not be
> > > considered
> > > > > > > compromised, therefore it makes sense to report the error
> only
> > > to
> > > > > > > all the functions that logged an error.
> > > > > >
> > > > > > Can you include a pointer to the relevant part of the spec
> here?
> > > >
> > > > Sure
> > > > According to section "6.2.2.2.2. Non-Fatal Errors"
> > > > << Non-fatal errors are uncorrectable errors which cause a
> particular
> > > > transaction to be unreliable but the Link is otherwise fully
> > > functional.
> > > > Isolating Non-fatal from Fatal errors provides Requester/Receiver
> > > logic
> > > > in a device or system management software the opportunity to
> recover
> > > > from the error without resetting the components on the Link and
> > > > disturbing other transactions in progress. Devices not associated
> > > with
> > > > the transaction in error are not impacted by the error.>>
> > > >
> > > > I will add it to the commit msg:
> > > >
> > > > >
> > > > > Also, I forgot to ask: can you outline the problem this fixes?
> I'm
> > > > > curious about why this hasn't been an issue in the past.  My
> guess
> > > is
> > > > > there's something new about your configuration, and the config
> and
> > > the
> > > > > symptoms might help connect this fix to similar problems.
> > > >
> > > > I already replied about this in the previous patch...
> > > > << In Hi1620 we have some integrated controllers that appear as
> PCIe
> > > EPs
> > > > under the same bus. Some of these controllers (e.g. the SATA
> > > > controller) are missing the err_handler callbacks.
> > > >
> > > > If one device reports a non-fatal uncorrectable error with the
> > > current
> > > > AER core code the callbacks for all the devices under the same
> bus
> > > will
> > > > be called and, if any of the devices is missing the callback all
> the
> > > > devices in the subtree are left in error state without
> recovery...
> > > > This patch is needed to sort out a situation like this one.>>
> > > >
> > > > Should I add this to the commit msg?
> > >
> > > Thanks for the reminder.  I thought I remembered some details but
> > > hadn't dug them out again.  Yes, I was hoping for something we
> could
> > > include in the commit message.  I'm still not sure what
> specifically
> > > is *new* about this situation.  Maybe the particular mix of
> functions
> > > in a multi-function device?  Maybe the fact that you're seeing more
> > > AER errors than before (or maybe just doing more testing?)
> >
> > Hi Bjorn as I said here we have some integrated controllers that
> appear
> > as PCIe EPs under the same bus. Usually PCIe is p2p (no more that 1
> > device per bus), but in our SoC we have different devices under the
> same
> > bus (not MF devices):
> >
> > RC---bus0---|-SAS ctrl
> >             |
> >             |-SATA ctrl
> >             |
> >             |-XGE ctrl
> >
> > Since this is unusual this is maybe the reason why this has not been
> > seen yet elsewhere...
> >
> > >
> > > Since this is actually a bug fix, this might be a good opportunity
> to
> > > open a bugzilla for it.  Then we have a place to attach the
> complete
> > > "lspci -vv" output, dmesg, etc., that are of interest but too much
> for
> > > the commit message.
> >
> > Sure we can do this and add the bugzilla link in the commit msg
> >
> > >
> > > > > > > This patch implements this new behaviour for non fatal
> errors.
> > > > > > >
> > > > > > > Signed-off-by: Gabriele Paoloni
> <gabriele.paoloni@huawei.com>
> > > > > > > Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>
> > > > > > > ---
> > > > > > > Changes from v1:
> > > > > > >    - now errors are reported only to the fucntions that
> logged
> > > the
> > > > > error
> > > > > > >      instead of all the functions in the same device.
> > > > > > >    - the patch subject has changed to match the new
> > > implementation
> > > > > > > ---
> > > > > > >  drivers/pci/pcie/aer/aerdrv_core.c | 9 ++++++++-
> > > > > > >  1 file changed, 8 insertions(+), 1 deletion(-)
> > > > > > >
> > > > > > > diff --git a/drivers/pci/pcie/aer/aerdrv_core.c
> > > > > b/drivers/pci/pcie/aer/aerdrv_core.c
> > > > > > > index b1303b3..057465ad 100644
> > > > > > > --- a/drivers/pci/pcie/aer/aerdrv_core.c
> > > > > > > +++ b/drivers/pci/pcie/aer/aerdrv_core.c
> > > > > > > @@ -390,7 +390,14 @@ static pci_ers_result_t
> > > > > broadcast_error_message(struct pci_dev *dev,
> > > > > > >  		 * If the error is reported by an end point, we
> think
> > > this
> > > > > > >  		 * error is related to the upstream link of the
> end
> > > point.
> > > > > > >  		 */
> > > > > > > -		pci_walk_bus(dev->bus, cb, &result_data);
> > > > > > > +		if (state =3D=3D pci_channel_io_normal)
> > > > > > > +			/*
> > > > > > > +			 * the error is non fatal so the bus is
> ok,
> > > just
> > > > > invoke
> > > > > > > +			 * the callback for the function that
> logged
> > > the
> > > > > error.
> > > > > > > +			 */
> > > > > > > +			cb(dev, &result_data);
> > > > > > > +		else
> > > > > > > +			pci_walk_bus(dev->bus, cb, &result_data);
> > > > > >
> > > > > > I think the concept of this change makes sense, but I don't
> like
> > > the
> > > > > > implicit connection of PCI_ERR_ROOT_UNCOR_RCV -> AER_NONFATAL
> ->
> > > > > > pci_channel_io_normal.  That makes it harder than it should
> be to
> > > > > read
> > > > > > the code.
> > > > > >
> > > > > > What would you think of changing the signature of
> do_recovery()
> > > and
> > > > > > broadcast_error_message() so they take the struct
> aer_err_info
> > > > > pointer
> > > > > > instead of just the severity and pci_channel_state?  Then we
> > > could
> > > > > > check directly for AER_NONFATAL here.
> > > >
> > > > I think the main issue of this approach is
> > > > aer_recover_work_func()->do_recovery()
> > > > If we modify the signature of do_recovery() we also need to
> modify
> > > > struct aer_recover_entry to embed aer_err_info sub struct (and
> anyway
> > > > so far there is no hook to aer_err_info in ghes.c...so it seems
> to
> > > > me like unfeasible...)
> > > >
> > > > I think we can either add a severity field to
> > > broadcast_error_message()
> > > > or move
> > > >
> > > > 	enum pci_channel_state state;
> > > >
> > > > 	if (severity =3D=3D AER_FATAL)
> > > > 		state =3D pci_channel_io_frozen;
> > > > 	else
> > > > 		state =3D pci_channel_io_normal;
> > > >
> > > > inside broadcast_error_message()
> > > >
> > > > In both cases we make the code more readable but we add
> redundancy...
> > > > Thoughts?
> > >
> > > Hmmm, it's not as simple to solve as I hoped.
> > >
> > > The "native" Linux AER driver reads registers directly from the AER
> > > capability, produces logs, and does some recovery.
> > >
> > > From 100 miles away, APEI is basically a way for the platform
> (i.e.,
> > > firmware or manageability software) to insert itself in the middle:
> > > *it* reads the AER registers, does whatever it wants to do (e.g.,
> > > OS-independent logging), and then passes a copy of the AER
> capability
> > > (and the PCIe capability for good measure) on to the OS via APEI.
> > >
> > > The Linux APEI code then stuffs that AER info into the native Linux
> > > AER path where we do our own recovery.
> > >
> > > So we basically have two entry points to the Linux AER code: (1)
> the
> > > get_device_error_info() path that reads the AER registers directly,
> > > and (2) the APEI path that gets the AER register info from the
> > > firmware.
> > >
> > > In my mind, these paths ought to be far more unified than they are.
> > > The transition from APEI to the native Linux AER code throws away
> > > almost all the information we got from the platform:
> > > aer_recover_work_func() in the APEI path gets a copy of the AER
> > > capability, but all it passes to do_recovery() in the native AER
> code
> > > is "severity" -- a single int.
> > >
> > > I think we should revamp the native AER code so it collects the AER
> > > register info a little higher up, maybe in aer_isr_one_error()
> (it's
> > > kind of stupid that aer_process_err_devices() currently reads the
> AER
> > > registers *twice*).
> > >
> > > Then we could make the APEI code copy the information we care about
> > > from the CPER into a struct aer_err_info, then stuff it into
> > > aer_process_err_devices().  That would have the nice side-effect of
> > > using exactly the same logging code for both paths (currently the
> APEI
> > > path uses cper_print_aer(), while the native path uses
> > > aer_print_error()).
> > >
> > > This is a lot of work.
> >
> > I agree (on what to do and, unfortunately, on a lot of work :) ).
> > However given that this patch fixes a bug I would ask if we can first
> > accept this patch first and then proceed with the rework...what do
> > you think?
>=20
> Yes, I think we can do that.  Can you repost this with a revised
> changelog that references the bugzilla?

Sure I have just opened https://bugzilla.kernel.org/show_bug.cgi?id=3D19705=
5

I will respin tomorrow

Thanks
Gab

>=20
> Bjorn
