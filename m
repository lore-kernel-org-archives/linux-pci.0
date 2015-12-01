Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 1 Dec 2015 17:07:10 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: Christopher Covington <cov@codeaurora.org>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>,
	linux-pci@vger.kernel.org, timur@codeaurora.org, jcm@redhat.com,
	Bjorn Helgaas <bhelgaas@google.com>,
	Yijing Wang <wangyijing@huawei.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/AER: enable SERR# forwarding and role-based error
 reporting
Message-ID: <20151201230710.GA32381@localhost>
References: <1445894704-28277-1-git-send-email-okaya@codeaurora.org>
 <20151201185157.GE9306@localhost>
 <565DF34C.6030606@codeaurora.org>
 <565DFE50.5030708@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <565DFE50.5030708@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Dec 01, 2015 at 03:08:48PM -0500, Sinan Kaya wrote:
> On 12/1/2015 2:21 PM, Christopher Covington wrote:
> > On 12/01/2015 01:51 PM, Bjorn Helgaas wrote:
> >> [+cc Taku]
> > 
> > It looks to me like Bjorn intended to add Taku to the distribution list,
> > but accidentally left him off, so I'm adding him to the To field in this
> > reply.
> > 
> > Regards,
> > Christopher Covington
> > 
> >> Hi Sinan,
> >>
> >> On Mon, Oct 26, 2015 at 05:25:02PM -0400, Sinan Kaya wrote:
> >>> A PCIe card behind a PCIe switch is unable to report its errors
> >>> when SERR# forwarding is not enabled on the PCIe switch's
> >>> secondary interface. This is required by the PCIe  spec. 
> >>
> >> I think enabling SERR# forwarding is only "required by the spec" in
> >> the sense that bridges do not forward errors upstream unless the
> >> SERR# Enable bit is set, right?  So I would say this is just an
> >> ordinary enable bit in the bridge, not a special spec requirement.
> 
> Bottom line is that AER errors won't be forwarded if this bit is not set.

Right.  So it's required by the spec if you want error forwarding, in
the same way the spec requires the Hot-Plug Interrupt Enable bit to be
set if you want interrupts for hot-plug events.

> >> The Linux AER code doesn't poll for errors; it assumes errors will be
> >> propagated upstream to the Root Port, where they will cause an
> >> interrupt, so I agree that it doesn't really make sense to enable AER
> >> for a device unless we also enable SERR# forwarding in all the bridges
> >> leading to it.
> >>
> >> I assume this patch fixes a problem, e.g., errors reported by a device
> >> are not forwarded upstream, so AER never logs them, and with this
> >> patch, AER does log them?  
> 
> Correct. I'm not observing the AER errors without this patch. After this
> patch, I'm seeing the AER errors coming from the endpoints.

Thanks for confirming this.

> >> I suppose we didn't notice this before
> >> because some firmware enables SERR# forwarding for us, but yours
> >> doesn't?
> 
> Possible..., I could have done this in the UEFI BIOS but I'm also
> worried about hotplug case. That's why, I chose to submit a patch for
> the kernel.

Thanks for confirming that your firmware does not enable SERR#
forwarding.  That explains why this patch makes a difference for you.
There must be firmware that does enable SERR# forwarding; otherwise
AER would never have worked for anybody.

I think it makes sense for Linux to make sure SERR# forwarding is
enabled when enabling AER.  We shouldn't rely on firmware setting it
for us.

> For instance, what happens after hotplug insertion. Will anybody set
> these bits? We need some kernel support for some PCIe features to
> reconfigure the hardware.

ACPI systems that support hotplug may supply _HPP or _HPX methods.  If
_HPP or _HPX indicates that SERR# forwarding should be enabled, Linux
does enable it for hot-added devices (and I think we now do it for all
devices at boot, too).  That would explain how this could work on ACPI
systems today.

But obviously AER should work even if we don't have ACPI, so we need
something like this patch.

> >>> This patch
> >>> enables SERR# forwarding and also cleans out compatibility
> >>> mode so that AER reporting is enabled.
> >>>
> >>> Tested with PEX8749-CA RDK.
> >>>
> >>> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> >>> ---
> >>>  drivers/pci/pcie/aer/aerdrv_core.c | 56 +++++++++++++++++++++++++++++++++++++-
> >>>  1 file changed, 55 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/pci/pcie/aer/aerdrv_core.c b/drivers/pci/pcie/aer/aerdrv_core.c
> >>> index 9803e3d..acd22d7 100644
> >>> --- a/drivers/pci/pcie/aer/aerdrv_core.c
> >>> +++ b/drivers/pci/pcie/aer/aerdrv_core.c
> >>> @@ -37,21 +37,75 @@ module_param(nosourceid, bool, 0);
> >>>  
> >>>  int pci_enable_pcie_error_reporting(struct pci_dev *dev)
> >>>  {
> >>> +	u8 header_type;
> >>> +	int pos;
> >>> +
> >>>  	if (pcie_aer_get_firmware_first(dev))
> >>>  		return -EIO;
> >>>  
> >>> -	if (!pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR))
> >>> +	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR);
> >>> +	if (!pos)
> >>>  		return -EIO;
> >>>  
> >>> +	pci_read_config_byte(dev, PCI_HEADER_TYPE, &header_type);
> >>> +
> >>> +	/* needs to be a bridge/switch */
> >>> +	if (header_type == PCI_HEADER_TYPE_BRIDGE) {
> >>> +		u32 status;
> >>> +		u16 control;
> >>> +
> >>> +		/*
> >>> +		 * A switch will not forward ERR_ messages coming from an
> >>> +		 * endpoint if SERR# forwarding is not enabled.
> >>> +		 * AER driver is checking the errors at the root only.
> >>> +		 */
> >>> +		pci_read_config_word(dev, PCI_BRIDGE_CONTROL, &control);
> >>> +		control |= PCI_BRIDGE_CTL_SERR;
> >>> +		pci_write_config_word(dev, PCI_BRIDGE_CONTROL, control);
> >>
> >> Does this work for hot-added devices?  I don't see a path that calls
> >> pci_enable_pcie_error_reporting() for hot-added devices, so I don't
> >> know how the PCI_EXP_AER_FLAGS bits would get set for them.
> 
> Yes for me. We remove the root port along with the endpoint during
> hotplug. On the next insertion, AER driver get reprobed for the root port.

The case I'm wondering about is when we hot-add an endpoint (not a
root port).  In that case, I think the AER driver is not re-probed
because aerdriver.port_type == PCI_EXP_TYPE_ROOT_PORT, so
pcie_port_bus_match() will only match the AER driver with a Root Port.

On your system (which I assume doesn't have _HPP or _HPX), if you
hot-add a bridge (not a Root Port) or an endpoint, I don't know what
would enable SERR# forwarding for a bridge or AER reporting for an
endpoint.

> >> Let's do this in a separate patch.  The SERR# thing is related to
> >> propagating error messages upstream.  PCI_ERR_COR_ADV_NFAT is a bit
> >> different.
> >>
> >> I don't understand all the implications of Role-Based Error Reporting.
> >> Can you include a pointer to the Linux code that comprehends it?
> >> It looks like the section 6.2.7 implementation note is relevant, but I
> >> don't understand it yet.
> 
> My understanding of the spec is that you can't have AER enabled when
> PCI_ERR_COR_ADV_NFAT is 1.

Can you point out the reasoning here in a little more detail?  This
may well be true, but it wasn't that obvious to me.

Bjorn
