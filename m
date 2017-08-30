Return-Path: <SRS0=linV=AA=broadcom.com=oza.oza@kernel.org>
Return-Path: <SRS0=linV=AA=broadcom.com=oza.oza@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170829200209.GN8154@bhelgaas-glaptop.roam.corp.google.com>
References: <1503551066-23212-1-git-send-email-oza.oza@broadcom.com>
 <1503551066-23212-3-git-send-email-oza.oza@broadcom.com> <20170828214753.GL8154@bhelgaas-glaptop.roam.corp.google.com>
 <CAMSpPPcFFULWZ+QTfzMSGhzQx0JboT618Uq6EA0=qPGpAK+h1w@mail.gmail.com> <20170829200209.GN8154@bhelgaas-glaptop.roam.corp.google.com>
From: Oza Oza <oza.oza@broadcom.com>
Date: Wed, 30 Aug 2017 14:48:33 +0530
Message-ID: <CAMSpPPd6_tPe1TtCfM0sbEJdhD9_i_s58KcxoYQkmVUbkROdwA@mail.gmail.com>
Subject: Re: [PATCH v8 2/3] PCI: iproc: retry request when CRS returned from EP
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>, Jon Mason <jonmason@broadcom.com>,
	BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
	Andy Gospodarek <gospo@broadcom.com>, linux-pci <linux-pci@vger.kernel.org>,
	devicetree@vger.kernel.org, Linux ARM <linux-arm-kernel@lists.infradead.org>,
	linux-kernel@vger.kernel.org, Oza Pawandeep <oza.pawandeep@gmail.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 30, 2017 at 1:32 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Tue, Aug 29, 2017 at 11:02:23AM +0530, Oza Oza wrote:
>> On Tue, Aug 29, 2017 at 3:17 AM, Bjorn Helgaas <helgaas@kernel.org> wrot=
e:
>> > On Thu, Aug 24, 2017 at 10:34:25AM +0530, Oza Pawandeep wrote:
>> >> PCIe spec r3.1, sec 2.3.2
>> >> If CRS software visibility is not enabled, the RC must reissue the
>> >> config request as a new request.
>> >>
>> >> - If CRS software visibility is enabled,
>> >> - for a config read of Vendor ID, the RC must return 0x0001 data
>> >> - for all other config reads/writes, the RC must reissue the
>> >>   request
>> >>
>> >> iproc PCIe Controller spec:
>> >> 4.7.3.3. Retry Status On Configuration Cycle
>> >> Endpoints are allowed to generate retry status on configuration
>> >> cycles. In this case, the RC needs to re-issue the request. The IP
>> >> does not handle this because the number of configuration cycles neede=
d
>> >> will probably be less than the total number of non-posted operations
>> >> needed.
>> >>
>> >> When a retry status is received on the User RX interface for a
>> >> configuration request that was sent on the User TX interface,
>> >> it will be indicated with a completion with the CMPL_STATUS field set
>> >> to 2=3DCRS, and the user will have to find the address and data value=
s
>> >> and send a new transaction on the User TX interface.
>> >> When the internal configuration space returns a retry status during a
>> >> configuration cycle (user_cscfg =3D 1) on the Command/Status interfac=
e,
>> >> the pcie_cscrs will assert with the pcie_csack signal to indicate the
>> >> CRS status.
>> >> When the CRS Software Visibility Enable register in the Root Control
>> >> register is enabled, the IP will return the data value to 0x0001 for
>> >> the Vendor ID value and 0xffff  (all 1=E2=80=99s) for the rest of the=
 data in
>> >> the request for reads of offset 0 that return with CRS status.  This
>> >> is true for both the User RX Interface and for the Command/Status
>> >> interface.  When CRS Software Visibility is enabled, the CMPL_STATUS
>> >> field of the completion on the User RX Interface will not be 2=3DCRS =
and
>> >> the pcie_cscrs signal will not assert on the Command/Status interface=
.
>> >>
>> >> Per PCIe r3.1, sec 2.3.2, config requests that receive completions
>> >> with Configuration Request Retry Status (CRS) should be reissued by
>> >> the hardware except reads of the Vendor ID when CRS Software
>> >> Visibility is enabled.
>> >>
>> >> This hardware never reissues configuration requests when it receives
>> >> CRS completions.
>> >> Note that, neither PCIe host bridge nor PCIe core re-issues the
>> >> request for any configuration offset.
>> >>
>> >> For config reads, this hardware returns CFG_RETRY_STATUS data when
>> >> it receives a CRS completion for a config read, regardless of the
>> >> address of the read or the CRS Software Visibility Enable bit.
>> >>
>> >> This patch implements iproc_pcie_config_read which gets called for
>> >> Stingray, if it receives a CRS completion, it retries reading it agai=
n.
>> >> In case of timeout, it returns 0xffffffff.
>> >> For other iproc based SOC, it falls back to PCI generic APIs.
>> >>
>> >> Signed-off-by: Oza Pawandeep <oza.oza@broadcom.com>
>> >>
>> >> diff --git a/drivers/pci/host/pcie-iproc.c b/drivers/pci/host/pcie-ip=
roc.c
>> >> index 61d9be6..37f4adf 100644
>> >> --- a/drivers/pci/host/pcie-iproc.c
>> >> +++ b/drivers/pci/host/pcie-iproc.c
>> >> @@ -68,6 +68,9 @@
>> >>  #define APB_ERR_EN_SHIFT             0
>> >>  #define APB_ERR_EN                   BIT(APB_ERR_EN_SHIFT)
>> >>
>> >> +#define CFG_RETRY_STATUS             0xffff0001
>> >> +#define CFG_RETRY_STATUS_TIMEOUT_US  500000 /* 500 milli-seconds. */
>> >> +
>> >>  /* derive the enum index of the outbound/inbound mapping registers *=
/
>> >>  #define MAP_REG(base_reg, index)      ((base_reg) + (index) * 2)
>> >>
>> >> @@ -473,6 +476,64 @@ static void __iomem *iproc_pcie_map_ep_cfg_reg(s=
truct iproc_pcie *pcie,
>> >>       return (pcie->base + offset);
>> >>  }
>> >>
>> >> +static unsigned int iproc_pcie_cfg_retry(void __iomem *cfg_data_p)
>> >> +{
>> >> +     int timeout =3D CFG_RETRY_STATUS_TIMEOUT_US;
>> >> +     unsigned int data;
>> >> +
>> >> +     /*
>> >> +      * As per PCIe spec r3.1, sec 2.3.2, CRS Software
>> >> +      * Visibility only affects config read of the Vendor ID.
>> >> +      * For config write or any other config read the Root must
>> >> +      * automatically re-issue configuration request again as a
>> >> +      * new request.
>> >> +      *
>> >> +      * For config reads, this hardware returns CFG_RETRY_STATUS dat=
a when
>> >> +      * it receives a CRS completion for a config read, regardless o=
f the
>> >> +      * address of the read or the CRS Software Visibility Enable bi=
t. As a
>> >> +      * partial workaround for this, we retry in software any read t=
hat
>> >> +      * returns CFG_RETRY_STATUS.
>> >> +      */
>> >> +     data =3D readl(cfg_data_p);
>> >> +     while (data =3D=3D CFG_RETRY_STATUS && timeout--) {
>> >> +             udelay(1);
>> >> +             data =3D readl(cfg_data_p);
>> >> +     }
>> >> +
>> >> +     if (data =3D=3D CFG_RETRY_STATUS)
>> >> +             data =3D 0xffffffff;
>> >> +
>> >> +     return data;
>> >> +}
>> >> +
>> >> +static int iproc_pcie_config_read(struct pci_bus *bus, unsigned int =
devfn,
>> >> +                                 int where, int size, u32 *val)
>> >> +{
>> >> +     struct iproc_pcie *pcie =3D iproc_data(bus);
>> >> +     unsigned int slot =3D PCI_SLOT(devfn);
>> >> +     unsigned int fn =3D PCI_FUNC(devfn);
>> >> +     unsigned int busno =3D bus->number;
>> >> +     void __iomem *cfg_data_p;
>> >> +     unsigned int data;
>> >> +
>> >> +     /* root complex access. */
>> >> +     if (busno =3D=3D 0)
>> >> +             return pci_generic_config_read32(bus, devfn, where, siz=
e, val);
>> >
>> > It sounds like Stingray advertises CRS SV support in its Root Capabili=
ties
>> > register.  I think we should mask out PCI_EXP_RTCAP_CRSVIS so we don't
>> > advertise it.  That will keep Linux from trying to enable it.  I know =
the
>> > hardware doesn't look at PCI_EXP_RTCTL_CRSSVE, but there's no point in
>> > confusing users reading the lspci output.
>> >
>> > We did something similar with f09f8735fb9c ("PCI: xgene: Disable
>> > Configuration Request Retry Status for v1 silicon").
>> >
>> > I tried to do this in the patch I pushed to pci/host-iproc.
>> >
>> >> +
>> >> +     cfg_data_p =3D iproc_pcie_map_ep_cfg_reg(pcie, busno, slot, fn,=
 where);
>> >> +
>> >> +     if (!cfg_data_p)
>> >> +             return PCIBIOS_DEVICE_NOT_FOUND;
>> >> +
>> >> +     data =3D iproc_pcie_cfg_retry(cfg_data_p);
>> >> +
>> >> +     *val =3D data;
>> >> +     if (size <=3D 2)
>> >> +             *val =3D (data >> (8 * (where & 3))) & ((1 << (size * 8=
)) - 1);
>> >> +
>> >> +     return PCIBIOS_SUCCESSFUL;
>> >> +}
>> >> +
>> >>  /**
>> >>   * Note access to the configuration registers are protected at the h=
igher layer
>> >>   * by 'pci_lock' in drivers/pci/access.c
>> >> @@ -567,8 +628,13 @@ static int iproc_pcie_config_read32(struct pci_b=
us *bus, unsigned int devfn,
>> >>                                   int where, int size, u32 *val)
>> >>  {
>> >>       int ret;
>> >> +     struct iproc_pcie *pcie =3D iproc_data(bus);
>> >>
>> >>       iproc_pcie_apb_err_disable(bus, true);
>> >> +     if (pcie->type =3D=3D IPROC_PCIE_PAXB_V2)
>> >> +             ret =3D iproc_pcie_config_read(bus, devfn, where, size,=
 val);
>> >> +     else
>> >> +             ret =3D pci_generic_config_read32(bus, devfn, where, si=
ze, val);
>> >>       ret =3D pci_generic_config_read32(bus, devfn, where, size, val)=
;
>> >
>> > This last pci_generic_config_read32() call looks like a duplicate.
>>
>> yes indeed.
>> I have tested your CRS visibility bit changes; and it works fine.
>>
>> do you want me to post new patch-set by removing the duplicate call
>> along with the changes you have made ?
>>
>> or since, you have already applied patches, with your changes, you
>> will take care of removing this last duplicate call ?
>> I think this is the last change for this patch-set, If I did not miss an=
ything.
>>
>> please let me know.
>
> I already removed that duplicate call.  It should be in the next -next.
> Let me know if there's anything wrong with it.
>
> Bjorn

Its all well I think. I see no problem.
once they are in, I have to base my PCI hotplug patches on those.

Regards,
Oza.
