Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
MIME-Version: 1.0
In-Reply-To: <20170531064340.0dcec477@w520.home>
References: <1496230412-19028-1-git-send-email-gakula@caviumnetworks.com>
 <20170531064340.0dcec477@w520.home>
From: Geetha Akula <geethasowjanya.akula@gmail.com>
Date: Fri, 2 Jun 2017 11:14:27 +0530
Message-ID: <CANHdaiYhosBfcUdtQT5pJN2bc93eqRJeaFSYHBmLjsFPHzLfvw@mail.gmail.com>
Subject: Re: [PATCH] PCI/PM: Set D3 power state only if the end device
 supports it.
To: Alex Williamson <alex.williamson@redhat.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-pci@vger.kernel.org, Geetha sowjanya <gakula@caviumnetworks.com>,
 linux-kernel@vger.kernel.org, Robert Richter <robert.richter@cavium.com>,
 jcm@redhat.com, bhelgaas@google.com, Sunil Goutham <sgoutham@cavium.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 31, 2017 at 6:13 PM, Alex Williamson
<alex.williamson@redhat.com> wrote:
> On Wed, 31 May 2017 17:03:32 +0530
> Geetha sowjanya <gakula@caviumnetworks.com> wrote:
>
>> Pci driver doesn't check if the device supports D3hot/D3cold power states
>> while setting these power states. The device that doesn't support these
>> states will fail when a driver like vfio try to do D0->D3 power transition.
>
>
> That's because support for D0 and D3 device states is REQUIRED by the
> PCIe spec (Rev 3.1a, 7.6).  Is this yet more non-spec compliance?
> Thanks,

Hi Alex,

The issue is seen with the LSI sata cards SAS3008 SAS-3 and SAS-2
 (vendor id: 1000 device id: 0087/0097). Both cards only support D1, D2
power state. This device fails when vfio driver tries to set the power
state to D3hot. The issue is seen across platforms.

Do you recommend to implement quirk for these devices?


Kernel crash when LSI card attached to vfio driver.

[74259.180968] Unhandled fault: synchronous external abort
(0x96000610) at 0x0000000033a80008
[74259.189223] Internal error: : 96000610 [#1] SMP
[74259.193740] Modules linked in: vfio_pci irqbypass vfio_virqfd
vfio_iommu_type1 vfio
[74259.201389] CPU: 104 PID: 2714 Comm: bash Not tainted 4.11.0+ #1
[74259.207382] Hardware name: www.cavium.com Cavium CN99XX/CN99XX,
BIOS 00:03:23 May 30 2017
[74259.215545] task: ffff800ec6680000 task.stack: ffff800ec0e00000
[74259.221454] PC is at pci_generic_config_read+0xa0/0xf0
[74259.226579] LR is at pci_generic_config_read+0x48/0xf0
[74259.231704] pc : [<ffff0000085a5a60>] lr : [<ffff0000085a5a08>]
pstate: 604001c9
[74259.239084] sp : ffff800ec0e03900
[74259.242386] x29: ffff800ec0e03900 x28: ffff800ec6680000
[74259.247685] x27: 0000000000001000 x26: 0000000000000097
[74259.252984] x25: 0000000000000140 x24: ffff000009466000
[74259.258283] x23: 0000000000000054 x22: 0000000000000000
[74259.263581] x21: ffff800ec0e03994 x20: 0000000000000002
[74259.268880] x19: ffff800f4c913800 x18: ffff0000091d3c10
[74259.274179] x17: 0000fffee43373d0 x16: ffff000008289c68
[74259.279477] x15: ffff800ec56b991c x14: 0000000000000000
[74259.284776] x13: 0000000000000040 x12: 0000000000000000
[74259.290074] x11: 0000000000000220 x10: 00000000000009b0
[74259.295373] x9 : ffff800ec0e03800 x8 : ffff800ec6680a10
[74259.300671] x7 : 0000000000000002 x6 : 0000000000000000
[74259.305970] x5 : 0000000000000013 x4 : ffff800f4c920500
[74259.311269] x3 : 0000000001300054 x2 : 0000000000000014
[74259.316567] x1 : ffff000010000000 x0 : ffff000011300054
[74259.321866] [.......]

[74259.860266] [<ffff0000085a5a60>] pci_generic_config_read+0xa0/0xf0
[74259.866434] [<ffff0000085a583c>] pci_bus_read_config_word+0xb4/0xd8
[74259.872688] [<ffff0000085ad048>] pci_raw_set_power_state+0x108/0x250
[74259.879028] [<ffff0000085b02ec>] pci_set_power_state+0xc4/0x160
[74259.884939] [<ffff000000dc0e88>] vfio_pci_probe+0xf0/0x1c8 [vfio_pci]
[74259.891367] [<ffff0000085b42f4>] local_pci_probe+0x44/0xb0
[74259.896839] [<ffff0000085b50c0>] pci_device_probe+0x140/0x170
[74259.902574] [<ffff0000086f0dac>] driver_probe_device+0x2bc/0x450
[74259.908568] [<ffff0000086f1064>] __driver_attach+0x124/0x128
[74259.914214] [<ffff0000086ee610>] bus_for_each_dev+0x88/0xe8
[74259.919773] [<ffff0000086f0500>] driver_attach+0x30/0x40
[74259.925072] [<ffff0000085b3af0>] pci_add_dynid+0xa8/0xd0
[74259.930370] [<ffff0000085b472c>] store_new_id+0x144/0x198
[74259.935756] [<ffff0000086ee0a8>] drv_attr_store+0x40/0x58
[74259.941143] [<ffff000008310ea4>] sysfs_kf_write+0x5c/0x78
[74259.946528] [<ffff000008310094>] kernfs_fop_write+0xbc/0x1e8
[74259.952176] [<ffff0000082877d8>] __vfs_write+0x60/0x168
[74259.957387] [<ffff000008288b20>] vfs_write+0xa8/0x1b8
[74259.962426] [<ffff000008289cd4>] SyS_write+0x6c/0xd8
[74259.967378] [<ffff0000080833b0>] el0_svc_naked+0x24/0x28
[74259.972677] Code: a9425bf5 f9401bf7 a8c47bfd d65f03c0 (79400000)
[74259.978794] ---[ end trace e0cfdf3c1d94e7aa ]---


Thank you,
Geetha.

>
> Alex
>
>
>> This patch adds a check that allows to set D3 power state only
>> for the supported devices.
>>
>> Signed-off-by: Geetha sowjanya <gakula@caviumnetworks.com>
>> ---
>>  drivers/pci/pci.c |    3 ++-
>>  1 files changed, 2 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index 563901c..cadd046 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -661,7 +661,8 @@ static int pci_raw_set_power_state(struct pci_dev *dev, pci_power_t state)
>>
>>       /* check if this device supports the desired state */
>>       if ((state == PCI_D1 && !dev->d1_support)
>> -        || (state == PCI_D2 && !dev->d2_support))
>> +        || (state == PCI_D2 && !dev->d2_support)
>> +        || (state == PCI_D3hot && !pci_pme_capable(dev, state)))
>>               return -EIO;
>>
>>       pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
