Return-Path: <SRS0=nKW4=7G=broadcom.com=oza.oza@kernel.org>
Return-Path: <SRS0=nKW4=7G=broadcom.com=oza.oza@kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAMSpPPcbnVefeVVh3HJd1M+8co+4VMj8HU2zmXMv4K5VGcdjVg@mail.gmail.com>
References: <1499310582-21193-1-git-send-email-oza.oza@broadcom.com>
 <1499310582-21193-2-git-send-email-oza.oza@broadcom.com> <20170802210455.GF20308@bhelgaas-glaptop.roam.corp.google.com>
 <CAMSpPPcfUFmjg471qmzqQmayNYzfq8Wo7yfHeiEKrj7hkWF=zg@mail.gmail.com>
 <20170803185713.GV20308@bhelgaas-glaptop.roam.corp.google.com> <CAMSpPPcbnVefeVVh3HJd1M+8co+4VMj8HU2zmXMv4K5VGcdjVg@mail.gmail.com>
From: Oza Oza <oza.oza@broadcom.com>
Date: Fri, 4 Aug 2017 11:40:46 +0530
Message-ID: <CAMSpPPfOwnevUNui+zUe1bbq655kHQ=u3FyOiRTO5NAo0yWBTg@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] PCI: iproc: Retry request when CRS returned from EP
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>, Jon Mason <jonmason@broadcom.com>,
	BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
	Andy Gospodarek <gospo@broadcom.com>, linux-pci <linux-pci@vger.kernel.org>,
	linux-kernel@vger.kernel.org, Oza Pawandeep <oza.pawandeep@gmail.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On Fri, Aug 4, 2017 at 11:29 AM, Oza Oza <oza.oza@broadcom.com> wrote:
> On Fri, Aug 4, 2017 at 12:27 AM, Bjorn Helgaas <helgaas@kernel.org> wrote=
:
>> On Thu, Aug 03, 2017 at 01:50:29PM +0530, Oza Oza wrote:
>>> On Thu, Aug 3, 2017 at 2:34 AM, Bjorn Helgaas <helgaas@kernel.org> wrot=
e:
>>> > On Thu, Jul 06, 2017 at 08:39:41AM +0530, Oza Pawandeep wrote:
>>> >> For Configuration Requests only, following reset it is possible for =
a
>>> >> device to terminate the request but indicate that it is temporarily =
unable
>>> >> to process the Request, but will be able to process the Request in t=
he
>>> >> future =E2=80=93 in this case, the Configuration Request Retry Statu=
s 100 (CRS)
>>> >> Completion Status is used.
>>> >
>>> > Please include the spec reference for this.
>>> >
>>> > The "100" looks like it's supposed to be the Completion Status Field
>>> > value for CRS from PCIe r3.1, sec 2.2.9, Table 2-34, but the value in
>>> > the table is actually 0b010, not 0b100.  I don't think this level of
>>> > detail is necessary unless your hardware exposes those values to the
>>> > driver.
>>> >
>>>
>>> I will remove the above description from the comment.
>>>
>>> >> As per PCI spec, CRS Software Visibility only affects config read of=
 the
>>> >> Vendor ID, for config write or any other config read the Root must
>>> >> automatically re-issue configuration request again as a new request.
>>> >> Iproc based PCIe RC (hw) does not retry request on its own.
>>> >
>>> > I think sec 2.3.2 is the relevant part of the spec.  It basically
>>> > says that when an RC receives a CRS completion for a config request:
>>> >
>>> >   - If CRS software visibility is not enabled, the RC must reissue th=
e
>>> >     config request as a new request.
>>> >
>>> >   - If CRS software visibility is enabled,
>>> >     - for a config read of Vendor ID, the RC must return 0x0001 data
>>> >     - for all other config reads/writes, the RC must reissue the
>>> >       request
>>> >
>>>
>>> yes, above is more relevant, and I will include it in the description.
>>>
>>> > Apparently iProc *never* reissues config requests, regardless of
>>> > whether CRS software visibility is enabled?
>>> >
>>>
>>> that is true.
>>>
>>> > But your CFG_RETRY_STATUS definition suggests that iProc always
>>> > fabricates config read data of 0xffff0001 when it sees CRS status, no
>>> > matter whether software visibility is enabled and no matter what
>>> > config address we read?
>>>
>>> yes, that is precisely the case.
>>
>> Not according to the documentation you quoted below.
>>
>>> > What about CRS status for a config *write*?  There's nothing here to
>>> > reissue those.
>>>
>>> No, we do not need there, because read will always be issued first
>>> before any write.
>>> so we do not need to implement write.
>>
>> How so?  As far as I know, there's nothing in the spec that requires
>> the first config access to a device to be a read, and there are
>> reasons why we might want to do a write first:
>> http://lkml.kernel.org/r/5952D144.8060609@oracle.com
>>
>
> I understand your point here. my thinking was during enumeration
> process first read will always be issued
> such as vendor/device id.
> I will extend this implementation for write.

I am sorry, but I just released that, it is not possible to implement
retry for write.
the reason is:

we have indirect way of accessing configuration space access.
for e.g.
for config write:

A) write to to addr register.
B) write to data register

now above those 2 registers are implemented by host bridge (not in
PCIe core IP).
there is no way of knowing for software, if write has to be retried.

e.g. I can not read data register (step B) to check if write was successful=
.
I have double checked this with internal ASIC team here.

so in conclusion: I have to do following of things.

1) include Documentation in Changelog.
2) include sec 2.3.2 from PCIe spec in commit description.

please confirm, if you are fine with all the information.
so then I make above 2 changes. and re-post the patch.

Regards,
Oza.

>
>>> > Is there a hardware erratum that describes the actual hardware
>>> > behavior?
>>>
>>> this is documented in our PCIe core hw manual.
>>> >>
>>> 4.7.3.3. Retry Status On Configuration Cycle
>>> Endpoints are allowed to generate retry status on configuration
>>> cycles.  In this case, the RC needs to re-issue the request.  The IP
>>> does not handle this because the number of configuration cycles needed
>>> will probably be less
>>> than the total number of non-posted operations needed.   When a retry s=
tatus
>>> is received on the User RX interface for a configuration request that
>>> was sent on the User TX interface, it will be indicated with a
>>> completion with the CMPL_STATUS field set to 2=3DCRS, and the user will
>>> have to find the address and data values and send a new transaction on
>>> the User TX interface.
>>> When the internal configuration space returns a retry status during a
>>> configuration cycle (user_cscfg =3D 1) on the Command/Status interface,
>>> the pcie_cscrs will assert with the pcie_csack signal to indicate the
>>> CRS status.
>>> When the CRS Software Visibility Enable register in the Root Control
>>> register is enabled, the IP will return the data value to 0x0001 for
>>> the Vendor ID value and 0xffff  (all 1=E2=80=99s) for the rest of the d=
ata in
>>> the request for reads of offset 0 that return with CRS status.  This
>>> is true for both the User RX Interface and for the Command/Status
>>> interface.  When CRS Software Visibility is enabled, the CMPL_STATUS
>>> field of the completion on the User RX Interface will not be 2=3DCRS an=
d
>>> the pcie_cscrs signal will not assert on the Command/Status interface.
>>> >>
>>> Broadcom does not sell PCIe core IP, so above information is not
>>> publicly available in terms of hardware erratum or any similar note.
>>>
>>>
>>> >
>>> >> As a result of the fact, PCIe RC driver (sw) should take care of CRS=
.
>>> >> This patch fixes the problem, and attempts to read config space agai=
n in
>>> >> case of PCIe code forwarding the CRS back to CPU.
>>> >> It implements iproc_pcie_config_read which gets called for Stingray,
>>> >> Otherwise it falls back to PCI generic APIs.
>>> >>
>>> >> Signed-off-by: Oza Pawandeep <oza.oza@broadcom.com>
>>> >> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
>>> >> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
>>> >>
>>> >> diff --git a/drivers/pci/host/pcie-iproc.c b/drivers/pci/host/pcie-i=
proc.c
>>> >> index 0f39bd2..b0abcd7 100644
>>> >> --- a/drivers/pci/host/pcie-iproc.c
>>> >> +++ b/drivers/pci/host/pcie-iproc.c
>>> >> @@ -68,6 +68,9 @@
>>> >>  #define APB_ERR_EN_SHIFT             0
>>> >>  #define APB_ERR_EN                   BIT(APB_ERR_EN_SHIFT)
>>> >>
>>> >> +#define CFG_RETRY_STATUS             0xffff0001
>>> >> +#define CFG_RETRY_STATUS_TIMEOUT_US  500000 /* 500 milli-seconds. *=
/
>>> >> +
>>> >>  /* derive the enum index of the outbound/inbound mapping registers =
*/
>>> >>  #define MAP_REG(base_reg, index)      ((base_reg) + (index) * 2)
>>> >>
>>> >> @@ -448,6 +451,55 @@ static inline void iproc_pcie_apb_err_disable(s=
truct pci_bus *bus,
>>> >>       }
>>> >>  }
>>> >>
>>> >> +static int iproc_pcie_cfg_retry(void __iomem *cfg_data_p)
>>> >> +{
>>> >> +     int timeout =3D CFG_RETRY_STATUS_TIMEOUT_US;
>>> >> +     unsigned int ret;
>>> >> +
>>> >> +     /*
>>> >> +      * As per PCI spec, CRS Software Visibility only
>>> >> +      * affects config read of the Vendor ID.
>>> >> +      * For config write or any other config read the Root must
>>> >> +      * automatically re-issue configuration request again as a
>>> >> +      * new request. Iproc based PCIe RC (hw) does not retry
>>> >> +      * request on its own, so handle it here.
>>> >> +      */
>>> >> +     do {
>>> >> +             ret =3D readl(cfg_data_p);
>>> >> +             if (ret =3D=3D CFG_RETRY_STATUS)
>>> >> +                     udelay(1);
>>> >> +             else
>>> >> +                     return PCIBIOS_SUCCESSFUL;
>>> >> +     } while (timeout--);
>>> >
>>> > Shouldn't this check *where* in config space we're reading?
>>> >
>>> No, we do not require, because with SPDK it was reading BAR space
>>> which points to MSI-x table.
>>> what I mean is, it could be anywhere.
>>
>> The documentation above says the IP returns data of 0x0001 for *reads
>> of offset 0*.  Your current code reissues the read if *any* read
>> anywhere returns data that happens to match CFG_RETRY_STATUS.  That
>> may be a perfectly valid register value for some device's config
>> space.  In that case, you do not want to reissue the read and you do
>> not want to timeout.
>
> ok, so the documentation is about PCIe core IP,
> It is not about the host bridge. (PCI to AXI bridge)
>
> PCIe core forwards 0x0001 return code to host bridge, and converts it
> into 0xffff0001.
> which is hard wired.
> we have another HW layer on top of PCIe core which implements lots of
> logic. (host bridge)
>
> I agree with you that, it could be valid data, but our ASIC conveyed
> that they have chosen the code
> such that this data is unlikely to be valid.
>
> however I have found one case where this data is valid.
> which is; BAR exposing 64-bit IO memory, which seems legacy and is rare a=
s well.
>
> however in our next chip revision, ASIC will give us separate CRS
> register in our host-bridge.
> We will be retrying on that register instead of this code. but that
> will be the minor code change.
>
> but for our current chip we do not have any choice other than checking
> for 0xffff0001.
>
>>
>>> > Shouldn't we check whether CRS software visiblity is enabled?  Does
>>> > iProc advertise CRS software visibility support in Root Capabilities?
>>>
>>> No, this is also not required because irrespective of that, IP will
>>> re-issue the request, and it will forwards error code to host bridge.
>>> and in-turn host-bridge is implemented to return 0xffff0001 as code.
>>
>> The documentation says the IP does not handle reissuing the request.
>
> yes, sorry, I meant IP does not handle it, so RC driver (sw) handles it.
>
>>
>>> > If CRS software visibility is enabled, we should return the 0x0001
>>> > data if we're reading the Vendor ID and see CRS status.  It looks lik=
e
>>> > this loop always retries if we see 0xffff0001 data.
>>> >
>>> our internal host bridge is implemented this way, and it returns 0xffff=
0001.
>>> so there, we have no choice.
>>
>> The PCIe spec says that if CRS software visibility is enabled and we
>> get a CRS completion for a config read of the Vendor ID at offset 0,
>> the read should not be retried, and the read should return 0x0001.
>> For example, pci_bus_read_dev_vendor_id() should see that 0x0001
>> value.
>>
>> That's not what this code does.  If the readl() returns
>> CFG_RETRY_STATUS, you do the delay and reissue the read.  You never
>> return 0x0001 to the caller of pci_bus_read_config_word().
>>
>
> As far as I understand, PCI config access APIs do not check for RETRY.
> Also caller of them such as __pci_read_base, do not check for retry.
>
> If we look at user space poll mode drivers, they do not check retry
> code as well. for e.g. SPDK
>
> The driver attempts to read it thinking this has to be retried, and it
> gives up after timeout.
> it is up-to upper layer to handle the data and return value.
>
> so the CRS should be handled at the lowest possible layer in SW, which
> is iproc pcie driver.
>
>>> As I understand from your comments that, I have to change comment
>>> description and include right PCI spec reference with section.
>>> apart form that I have tried to answer your IP specific details.
>>
>> Please include the documentation quote above in the changelog when you
>> revise this patch.
>
> so in conclusion: I have to do following of things.
>
> 1) implement retry for write.
> 2) include Documentation in Changelog.
> 3) include sec 2.3.2 from PCIe spec in commit description.
>
> Regards,
> Oza.
>
>>
>>> >> +
>>> >> +     return PCIBIOS_DEVICE_NOT_FOUND;
>>> >> +}
>>> >> +
>>> >> +static void __iomem *iproc_pcie_map_ep_cfg_reg(struct iproc_pcie *p=
cie,
>>> >> +                                            unsigned int busno,
>>> >> +                                            unsigned int slot,
>>> >> +                                            unsigned int fn,
>>> >> +                                            int where)
>>> >> +{
>>> >> +     u16 offset;
>>> >> +     u32 val;
>>> >> +
>>> >> +     /* EP device access */
>>> >> +     val =3D (busno << CFG_ADDR_BUS_NUM_SHIFT) |
>>> >> +             (slot << CFG_ADDR_DEV_NUM_SHIFT) |
>>> >> +             (fn << CFG_ADDR_FUNC_NUM_SHIFT) |
>>> >> +             (where & CFG_ADDR_REG_NUM_MASK) |
>>> >> +             (1 & CFG_ADDR_CFG_TYPE_MASK);
>>> >> +
>>> >> +     iproc_pcie_write_reg(pcie, IPROC_PCIE_CFG_ADDR, val);
>>> >> +     offset =3D iproc_pcie_reg_offset(pcie, IPROC_PCIE_CFG_DATA);
>>> >> +
>>> >> +     if (iproc_pcie_reg_is_invalid(offset))
>>> >> +             return NULL;
>>> >> +
>>> >> +     return (pcie->base + offset);
>>> >> +}
>>> >> +
>>> >>  /**
>>> >>   * Note access to the configuration registers are protected at the =
higher layer
>>> >>   * by 'pci_lock' in drivers/pci/access.c
>>> >> @@ -499,13 +551,48 @@ static void __iomem *iproc_pcie_map_cfg_bus(st=
ruct pci_bus *bus,
>>> >>               return (pcie->base + offset);
>>> >>  }
>>> >>
>>> >> +static int iproc_pcie_config_read(struct pci_bus *bus, unsigned int=
 devfn,
>>> >> +                                 int where, int size, u32 *val)
>>> >> +{
>>> >> +     struct iproc_pcie *pcie =3D iproc_data(bus);
>>> >> +     unsigned int slot =3D PCI_SLOT(devfn);
>>> >> +     unsigned int fn =3D PCI_FUNC(devfn);
>>> >> +     unsigned int busno =3D bus->number;
>>> >> +     void __iomem *cfg_data_p;
>>> >> +     int ret;
>>> >> +
>>> >> +     /* root complex access. */
>>> >> +     if (busno =3D=3D 0)
>>> >> +             return pci_generic_config_read32(bus, devfn, where, si=
ze, val);
>>> >> +
>>> >> +     cfg_data_p =3D iproc_pcie_map_ep_cfg_reg(pcie, busno, slot, fn=
, where);
>>> >> +
>>> >> +     if (!cfg_data_p)
>>> >> +             return PCIBIOS_DEVICE_NOT_FOUND;
>>> >> +
>>> >> +     ret =3D iproc_pcie_cfg_retry(cfg_data_p);
>>> >> +     if (ret)
>>> >> +             return ret;
>>> >> +
>>> >> +     *val =3D readl(cfg_data_p);
>>> >> +
>>> >> +     if (size <=3D 2)
>>> >> +             *val =3D (*val >> (8 * (where & 3))) & ((1 << (size * =
8)) - 1);
>>> >> +
>>> >> +     return PCIBIOS_SUCCESSFUL;
>>> >> +}
>>> >> +
>>> >>  static int iproc_pcie_config_read32(struct pci_bus *bus, unsigned i=
nt devfn,
>>> >>                                   int where, int size, u32 *val)
>>> >>  {
>>> >>       int ret;
>>> >> +     struct iproc_pcie *pcie =3D iproc_data(bus);
>>> >>
>>> >>       iproc_pcie_apb_err_disable(bus, true);
>>> >> -     ret =3D pci_generic_config_read32(bus, devfn, where, size, val=
);
>>> >> +     if (pcie->type =3D=3D IPROC_PCIE_PAXB_V2)
>>> >> +             ret =3D iproc_pcie_config_read(bus, devfn, where, size=
, val);
>>> >> +     else
>>> >> +             ret =3D pci_generic_config_read32(bus, devfn, where, s=
ize, val);
>>> >>       iproc_pcie_apb_err_disable(bus, false);
>>> >>
>>> >>       return ret;
>>> >> --
>>> >> 1.9.1
>>> >>
