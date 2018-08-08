Return-Path: <SRS0=SU/x=KX=gmail.com=gokuljnpr@kernel.org>
Return-Path: <SRS0=SU/x=KX=gmail.com=gokuljnpr@kernel.org>
MIME-Version: 1.0
In-Reply-To: <0afd8c9c-8552-4141-3ccf-9d90d4698a0b@oracle.com>
References: <dac488604766f3dcb948e702210ecc381c4f907b.1533015755.git.lukas@wunner.de>
 <20180801164358.GI2534@lahna.fi.intel.com> <20180801171512.GA28440@wunner.de>
 <20180802072036.GN2534@lahna.fi.intel.com> <CAFP4jM8AYG7hmkC_rYgXAfLoJmkJuW0e1UbgiayGrCPbb_yw8A@mail.gmail.com>
 <20180802084657.GA21267@wunner.de> <20180802150749.GA31683@wunner.de>
 <ebb526d2-0440-6bd7-765c-b7489d75d830@oracle.com> <CAFP4jM_hqaHjHx1A4G05cX8p3gQGywkXLf1bNa+6Kpdzb_+bTw@mail.gmail.com>
 <0afd8c9c-8552-4141-3ccf-9d90d4698a0b@oracle.com>
From: gokul cg <gokuljnpr@gmail.com>
Date: Wed, 8 Aug 2018 16:51:08 +0530
Message-ID: <CAFP4jM8fS3dRtCDNWcBd+X92tNu0G4orx-aycgKfdcRu5hFGdw@mail.gmail.com>
Subject: Re: [PATCH] PCI: pciehp: Differentiate between surprise and safe removal
To: Thomas Tai <thomas.tai@oracle.com>
Cc: Lukas Wunner <lukas@wunner.de>, Mika Westerberg <mika.westerberg@linux.intel.com>,
	Bjorn Helgaas <helgaas@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
	Keith Busch <keith.busch@intel.com>, Yinghai Lu <yinghai@kernel.org>,
	Sinan Kaya <okaya@kernel.org>, linux-pci@vger.kernel.org,
	Alexandru Gagniuc <mr.nuke.me@gmail.com>
Content-Type: multipart/alternative; boundary="00000000000009cb5f0572eab54c"
List-ID: <linux-pci.vger.kernel.org>

--00000000000009cb5f0572eab54c
Content-Type: text/plain; charset="UTF-8"

Thanks Thomas,

With patch you suggested , panic has gone away from '
pci_find_next_ext_capability' as we not using inside aer_isr , but now it
hits at pci_bus_read_config_dword.

-------------------xxxxxxx bt og xxxxxxxx-----------------"
PID: 24     TASK: ffff880274ac0000  CPU: 0   COMMAND: "kworker/0:1"
 #0 [ffff880274abbb18] machine_kexec at ffffffff8102cf18
 #1 [ffff880274abbb78] crash_kexec at ffffffff810a6b05
 #2 [ffff880274abbc40] oops_end at ffffffff8176d960
 #3 [ffff880274abbc68] die at ffffffff810060db
 #4 [ffff880274abbc98] do_general_protection at ffffffff8176d452
 #5 [ffff880274abbcc0] general_protection at ffffffff8176cdf2
    [exception RIP: pci_bus_read_config_dword+100]
    RIP: ffffffff813405f4  RSP: ffff880274abbd70  RFLAGS: 00010046
    RAX: 455a494c41495449  RBX: ffff880274891800  RCX: 0000000000000004
    RDX: 0000000000000110  RSI: 0000000000000060  RDI: ffff880274891800
    RBP: ffff880274abbd98   R8: ffff880274abbd7c   R9: 00000000000011b5
    R10: 0000000000000000  R11: 00000000000011b4  R12: ffff8802741a0210
    R13: 0000000000000246  R14: ffff880272afc008  R15: ffff880272af8800
    ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
 #6 [ffff880274abbda0] get_device_error_info at ffffffff81356d74
 #7 [ffff880274abbdd0] aer_isr at ffffffff81357b41
 #8 [ffff880274abbe28] process_one_work at ffffffff8105d4c0
 #9 [ffff880274abbe70] worker_thread at ffffffff8105e251
#10 [ffff880274abbed0] kthread at ffffffff81064260
#11 [ffff880274abbf50] ret_from_fork at ffffffff81773a38"

-------------------xxxxxxx bt og end xxxxxxxx-----------------


Regards,
Gokul


On Tue, Aug 7, 2018 at 9:00 PM, Thomas Tai <thomas.tai@oracle.com> wrote:

> Hi Gokul,
> Something pop up in my mind and want to share with you. I assume that your
> device is not a root port device or a switch device. I assume when you
> power off the device, a FATAL error is sent to the root port thus trigger
> the aer_isr.
>
> Since it is a fatal error and your device is not a switch device, the code
> should not reach out your device because fatal error means that the link to
> your device is not reliable. So the pci_find_ext_capability() looks strange
> to me. When compare the code with the master branch. v3.10 is missing
> following patch. Would you think you can give it a try?
>
> commit 66b808099146166c44157600a166c8372172cd76
> Author: Keith Busch <keith.busch@intel.com>
> Date:   Tue Sep 27 16:23:34 2016 -0400
>
>     PCI/AER: Cache capability position
>
>     Save the position of the error reporting capability so it doesn't need
> to
>     be rediscovered during error handling.
>
>     Signed-off-by: Keith Busch <keith.busch@intel.com>
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>     CC: Lukas Wunner <lukas@wunner.de>
>
> - Thomas
>
>
> On 08/06/2018 02:33 PM, gokul cg wrote:
>
>> Hi,
>>
>> I have tried with following patch and I am still getting same kernel
>> panic.
>>
>> -------------X++++++++++++++++++++X---------------------
>>
>> diff --git a/drivers/pci/pcie/aer/aerdrv_core.c
>> b/drivers/pci/pcie/aer/aerdrv_core.c
>> index 0f4554e..05592aa 100644
>> --- a/drivers/pci/pcie/aer/aerdrv_core.c
>> +++ b/drivers/pci/pcie/aer/aerdrv_core.c
>> @@ -26,6 +26,7 @@
>>   #include <linux/slab.h>
>>   #include <linux/kfifo.h>
>>   #include "aerdrv.h"
>> +#include "../../pci.h"
>>
>>   static bool forceload;
>>   static bool nosourceid;
>> @@ -82,7 +82,7 @@ EXPORT_SYMBOL_GPL(pci_cleanup_
>> aer_uncorrect_error_status);
>>   static int add_error_device(struct aer_err_info *e_info, struct pci_dev
>> *dev)
>>   {
>> if (e_info->error_dev_num < AER_MAX_MULTI_ERR_DEVICES) {
>> -e_info->dev[e_info->error_dev_num] = dev;
>> +e_info->dev[e_info->error_dev_num] = pci_dev_get(dev);
>>
>> e_info->error_dev_num++;
>> return 0;
>> }
>> @@ -659,6 +659,9 @@ static int get_device_error_info(struct pci_dev *dev,
>> struct aer_err_info *info)
>> if (!pos)
>> return 1;
>>
>> +        if (pci_dev_is_disconnected(dev))
>> +                return 0;
>> +
>> if (info->severity == AER_CORRECTABLE) {
>> pci_read_config_dword(dev, pos + PCI_ERR_COR_STATUS,
>> &info->status);
>> @@ -710,6 +713,8 @@ static inline void aer_process_err_devices(struct
>> pcie_device *p_device,
>> for (i = 0; i < e_info->error_dev_num && e_info->dev[i]; i++) {
>> if (get_device_error_info(e_info->dev[i], e_info))
>> handle_error_source(p_device, e_info->dev[i], e_info);
>> +
>> +                pci_dev_put(e_info->dev[i]);
>> }
>>   }
>> -------------X++++++++++++++++++++X---------------------
>>
>>
>> Note: I have configured CONFIG_HOTPLUG_PCI_PCIE and CONFIG_HOTPLUG_PCI as
>> modules and  loading in start up using script.
>>
>> root@/proc/:~# cat config | grep -i HOT
>> CONFIG_TICK_ONESHOT=y
>> CONFIG_HOTPLUG=y
>> # CONFIG_MEMORY_HOTPLUG is not set
>> CONFIG_HOTPLUG_CPU=y
>> # CONFIG_BOOTPARAM_HOTPLUG_CPU0 is not set
>> # CONFIG_DEBUG_HOTPLUG_CPU0 is not set
>> CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
>> CONFIG_ACPI_HOTPLUG_CPU=y
>> CONFIG_HOTPLUG_PCI_PCIE=m
>> CONFIG_HOTPLUG_PCI=m
>> # CONFIG_HOTPLUG_PCI_CPCI is not set
>> # CONFIG_HOTPLUG_PCI_SHPC is not set
>> CONFIG_DM_SNAPSHOT=y
>> # CONFIG_USB_STORAGE_JUMPSHOT is not set
>> # CONFIG_TRACER_SNAPSHOT is not set
>> root@/proc/:~#
>>
>> Panic back trace :
>> crash> bt
>> PID: 24     TASK: ffff880274ac0000  CPU: 0   COMMAND: "kworker/0:1"
>>   #0 [ffff880274abbac8] machine_kexec at ffffffff8102cf18
>>   #1 [ffff880274abbb28] crash_kexec at ffffffff810a6b05
>>   #2 [ffff880274abbbf0] oops_end at ffffffff8176d8a0
>>   #3 [ffff880274abbc18] die at ffffffff810060db
>>   #4 [ffff880274abbc48] do_general_protection at ffffffff8176d392
>>   #5 [ffff880274abbc70] general_protection at ffffffff8176cd32
>>      [exception RIP: pci_bus_read_config_dword+100]
>>      RIP: ffffffff813405f4  RSP: ffff880274abbd20  RFLAGS: 00010046
>>      RAX: 435f494350006963  RBX: ffff880274891800  RCX: 0000000000000004
>>      RDX: 0000000000000ffc  RSI: 0000000000000060  RDI: ffff880274891800
>>      RBP: ffff880274abbd48   R8: ffff880274abbd2c   R9: 00000000000002b8
>>      R10: ffff880274340000  R11: 0000000000000246  R12: ffff880274abbd5c
>>      R13: 0000000000000246  R14: 0000000000000000  R15: ffff880274920000
>>      ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
>>   #6 [ffff880274abbd50] pci_find_next_ext_capability at ffffffff81345db6
>>   #7 [ffff880274abbd90] pci_find_ext_capability at ffffffff81347225
>>   #8 [ffff880274abbda0] get_device_error_info at ffffffff81356c4d
>>   #9 [ffff880274abbdd0] aer_isr at ffffffff81357ab0
>> #10 [ffff880274abbe28] process_one_work at ffffffff8105d4c0
>> #11 [ffff880274abbe70] worker_thread at ffffffff8105e251
>> #12 [ffff880274abbed0] kthread at ffffffff81064260
>> #13 [ffff880274abbf50] ret_from_fork at ffffffff81773978
>> crash>
>>
>>
>> Regards,
>> Gokul
>>
>> On Thu, Aug 2, 2018 at 10:39 PM, Thomas Tai <thomas.tai@oracle.com
>> <mailto:thomas.tai@oracle.com>> wrote:
>>
>>
>>     On 08/02/2018 11:07 AM, Lukas Wunner wrote:
>>
>>         [cc += Thomas Tai]
>>
>>
>>     Hi Lukas,
>>     Thank you very much for cc me.
>>
>>
>>         On Thu, Aug 02, 2018 at 10:46:57AM +0200, Lukas Wunner wrote:
>>
>>             On Thu, Aug 02, 2018 at 12:59:18PM +0530, gokul cg wrote:
>>
>>                 I am suspecting a possible race condition in the kernel
>>                 between PCI driver
>>                 and AER handling.
>>
>>
>>             The solution is to acquire a ref on each device in
>>             add_error_device().
>>             Then release the ref aer_process_err_devices() by calling
>>             pci_dev_put().
>>
>>
>>         So in case it wasn't clear, the below is what I had in mind.
>>         Completely untested though.  Does this work for you?
>>
>>         For v3.10 compatibility, cherry-pick 89ee9f768003 (or
>> alternatively
>>         cherry-pick 8496e85c20e7 and replace pci_dev_is_disconnected(dev)
>>         with !pci_device_is_present(dev)).
>>
>>         -- >8 --
>>         Subject: [PATCH] PCI/AER: Fix use-after-free on surprise removal
>>
>>         The work item to consume errors, aer_isr(), walks the hierarchy
>>         using
>>         pci_walk_bus() and stores a pointer to PCI devices which reported
>> an
>>         error in an array.  As long as pci_walk_bus() runs, those
>>         pointers are
>>         valid because pci_bus_sem is held.  But once pci_walk_bus()
>>         finishes,
>>         nothing prevents the pointers from becoming invalid, e.g. through
>>         unplugging of the PCI devices.  The unprotected pointers are then
>>         dereferenced in aer_process_err_devices(), which may oops:
>>
>>
>>     I like your idea to increment the refcount during pci_walk_bus(),
>>     that should fix the use-after-free issue. We just need Gokul to
>>     confirm if it fixes his issue or not.
>>
>>     Thanks,
>>     Thomas
>>
>>
>>
>>             #5  general_protection at ffffffff8176cdf2
>>                 [exception RIP: pci_bus_read_config_dword+100]
>>             #6  pci_find_next_ext_capability at ffffffff81345d7b
>>             #7  pci_find_ext_capability at ffffffff81347225
>>             #8  get_device_error_info at ffffffff81356c4d
>>             #9  aer_isr at ffffffff81357a38
>>
>>         Fix by holding a ref on the devices until they have been
>> processed.
>>         Skip processing of unplugged devices.
>>
>>         Reported-by: gokul cg <gokuljnpr@gmail.com
>>         <mailto:gokuljnpr@gmail.com>>
>>         Signed-off-by: Lukas Wunner <lukas@wunner.de
>>         <mailto:lukas@wunner.de>>
>>
>>         ---
>>            drivers/pci/pcie/aer.c | 6 +++++-
>>            1 file changed, 5 insertions(+), 1 deletion(-)
>>
>>         diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
>>         index a2e8838..937592e 100644
>>         --- a/drivers/pci/pcie/aer.c
>>         +++ b/drivers/pci/pcie/aer.c
>>         @@ -657,7 +657,7 @@ void cper_print_aer(struct pci_dev *dev, int
>>         aer_severity,
>>            static int add_error_device(struct aer_err_info *e_info,
>>         struct pci_dev *dev)
>>            {
>>                  if (e_info->error_dev_num < AER_MAX_MULTI_ERR_DEVICES) {
>>         -               e_info->dev[e_info->error_dev_num] = dev;
>>         +               e_info->dev[e_info->error_dev_num] =
>>         pci_dev_get(dev);
>>                          e_info->error_dev_num++;
>>                          return 0;
>>                  }
>>         @@ -898,6 +898,9 @@ static int get_device_error_info(struct
>>         pci_dev *dev, struct aer_err_info *info)
>>                  if (!pos)
>>                          return 0;
>>            +     if (pci_dev_is_disconnected(dev))
>>         +               return 0;
>>         +
>>                  if (info->severity == AER_CORRECTABLE) {
>>                          pci_read_config_dword(dev, pos +
>>         PCI_ERR_COR_STATUS,
>>                                  &info->status);
>>         @@ -948,6 +951,7 @@ static inline void
>>         aer_process_err_devices(struct aer_err_info *e_info)
>>                  for (i = 0; i < e_info->error_dev_num &&
>>         e_info->dev[i]; i++) {
>>                          if (get_device_error_info(e_info->dev[i],
>> e_info))
>>                                  handle_error_source(e_info->dev[i],
>>         e_info);
>>         +               pci_dev_put(e_info->dev[i]);
>>                  }
>>            }
>>
>>
>>

--00000000000009cb5f0572eab54c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><span style=3D"font-size:12.8px;text-decoration-style:init=
ial;text-decoration-color:initial;float:none;display:inline">Thanks Thomas,=
</span><div style=3D"font-size:12.8px;text-decoration-style:initial;text-de=
coration-color:initial"><br></div><div style=3D"font-size:12.8px;text-decor=
ation-style:initial;text-decoration-color:initial">With patch you suggested=
 , panic has gone away from &#39;<span style=3D"font-size:small;background-=
color:rgb(255,255,255);text-decoration-style:initial;text-decoration-color:=
initial;float:none;display:inline">pci_find_next_ext_capability</span>&#39;=
 as we not using inside aer_isr , but now it hits at=C2=A0<span style=3D"fo=
nt-size:small;background-color:rgb(255,255,255);text-decoration-style:initi=
al;text-decoration-color:initial;float:none;display:inline">pci_bus_read_co=
nfig_dword.</span></div><div style=3D"font-size:12.8px;text-decoration-styl=
e:initial;text-decoration-color:initial"><br></div><div style=3D"font-size:=
12.8px;text-decoration-style:initial;text-decoration-color:initial"><span c=
lass=3D"gmail-im" style=3D"color:rgb(80,0,80)"><div>-<span style=3D"backgro=
und-color:rgb(255,255,255);text-decoration-style:initial;text-decoration-co=
lor:initial;float:none;display:inline">-----------------</span>-xxxxxxx bt =
og xxxxxxxx-----------------&quot;</div><div>PID: 24=C2=A0 =C2=A0 =C2=A0TAS=
K: ffff880274ac0000=C2=A0 CPU: 0=C2=A0 =C2=A0COMMAND: &quot;kworker/0:1&quo=
t;</div></span><div>=C2=A0#0 [ffff880274abbb18] machine_kexec at ffffffff81=
02cf18</div><div>=C2=A0#1 [ffff880274abbb78] crash_kexec at ffffffff810a6b0=
5</div><div>=C2=A0#2 [ffff880274abbc40] oops_end at ffffffff8176d960</div><=
div>=C2=A0#3 [ffff880274abbc68] die at ffffffff810060db</div><div>=C2=A0#4 =
[ffff880274abbc98] do_general_protection at ffffffff8176d452</div><div>=C2=
=A0#5 [ffff880274abbcc0] general_protection at ffffffff8176cdf2</div><div>=
=C2=A0 =C2=A0 [exception RIP: pci_bus_read_config_dword+100]</div><div>=C2=
=A0 =C2=A0 RIP: ffffffff813405f4=C2=A0 RSP: ffff880274abbd70=C2=A0 RFLAGS: =
00010046</div><div>=C2=A0 =C2=A0 RAX: 455a494c41495449=C2=A0 RBX: ffff88027=
4891800=C2=A0 RCX: 0000000000000004</div><div>=C2=A0 =C2=A0 RDX: 0000000000=
000110=C2=A0 RSI: 0000000000000060=C2=A0 RDI: ffff880274891800</div><div>=
=C2=A0 =C2=A0 RBP: ffff880274abbd98=C2=A0 =C2=A0R8: ffff880274abbd7c=C2=A0 =
=C2=A0R9: 00000000000011b5</div><div>=C2=A0 =C2=A0 R10: 0000000000000000=C2=
=A0 R11: 00000000000011b4=C2=A0 R12: ffff8802741a0210</div><div>=C2=A0 =C2=
=A0 R13: 0000000000000246=C2=A0 R14: ffff880272afc008=C2=A0 R15: ffff880272=
af8800</div><span class=3D"gmail-im" style=3D"color:rgb(80,0,80)"><div>=C2=
=A0 =C2=A0 ORIG_RAX: ffffffffffffffff=C2=A0 CS: 0010=C2=A0 SS: 0018</div></=
span><div>=C2=A0#6 [ffff880274abbda0] get_device_error_info at ffffffff8135=
6d74</div><div>=C2=A0#7 [ffff880274abbdd0] aer_isr at ffffffff81357b41</div=
><div>=C2=A0#8 [ffff880274abbe28] process_one_work at ffffffff8105d4c0</div=
><div>=C2=A0#9 [ffff880274abbe70] worker_thread at ffffffff8105e251</div><d=
iv>#10 [ffff880274abbed0] kthread at ffffffff81064260</div><div>#11 [ffff88=
0274abbf50] ret_from_fork at ffffffff81773a38&quot;</div><br class=3D"gmail=
-Apple-interchange-newline"><span style=3D"color:rgb(80,0,80);background-co=
lor:rgb(255,255,255);text-decoration-style:initial;text-decoration-color:in=
itial;float:none;display:inline">-</span><span style=3D"color:rgb(80,0,80);=
text-decoration-style:initial;text-decoration-color:initial;background-colo=
r:rgb(255,255,255);float:none;display:inline">-----------------</span><span=
 style=3D"color:rgb(80,0,80);background-color:rgb(255,255,255);text-decorat=
ion-style:initial;text-decoration-color:initial;float:none;display:inline">=
-xxxxxxx bt og end xxxxxxxx-----------------</span><div class=3D"gmail_extr=
a"><br></div><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra=
">Regards,</div><div class=3D"gmail_extra">Gokul=C2=A0</div></div><br></div=
><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Tue, Aug 7, 2=
018 at 9:00 PM, Thomas Tai <span dir=3D"ltr">&lt;<a href=3D"mailto:thomas.t=
ai@oracle.com" target=3D"_blank">thomas.tai@oracle.com</a>&gt;</span> wrote=
:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-le=
ft:1px #ccc solid;padding-left:1ex">Hi Gokul,<br>
Something pop up in my mind and want to share with you. I assume that your =
device is not a root port device or a switch device. I assume when you powe=
r off the device, a FATAL error is sent to the root port thus trigger the a=
er_isr.<br>
<br>
Since it is a fatal error and your device is not a switch device, the code =
should not reach out your device because fatal error means that the link to=
 your device is not reliable. So the pci_find_ext_capability() looks strang=
e to me. When compare the code with the master branch. v3.10 is missing fol=
lowing patch. Would you think you can give it a try?<br>
<br>
commit 66b808099146166c44157600a166c8<wbr>372172cd76<br>
Author: Keith Busch &lt;<a href=3D"mailto:keith.busch@intel.com" target=3D"=
_blank">keith.busch@intel.com</a>&gt;<br>
Date:=C2=A0 =C2=A0Tue Sep 27 16:23:34 2016 -0400<br>
<br>
=C2=A0 =C2=A0 PCI/AER: Cache capability position<br>
<br>
=C2=A0 =C2=A0 Save the position of the error reporting capability so it doe=
sn&#39;t need to<br>
=C2=A0 =C2=A0 be rediscovered during error handling.<br>
<br>
=C2=A0 =C2=A0 Signed-off-by: Keith Busch &lt;<a href=3D"mailto:keith.busch@=
intel.com" target=3D"_blank">keith.busch@intel.com</a>&gt;<br>
=C2=A0 =C2=A0 Signed-off-by: Bjorn Helgaas &lt;<a href=3D"mailto:bhelgaas@g=
oogle.com" target=3D"_blank">bhelgaas@google.com</a>&gt;<br>
=C2=A0 =C2=A0 CC: Lukas Wunner &lt;<a href=3D"mailto:lukas@wunner.de" targe=
t=3D"_blank">lukas@wunner.de</a>&gt;<br>
<br>
- Thomas<span class=3D""><br>
<br>
<br>
On 08/06/2018 02:33 PM, gokul cg wrote:<br>
</span><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-=
left:1px #ccc solid;padding-left:1ex"><span class=3D"">
Hi,<br>
<br>
I have tried with following patch and I am still getting same kernel panic.=
<br>
<br>
-------------X++++++++++++++++<wbr>++++X---------------------<br>
<br>
diff --git a/drivers/pci/pcie/aer/aerdrv_<wbr>core.c b/drivers/pci/pcie/aer=
/aerdrv_<wbr>core.c<br>
index 0f4554e..05592aa 100644<br>
--- a/drivers/pci/pcie/aer/aerdrv_<wbr>core.c<br>
+++ b/drivers/pci/pcie/aer/aerdrv_<wbr>core.c<br>
@@ -26,6 +26,7 @@<br>
=C2=A0=C2=A0#include &lt;linux/slab.h&gt;<br>
=C2=A0=C2=A0#include &lt;linux/kfifo.h&gt;<br>
=C2=A0=C2=A0#include &quot;aerdrv.h&quot;<br>
+#include &quot;../../pci.h&quot;<br>
<br>
=C2=A0=C2=A0static bool forceload;<br>
=C2=A0=C2=A0static bool nosourceid;<br>
@@ -82,7 +82,7 @@ EXPORT_SYMBOL_GPL(pci_cleanup_<wbr>aer_uncorrect_error_st=
atus);<br>
=C2=A0=C2=A0static int add_error_device(struct aer_err_info *e_info, struct=
 pci_dev *dev)<br>
=C2=A0=C2=A0{<br>
if (e_info-&gt;error_dev_num &lt; AER_MAX_MULTI_ERR_DEVICES) {<br></span>
-e_info-&gt;dev[e_info-&gt;error_dev<wbr>_num] =3D dev;<br>
+e_info-&gt;dev[e_info-&gt;error_dev<wbr>_num] =3D pci_dev_get(dev);<div><d=
iv class=3D"h5"><br>
e_info-&gt;error_dev_num++;<br>
return 0;<br>
}<br>
@@ -659,6 +659,9 @@ static int get_device_error_info(struct pci_dev *dev, s=
truct aer_err_info *info)<br>
if (!pos)<br>
return 1;<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (pci_dev_is_disconnected(dev))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
+<br>
if (info-&gt;severity =3D=3D AER_CORRECTABLE) {<br>
pci_read_config_dword(dev, pos + PCI_ERR_COR_STATUS,<br>
&amp;info-&gt;status);<br>
@@ -710,6 +713,8 @@ static inline void aer_process_err_devices(struct pcie_=
device *p_device,<br>
for (i =3D 0; i &lt; e_info-&gt;error_dev_num &amp;&amp; e_info-&gt;dev[i];=
 i++) {<br>
if (get_device_error_info(e_info-<wbr>&gt;dev[i], e_info))<br>
handle_error_source(p_device, e_info-&gt;dev[i], e_info);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pci_dev_put(e_info=
-&gt;dev[i]);<br>
}<br>
=C2=A0=C2=A0}<br>
-------------X++++++++++++++++<wbr>++++X---------------------<br>
<br>
<br>
Note: I have configured CONFIG_HOTPLUG_PCI_PCIE and CONFIG_HOTPLUG_PCI as m=
odules and=C2=A0 loading in start up using script.<br>
<br>
root@/proc/:~# cat config | grep -i HOT<br>
CONFIG_TICK_ONESHOT=3Dy<br>
CONFIG_HOTPLUG=3Dy<br>
# CONFIG_MEMORY_HOTPLUG is not set<br>
CONFIG_HOTPLUG_CPU=3Dy<br>
# CONFIG_BOOTPARAM_HOTPLUG_CPU0 is not set<br>
# CONFIG_DEBUG_HOTPLUG_CPU0 is not set<br>
CONFIG_ARCH_ENABLE_MEMORY_HOTP<wbr>LUG=3Dy<br>
CONFIG_ACPI_HOTPLUG_CPU=3Dy<br>
CONFIG_HOTPLUG_PCI_PCIE=3Dm<br>
CONFIG_HOTPLUG_PCI=3Dm<br>
# CONFIG_HOTPLUG_PCI_CPCI is not set<br>
# CONFIG_HOTPLUG_PCI_SHPC is not set<br>
CONFIG_DM_SNAPSHOT=3Dy<br>
# CONFIG_USB_STORAGE_JUMPSHOT is not set<br>
# CONFIG_TRACER_SNAPSHOT is not set<br>
root@/proc/:~#<br>
<br>
Panic back trace :<br>
crash&gt; bt<br>
PID: 24=C2=A0 =C2=A0 =C2=A0TASK: ffff880274ac0000=C2=A0 CPU: 0=C2=A0 =C2=A0=
COMMAND: &quot;kworker/0:1&quot;<br>
=C2=A0=C2=A0#0 [ffff880274abbac8] machine_kexec at ffffffff8102cf18<br>
=C2=A0=C2=A0#1 [ffff880274abbb28] crash_kexec at ffffffff810a6b05<br>
=C2=A0=C2=A0#2 [ffff880274abbbf0] oops_end at ffffffff8176d8a0<br>
=C2=A0=C2=A0#3 [ffff880274abbc18] die at ffffffff810060db<br>
=C2=A0=C2=A0#4 [ffff880274abbc48] do_general_protection at ffffffff8176d392=
<br>
=C2=A0=C2=A0#5 [ffff880274abbc70] general_protection at ffffffff8176cd32<br=
>
=C2=A0=C2=A0 =C2=A0 [exception RIP: pci_bus_read_config_dword+100]<br>
=C2=A0=C2=A0 =C2=A0 RIP: ffffffff813405f4=C2=A0 RSP: ffff880274abbd20=C2=A0=
 RFLAGS: 00010046<br>
=C2=A0=C2=A0 =C2=A0 RAX: 435f494350006963=C2=A0 RBX: ffff880274891800=C2=A0=
 RCX: 0000000000000004<br>
=C2=A0=C2=A0 =C2=A0 RDX: 0000000000000ffc=C2=A0 RSI: 0000000000000060=C2=A0=
 RDI: ffff880274891800<br>
=C2=A0=C2=A0 =C2=A0 RBP: ffff880274abbd48=C2=A0 =C2=A0R8: ffff880274abbd2c=
=C2=A0 =C2=A0R9: 00000000000002b8<br>
=C2=A0=C2=A0 =C2=A0 R10: ffff880274340000=C2=A0 R11: 0000000000000246=C2=A0=
 R12: ffff880274abbd5c<br>
=C2=A0=C2=A0 =C2=A0 R13: 0000000000000246=C2=A0 R14: 0000000000000000=C2=A0=
 R15: ffff880274920000<br>
=C2=A0=C2=A0 =C2=A0 ORIG_RAX: ffffffffffffffff=C2=A0 CS: 0010=C2=A0 SS: 001=
8<br>
=C2=A0=C2=A0#6 [ffff880274abbd50] pci_find_next_ext_capability at ffffffff8=
1345db6<br>
=C2=A0=C2=A0#7 [ffff880274abbd90] pci_find_ext_capability at ffffffff813472=
25<br>
=C2=A0=C2=A0#8 [ffff880274abbda0] get_device_error_info at ffffffff81356c4d=
<br>
=C2=A0=C2=A0#9 [ffff880274abbdd0] aer_isr at ffffffff81357ab0<br>
#10 [ffff880274abbe28] process_one_work at ffffffff8105d4c0<br>
#11 [ffff880274abbe70] worker_thread at ffffffff8105e251<br>
#12 [ffff880274abbed0] kthread at ffffffff81064260<br>
#13 [ffff880274abbf50] ret_from_fork at ffffffff81773978<br>
crash&gt;<br>
<br>
<br>
Regards,<br>
Gokul<br>
<br></div></div><div><div class=3D"h5">
On Thu, Aug 2, 2018 at 10:39 PM, Thomas Tai &lt;<a href=3D"mailto:thomas.ta=
i@oracle.com" target=3D"_blank">thomas.tai@oracle.com</a> &lt;mailto:<a hre=
f=3D"mailto:thomas.tai@oracle.com" target=3D"_blank">thomas.tai@oracle.com<=
/a>&gt;<wbr>&gt; wrote:<br>
<br>
<br>
=C2=A0 =C2=A0 On 08/02/2018 11:07 AM, Lukas Wunner wrote:<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 [cc +=3D Thomas Tai]<br>
<br>
<br>
=C2=A0 =C2=A0 Hi Lukas,<br>
=C2=A0 =C2=A0 Thank you very much for cc me.<br>
<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 On Thu, Aug 02, 2018 at 10:46:57AM +0200, Lukas=
 Wunner wrote:<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 On Thu, Aug 02, 2018 at 12:59:18P=
M +0530, gokul cg wrote:<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 I am suspecting a p=
ossible race condition in the kernel<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 between PCI driver<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 and AER handling.<b=
r>
<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 The solution is to acquire a ref =
on each device in<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 add_error_device().<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Then release the ref aer_process_=
err_devices() by calling<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pci_dev_put().<br>
<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 So in case it wasn&#39;t clear, the below is wh=
at I had in mind.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Completely untested though.=C2=A0 Does this wor=
k for you?<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 For v3.10 compatibility, cherry-pick 89ee9f7680=
03 (or alternatively<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 cherry-pick 8496e85c20e7 and replace pci_dev_is=
_disconnected(dev)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 with !pci_device_is_present(dev)).<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 -- &gt;8 --<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Subject: [PATCH] PCI/AER: Fix use-after-free on=
 surprise removal<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 The work item to consume errors, aer_isr(), wal=
ks the hierarchy<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 using<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 pci_walk_bus() and stores a pointer to PCI devi=
ces which reported an<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 error in an array.=C2=A0 As long as pci_walk_bu=
s() runs, those<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 pointers are<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 valid because pci_bus_sem is held.=C2=A0 But on=
ce pci_walk_bus()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 finishes,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 nothing prevents the pointers from becoming inv=
alid, e.g. through<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 unplugging of the PCI devices.=C2=A0 The unprot=
ected pointers are then<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 dereferenced in aer_process_err_devices(), whic=
h may oops:<br>
<br>
<br>
=C2=A0 =C2=A0 I like your idea to increment the refcount during pci_walk_bu=
s(),<br>
=C2=A0 =C2=A0 that should fix the use-after-free issue. We just need Gokul =
to<br>
=C2=A0 =C2=A0 confirm if it fixes his issue or not.<br>
<br>
=C2=A0 =C2=A0 Thanks,<br>
=C2=A0 =C2=A0 Thomas<br>
<br>
<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0#5=C2=A0 general_protection =
at ffffffff8176cdf2<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0[exception RIP=
: pci_bus_read_config_dword+100]<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0#6=C2=A0 pci_find_next_ext_c=
apability at ffffffff81345d7b<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0#7=C2=A0 pci_find_ext_capabi=
lity at ffffffff81347225<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0#8=C2=A0 get_device_error_in=
fo at ffffffff81356c4d<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0#9=C2=A0 aer_isr at ffffffff=
81357a38<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Fix by holding a ref on the devices until they =
have been processed.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Skip processing of unplugged devices.<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Reported-by: gokul cg &lt;<a href=3D"mailto:gok=
uljnpr@gmail.com" target=3D"_blank">gokuljnpr@gmail.com</a><br></div></div>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;mailto:<a href=3D"mailto:gokuljnpr@gmail.co=
m" target=3D"_blank">gokuljnpr@gmail.com</a>&gt;&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Signed-off-by: Lukas Wunner &lt;<a href=3D"mail=
to:lukas@wunner.de" target=3D"_blank">lukas@wunner.de</a><br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;mailto:<a href=3D"mailto:lukas@wunner.de" t=
arget=3D"_blank">lukas@wunner.de</a>&gt;&gt;<div><div class=3D"h5"><br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ---<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 drivers/pci/pcie/aer.c | 6 +++++-<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 1 file changed, 5 insertions(+), 1=
 deletion(-)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 diff --git a/drivers/pci/pcie/aer.c b/drivers/p=
ci/pcie/aer.c<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 index a2e8838..937592e 100644<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 --- a/drivers/pci/pcie/aer.c<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +++ b/drivers/pci/pcie/aer.c<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 @@ -657,7 +657,7 @@ void cper_print_aer(struct =
pci_dev *dev, int<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 aer_severity,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 static int add_error_device(struct=
 aer_err_info *e_info,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct pci_dev *dev)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (e_info-&g=
t;error_dev_num &lt; AER_MAX_MULTI_ERR_DEVICES) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0e_info-&gt;dev[e_info-&gt;error_dev<wbr>_num] =3D dev;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0e_info-&gt;dev[e_info-&gt;error_dev<wbr>_num] =3D<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 pci_dev_get(dev);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 e_info-&gt;error_dev_num++;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 return 0;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 @@ -898,6 +898,9 @@ static int get_device_error=
_info(struct<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 pci_dev *dev, struct aer_err_info *info)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!pos)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 return 0;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 +=C2=A0 =C2=A0 =C2=A0if (pci_dev_i=
s_disconnected(dev))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0return 0;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (info-&gt;=
severity =3D=3D AER_CORRECTABLE) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 pci_read_config_dword(dev, pos +<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 PCI_ERR_COR_STATUS,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;info-&gt;status);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 @@ -948,6 +951,7 @@ static inline void<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 aer_process_err_devices(struct aer_err_info *e_=
info)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0;=
 i &lt; e_info-&gt;error_dev_num &amp;&amp;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 e_info-&gt;dev[i]; i++) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 if (get_device_error_info(e_info-<wbr>&gt;dev[i], e_info))<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 handle_error_source(e_info-&gt;d=
e<wbr>v[i],<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 e_info);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0pci_dev_put(e_info-&gt;dev[i]);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 }<br>
<br>
<br>
</div></div></blockquote>
</blockquote></div><br></div>

--00000000000009cb5f0572eab54c--
