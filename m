Return-Path: <SRS0=FYNY=7F=broadcom.com=oza.oza@kernel.org>
Return-Path: <SRS0=FYNY=7F=broadcom.com=oza.oza@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170802210455.GF20308@bhelgaas-glaptop.roam.corp.google.com>
References: <1499310582-21193-1-git-send-email-oza.oza@broadcom.com>
 <1499310582-21193-2-git-send-email-oza.oza@broadcom.com> <20170802210455.GF20308@bhelgaas-glaptop.roam.corp.google.com>
From: Oza Oza <oza.oza@broadcom.com>
Date: Thu, 3 Aug 2017 13:50:29 +0530
Message-ID: <CAMSpPPcfUFmjg471qmzqQmayNYzfq8Wo7yfHeiEKrj7hkWF=zg@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] PCI: iproc: Retry request when CRS returned from EP
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>, Jon Mason <jonmason@broadcom.com>,
	BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
	Andy Gospodarek <gospo@broadcom.com>, linux-pci <linux-pci@vger.kernel.org>,
	linux-kernel@vger.kernel.org, Oza Pawandeep <oza.pawandeep@gmail.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On Thu, Aug 3, 2017 at 2:34 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Thu, Jul 06, 2017 at 08:39:41AM +0530, Oza Pawandeep wrote:
>> For Configuration Requests only, following reset it is possible for a
>> device to terminate the request but indicate that it is temporarily unab=
le
>> to process the Request, but will be able to process the Request in the
>> future =E2=80=93 in this case, the Configuration Request Retry Status 10=
0 (CRS)
>> Completion Status is used.
>
> Please include the spec reference for this.
>
> The "100" looks like it's supposed to be the Completion Status Field
> value for CRS from PCIe r3.1, sec 2.2.9, Table 2-34, but the value in
> the table is actually 0b010, not 0b100.  I don't think this level of
> detail is necessary unless your hardware exposes those values to the
> driver.
>

I will remove the above description from the comment.

>> As per PCI spec, CRS Software Visibility only affects config read of the
>> Vendor ID, for config write or any other config read the Root must
>> automatically re-issue configuration request again as a new request.
>> Iproc based PCIe RC (hw) does not retry request on its own.
>
> I think sec 2.3.2 is the relevant part of the spec.  It basically
> says that when an RC receives a CRS completion for a config request:
>
>   - If CRS software visibility is not enabled, the RC must reissue the
>     config request as a new request.
>
>   - If CRS software visibility is enabled,
>     - for a config read of Vendor ID, the RC must return 0x0001 data
>     - for all other config reads/writes, the RC must reissue the
>       request
>

yes, above is more relevant, and I will include it in the description.

> Apparently iProc *never* reissues config requests, regardless of
> whether CRS software visibility is enabled?
>

that is true.

> But your CFG_RETRY_STATUS definition suggests that iProc always
> fabricates config read data of 0xffff0001 when it sees CRS status, no
> matter whether software visibility is enabled and no matter what
> config address we read?
>

yes, that is precisely the case.


> What about CRS status for a config *write*?  There's nothing here to
> reissue those.
>

No, we do not need there, because read will always be issued first
before any write.
so we do not need to implement write.

> Is there a hardware erratum that describes the actual hardware
> behavior?

this is documented in our PCIe core hw manual.
>>
4.7.3.3. Retry Status On Configuration Cycle
Endpoints are allowed to generate retry status on configuration
cycles.  In this case, the RC needs to re-issue the request.  The IP
does not handle this because the number of configuration cycles needed
will probably be less
than the total number of non-posted operations needed.   When a retry statu=
s
is received on the User RX interface for a configuration request that
was sent on the User TX interface, it will be indicated with a
completion with the CMPL_STATUS field set to 2=3DCRS, and the user will
have to find the address and data values and send a new transaction on
the User TX interface.
When the internal configuration space returns a retry status during a
configuration cycle (user_cscfg =3D 1) on the Command/Status interface,
the pcie_cscrs will assert with the pcie_csack signal to indicate the
CRS status.
When the CRS Software Visibility Enable register in the Root Control
register is enabled, the IP will return the data value to 0x0001 for
the Vendor ID value and 0xffff  (all 1=E2=80=99s) for the rest of the data =
in
the request for reads of offset 0 that return with CRS status.  This
is true for both the User RX Interface and for the Command/Status
interface.  When CRS Software Visibility is enabled, the CMPL_STATUS
field of the completion on the User RX Interface will not be 2=3DCRS and
the pcie_cscrs signal will not assert on the Command/Status interface.
>>
Broadcom does not sell PCIe core IP, so above information is not
publicly available in terms of hardware erratum or any similar note.


>
>> As a result of the fact, PCIe RC driver (sw) should take care of CRS.
>> This patch fixes the problem, and attempts to read config space again in
>> case of PCIe code forwarding the CRS back to CPU.
>> It implements iproc_pcie_config_read which gets called for Stingray,
>> Otherwise it falls back to PCI generic APIs.
>>
>> Signed-off-by: Oza Pawandeep <oza.oza@broadcom.com>
>> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
>> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
>>
>> diff --git a/drivers/pci/host/pcie-iproc.c b/drivers/pci/host/pcie-iproc=
.c
>> index 0f39bd2..b0abcd7 100644
>> --- a/drivers/pci/host/pcie-iproc.c
>> +++ b/drivers/pci/host/pcie-iproc.c
>> @@ -68,6 +68,9 @@
>>  #define APB_ERR_EN_SHIFT             0
>>  #define APB_ERR_EN                   BIT(APB_ERR_EN_SHIFT)
>>
>> +#define CFG_RETRY_STATUS             0xffff0001
>> +#define CFG_RETRY_STATUS_TIMEOUT_US  500000 /* 500 milli-seconds. */
>> +
>>  /* derive the enum index of the outbound/inbound mapping registers */
>>  #define MAP_REG(base_reg, index)      ((base_reg) + (index) * 2)
>>
>> @@ -448,6 +451,55 @@ static inline void iproc_pcie_apb_err_disable(struc=
t pci_bus *bus,
>>       }
>>  }
>>
>> +static int iproc_pcie_cfg_retry(void __iomem *cfg_data_p)
>> +{
>> +     int timeout =3D CFG_RETRY_STATUS_TIMEOUT_US;
>> +     unsigned int ret;
>> +
>> +     /*
>> +      * As per PCI spec, CRS Software Visibility only
>> +      * affects config read of the Vendor ID.
>> +      * For config write or any other config read the Root must
>> +      * automatically re-issue configuration request again as a
>> +      * new request. Iproc based PCIe RC (hw) does not retry
>> +      * request on its own, so handle it here.
>> +      */
>> +     do {
>> +             ret =3D readl(cfg_data_p);
>> +             if (ret =3D=3D CFG_RETRY_STATUS)
>> +                     udelay(1);
>> +             else
>> +                     return PCIBIOS_SUCCESSFUL;
>> +     } while (timeout--);
>
> Shouldn't this check *where* in config space we're reading?
>
No, we do not require, because with SPDK it was reading BAR space
which points to MSI-x table.
what I mean is, it could be anywhere.

> Shouldn't we check whether CRS software visiblity is enabled?  Does
> iProc advertise CRS software visibility support in Root Capabilities?
>

No, this is also not required because irrespective of that, IP will
re-issue the request, and it will forwards error code to host bridge.
and in-turn host-bridge is implemented to return 0xffff0001 as code.

> If CRS software visibility is enabled, we should return the 0x0001
> data if we're reading the Vendor ID and see CRS status.  It looks like
> this loop always retries if we see 0xffff0001 data.
>
our internal host bridge is implemented this way, and it returns 0xffff0001=
.
so there, we have no choice.


As I understand from your comments that, I have to change comment
description and include right PCI spec reference with section.
apart form that I have tried to answer your IP specific details.

>> +
>> +     return PCIBIOS_DEVICE_NOT_FOUND;
>> +}
>> +
>> +static void __iomem *iproc_pcie_map_ep_cfg_reg(struct iproc_pcie *pcie,
>> +                                            unsigned int busno,
>> +                                            unsigned int slot,
>> +                                            unsigned int fn,
>> +                                            int where)
>> +{
>> +     u16 offset;
>> +     u32 val;
>> +
>> +     /* EP device access */
>> +     val =3D (busno << CFG_ADDR_BUS_NUM_SHIFT) |
>> +             (slot << CFG_ADDR_DEV_NUM_SHIFT) |
>> +             (fn << CFG_ADDR_FUNC_NUM_SHIFT) |
>> +             (where & CFG_ADDR_REG_NUM_MASK) |
>> +             (1 & CFG_ADDR_CFG_TYPE_MASK);
>> +
>> +     iproc_pcie_write_reg(pcie, IPROC_PCIE_CFG_ADDR, val);
>> +     offset =3D iproc_pcie_reg_offset(pcie, IPROC_PCIE_CFG_DATA);
>> +
>> +     if (iproc_pcie_reg_is_invalid(offset))
>> +             return NULL;
>> +
>> +     return (pcie->base + offset);
>> +}
>> +
>>  /**
>>   * Note access to the configuration registers are protected at the high=
er layer
>>   * by 'pci_lock' in drivers/pci/access.c
>> @@ -499,13 +551,48 @@ static void __iomem *iproc_pcie_map_cfg_bus(struct=
 pci_bus *bus,
>>               return (pcie->base + offset);
>>  }
>>
>> +static int iproc_pcie_config_read(struct pci_bus *bus, unsigned int dev=
fn,
>> +                                 int where, int size, u32 *val)
>> +{
>> +     struct iproc_pcie *pcie =3D iproc_data(bus);
>> +     unsigned int slot =3D PCI_SLOT(devfn);
>> +     unsigned int fn =3D PCI_FUNC(devfn);
>> +     unsigned int busno =3D bus->number;
>> +     void __iomem *cfg_data_p;
>> +     int ret;
>> +
>> +     /* root complex access. */
>> +     if (busno =3D=3D 0)
>> +             return pci_generic_config_read32(bus, devfn, where, size, =
val);
>> +
>> +     cfg_data_p =3D iproc_pcie_map_ep_cfg_reg(pcie, busno, slot, fn, wh=
ere);
>> +
>> +     if (!cfg_data_p)
>> +             return PCIBIOS_DEVICE_NOT_FOUND;
>> +
>> +     ret =3D iproc_pcie_cfg_retry(cfg_data_p);
>> +     if (ret)
>> +             return ret;
>> +
>> +     *val =3D readl(cfg_data_p);
>> +
>> +     if (size <=3D 2)
>> +             *val =3D (*val >> (8 * (where & 3))) & ((1 << (size * 8)) =
- 1);
>> +
>> +     return PCIBIOS_SUCCESSFUL;
>> +}
>> +
>>  static int iproc_pcie_config_read32(struct pci_bus *bus, unsigned int d=
evfn,
>>                                   int where, int size, u32 *val)
>>  {
>>       int ret;
>> +     struct iproc_pcie *pcie =3D iproc_data(bus);
>>
>>       iproc_pcie_apb_err_disable(bus, true);
>> -     ret =3D pci_generic_config_read32(bus, devfn, where, size, val);
>> +     if (pcie->type =3D=3D IPROC_PCIE_PAXB_V2)
>> +             ret =3D iproc_pcie_config_read(bus, devfn, where, size, va=
l);
>> +     else
>> +             ret =3D pci_generic_config_read32(bus, devfn, where, size,=
 val);
>>       iproc_pcie_apb_err_disable(bus, false);
>>
>>       return ret;
>> --
>> 1.9.1
>>
