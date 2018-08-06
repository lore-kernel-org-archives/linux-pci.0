Return-Path: <SRS0=LX4G=KV=gmail.com=gokuljnpr@kernel.org>
Return-Path: <SRS0=LX4G=KV=gmail.com=gokuljnpr@kernel.org>
MIME-Version: 1.0
In-Reply-To: <ebb526d2-0440-6bd7-765c-b7489d75d830@oracle.com>
References: <dac488604766f3dcb948e702210ecc381c4f907b.1533015755.git.lukas@wunner.de>
 <20180801164358.GI2534@lahna.fi.intel.com> <20180801171512.GA28440@wunner.de>
 <20180802072036.GN2534@lahna.fi.intel.com> <CAFP4jM8AYG7hmkC_rYgXAfLoJmkJuW0e1UbgiayGrCPbb_yw8A@mail.gmail.com>
 <20180802084657.GA21267@wunner.de> <20180802150749.GA31683@wunner.de> <ebb526d2-0440-6bd7-765c-b7489d75d830@oracle.com>
From: gokul cg <gokuljnpr@gmail.com>
Date: Tue, 7 Aug 2018 00:03:37 +0530
Message-ID: <CAFP4jM_hqaHjHx1A4G05cX8p3gQGywkXLf1bNa+6Kpdzb_+bTw@mail.gmail.com>
Subject: Re: [PATCH] PCI: pciehp: Differentiate between surprise and safe removal
To: Thomas Tai <thomas.tai@oracle.com>
Cc: Lukas Wunner <lukas@wunner.de>, Mika Westerberg <mika.westerberg@linux.intel.com>,
	Bjorn Helgaas <helgaas@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
	Keith Busch <keith.busch@intel.com>, Yinghai Lu <yinghai@kernel.org>,
	Sinan Kaya <okaya@kernel.org>, linux-pci@vger.kernel.org,
	Alexandru Gagniuc <mr.nuke.me@gmail.com>
Content-Type: multipart/alternative; boundary="00000000000017f7ac0572c884f6"
List-ID: <linux-pci.vger.kernel.org>

--00000000000017f7ac0572c884f6
Content-Type: text/plain; charset="UTF-8"

Hi,

I have tried with following patch and I am still getting same kernel panic.

-------------X++++++++++++++++++++X---------------------

diff --git a/drivers/pci/pcie/aer/aerdrv_core.c
b/drivers/pci/pcie/aer/aerdrv_core.c
index 0f4554e..05592aa 100644
--- a/drivers/pci/pcie/aer/aerdrv_core.c
+++ b/drivers/pci/pcie/aer/aerdrv_core.c
@@ -26,6 +26,7 @@
 #include <linux/slab.h>
 #include <linux/kfifo.h>
 #include "aerdrv.h"
+#include "../../pci.h"

 static bool forceload;
 static bool nosourceid;
@@ -82,7 +82,7 @@ EXPORT_SYMBOL_GPL(pci_cleanup_aer_uncorrect_error_status);
 static int add_error_device(struct aer_err_info *e_info, struct pci_dev
*dev)
 {
  if (e_info->error_dev_num < AER_MAX_MULTI_ERR_DEVICES) {
- e_info->dev[e_info->error_dev_num] = dev;
+ e_info->dev[e_info->error_dev_num] = pci_dev_get(dev);
  e_info->error_dev_num++;
  return 0;
  }
@@ -659,6 +659,9 @@ static int get_device_error_info(struct pci_dev *dev,
struct aer_err_info *info)
  if (!pos)
  return 1;

+        if (pci_dev_is_disconnected(dev))
+                return 0;
+
  if (info->severity == AER_CORRECTABLE) {
  pci_read_config_dword(dev, pos + PCI_ERR_COR_STATUS,
  &info->status);
@@ -710,6 +713,8 @@ static inline void aer_process_err_devices(struct
pcie_device *p_device,
  for (i = 0; i < e_info->error_dev_num && e_info->dev[i]; i++) {
  if (get_device_error_info(e_info->dev[i], e_info))
  handle_error_source(p_device, e_info->dev[i], e_info);
+
+                pci_dev_put(e_info->dev[i]);
  }
 }
-------------X++++++++++++++++++++X---------------------


Note: I have configured CONFIG_HOTPLUG_PCI_PCIE and CONFIG_HOTPLUG_PCI as
modules and  loading in start up using script.

root@/proc/:~# cat config | grep -i HOT
CONFIG_TICK_ONESHOT=y
CONFIG_HOTPLUG=y
# CONFIG_MEMORY_HOTPLUG is not set
CONFIG_HOTPLUG_CPU=y
# CONFIG_BOOTPARAM_HOTPLUG_CPU0 is not set
# CONFIG_DEBUG_HOTPLUG_CPU0 is not set
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_ACPI_HOTPLUG_CPU=y
CONFIG_HOTPLUG_PCI_PCIE=m
CONFIG_HOTPLUG_PCI=m
# CONFIG_HOTPLUG_PCI_CPCI is not set
# CONFIG_HOTPLUG_PCI_SHPC is not set
CONFIG_DM_SNAPSHOT=y
# CONFIG_USB_STORAGE_JUMPSHOT is not set
# CONFIG_TRACER_SNAPSHOT is not set
root@/proc/:~#

Panic back trace :
crash> bt
PID: 24     TASK: ffff880274ac0000  CPU: 0   COMMAND: "kworker/0:1"
 #0 [ffff880274abbac8] machine_kexec at ffffffff8102cf18
 #1 [ffff880274abbb28] crash_kexec at ffffffff810a6b05
 #2 [ffff880274abbbf0] oops_end at ffffffff8176d8a0
 #3 [ffff880274abbc18] die at ffffffff810060db
 #4 [ffff880274abbc48] do_general_protection at ffffffff8176d392
 #5 [ffff880274abbc70] general_protection at ffffffff8176cd32
    [exception RIP: pci_bus_read_config_dword+100]
    RIP: ffffffff813405f4  RSP: ffff880274abbd20  RFLAGS: 00010046
    RAX: 435f494350006963  RBX: ffff880274891800  RCX: 0000000000000004
    RDX: 0000000000000ffc  RSI: 0000000000000060  RDI: ffff880274891800
    RBP: ffff880274abbd48   R8: ffff880274abbd2c   R9: 00000000000002b8
    R10: ffff880274340000  R11: 0000000000000246  R12: ffff880274abbd5c
    R13: 0000000000000246  R14: 0000000000000000  R15: ffff880274920000
    ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
 #6 [ffff880274abbd50] pci_find_next_ext_capability at ffffffff81345db6
 #7 [ffff880274abbd90] pci_find_ext_capability at ffffffff81347225
 #8 [ffff880274abbda0] get_device_error_info at ffffffff81356c4d
 #9 [ffff880274abbdd0] aer_isr at ffffffff81357ab0
#10 [ffff880274abbe28] process_one_work at ffffffff8105d4c0
#11 [ffff880274abbe70] worker_thread at ffffffff8105e251
#12 [ffff880274abbed0] kthread at ffffffff81064260
#13 [ffff880274abbf50] ret_from_fork at ffffffff81773978
crash>


Regards,
Gokul

On Thu, Aug 2, 2018 at 10:39 PM, Thomas Tai <thomas.tai@oracle.com> wrote:

>
> On 08/02/2018 11:07 AM, Lukas Wunner wrote:
>
>> [cc += Thomas Tai]
>>
>
> Hi Lukas,
> Thank you very much for cc me.
>
>>
>> On Thu, Aug 02, 2018 at 10:46:57AM +0200, Lukas Wunner wrote:
>>
>>> On Thu, Aug 02, 2018 at 12:59:18PM +0530, gokul cg wrote:
>>>
>>>> I am suspecting a possible race condition in the kernel between PCI
>>>> driver
>>>> and AER handling.
>>>>
>>>
>>> The solution is to acquire a ref on each device in add_error_device().
>>> Then release the ref aer_process_err_devices() by calling pci_dev_put().
>>>
>>
>> So in case it wasn't clear, the below is what I had in mind.
>> Completely untested though.  Does this work for you?
>>
>> For v3.10 compatibility, cherry-pick 89ee9f768003 (or alternatively
>> cherry-pick 8496e85c20e7 and replace pci_dev_is_disconnected(dev)
>> with !pci_device_is_present(dev)).
>>
>> -- >8 --
>> Subject: [PATCH] PCI/AER: Fix use-after-free on surprise removal
>>
>> The work item to consume errors, aer_isr(), walks the hierarchy using
>> pci_walk_bus() and stores a pointer to PCI devices which reported an
>> error in an array.  As long as pci_walk_bus() runs, those pointers are
>> valid because pci_bus_sem is held.  But once pci_walk_bus() finishes,
>> nothing prevents the pointers from becoming invalid, e.g. through
>> unplugging of the PCI devices.  The unprotected pointers are then
>> dereferenced in aer_process_err_devices(), which may oops:
>>
>
> I like your idea to increment the refcount during pci_walk_bus(), that
> should fix the use-after-free issue. We just need Gokul to confirm if it
> fixes his issue or not.
>
> Thanks,
> Thomas
>
>
>
>>    #5  general_protection at ffffffff8176cdf2
>>        [exception RIP: pci_bus_read_config_dword+100]
>>    #6  pci_find_next_ext_capability at ffffffff81345d7b
>>    #7  pci_find_ext_capability at ffffffff81347225
>>    #8  get_device_error_info at ffffffff81356c4d
>>    #9  aer_isr at ffffffff81357a38
>>
>> Fix by holding a ref on the devices until they have been processed.
>> Skip processing of unplugged devices.
>>
>> Reported-by: gokul cg <gokuljnpr@gmail.com>
>> Signed-off-by: Lukas Wunner <lukas@wunner.de>
>> ---
>>   drivers/pci/pcie/aer.c | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
>> index a2e8838..937592e 100644
>> --- a/drivers/pci/pcie/aer.c
>> +++ b/drivers/pci/pcie/aer.c
>> @@ -657,7 +657,7 @@ void cper_print_aer(struct pci_dev *dev, int
>> aer_severity,
>>   static int add_error_device(struct aer_err_info *e_info, struct pci_dev
>> *dev)
>>   {
>>         if (e_info->error_dev_num < AER_MAX_MULTI_ERR_DEVICES) {
>> -               e_info->dev[e_info->error_dev_num] = dev;
>> +               e_info->dev[e_info->error_dev_num] = pci_dev_get(dev);
>>                 e_info->error_dev_num++;
>>                 return 0;
>>         }
>> @@ -898,6 +898,9 @@ static int get_device_error_info(struct pci_dev *dev,
>> struct aer_err_info *info)
>>         if (!pos)
>>                 return 0;
>>   +     if (pci_dev_is_disconnected(dev))
>> +               return 0;
>> +
>>         if (info->severity == AER_CORRECTABLE) {
>>                 pci_read_config_dword(dev, pos + PCI_ERR_COR_STATUS,
>>                         &info->status);
>> @@ -948,6 +951,7 @@ static inline void aer_process_err_devices(struct
>> aer_err_info *e_info)
>>         for (i = 0; i < e_info->error_dev_num && e_info->dev[i]; i++) {
>>                 if (get_device_error_info(e_info->dev[i], e_info))
>>                         handle_error_source(e_info->dev[i], e_info);
>> +               pci_dev_put(e_info->dev[i]);
>>         }
>>   }
>>
>>
>

--00000000000017f7ac0572c884f6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>I have tried with following patch a=
nd I am still getting same kernel panic.</div><div><br></div><div><div styl=
e=3D"font-size:small;background-color:rgb(255,255,255);text-decoration-styl=
e:initial;text-decoration-color:initial">-------------X++++++++++++++++++++=
X---------------------</div><br></div><div><div>diff --git a/drivers/pci/pc=
ie/aer/aerdrv_core.c b/drivers/pci/pcie/aer/aerdrv_core.c</div><div>index 0=
f4554e..05592aa 100644</div><div>--- a/drivers/pci/pcie/aer/aerdrv_core.c</=
div><div>+++ b/drivers/pci/pcie/aer/aerdrv_core.c</div><div>@@ -26,6 +26,7 =
@@</div><div>=C2=A0#include &lt;linux/slab.h&gt;</div><div>=C2=A0#include &=
lt;linux/kfifo.h&gt;</div><div>=C2=A0#include &quot;aerdrv.h&quot;</div><di=
v>+#include &quot;../../pci.h&quot;</div><div><br></div><div>=C2=A0static b=
ool forceload;</div><div>=C2=A0static bool nosourceid;</div><div>@@ -82,7 +=
82,7 @@ EXPORT_SYMBOL_GPL(pci_cleanup_aer_uncorrect_error_status);</div><di=
v>=C2=A0static int add_error_device(struct aer_err_info *e_info, struct pci=
_dev *dev)</div><div>=C2=A0{</div><div>=C2=A0<span style=3D"white-space:pre=
">	</span>if (e_info-&gt;error_dev_num &lt; AER_MAX_MULTI_ERR_DEVICES) {</d=
iv><div>-<span style=3D"white-space:pre">		</span>e_info-&gt;dev[e_info-&gt=
;error_dev_num] =3D dev;</div><div>+<span style=3D"white-space:pre">		</spa=
n>e_info-&gt;dev[e_info-&gt;error_dev_num] =3D pci_dev_get(dev);</div><div>=
=C2=A0<span style=3D"white-space:pre">		</span>e_info-&gt;error_dev_num++;<=
/div><div>=C2=A0<span style=3D"white-space:pre">		</span>return 0;</div><di=
v>=C2=A0<span style=3D"white-space:pre">	</span>}</div><div>@@ -659,6 +659,=
9 @@ static int get_device_error_info(struct pci_dev *dev, struct aer_err_i=
nfo *info)</div><div>=C2=A0<span style=3D"white-space:pre">	</span>if (!pos=
)</div><div>=C2=A0<span style=3D"white-space:pre">		</span>return 1;</div><=
div><br></div><div>+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (pci_dev_is_disconnected=
(dev))</div><div>+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 r=
eturn 0;</div><div>+</div><div>=C2=A0<span style=3D"white-space:pre">	</spa=
n>if (info-&gt;severity =3D=3D AER_CORRECTABLE) {</div><div>=C2=A0<span sty=
le=3D"white-space:pre">		</span>pci_read_config_dword(dev, pos + PCI_ERR_CO=
R_STATUS,</div><div>=C2=A0<span style=3D"white-space:pre">			</span>&amp;in=
fo-&gt;status);</div><div>@@ -710,6 +713,8 @@ static inline void aer_proces=
s_err_devices(struct pcie_device *p_device,</div><div>=C2=A0<span style=3D"=
white-space:pre">	</span>for (i =3D 0; i &lt; e_info-&gt;error_dev_num &amp=
;&amp; e_info-&gt;dev[i]; i++) {</div><div>=C2=A0<span style=3D"white-space=
:pre">		</span>if (get_device_error_info(e_info-&gt;dev[i], e_info))</div><=
div>=C2=A0<span style=3D"white-space:pre">			</span>handle_error_source(p_d=
evice, e_info-&gt;dev[i], e_info);</div><div>+</div><div>+=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pci_dev_put(e_info-&gt;dev[i]);</div=
><div>=C2=A0<span style=3D"white-space:pre">	</span>}</div><div>=C2=A0}</di=
v><div>-------------X++++++++++++++++++++X---------------------</div><div><=
br></div></div><div><br></div><div>Note: I have configured=C2=A0<span style=
=3D"font-size:small;background-color:rgb(255,255,255);text-decoration-style=
:initial;text-decoration-color:initial;float:none;display:inline">CONFIG_HO=
TPLUG_PCI_PCIE and=C2=A0<span style=3D"text-decoration-style:initial;text-d=
ecoration-color:initial;float:none;display:inline">CONFIG_HOTPLUG_PCI as mo=
dules and=C2=A0 loading in start up using script.=C2=A0</span></span></div>=
<div><span style=3D"font-size:small;background-color:rgb(255,255,255);text-=
decoration-style:initial;text-decoration-color:initial;float:none;display:i=
nline"><span style=3D"text-decoration-style:initial;text-decoration-color:i=
nitial;float:none;display:inline"><br></span></span></div><div>root@/proc/:=
~# cat config | grep -i HOT</div><div>CONFIG_TICK_ONESHOT=3Dy</div><div>CON=
FIG_HOTPLUG=3Dy</div><div># CONFIG_MEMORY_HOTPLUG is not set</div><div>CONF=
IG_HOTPLUG_CPU=3Dy</div><div># CONFIG_BOOTPARAM_HOTPLUG_CPU0 is not set</di=
v><div># CONFIG_DEBUG_HOTPLUG_CPU0 is not set</div><div>CONFIG_ARCH_ENABLE_=
MEMORY_HOTPLUG=3Dy</div><div>CONFIG_ACPI_HOTPLUG_CPU=3Dy</div><div>CONFIG_H=
OTPLUG_PCI_PCIE=3Dm</div><div>CONFIG_HOTPLUG_PCI=3Dm</div><div># CONFIG_HOT=
PLUG_PCI_CPCI is not set</div><div># CONFIG_HOTPLUG_PCI_SHPC is not set</di=
v><div>CONFIG_DM_SNAPSHOT=3Dy</div><div># CONFIG_USB_STORAGE_JUMPSHOT is no=
t set</div><div># CONFIG_TRACER_SNAPSHOT is not set</div><div>root@/proc/:~=
#</div><div><br></div><div>Panic back trace :</div><div><div>crash&gt; bt</=
div><div>PID: 24=C2=A0 =C2=A0 =C2=A0TASK: ffff880274ac0000=C2=A0 CPU: 0=C2=
=A0 =C2=A0COMMAND: &quot;kworker/0:1&quot;</div><div>=C2=A0#0 [ffff880274ab=
bac8] machine_kexec at ffffffff8102cf18</div><div>=C2=A0#1 [ffff880274abbb2=
8] crash_kexec at ffffffff810a6b05</div><div>=C2=A0#2 [ffff880274abbbf0] oo=
ps_end at ffffffff8176d8a0</div><div>=C2=A0#3 [ffff880274abbc18] die at fff=
fffff810060db</div><div>=C2=A0#4 [ffff880274abbc48] do_general_protection a=
t ffffffff8176d392</div><div>=C2=A0#5 [ffff880274abbc70] general_protection=
 at ffffffff8176cd32</div><div>=C2=A0 =C2=A0 [exception RIP: pci_bus_read_c=
onfig_dword+100]</div><div>=C2=A0 =C2=A0 RIP: ffffffff813405f4=C2=A0 RSP: f=
fff880274abbd20=C2=A0 RFLAGS: 00010046</div><div>=C2=A0 =C2=A0 RAX: 435f494=
350006963=C2=A0 RBX: ffff880274891800=C2=A0 RCX: 0000000000000004</div><div=
>=C2=A0 =C2=A0 RDX: 0000000000000ffc=C2=A0 RSI: 0000000000000060=C2=A0 RDI:=
 ffff880274891800</div><div>=C2=A0 =C2=A0 RBP: ffff880274abbd48=C2=A0 =C2=
=A0R8: ffff880274abbd2c=C2=A0 =C2=A0R9: 00000000000002b8</div><div>=C2=A0 =
=C2=A0 R10: ffff880274340000=C2=A0 R11: 0000000000000246=C2=A0 R12: ffff880=
274abbd5c</div><div>=C2=A0 =C2=A0 R13: 0000000000000246=C2=A0 R14: 00000000=
00000000=C2=A0 R15: ffff880274920000</div><div>=C2=A0 =C2=A0 ORIG_RAX: ffff=
ffffffffffff=C2=A0 CS: 0010=C2=A0 SS: 0018</div><div>=C2=A0#6 [ffff880274ab=
bd50] pci_find_next_ext_capability at ffffffff81345db6</div><div>=C2=A0#7 [=
ffff880274abbd90] pci_find_ext_capability at ffffffff81347225</div><div>=C2=
=A0#8 [ffff880274abbda0] get_device_error_info at ffffffff81356c4d</div><di=
v>=C2=A0#9 [ffff880274abbdd0] aer_isr at ffffffff81357ab0</div><div>#10 [ff=
ff880274abbe28] process_one_work at ffffffff8105d4c0</div><div>#11 [ffff880=
274abbe70] worker_thread at ffffffff8105e251</div><div>#12 [ffff880274abbed=
0] kthread at ffffffff81064260</div><div>#13 [ffff880274abbf50] ret_from_fo=
rk at ffffffff81773978</div><div>crash&gt;</div></div><div><br></div><div><=
br></div><div>Regards,</div><div>Gokul=C2=A0</div></div><div class=3D"gmail=
_extra"><br><div class=3D"gmail_quote">On Thu, Aug 2, 2018 at 10:39 PM, Tho=
mas Tai <span dir=3D"ltr">&lt;<a href=3D"mailto:thomas.tai@oracle.com" targ=
et=3D"_blank">thomas.tai@oracle.com</a>&gt;</span> wrote:<br><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;p=
adding-left:1ex"><br>
On 08/02/2018 11:07 AM, Lukas Wunner wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
[cc +=3D Thomas Tai]<br>
</blockquote>
<br>
Hi Lukas,<br>
Thank you very much for cc me.<span class=3D""><br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
<br>
On Thu, Aug 02, 2018 at 10:46:57AM +0200, Lukas Wunner wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
On Thu, Aug 02, 2018 at 12:59:18PM +0530, gokul cg wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
I am suspecting a possible race condition in the kernel between PCI driver<=
br>
and AER handling.<br>
</blockquote>
<br>
The solution is to acquire a ref on each device in add_error_device().<br>
Then release the ref aer_process_err_devices() by calling pci_dev_put().<br=
>
</blockquote>
<br>
So in case it wasn&#39;t clear, the below is what I had in mind.<br>
Completely untested though.=C2=A0 Does this work for you?<br>
<br>
For v3.10 compatibility, cherry-pick 89ee9f768003 (or alternatively<br>
cherry-pick 8496e85c20e7 and replace pci_dev_is_disconnected(dev)<br>
with !pci_device_is_present(dev)).<br>
<br>
-- &gt;8 --<br>
Subject: [PATCH] PCI/AER: Fix use-after-free on surprise removal<br>
<br>
The work item to consume errors, aer_isr(), walks the hierarchy using<br>
pci_walk_bus() and stores a pointer to PCI devices which reported an<br>
error in an array.=C2=A0 As long as pci_walk_bus() runs, those pointers are=
<br>
valid because pci_bus_sem is held.=C2=A0 But once pci_walk_bus() finishes,<=
br>
nothing prevents the pointers from becoming invalid, e.g. through<br>
unplugging of the PCI devices.=C2=A0 The unprotected pointers are then<br>
dereferenced in aer_process_err_devices(), which may oops:<br>
</blockquote>
<br></span>
I like your idea to increment the refcount during pci_walk_bus(), that shou=
ld fix the use-after-free issue. We just need Gokul to confirm if it fixes =
his issue or not.<br>
<br>
Thanks,<br>
Thomas<div class=3D"HOEnZb"><div class=3D"h5"><br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
<br>
=C2=A0 =C2=A0#5=C2=A0 general_protection at ffffffff8176cdf2<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0[exception RIP: pci_bus_read_config_dword+100]<b=
r>
=C2=A0 =C2=A0#6=C2=A0 pci_find_next_ext_capability at ffffffff81345d7b<br>
=C2=A0 =C2=A0#7=C2=A0 pci_find_ext_capability at ffffffff81347225<br>
=C2=A0 =C2=A0#8=C2=A0 get_device_error_info at ffffffff81356c4d<br>
=C2=A0 =C2=A0#9=C2=A0 aer_isr at ffffffff81357a38<br>
<br>
Fix by holding a ref on the devices until they have been processed.<br>
Skip processing of unplugged devices.<br>
<br>
Reported-by: gokul cg &lt;<a href=3D"mailto:gokuljnpr@gmail.com" target=3D"=
_blank">gokuljnpr@gmail.com</a>&gt;<br>
Signed-off-by: Lukas Wunner &lt;<a href=3D"mailto:lukas@wunner.de" target=
=3D"_blank">lukas@wunner.de</a>&gt;<br>
---<br>
=C2=A0 drivers/pci/pcie/aer.c | 6 +++++-<br>
=C2=A0 1 file changed, 5 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c<br>
index a2e8838..937592e 100644<br>
--- a/drivers/pci/pcie/aer.c<br>
+++ b/drivers/pci/pcie/aer.c<br>
@@ -657,7 +657,7 @@ void cper_print_aer(struct pci_dev *dev, int aer_severi=
ty,<br>
=C2=A0 static int add_error_device(struct aer_err_info *e_info, struct pci_=
dev *dev)<br>
=C2=A0 {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (e_info-&gt;error_dev_num &lt; AER_MAX_MULTI=
_ERR_DEVICES) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0e_info-&gt;dev[e_in=
fo-&gt;error_<wbr>dev_num] =3D dev;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0e_info-&gt;dev[e_in=
fo-&gt;error_<wbr>dev_num] =3D pci_dev_get(dev);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 e_info-&gt;error_de=
v_num++;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
@@ -898,6 +898,9 @@ static int get_device_error_info(struct pci_dev *dev, s=
truct aer_err_info *info)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!pos)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
=C2=A0 +=C2=A0 =C2=A0 =C2=A0if (pci_dev_is_disconnected(dev))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (info-&gt;severity =3D=3D AER_CORRECTABLE) {=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pci_read_config_dwo=
rd(dev, pos + PCI_ERR_COR_STATUS,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &amp;info-&gt;status);<br>
@@ -948,6 +951,7 @@ static inline void aer_process_err_devices(struct aer_e=
rr_info *e_info)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i &lt; e_info-&gt;error_dev_num &=
amp;&amp; e_info-&gt;dev[i]; i++) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (get_device_erro=
r_info(e_info-<wbr>&gt;dev[i], e_info))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 handle_error_source(e_info-&gt;de<wbr>v[i], e_info);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pci_dev_put(e_info-=
&gt;dev[i]);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 }<br>
=C2=A0 <br>
</blockquote>
</div></div></blockquote></div><br></div>

--00000000000017f7ac0572c884f6--
