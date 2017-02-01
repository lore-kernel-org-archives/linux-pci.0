Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Wed, 1 Feb 2017 07:34:09 -0800
From: Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH] PCI: ACPI: Fix ThunderX PEM initialization
Message-ID: <20170201153409.GA16088@localhost.localdomain>
References: <1485793552-12614-1-git-send-email-Vadim.Lomovtsev@caviumnetworks.com>
 <20170130211236.GW20550@bhelgaas-glaptop.roam.corp.google.com>
 <20170131102830.GA13854@localhost.localdomain>
 <20170131142525.GA9942@bhelgaas-glaptop.roam.corp.google.com>
 <20170131145720.GA14231@localhost.localdomain>
 <20170131203109.GA14127@bhelgaas-glaptop.roam.corp.google.com>
 <20170201125325.GA15805@localhost.localdomain>
 <20170201151807.GA15793@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
In-Reply-To: <20170201151807.GA15793@bhelgaas-glaptop.roam.corp.google.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: David.Daney@cavium.com, tn@semihalf.com, Vadim.Lomovtsev@caviumnetworks.com,
 linux-kernel@vger.kernel.org, stemerkhanov@CAVIUMNETWORKS.onmicrosoft.com,
 linux-pci@vger.kernel.org, bhelgaas@google.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Feb 01, 2017 at 09:18:07AM -0600, Bjorn Helgaas wrote:
> On Wed, Feb 01, 2017 at 04:53:25AM -0800, Vadim Lomovtsev wrote:
> > On Tue, Jan 31, 2017 at 02:31:09PM -0600, Bjorn Helgaas wrote:
> > > On Tue, Jan 31, 2017 at 06:57:20AM -0800, Vadim Lomovtsev wrote:
> > > > On Tue, Jan 31, 2017 at 08:25:25AM -0600, Bjorn Helgaas wrote:
> > > > > On Tue, Jan 31, 2017 at 02:28:30AM -0800, Vadim Lomovtsev wrote:
> > > > > > Hi Bjorn,
> > > > > > 
> > > > > > On Mon, Jan 30, 2017 at 03:12:37PM -0600, Bjorn Helgaas wrote:
> > > > > > > Hi Vadim,
> > > > > > > 
> > > > > > > On Mon, Jan 30, 2017 at 08:25:52AM -0800, Vadim Lomovtsev wrote:
> > > > > > > > This patch is to address PEM initialization issue
> > > > > > > > which causes network issues.
> > > > > > > > 
> > > > > > > > It is necessary to search for _HID:PNP0A08 while requesting
> > > > > > > > PEM resources via ACPI instead of "THRX0002".
> > > > > > > > 
> > > > > > > > Signed-off-by: Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>
> > > > > > > > ---
> > > > > > > >  drivers/pci/host/pci-thunder-pem.c | 2 +-
> > > > > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > > > > 
> > > > > > > > diff --git a/drivers/pci/host/pci-thunder-pem.c b/drivers/pci/host/pci-thunder-pem.c
> > > > > > > > index af722eb..aec30b8 100644
> > > > > > > > --- a/drivers/pci/host/pci-thunder-pem.c
> > > > > > > > +++ b/drivers/pci/host/pci-thunder-pem.c
> > > > > > > > @@ -331,7 +331,7 @@ static int thunder_pem_acpi_init(struct pci_config_window *cfg)
> > > > > > > >  	if (!res_pem)
> > > > > > > >  		return -ENOMEM;
> > > > > > > >  
> > > > > > > > -	ret = acpi_get_rc_resources(dev, "THRX0002", root->segment, res_pem);
> > > > > > > > +	ret = acpi_get_rc_resources(dev, "PNP0A08", root->segment, res_pem);
> > > > > > > 
> > > > > > > This doesn't smell right: PNP0A08 is the generic ACPI ID.  There's no
> > > > > > > guarantee that if we find a PNP0A08 device, it is a ThunderX device.
> > > > > > > 
> > > > > > > I think the only way to call thunder_pem_acpi_init() is via an MCFG
> > > > > > > quirk that mentions thunder_pem_ecam_ops, which means we only call it
> > > > > > > if we find an MCFG with "CAVIUM" "THUNDERX" OEM and table IDs, so it's
> > > > > > > probably safe in that sense.
> > > > > > 
> > > > > > Agree, it is not the best solution.
> > > > > > We will implement such approach and send for review. 
> > > > > > 
> > > > > > > 
> > > > > > > But it's an abuse of the ACPI _HID model.  If you match a device using
> > > > > > > PNP0A08, all you can assume about it is that it uses the generic
> > > > > > > PNP0A08 programming model, and I don't think that includes "the first
> > > > > > > memory resource in _CRS contains ECAM space and MSI-X tables."
> > > > > > > 
> > > > > > > I expect this is a teething issue because you have firmware in the
> > > > > > > field that uses PNP0A08 and it's not feasible to update it.  If that's
> > > > > > > the case, the changelog should have details about it and we should
> > > > > > > have a comment in the code, because I don't think this is the model we
> > > > > > > want to end up with in future releases.
> > > > > > 
> > > > > > It could become so. However, for now I didn't get any reports on that,
> > > > > > (may be I miss something) except some internal emailings.
> > > > > > At my testing HW I was able to see some issues related to acpi-PEM stuff.
> > > > > > 
> > > > > > Thanks for feed-back, we will prepare another patch or patchset
> > > > > > implementing approach you've highlighted.
> > > > > 
> > > > > The approach I would like best is to search for THRX0002, because then
> > > > > you know you have a ThunderX PEM device, and you can assume
> > > > > device-specific details about its _CRS.
> > > > >
> > > > > But that's what the existing code does, and apparently that doesn't
> > > > > work.  My guess is that you have firmware in the field where the host
> > > > > bridge has only PNP0A08 (and maybe PNP0A03) as device IDs.
> > > > 
> > > > Because there is no such ACPI ID as "THRX0002" registered
> > > > (http://www.uefi.org/acpi_id_list).
> > > 
> > > To be pedantically correct, I think you want "THRX" registered.  Then
> > > you can manage the "0002" part internally without registering each
> > > individual device.
> > 
> > Not sure if it would be registered that way, because (AFAIK)
> > it expected to be string constructed from Vendor ID (not the Product ID) plus
> > four hex digit manged internaly. So we suggest to change it to 177DXXXX
> > which corresponds to Cavium PCI ID https://pci-ids.ucw.cz/pci.ids.
> > It's also possible to use the 3-digit PNP ID, "CAV", to construct these
> > _HID/_CID/_SUB values (http://www.uefi.org/pnp_id_list).
> 
> My point was that you only need to register the prefix ("CAV" or
> "THRX") of the PNP or ACPI ID.  Then you manage the suffixes
> internally.  You as long as you register "CAV" or "THRX", you can
> assign and use "THRX0002" yourself without registering that
> specifically.

Yes, exactly. And the "CAV" perfix is already registered.
And I think will'll use it to keep things aligned to specs & rules.

> 
> > So the FW will be updated accordingly.
> > 
> > For old FW we'll implement fallback scenario gathering resource info
> > via _CRS object (comments will be provided in the code also).
> > 
> > > 
> > > > From the other hand we may gather device resources through
> > > > _CRS (we have acpi_device already set by this moment) but
> > > > we need to be sure that we're running at Cavium ThunderX board then.
> > > > 
> > > > To do that we may add _SUB value (accrodingly to spec) with
> > > > exact ID string (a full PCI ID value "177DA22D" is suggested).
> > > > This will eventually become the main method of finding out
> > > > whether we run on a ThunderX PEM.
> > > 
> > > I don't understand why you would use _SUB.  I think the correct way to
> > > handle this is to use a _HID of "THRX0002" with a _CID of "PNP0A08".
> > > Is there some existing _SUB usage you're using as an example?
> > 
> > Here we were talking about extra quirk to match PEM and ECAM and thus make
> > a decision. This object could also store some vendor-specific IDs.
> > To be honest I didn't see usage in kernel (didn't search), but ACPI Spec
> > provide an example as (p 6.1.9) :
> >   Name (_SUB, "MSFT3000")// Vendor-defined subsystem
> > 
> > However this is still debatable and we probably stick to _HID while
> > implementing additional match functions.
> 
> If you want a driver to bind to a specific device, e.g., the ThunderX
> PCI host bridge, the firmware should use a unique _HID in the ACPI
> namespace and the driver should claim that _HID.
> 
> It's conceivable that you could use _SUB, but that's needlessly
> different from everything else.

See your point, thank you for quick and clear feed-back.

Just to let you know:
We are in the middle of developing solution for fall-back
scenario (when ACPI/PNP ID wasn't found) for PEM initalization.
Hope to be able to get it into 4.10.

> 
> Bjorn

Vadim

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
