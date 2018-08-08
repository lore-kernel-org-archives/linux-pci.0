Return-Path: <SRS0=b1Fv=KX=oracle.com=thomas.tai@kernel.org>
Return-Path: <SRS0=b1Fv=KX=oracle.com=thomas.tai@kernel.org>
Subject: Re: [PATCH] PCI: pciehp: Differentiate between surprise and safe
 removal
To: gokul cg <gokuljnpr@gmail.com>
Cc: Lukas Wunner <lukas@wunner.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
        Keith Busch <keith.busch@intel.com>, Yinghai Lu <yinghai@kernel.org>,
        Sinan Kaya <okaya@kernel.org>, linux-pci@vger.kernel.org,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>
References: <dac488604766f3dcb948e702210ecc381c4f907b.1533015755.git.lukas@wunner.de>
 <20180801164358.GI2534@lahna.fi.intel.com> <20180801171512.GA28440@wunner.de>
 <20180802072036.GN2534@lahna.fi.intel.com>
 <CAFP4jM8AYG7hmkC_rYgXAfLoJmkJuW0e1UbgiayGrCPbb_yw8A@mail.gmail.com>
 <20180802084657.GA21267@wunner.de> <20180802150749.GA31683@wunner.de>
 <ebb526d2-0440-6bd7-765c-b7489d75d830@oracle.com>
 <CAFP4jM_hqaHjHx1A4G05cX8p3gQGywkXLf1bNa+6Kpdzb_+bTw@mail.gmail.com>
 <0afd8c9c-8552-4141-3ccf-9d90d4698a0b@oracle.com>
 <CAFP4jM8fS3dRtCDNWcBd+X92tNu0G4orx-aycgKfdcRu5hFGdw@mail.gmail.com>
From: Thomas Tai <thomas.tai@oracle.com>
Message-ID: <2be77108-8db1-dbc4-7dd8-68b22ef9dd1c@oracle.com>
Date: Wed, 8 Aug 2018 16:49:24 -0400
MIME-Version: 1.0
In-Reply-To: <CAFP4jM8fS3dRtCDNWcBd+X92tNu0G4orx-aycgKfdcRu5hFGdw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>



On 08/08/2018 07:21 AM, gokul cg wrote:
> Thanks Thomas,
> 
> With patch you suggested , panic has gone away from 
> 'pci_find_next_ext_capability' as we not using inside aer_isr , but now 
> it hits at pci_bus_read_config_dword.

Hmm, that's too bad. You probably are right, the dev->bus->ops->read may 
be corrupted. I am wondering can you print out the dev->bus->ops->read 
in normal working condition and compare it with the surprise power off.

By the way, I am using following aer-inject tools:
https://git.kernel.org/pub/scm/linux/kernel/git/gong.chen/aer-inject.git

Others thoughts is that I did pci_stop_and_remove_bus_device() and then 
call pci_read_config_dword() I still don't get the protection fault. Do 
your device driver do something special when it detects the power off? 
Or, may be the BIOS/UEFI did something to prevent the configure read?

Regards,
Thomas

> 
> -------------------xxxxxxx bt og xxxxxxxx-----------------"
> PID: 24     TASK: ffff880274ac0000  CPU: 0   COMMAND: "kworker/0:1"
>   #0 [ffff880274abbb18] machine_kexec at ffffffff8102cf18
>   #1 [ffff880274abbb78] crash_kexec at ffffffff810a6b05
>   #2 [ffff880274abbc40] oops_end at ffffffff8176d960
>   #3 [ffff880274abbc68] die at ffffffff810060db
>   #4 [ffff880274abbc98] do_general_protection at ffffffff8176d452
>   #5 [ffff880274abbcc0] general_protection at ffffffff8176cdf2
>      [exception RIP: pci_bus_read_config_dword+100]
>      RIP: ffffffff813405f4  RSP: ffff880274abbd70  RFLAGS: 00010046
>      RAX: 455a494c41495449  RBX: ffff880274891800  RCX: 0000000000000004
>      RDX: 0000000000000110  RSI: 0000000000000060  RDI: ffff880274891800
>      RBP: ffff880274abbd98   R8: ffff880274abbd7c   R9: 00000000000011b5
>      R10: 0000000000000000  R11: 00000000000011b4  R12: ffff8802741a0210
>      R13: 0000000000000246  R14: ffff880272afc008  R15: ffff880272af8800
>      ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
>   #6 [ffff880274abbda0] get_device_error_info at ffffffff81356d74
>   #7 [ffff880274abbdd0] aer_isr at ffffffff81357b41
>   #8 [ffff880274abbe28] process_one_work at ffffffff8105d4c0
>   #9 [ffff880274abbe70] worker_thread at ffffffff8105e251
> #10 [ffff880274abbed0] kthread at ffffffff81064260
> #11 [ffff880274abbf50] ret_from_fork at ffffffff81773a38"
> 
> -------------------xxxxxxx bt og end xxxxxxxx-----------------
> 
> 
> Regards,
> Gokul
> 
> 
> On Tue, Aug 7, 2018 at 9:00 PM, Thomas Tai <thomas.tai@oracle.com 
> <mailto:thomas.tai@oracle.com>> wrote:
> 
>     Hi Gokul,
>     Something pop up in my mind and want to share with you. I assume
>     that your device is not a root port device or a switch device. I
>     assume when you power off the device, a FATAL error is sent to the
>     root port thus trigger the aer_isr.
> 
>     Since it is a fatal error and your device is not a switch device,
>     the code should not reach out your device because fatal error means
>     that the link to your device is not reliable. So the
>     pci_find_ext_capability() looks strange to me. When compare the code
>     with the master branch. v3.10 is missing following patch. Would you
>     think you can give it a try?
> 
>     commit 66b808099146166c44157600a166c8372172cd76
>     Author: Keith Busch <keith.busch@intel.com
>     <mailto:keith.busch@intel.com>>
>     Date:   Tue Sep 27 16:23:34 2016 -0400
> 
>          PCI/AER: Cache capability position
> 
>          Save the position of the error reporting capability so it
>     doesn't need to
>          be rediscovered during error handling.
> 
>          Signed-off-by: Keith Busch <keith.busch@intel.com
>     <mailto:keith.busch@intel.com>>
>          Signed-off-by: Bjorn Helgaas <bhelgaas@google.com
>     <mailto:bhelgaas@google.com>>
>          CC: Lukas Wunner <lukas@wunner.de <mailto:lukas@wunner.de>>
> 
>     - Thomas
> 
> 
>     On 08/06/2018 02:33 PM, gokul cg wrote:
> 
>         Hi,
> 
>         I have tried with following patch and I am still getting same
>         kernel panic.
> 
>         -------------X++++++++++++++++++++X---------------------
> 
>         diff --git a/drivers/pci/pcie/aer/aerdrv_core.c
>         b/drivers/pci/pcie/aer/aerdrv_core.c
>         index 0f4554e..05592aa 100644
>         --- a/drivers/pci/pcie/aer/aerdrv_core.c
>         +++ b/drivers/pci/pcie/aer/aerdrv_core.c
>         @@ -26,6 +26,7 @@
>            #include <linux/slab.h>
>            #include <linux/kfifo.h>
>            #include "aerdrv.h"
>         +#include "../../pci.h"
> 
>            static bool forceload;
>            static bool nosourceid;
>         @@ -82,7 +82,7 @@
>         EXPORT_SYMBOL_GPL(pci_cleanup_aer_uncorrect_error_status);
>            static int add_error_device(struct aer_err_info *e_info,
>         struct pci_dev *dev)
>            {
>         if (e_info->error_dev_num < AER_MAX_MULTI_ERR_DEVICES) {
>         -e_info->dev[e_info->error_dev_num] = dev;
>         +e_info->dev[e_info->error_dev_num] = pci_dev_get(dev);
> 
>         e_info->error_dev_num++;
>         return 0;
>         }
>         @@ -659,6 +659,9 @@ static int get_device_error_info(struct
>         pci_dev *dev, struct aer_err_info *info)
>         if (!pos)
>         return 1;
> 
>         +        if (pci_dev_is_disconnected(dev))
>         +                return 0;
>         +
>         if (info->severity == AER_CORRECTABLE) {
>         pci_read_config_dword(dev, pos + PCI_ERR_COR_STATUS,
>         &info->status);
>         @@ -710,6 +713,8 @@ static inline void
>         aer_process_err_devices(struct pcie_device *p_device,
>         for (i = 0; i < e_info->error_dev_num && e_info->dev[i]; i++) {
>         if (get_device_error_info(e_info->dev[i], e_info))
>         handle_error_source(p_device, e_info->dev[i], e_info);
>         +
>         +                pci_dev_put(e_info->dev[i]);
>         }
>            }
>         -------------X++++++++++++++++++++X---------------------
> 
> 
>         Note: I have configured CONFIG_HOTPLUG_PCI_PCIE and
>         CONFIG_HOTPLUG_PCI as modules and  loading in start up using script.
> 
>         root@/proc/:~# cat config | grep -i HOT
>         CONFIG_TICK_ONESHOT=y
>         CONFIG_HOTPLUG=y
>         # CONFIG_MEMORY_HOTPLUG is not set
>         CONFIG_HOTPLUG_CPU=y
>         # CONFIG_BOOTPARAM_HOTPLUG_CPU0 is not set
>         # CONFIG_DEBUG_HOTPLUG_CPU0 is not set
>         CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
>         CONFIG_ACPI_HOTPLUG_CPU=y
>         CONFIG_HOTPLUG_PCI_PCIE=m
>         CONFIG_HOTPLUG_PCI=m
>         # CONFIG_HOTPLUG_PCI_CPCI is not set
>         # CONFIG_HOTPLUG_PCI_SHPC is not set
>         CONFIG_DM_SNAPSHOT=y
>         # CONFIG_USB_STORAGE_JUMPSHOT is not set
>         # CONFIG_TRACER_SNAPSHOT is not set
>         root@/proc/:~#
> 
>         Panic back trace :
>         crash> bt
>         PID: 24     TASK: ffff880274ac0000  CPU: 0   COMMAND: "kworker/0:1"
>            #0 [ffff880274abbac8] machine_kexec at ffffffff8102cf18
>            #1 [ffff880274abbb28] crash_kexec at ffffffff810a6b05
>            #2 [ffff880274abbbf0] oops_end at ffffffff8176d8a0
>            #3 [ffff880274abbc18] die at ffffffff810060db
>            #4 [ffff880274abbc48] do_general_protection at ffffffff8176d392
>            #5 [ffff880274abbc70] general_protection at ffffffff8176cd32
>               [exception RIP: pci_bus_read_config_dword+100]
>               RIP: ffffffff813405f4  RSP: ffff880274abbd20  RFLAGS: 00010046
>               RAX: 435f494350006963  RBX: ffff880274891800  RCX:
>         0000000000000004
>               RDX: 0000000000000ffc  RSI: 0000000000000060  RDI:
>         ffff880274891800
>               RBP: ffff880274abbd48   R8: ffff880274abbd2c   R9:
>         00000000000002b8
>               R10: ffff880274340000  R11: 0000000000000246  R12:
>         ffff880274abbd5c
>               R13: 0000000000000246  R14: 0000000000000000  R15:
>         ffff880274920000
>               ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
>            #6 [ffff880274abbd50] pci_find_next_ext_capability at
>         ffffffff81345db6
>            #7 [ffff880274abbd90] pci_find_ext_capability at ffffffff81347225
>            #8 [ffff880274abbda0] get_device_error_info at ffffffff81356c4d
>            #9 [ffff880274abbdd0] aer_isr at ffffffff81357ab0
>         #10 [ffff880274abbe28] process_one_work at ffffffff8105d4c0
>         #11 [ffff880274abbe70] worker_thread at ffffffff8105e251
>         #12 [ffff880274abbed0] kthread at ffffffff81064260
>         #13 [ffff880274abbf50] ret_from_fork at ffffffff81773978
>         crash>
> 
> 
>         Regards,
>         Gokul
> 
>         On Thu, Aug 2, 2018 at 10:39 PM, Thomas Tai
>         <thomas.tai@oracle.com <mailto:thomas.tai@oracle.com>
>         <mailto:thomas.tai@oracle.com <mailto:thomas.tai@oracle.com>>>
>         wrote:
> 
> 
>              On 08/02/2018 11:07 AM, Lukas Wunner wrote:
> 
>                  [cc += Thomas Tai]
> 
> 
>              Hi Lukas,
>              Thank you very much for cc me.
> 
> 
>                  On Thu, Aug 02, 2018 at 10:46:57AM +0200, Lukas Wunner
>         wrote:
> 
>                      On Thu, Aug 02, 2018 at 12:59:18PM +0530, gokul cg
>         wrote:
> 
>                          I am suspecting a possible race condition in
>         the kernel
>                          between PCI driver
>                          and AER handling.
> 
> 
>                      The solution is to acquire a ref on each device in
>                      add_error_device().
>                      Then release the ref aer_process_err_devices() by
>         calling
>                      pci_dev_put().
> 
> 
>                  So in case it wasn't clear, the below is what I had in
>         mind.
>                  Completely untested though.  Does this work for you?
> 
>                  For v3.10 compatibility, cherry-pick 89ee9f768003 (or
>         alternatively
>                  cherry-pick 8496e85c20e7 and replace
>         pci_dev_is_disconnected(dev)
>                  with !pci_device_is_present(dev)).
> 
>                  -- >8 --
>                  Subject: [PATCH] PCI/AER: Fix use-after-free on
>         surprise removal
> 
>                  The work item to consume errors, aer_isr(), walks the
>         hierarchy
>                  using
>                  pci_walk_bus() and stores a pointer to PCI devices
>         which reported an
>                  error in an array.  As long as pci_walk_bus() runs, those
>                  pointers are
>                  valid because pci_bus_sem is held.  But once pci_walk_bus()
>                  finishes,
>                  nothing prevents the pointers from becoming invalid,
>         e.g. through
>                  unplugging of the PCI devices.  The unprotected
>         pointers are then
>                  dereferenced in aer_process_err_devices(), which may oops:
> 
> 
>              I like your idea to increment the refcount during
>         pci_walk_bus(),
>              that should fix the use-after-free issue. We just need Gokul to
>              confirm if it fixes his issue or not.
> 
>              Thanks,
>              Thomas
> 
> 
> 
>                      #5  general_protection at ffffffff8176cdf2
>                          [exception RIP: pci_bus_read_config_dword+100]
>                      #6  pci_find_next_ext_capability at ffffffff81345d7b
>                      #7  pci_find_ext_capability at ffffffff81347225
>                      #8  get_device_error_info at ffffffff81356c4d
>                      #9  aer_isr at ffffffff81357a38
> 
>                  Fix by holding a ref on the devices until they have
>         been processed.
>                  Skip processing of unplugged devices.
> 
>                  Reported-by: gokul cg <gokuljnpr@gmail.com
>         <mailto:gokuljnpr@gmail.com>
>                  <mailto:gokuljnpr@gmail.com <mailto:gokuljnpr@gmail.com>>>
>                  Signed-off-by: Lukas Wunner <lukas@wunner.de
>         <mailto:lukas@wunner.de>
>                  <mailto:lukas@wunner.de <mailto:lukas@wunner.de>>>
> 
>                  ---
>                     drivers/pci/pcie/aer.c | 6 +++++-
>                     1 file changed, 5 insertions(+), 1 deletion(-)
> 
>                  diff --git a/drivers/pci/pcie/aer.c
>         b/drivers/pci/pcie/aer.c
>                  index a2e8838..937592e 100644
>                  --- a/drivers/pci/pcie/aer.c
>                  +++ b/drivers/pci/pcie/aer.c
>                  @@ -657,7 +657,7 @@ void cper_print_aer(struct pci_dev
>         *dev, int
>                  aer_severity,
>                     static int add_error_device(struct aer_err_info *e_info,
>                  struct pci_dev *dev)
>                     {
>                           if (e_info->error_dev_num <
>         AER_MAX_MULTI_ERR_DEVICES) {
>                  -               e_info->dev[e_info->error_dev_num] = dev;
>                  +               e_info->dev[e_info->error_dev_num] =
>                  pci_dev_get(dev);
>                                   e_info->error_dev_num++;
>                                   return 0;
>                           }
>                  @@ -898,6 +898,9 @@ static int get_device_error_info(struct
>                  pci_dev *dev, struct aer_err_info *info)
>                           if (!pos)
>                                   return 0;
>                     +     if (pci_dev_is_disconnected(dev))
>                  +               return 0;
>                  +
>                           if (info->severity == AER_CORRECTABLE) {
>                                   pci_read_config_dword(dev, pos +
>                  PCI_ERR_COR_STATUS,
>                                           &info->status);
>                  @@ -948,6 +951,7 @@ static inline void
>                  aer_process_err_devices(struct aer_err_info *e_info)
>                           for (i = 0; i < e_info->error_dev_num &&
>                  e_info->dev[i]; i++) {
>                                   if
>         (get_device_error_info(e_info->dev[i], e_info))
>                                          
>         handle_error_source(e_info->dev[i],
>                  e_info);
>                  +               pci_dev_put(e_info->dev[i]);
>                           }
>                     }
> 
> 
> 
