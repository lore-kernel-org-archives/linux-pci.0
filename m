Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Tue, 31 Jan 2017 06:57:20 -0800
From: Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH] PCI: ACPI: Fix ThunderX PEM initialization
Message-ID: <20170131145720.GA14231@localhost.localdomain>
References: <1485793552-12614-1-git-send-email-Vadim.Lomovtsev@caviumnetworks.com>
 <20170130211236.GW20550@bhelgaas-glaptop.roam.corp.google.com>
 <20170131102830.GA13854@localhost.localdomain>
 <20170131142525.GA9942@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
In-Reply-To: <20170131142525.GA9942@bhelgaas-glaptop.roam.corp.google.com>
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

On Tue, Jan 31, 2017 at 08:25:25AM -0600, Bjorn Helgaas wrote:
> On Tue, Jan 31, 2017 at 02:28:30AM -0800, Vadim Lomovtsev wrote:
> > Hi Bjorn,
> > 
> > On Mon, Jan 30, 2017 at 03:12:37PM -0600, Bjorn Helgaas wrote:
> > > Hi Vadim,
> > > 
> > > On Mon, Jan 30, 2017 at 08:25:52AM -0800, Vadim Lomovtsev wrote:
> > > > This patch is to address PEM initialization issue
> > > > which causes network issues.
> > > > 
> > > > It is necessary to search for _HID:PNP0A08 while requesting
> > > > PEM resources via ACPI instead of "THRX0002".
> > > > 
> > > > Signed-off-by: Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>
> > > > ---
> > > >  drivers/pci/host/pci-thunder-pem.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/pci/host/pci-thunder-pem.c b/drivers/pci/host/pci-thunder-pem.c
> > > > index af722eb..aec30b8 100644
> > > > --- a/drivers/pci/host/pci-thunder-pem.c
> > > > +++ b/drivers/pci/host/pci-thunder-pem.c
> > > > @@ -331,7 +331,7 @@ static int thunder_pem_acpi_init(struct pci_config_window *cfg)
> > > >  	if (!res_pem)
> > > >  		return -ENOMEM;
> > > >  
> > > > -	ret = acpi_get_rc_resources(dev, "THRX0002", root->segment, res_pem);
> > > > +	ret = acpi_get_rc_resources(dev, "PNP0A08", root->segment, res_pem);
> > > 
> > > This doesn't smell right: PNP0A08 is the generic ACPI ID.  There's no
> > > guarantee that if we find a PNP0A08 device, it is a ThunderX device.
> > > 
> > > I think the only way to call thunder_pem_acpi_init() is via an MCFG
> > > quirk that mentions thunder_pem_ecam_ops, which means we only call it
> > > if we find an MCFG with "CAVIUM" "THUNDERX" OEM and table IDs, so it's
> > > probably safe in that sense.
> > 
> > Agree, it is not the best solution.
> > We will implement such approach and send for review. 
> > 
> > > 
> > > But it's an abuse of the ACPI _HID model.  If you match a device using
> > > PNP0A08, all you can assume about it is that it uses the generic
> > > PNP0A08 programming model, and I don't think that includes "the first
> > > memory resource in _CRS contains ECAM space and MSI-X tables."
> > > 
> > > I expect this is a teething issue because you have firmware in the
> > > field that uses PNP0A08 and it's not feasible to update it.  If that's
> > > the case, the changelog should have details about it and we should
> > > have a comment in the code, because I don't think this is the model we
> > > want to end up with in future releases.
> > 
> > It could become so. However, for now I didn't get any reports on that,
> > (may be I miss something) except some internal emailings.
> > At my testing HW I was able to see some issues related to acpi-PEM stuff.
> > 
> > Thanks for feed-back, we will prepare another patch or patchset
> > implementing approach you've highlighted.
> 
> The approach I would like best is to search for THRX0002, because then
> you know you have a ThunderX PEM device, and you can assume
> device-specific details about its _CRS.
>
> But that's what the existing code does, and apparently that doesn't
> work.  My guess is that you have firmware in the field where the host
> bridge has only PNP0A08 (and maybe PNP0A03) as device IDs.

Because there is no such ACPI ID as "THRX0002" registered
(http://www.uefi.org/acpi_id_list).

>From the other hand we may gather device resources through
_CRS (we have acpi_device already set by this moment) but
we need to be sure that we're running at Cavium ThunderX board then.

To do that we may add _SUB value (accrodingly to spec) with
exact ID string (a full PCI ID value "177DA22D" is suggested).
This will eventually become the main method of finding out
whether we run on a ThunderX PEM.

However the current FW have no such string and we
need to handle this case also.

> Per spec, the OS can only assume the generic PCI host bridge
> programming model in that case.  It can't use any device-specific
> features, like the register space you're extracting here, since
> there's no way to tell what specific device you have.
> 
> If the OS needs to use device-specific features, there must be a
> device-specific _HID, i.e., THRX0002.  This is the important thing to
> get right in the future.
> 
> If existing firmware in the field has no device-specific _HID, we

I'm afraid not.

> might need something like this as a quirk to work around that firmware
> deficiency.  If that's the case, all I'm really asking for is:
> 
>   - Some indication that you have a plan to change the firmware
>     strategy so future releases don't require similar quirks, and

I believe we have some work at FW level to get this things done
accordingly, but we have HW in the field and this could become
critical.

>   - Some comments in the code pointing out that this is a workaround
>     for a firmware deficiency.
> 
> As I mentioned, I think this change should be safe because we only run
> this code if we find a CAVIUM THUNDERX MCFG table, and we search for a
> PNP0A08 device that matches the segment from MCFG.

However, the patch is not in good shape (was done in rush to be honest)
so I prepare another one shortly, addressing your comments.

> The only way we could accidentally match the wrong device would be if
> we had another bridge in the same segment.  Maybe we should have made
> acpi_get_rc_resources() match on the bus range as well as the segment.
> But that feels like just a "pedantically correct" sort of thing and
> probably over-engineering for this situation; I don't think it would
> solve any current problem.
> 
> I know you'd like to see this in v4.10, so we need to sort this out
> ASAP.
> 
> Bjorn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
