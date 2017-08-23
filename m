Return-Path: <SRS0=Fnf9=7Z=broadcom.com=oza.oza@kernel.org>
Return-Path: <SRS0=Fnf9=7Z=broadcom.com=oza.oza@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170822203347.GE6948@bhelgaas-glaptop.roam.corp.google.com>
References: <1503331124-25029-1-git-send-email-oza.oza@broadcom.com>
 <1503331124-25029-2-git-send-email-oza.oza@broadcom.com> <20170822203347.GE6948@bhelgaas-glaptop.roam.corp.google.com>
From: Oza Oza <oza.oza@broadcom.com>
Date: Wed, 23 Aug 2017 15:57:02 +0530
Message-ID: <CAMSpPPctfRhf8zkeoGN73N-vm8Adn7SwieAAeRKrjhY7m_RkEw@mail.gmail.com>
Subject: Re: [PATCH v7 1/2] PCI: iproc: Retry request when CRS returned from EP
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>, Jon Mason <jonmason@broadcom.com>,
	BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
	Andy Gospodarek <gospo@broadcom.com>, linux-pci <linux-pci@vger.kernel.org>,
	linux-kernel@vger.kernel.org, Oza Pawandeep <oza.pawandeep@gmail.com>,
	Sinan Kaya <okaya@codeaurora.org>, Timur Tabi <timur@codeaurora.org>,
	Alex Williamson <alex.williamson@redhat.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 23, 2017 at 2:03 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> [+cc Sinan, Timur, Alex]
>
> Hi Oza,
>
> On Mon, Aug 21, 2017 at 09:28:43PM +0530, Oza Pawandeep wrote:
>> PCIe spec r3.1, sec 2.3.2
>> If CRS software visibility is not enabled, the RC must reissue the
>> config request as a new request.
>>
>> - If CRS software visibility is enabled,
>> - for a config read of Vendor ID, the RC must return 0x0001 data
>> - for all other config reads/writes, the RC must reissue the
>>   request
>
> You mentioned early on that this fixes an issue with NVMe after a
> reset.  Is that reset an FLR?  I'm wondering if this overlaps with the
> work Sinan is doing:
>
>   http://lkml.kernel.org/r/20170818212310.15145.21732.stgit@bhelgaas-glap=
top.roam.corp.google.com
>
> With the current code in the tree, pci_flr_wait() probably waits only
> 100ms on your system.  It currently reads PCI_COMMAND and probably
> sees 0xffff0001 because the NVMe device returns a CRS completion
> (which this iproc RC incorrectly turns into 0xffff0001 data), so we
> exit the loop after a single msleep(100).
>
> Sinan is extending pci_flr_wait() to read the Vendor ID and look for
> the CRS SV indication.  If this is where you're seeing the NVMe issue,
> I bet we can fix this by simply changing iproc_pcie_config_read() to
> return the correct data when it sees a CRS completion.  Then the
> retry loop in pci_flr_wait() will work as intended.
>

The issue with User Space poll mode drivers resulting into CRS.


root@bcm958742k:~# /usr/share/spdk/examples/nvme/perf -r 'trtype:PCIe
traddr:0000:01:00.0' -q 128 -s 4096 -w read -d 2048 -t 30 -c 0x1
Starting DPDK 16.11.1 initialization...
[ DPDK EAL parameters: perf -c 1 -m 2048 --file-prefix=3Dspdk_pid2202 ]
EAL: Detected 8 lcore(s)
EAL: Probing VFIO support...
EAL: VFIO support initialized
EAL: cannot open /proc/self/numa_maps, consider that all memory is in
socket_id 0
Initializing NVMe Controllers
EAL: PCI device 0000:01:00.0 on NUMA socket 0
EAL:   probe driver: 8086:953 spdk_nvme
EAL:   using IOMMU type 1 (Type 1)
[   45.811353] vfio_ecap_init: 0000:01:00.0 hiding ecap 0x19@0x2a0
Attaching to NVMe Controller at 0000:01:00.0 [8086:0953]
[   46.486601] vfio_bar_restore: 0000:01:00.0 reset recovery - restoring ba=
rs
nvme_ctrlr.c:1237:nvme_ctrlr_process_init: ***ERROR*** Initialization
timed out in state 3
nvme_ctrlr.c: 414:nvme_ctrlr_shutdown: ***ERROR*** did not shutdown
within 5 seconds
EAL: Hotplug doesn't support vfio yet
spdk_nvme_probe() failed for transport address '0000:01:00.0'
/usr/share/spdk/examples/nvme/perf: errors occured

ok, so this is in the context of
[   52.500579] [<ffff000008088498>] dump_backtrace+0x0/0x208
[   52.506147] [<ffff0000080886b4>] show_stack+0x14/0x20
[   52.511357] [<ffff0000083ace34>] dump_stack+0x8c/0xb0
[   52.516567] [<ffff00000840a550>] pci_flr_wait+0x18/0xc8
[   52.521955] [<ffff00000840bf9c>] pcie_flr+0x34/0x68
[   52.526986] [<ffff00000840e3d0>] __pci_dev_reset+0x100/0x2c0
[   52.532823] [<ffff00000840e60c>] pci_try_reset_function+0x64/0x80
[   52.539108] [<ffff00000856e4b8>] vfio_pci_ioctl+0x398/0xb78
[   52.544857] [<ffff000008568378>] vfio_device_fops_unl_ioctl+0x20/0x30
[   52.551501] [<ffff0000081d4e24>] do_vfs_ioctl+0xa4/0x738
[   52.556980] [<ffff0000081d5544>] SyS_ioctl+0x8c/0xa0
[   52.562100] [<ffff000008082f8c>] __sys_trace_return+0x0/0x4


So, I have two things to do here.

1) remove retry funciton and just do following.
   data =3D readl(cfg_data_p);
   if (data =3D=3D CFG_RETRY_STATUS)    /* 0xffff0001 */
     data =3D 0xffffffff;

2) refactor the code with separate patch.

but for that Sinan's patch is required.
then with both the patches I think, things will work out correctly for
iproc SOC.

Let me know how this sounds and if you agree with above two points, I
will be posting final set of patches.

let me know if you want me to change anything in the commit description.
in my opinion I should remove config write description which is irrelevant =
here.

Regards,
Oza.

> Sec 2.3.2 says the RC may limit the number of retries, and it doesn't
> say anything about how many retries the RC should do or what interval
> should be between them.  So I think it should be legal to say "this RC
> does zero retries".
>
> I think an RC that does zero retries and doesn't support CRS SV would
> always handle a CRS completion as a "failed transaction" so it would
> synthesize 0xffffffff data (and, I assume, set an error bit like
> Received Master Abort).  If we treated this controller as though it
> doesn't support CRS SV, the workaround in iproc_pcie_config_read()
> would be simply:
>
>   data =3D readl(cfg_data_p);
>   if (data =3D=3D CFG_RETRY_STATUS)    /* 0xffff0001 */
>     data =3D 0xffffffff;
>
> That would make the loop in pci_flr_wait() that reads PCI_COMMAND work
> correctly.  It would get 0xffffffff data as long as the device
> returned CRS completions.
>
> It wouldn't make Sinan's new CRS SV code work, but that's OK: that all
> has to work correctly even on systems that don't support CRS SV.
>
> The only problem is that when we read a non-Vendor ID register that
> happens to really be 0xffff0001, we *should* return 0xffff0001, but we
> incorrectly return 0xffffffff.  But we already know we just have to
> live with that issue.
>
> One minor refactoring comment below.
>
>> iproc PCIe Controller spec:
>> 4.7.3.3. Retry Status On Configuration Cycle
>> Endpoints are allowed to generate retry status on configuration
>> cycles. In this case, the RC needs to re-issue the request. The IP
>> does not handle this because the number of configuration cycles needed
>> will probably be less than the total number of non-posted operations
>> needed.
>>
>> When a retry status is received on the User RX interface for a
>> configuration request that was sent on the User TX interface,
>> it will be indicated with a completion with the CMPL_STATUS field set
>> to 2=3DCRS, and the user will have to find the address and data values
>> and send a new transaction on the User TX interface.
>> When the internal configuration space returns a retry status during a
>> configuration cycle (user_cscfg =3D 1) on the Command/Status interface,
>> the pcie_cscrs will assert with the pcie_csack signal to indicate the
>> CRS status.
>> When the CRS Software Visibility Enable register in the Root Control
>> register is enabled, the IP will return the data value to 0x0001 for
>> the Vendor ID value and 0xffff  (all 1=E2=80=99s) for the rest of the da=
ta in
>> the request for reads of offset 0 that return with CRS status.  This
>> is true for both the User RX Interface and for the Command/Status
>> interface.  When CRS Software Visibility is enabled, the CMPL_STATUS
>> field of the completion on the User RX Interface will not be 2=3DCRS and
>> the pcie_cscrs signal will not assert on the Command/Status interface.
>>
>> Per PCIe r3.1, sec 2.3.2, config requests that receive completions
>> with Configuration Request Retry Status (CRS) should be reissued by
>> the hardware except reads of the Vendor ID when CRS Software
>> Visibility is enabled.
>>
>> This hardware never reissues configuration requests when it receives
>> CRS completions.
>> Note that, neither PCIe host bridge nor PCIe core re-issues the
>> request for any configuration offset.
>> As a result of the fact, PCIe RC driver (sw) should take care of
>> retrying.
>>
>> For config writes, there is no way for this driver to learn about
>> CRS completions. A write that receives a CRS completion will not be
>> retried and the data will be discarded. This is a potential data
>> corruption.
>>
>> For config reads, this hardware returns CFG_RETRY_STATUS data when
>> it receives a CRS completion for a config read, regardless of the
>> address of the read or the CRS Software Visibility Enable bit.  As a
>> partial workaround for this, we retry in software any read that
>> returns CFG_RETRY_STATUS.
>>
>> It implements iproc_pcie_config_read which gets called for Stingray.
>> For other iproc based SOC, it falls back to PCI generic APIs.
>>
>> Signed-off-by: Oza Pawandeep <oza.oza@broadcom.com>
>> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
>> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
>>
>> diff --git a/drivers/pci/host/pcie-iproc.c b/drivers/pci/host/pcie-iproc=
.c
>> index c574863..a3edae4 100644
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
>> @@ -448,6 +451,89 @@ static inline void iproc_pcie_apb_err_disable(struc=
t pci_bus *bus,
>>       }
>>  }
>>
>> +static unsigned int iproc_pcie_cfg_retry(void __iomem *cfg_data_p)
>> +{
>> +     int timeout =3D CFG_RETRY_STATUS_TIMEOUT_US;
>> +     unsigned int data;
>> +
>> +     /*
>> +      * As per PCIe spec r3.1, sec 2.3.2, CRS Software
>> +      * Visibility only affects config read of the Vendor ID.
>> +      * For config write or any other config read the Root must
>> +      * automatically re-issue configuration request again as a
>> +      * new request.
>> +      *
>> +      * For config reads, this hardware returns CFG_RETRY_STATUS data w=
hen
>> +      * it receives a CRS completion for a config read, regardless of t=
he
>> +      * address of the read or the CRS Software Visibility Enable bit. =
As a
>> +      * partial workaround for this, we retry in software any read that
>> +      * returns CFG_RETRY_STATUS.
>> +      */
>> +     data =3D readl(cfg_data_p);
>> +     while (data =3D=3D CFG_RETRY_STATUS && timeout--) {
>> +             udelay(1);
>> +             data =3D readl(cfg_data_p);
>> +     }
>> +
>> +     if (data =3D=3D CFG_RETRY_STATUS)
>> +             data =3D 0xffffffff;
>> +
>> +     return data;
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
>> +static int iproc_pcie_config_read(struct pci_bus *bus, unsigned int dev=
fn,
>> +                                 int where, int size, u32 *val)
>> +{
>> +     struct iproc_pcie *pcie =3D iproc_data(bus);
>> +     unsigned int slot =3D PCI_SLOT(devfn);
>> +     unsigned int fn =3D PCI_FUNC(devfn);
>> +     unsigned int busno =3D bus->number;
>> +     void __iomem *cfg_data_p;
>> +     u32 data;
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
>> +     data =3D iproc_pcie_cfg_retry(cfg_data_p);
>> +
>> +     *val =3D data;
>> +     if (size <=3D 2)
>> +             *val =3D (data >> (8 * (where & 3))) & ((1 << (size * 8)) =
- 1);
>> +
>> +     return PCIBIOS_SUCCESSFUL;
>> +}
>> +
>>  /**
>>   * Note access to the configuration registers are protected at the high=
er layer
>>   * by 'pci_lock' in drivers/pci/access.c
>> @@ -459,7 +545,6 @@ static void __iomem *iproc_pcie_map_cfg_bus(struct i=
proc_pcie *pcie,
>>  {
>>       unsigned slot =3D PCI_SLOT(devfn);
>>       unsigned fn =3D PCI_FUNC(devfn);
>> -     u32 val;
>>       u16 offset;
>>
>>       /* root complex access */
>> @@ -484,18 +569,7 @@ static void __iomem *iproc_pcie_map_cfg_bus(struct =
iproc_pcie *pcie,
>>               if (slot > 0)
>>                       return NULL;
>>
>> -     /* EP device access */
>> -     val =3D (busno << CFG_ADDR_BUS_NUM_SHIFT) |
>> -             (slot << CFG_ADDR_DEV_NUM_SHIFT) |
>> -             (fn << CFG_ADDR_FUNC_NUM_SHIFT) |
>> -             (where & CFG_ADDR_REG_NUM_MASK) |
>> -             (1 & CFG_ADDR_CFG_TYPE_MASK);
>> -     iproc_pcie_write_reg(pcie, IPROC_PCIE_CFG_ADDR, val);
>> -     offset =3D iproc_pcie_reg_offset(pcie, IPROC_PCIE_CFG_DATA);
>> -     if (iproc_pcie_reg_is_invalid(offset))
>> -             return NULL;
>> -     else
>> -             return (pcie->base + offset);
>> +     return iproc_pcie_map_ep_cfg_reg(pcie, busno, slot, fn, where);
>
> Thanks for factoring this out.  Can you please split that refactor
> into a separate patch?  That will make this CRS-handling patch smaller
> and simpler.
>
>>  }
>>
>>  static void __iomem *iproc_pcie_bus_map_cfg_bus(struct pci_bus *bus,
>> @@ -554,8 +628,13 @@ static int iproc_pcie_config_read32(struct pci_bus =
*bus, unsigned int devfn,
>>                                   int where, int size, u32 *val)
>>  {
>>       int ret;
>> +     struct iproc_pcie *pcie =3D iproc_data(bus);
>>
>>       iproc_pcie_apb_err_disable(bus, true);
>> +     if (pcie->type =3D=3D IPROC_PCIE_PAXB_V2)
>> +             ret =3D iproc_pcie_config_read(bus, devfn, where, size, va=
l);
>> +     else
>> +             ret =3D pci_generic_config_read32(bus, devfn, where, size,=
 val);
>>       ret =3D pci_generic_config_read32(bus, devfn, where, size, val);
>>       iproc_pcie_apb_err_disable(bus, false);
>>
>> --
>> 1.9.1
>>
