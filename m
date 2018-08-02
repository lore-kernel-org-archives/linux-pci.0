Return-Path: <SRS0=+XN2=KR=gmail.com=gokuljnpr@kernel.org>
Return-Path: <SRS0=+XN2=KR=gmail.com=gokuljnpr@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180802072036.GN2534@lahna.fi.intel.com>
References: <dac488604766f3dcb948e702210ecc381c4f907b.1533015755.git.lukas@wunner.de>
 <20180801164358.GI2534@lahna.fi.intel.com> <20180801171512.GA28440@wunner.de> <20180802072036.GN2534@lahna.fi.intel.com>
From: gokul cg <gokuljnpr@gmail.com>
Date: Thu, 2 Aug 2018 12:59:18 +0530
Message-ID: <CAFP4jM8AYG7hmkC_rYgXAfLoJmkJuW0e1UbgiayGrCPbb_yw8A@mail.gmail.com>
Subject: Re: [PATCH] PCI: pciehp: Differentiate between surprise and safe removal
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
	Keith Busch <keith.busch@intel.com>, Yinghai Lu <yinghai@kernel.org>,
	Sinan Kaya <okaya@kernel.org>, linux-pci@vger.kernel.org,
	Alexandru Gagniuc <mr.nuke.me@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000e724d705726ec4ae"
List-ID: <linux-pci.vger.kernel.org>

--000000000000e724d705726ec4ae
Content-Type: text/plain; charset="UTF-8"

Hi ,

>After the pci_dev is removed from the
>> hierarchy, accessing it seems at least questionable.

What about AER driver .  I was discussing the same in another mail chain
with subject  "Possible race condition in the kernel between PCI driver and
AER handling"

Regards
Gokul,

--------------------FYI---------------

I am suspecting a possible race condition in the kernel between PCI driver
and AER handling.

Because of the same kernel panic happens from worker thread which handles
bottom half of aer irq.


I am seeing this issue when I suddenly power off PCI card which
supports/enabled PCIE AER error reporting.

While powering off PCI device, AER driver will get AER IRQ for the device,
from AER IRQ handler, it will cache AER error code and schedule worker
thread to handle error.

The PCIe device will get removed from PCI tree before worker thread
completes its task and kernel panic is  happening when worker thread tries
to access PCI device's config space.


Issue:

crash>

crash> bt

PID: 2727   TASK: ffff880272adc530  CPU: 0   COMMAND: "kworker/0:2"

#0 [ffff88027469fac8] machine_kexec at ffffffff8102cf18

#1 [ffff88027469fb28] crash_kexec at ffffffff810a6b05

#2 [ffff88027469fbf0] oops_end at ffffffff8176d960

#3 [ffff88027469fc18] die at ffffffff810060db

#4 [ffff88027469fc48] do_general_protection at ffffffff8176d452

#5 [ffff88027469fc70] general_protection at ffffffff8176cdf2

    [exception RIP: pci_bus_read_config_dword+100]

    RIP: ffffffff813405f4  RSP: ffff88027469fd20  RFLAGS: 00010046

    RAX: 435f494350006963  RBX: ffff880274892000  RCX: 0000000000000004

    RDX: 0000000000000100  RSI: 0000000000000060  RDI: ffff880274892000

    RBP: ffff88027469fd48   R8: ffff88027469fd2c   R9: 00000000000012c0

    R10: 0000000000000006  R11: 00000000000012bf  R12: ffff88027469fd5c

    R13: 0000000000000246  R14: 0000000000000000  R15: ffff8802741a4000

    ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0000

#6 [ffff88027469fd50] pci_find_next_ext_capability at ffffffff81345d7b

#7 [ffff88027469fd90] pci_find_ext_capability at ffffffff81347225

#8 [ffff88027469fda0] get_device_error_info at ffffffff81356c4d

#9 [ffff88027469fdd0] aer_isr at ffffffff81357a38

#10 [ffff88027469fe28] process_one_work at ffffffff8105d4c0

#11 [ffff88027469fe70] worker_thread at ffffffff8105e251

#12 [ffff88027469fed0] kthread at ffffffff81064260

#13 [ffff88027469ff50] ret_from_fork at ffffffff81773a38


crash>


I have tested it on kernel 3.10 . But from source i could see that this
case is still relevant for latest Linux source .

--------------------END--------------

On Thu, Aug 2, 2018 at 12:50 PM, Mika Westerberg <
mika.westerberg@linux.intel.com> wrote:

> On Wed, Aug 01, 2018 at 07:15:12PM +0200, Lukas Wunner wrote:
> > On Wed, Aug 01, 2018 at 07:43:58PM +0300, Mika Westerberg wrote:
> > > On Tue, Jul 31, 2018 at 07:50:37AM +0200, Lukas Wunner wrote:
> > > > -static void remove_board(struct slot *p_slot)
> > > > +static void remove_board(struct slot *p_slot, bool safe_removal)
> > > >  {
> > > >   struct controller *ctrl = p_slot->ctrl;
> > > >
> > > > - pciehp_unconfigure_device(p_slot);
> > > > + pciehp_unconfigure_device(p_slot, safe_removal);
> > >
> > > Below we turn off power to the slot if it has power controller. Even if
> > > we disable slot from sysfs, I think it ends up being inaccessible after
> > > power is turned off. I wonder if we should mark the devices
> disconnected
> > > in that case as well?
> > >
> > > >
> > > >   if (POWER_CTRL(ctrl)) {
> > > >           pciehp_power_off_slot(p_slot);
> >
> > No, when pciehp_unconfigure_device() returns, the PCI devices below
> > the hotplug bridge are unbound and removed from the system.  They're
> > gone, so the bit set in their pci_dev struct would no longer be
> > accessible anyway.  Unless of course something is holding a ref on
> > the pci_dev, but that would seem to be a bug.  (Accessing a device
> > that's already removed from the system, that is.)
> >
> > Calling pci_dev_set_disconnected() only gives the PCI core and the
> > driver bound to the device an indication that's it's inaccessible,
> > so any code paths during unbound and PCI device teardown can skip
> > accesses.  (Because pci_dev_is_disconnected() is currently scoped
> > to the PCI core, the disconnected status can only be queried from
> > drivers that live in the PCI core, such as portdrv and all the
> > port services drivers.)  After the pci_dev is removed from the
> > hierarchy, accessing it seems at least questionable.
> >
> > Does this make things clearer?  Shout if it not. :-)
>
> Yes it does. Thank you :)
>

--000000000000e724d705726ec4ae
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi ,<div><br></div><div>&gt;<span style=3D"font-size:small=
;background-color:rgb(255,255,255);text-decoration-style:initial;text-decor=
ation-color:initial;float:none;display:inline">After the pci_dev is removed=
 from the</span><br style=3D"font-size:small;background-color:rgb(255,255,2=
55);text-decoration-style:initial;text-decoration-color:initial"><span styl=
e=3D"font-size:small;background-color:rgb(255,255,255);text-decoration-styl=
e:initial;text-decoration-color:initial;float:none;display:inline">&gt;&gt;=
 hierarchy, accessing it seems at least questionable.</span></div><div><br>=
</div><div>What about AER driver .=C2=A0 I was discussing the same in anoth=
er mail chain with subject=C2=A0 &quot;<span style=3D"background-color:rgb(=
255,255,255);text-decoration-style:initial;text-decoration-color:initial;fl=
oat:none;display:inline">Possible race condition in the kernel between PCI =
driver and AER handling&quot;</span></div><div><span style=3D"background-co=
lor:rgb(255,255,255);text-decoration-style:initial;text-decoration-color:in=
itial;float:none;display:inline"><br></span></div><div><span style=3D"backg=
round-color:rgb(255,255,255);text-decoration-style:initial;text-decoration-=
color:initial;float:none;display:inline">Regards</span></div><div><span sty=
le=3D"background-color:rgb(255,255,255);text-decoration-style:initial;text-=
decoration-color:initial;float:none;display:inline">Gokul,</span></div><div=
><span style=3D"background-color:rgb(255,255,255);text-decoration-style:ini=
tial;text-decoration-color:initial;float:none;display:inline"><br></span></=
div><div><span style=3D"background-color:rgb(255,255,255);text-decoration-s=
tyle:initial;text-decoration-color:initial;float:none;display:inline">-----=
---------------FYI---------------</span></div><div><span style=3D"backgroun=
d-color:rgb(255,255,255);text-decoration-style:initial;text-decoration-colo=
r:initial;float:none;display:inline"><p class=3D"gmail-m_643708960377074881=
2gmail-p1" style=3D"font-variant-numeric:normal;font-variant-east-asian:nor=
mal;font-stretch:normal;font-size:12.8px;line-height:normal;text-decoration=
-style:initial;text-decoration-color:initial;margin:0px"><span style=3D"fon=
t-size:12px;font-family:Helvetica"><span>I=C2=A0</span>am suspecting a poss=
ible race condition in the kernel between PCI driver and AER handling.</spa=
n><br></p><p class=3D"gmail-m_6437089603770748812gmail-p1" style=3D"font-va=
riant-numeric:normal;font-variant-east-asian:normal;font-stretch:normal;fon=
t-size:12.8px;line-height:normal;text-decoration-style:initial;text-decorat=
ion-color:initial;margin:0px"><font face=3D"Helvetica"><span style=3D"font-=
size:12px">Because of the same kernel panic happens from worker thread whic=
h handles bottom half of aer irq.</span></font></p><p class=3D"gmail-m_6437=
089603770748812gmail-p1" style=3D"font-variant-numeric:normal;font-variant-=
east-asian:normal;font-stretch:normal;font-size:12.8px;line-height:normal;t=
ext-decoration-style:initial;text-decoration-color:initial;margin:0px"><fon=
t face=3D"Helvetica"><span style=3D"font-size:12px"><br></span></font></p><=
p class=3D"gmail-m_6437089603770748812gmail-p1" style=3D"font-variant-numer=
ic:normal;font-variant-east-asian:normal;font-stretch:normal;font-size:12.8=
px;line-height:normal;text-decoration-style:initial;text-decoration-color:i=
nitial;margin:0px"><font face=3D"Helvetica"><span style=3D"font-size:12px">=
I am seeing this issue when I suddenly power off PCI card which supports/en=
abled PCIE AER error reporting.</span></font></p><p class=3D"gmail-m_643708=
9603770748812gmail-p1" style=3D"font-variant-numeric:normal;font-variant-ea=
st-asian:normal;font-stretch:normal;font-size:12.8px;line-height:normal;tex=
t-decoration-style:initial;text-decoration-color:initial;margin:0px"><font =
face=3D"Helvetica"><span style=3D"font-size:12px">While powering off PCI de=
vice, AER driver will get AER IRQ for the device, from AER IRQ handler, it =
will cache AER error code and schedule worker thread to handle error.</span=
></font></p><p class=3D"gmail-m_6437089603770748812gmail-p1" style=3D"font-=
variant-numeric:normal;font-variant-east-asian:normal;font-stretch:normal;f=
ont-size:12.8px;line-height:normal;text-decoration-style:initial;text-decor=
ation-color:initial;margin:0px"><font face=3D"Helvetica"><span style=3D"fon=
t-size:12px">The PCIe device will get removed from PCI tree before worker t=
hread completes its task and kernel panic is=C2=A0 happening when worker th=
read tries to access PCI device&#39;s config space.</span></font></p><p cla=
ss=3D"gmail-m_6437089603770748812gmail-p1" style=3D"font-variant-numeric:no=
rmal;font-variant-east-asian:normal;font-stretch:normal;font-size:12.8px;li=
ne-height:normal;text-decoration-style:initial;text-decoration-color:initia=
l;margin:0px"><br></p><p class=3D"gmail-m_6437089603770748812gmail-p1" styl=
e=3D"font-variant-numeric:normal;font-variant-east-asian:normal;font-stretc=
h:normal;font-size:small;line-height:normal;text-decoration-style:initial;t=
ext-decoration-color:initial;margin:0px"><font face=3D"Helvetica"><span sty=
le=3D"font-size:12px">Issue:</span></font></p><br class=3D"gmail-m_64370896=
03770748812gmail-Apple-interchange-newline" style=3D"font-size:12.8px;text-=
decoration-style:initial;text-decoration-color:initial"><p class=3D"gmail-m=
_6437089603770748812gmail-p1" style=3D"font-variant-numeric:normal;font-var=
iant-east-asian:normal;font-stretch:normal;font-size:12.8px;line-height:nor=
mal;text-decoration-style:initial;text-decoration-color:initial;margin:0px"=
><font face=3D"Helvetica"><span style=3D"font-size:12px">crash&gt;</span></=
font></p><p class=3D"gmail-m_6437089603770748812gmail-p1" style=3D"font-var=
iant-numeric:normal;font-variant-east-asian:normal;font-stretch:normal;font=
-size:12.8px;line-height:normal;text-decoration-style:initial;text-decorati=
on-color:initial;margin:0px"><font face=3D"Helvetica"><span style=3D"font-s=
ize:12px">crash&gt; bt</span></font></p><p class=3D"gmail-m_643708960377074=
8812gmail-p1" style=3D"font-variant-numeric:normal;font-variant-east-asian:=
normal;font-stretch:normal;font-size:12.8px;line-height:normal;text-decorat=
ion-style:initial;text-decoration-color:initial;margin:0px"><font face=3D"H=
elvetica"><span style=3D"font-size:12px">PID: 2727=C2=A0 =C2=A0TASK: ffff88=
0272adc530=C2=A0 CPU: 0=C2=A0 =C2=A0COMMAND: &quot;kworker/0:2&quot;</span>=
</font></p><p class=3D"gmail-m_6437089603770748812gmail-p1" style=3D"font-v=
ariant-numeric:normal;font-variant-east-asian:normal;font-stretch:normal;fo=
nt-size:12.8px;line-height:normal;text-decoration-style:initial;text-decora=
tion-color:initial;margin:0px"><font face=3D"Helvetica"><span style=3D"font=
-size:12px">#0 [ffff88027469fac8] machine_kexec at ffffffff8102cf18</span><=
/font></p><p class=3D"gmail-m_6437089603770748812gmail-p1" style=3D"font-va=
riant-numeric:normal;font-variant-east-asian:normal;font-stretch:normal;fon=
t-size:12.8px;line-height:normal;text-decoration-style:initial;text-decorat=
ion-color:initial;margin:0px"><font face=3D"Helvetica"><span style=3D"font-=
size:12px">#1 [ffff88027469fb28] crash_kexec at ffffffff810a6b05</span></fo=
nt></p><p class=3D"gmail-m_6437089603770748812gmail-p1" style=3D"font-varia=
nt-numeric:normal;font-variant-east-asian:normal;font-stretch:normal;font-s=
ize:12.8px;line-height:normal;text-decoration-style:initial;text-decoration=
-color:initial;margin:0px"><font face=3D"Helvetica"><span style=3D"font-siz=
e:12px">#2 [ffff88027469fbf0] oops_end at ffffffff8176d960</span></font></p=
><p class=3D"gmail-m_6437089603770748812gmail-p1" style=3D"font-variant-num=
eric:normal;font-variant-east-asian:normal;font-stretch:normal;font-size:12=
.8px;line-height:normal;text-decoration-style:initial;text-decoration-color=
:initial;margin:0px"><font face=3D"Helvetica"><span style=3D"font-size:12px=
">#3 [ffff88027469fc18] die at ffffffff810060db</span></font></p><p class=
=3D"gmail-m_6437089603770748812gmail-p1" style=3D"font-variant-numeric:norm=
al;font-variant-east-asian:normal;font-stretch:normal;font-size:12.8px;line=
-height:normal;text-decoration-style:initial;text-decoration-color:initial;=
margin:0px"><font face=3D"Helvetica"><span style=3D"font-size:12px">#4 [fff=
f88027469fc48] do_general_protection at ffffffff8176d452</span></font></p><=
p class=3D"gmail-m_6437089603770748812gmail-p1" style=3D"font-variant-numer=
ic:normal;font-variant-east-asian:normal;font-stretch:normal;font-size:12.8=
px;line-height:normal;text-decoration-style:initial;text-decoration-color:i=
nitial;margin:0px"><font face=3D"Helvetica"><span style=3D"font-size:12px">=
#5 [ffff88027469fc70] general_protection at ffffffff8176cdf2</span></font><=
/p><p class=3D"gmail-m_6437089603770748812gmail-p1" style=3D"font-variant-n=
umeric:normal;font-variant-east-asian:normal;font-stretch:normal;font-size:=
12.8px;line-height:normal;text-decoration-style:initial;text-decoration-col=
or:initial;margin:0px"><font face=3D"Helvetica"><span style=3D"font-size:12=
px">=C2=A0 =C2=A0 [exception RIP: pci_bus_read_config_dword+100]</span></fo=
nt></p><p class=3D"gmail-m_6437089603770748812gmail-p1" style=3D"font-varia=
nt-numeric:normal;font-variant-east-asian:normal;font-stretch:normal;font-s=
ize:12.8px;line-height:normal;text-decoration-style:initial;text-decoration=
-color:initial;margin:0px"><font face=3D"Helvetica"><span style=3D"font-siz=
e:12px">=C2=A0 =C2=A0 RIP: ffffffff813405f4=C2=A0 RSP: ffff88027469fd20=C2=
=A0 RFLAGS: 00010046</span></font></p><p class=3D"gmail-m_64370896037707488=
12gmail-p1" style=3D"font-variant-numeric:normal;font-variant-east-asian:no=
rmal;font-stretch:normal;font-size:12.8px;line-height:normal;text-decoratio=
n-style:initial;text-decoration-color:initial;margin:0px"><font face=3D"Hel=
vetica"><span style=3D"font-size:12px">=C2=A0 =C2=A0 RAX: 435f494350006963=
=C2=A0 RBX: ffff880274892000=C2=A0 RCX: 0000000000000004</span></font></p><=
p class=3D"gmail-m_6437089603770748812gmail-p1" style=3D"font-variant-numer=
ic:normal;font-variant-east-asian:normal;font-stretch:normal;font-size:12.8=
px;line-height:normal;text-decoration-style:initial;text-decoration-color:i=
nitial;margin:0px"><font face=3D"Helvetica"><span style=3D"font-size:12px">=
=C2=A0 =C2=A0 RDX: 0000000000000100=C2=A0 RSI: 0000000000000060=C2=A0 RDI: =
ffff880274892000</span></font></p><p class=3D"gmail-m_6437089603770748812gm=
ail-p1" style=3D"font-variant-numeric:normal;font-variant-east-asian:normal=
;font-stretch:normal;font-size:12.8px;line-height:normal;text-decoration-st=
yle:initial;text-decoration-color:initial;margin:0px"><font face=3D"Helveti=
ca"><span style=3D"font-size:12px">=C2=A0 =C2=A0 RBP: ffff88027469fd48=C2=
=A0 =C2=A0R8: ffff88027469fd2c=C2=A0 =C2=A0R9: 00000000000012c0</span></fon=
t></p><p class=3D"gmail-m_6437089603770748812gmail-p1" style=3D"font-varian=
t-numeric:normal;font-variant-east-asian:normal;font-stretch:normal;font-si=
ze:12.8px;line-height:normal;text-decoration-style:initial;text-decoration-=
color:initial;margin:0px"><font face=3D"Helvetica"><span style=3D"font-size=
:12px">=C2=A0 =C2=A0 R10: 0000000000000006=C2=A0 R11: 00000000000012bf=C2=
=A0 R12: ffff88027469fd5c</span></font></p><p class=3D"gmail-m_643708960377=
0748812gmail-p1" style=3D"font-variant-numeric:normal;font-variant-east-asi=
an:normal;font-stretch:normal;font-size:12.8px;line-height:normal;text-deco=
ration-style:initial;text-decoration-color:initial;margin:0px"><font face=
=3D"Helvetica"><span style=3D"font-size:12px">=C2=A0 =C2=A0 R13: 0000000000=
000246=C2=A0 R14: 0000000000000000=C2=A0 R15: ffff8802741a4000</span></font=
></p><p class=3D"gmail-m_6437089603770748812gmail-p1" style=3D"font-variant=
-numeric:normal;font-variant-east-asian:normal;font-stretch:normal;font-siz=
e:12.8px;line-height:normal;text-decoration-style:initial;text-decoration-c=
olor:initial;margin:0px"><font face=3D"Helvetica"><span style=3D"font-size:=
12px">=C2=A0 =C2=A0 ORIG_RAX: ffffffffffffffff=C2=A0 CS: 0010=C2=A0 SS: 000=
0</span></font></p><p class=3D"gmail-m_6437089603770748812gmail-p1" style=
=3D"font-variant-numeric:normal;font-variant-east-asian:normal;font-stretch=
:normal;font-size:12.8px;line-height:normal;text-decoration-style:initial;t=
ext-decoration-color:initial;margin:0px"><font face=3D"Helvetica"><span sty=
le=3D"font-size:12px">#6 [ffff88027469fd50] pci_find_next_ext_capability at=
 ffffffff81345d7b</span></font></p><p class=3D"gmail-m_6437089603770748812g=
mail-p1" style=3D"font-variant-numeric:normal;font-variant-east-asian:norma=
l;font-stretch:normal;font-size:12.8px;line-height:normal;text-decoration-s=
tyle:initial;text-decoration-color:initial;margin:0px"><font face=3D"Helvet=
ica"><span style=3D"font-size:12px">#7 [ffff88027469fd90] pci_find_ext_capa=
bility at ffffffff81347225</span></font></p><p class=3D"gmail-m_64370896037=
70748812gmail-p1" style=3D"font-variant-numeric:normal;font-variant-east-as=
ian:normal;font-stretch:normal;font-size:12.8px;line-height:normal;text-dec=
oration-style:initial;text-decoration-color:initial;margin:0px"><font face=
=3D"Helvetica"><span style=3D"font-size:12px">#8 [ffff88027469fda0] get_dev=
ice_error_info at ffffffff81356c4d</span></font></p><p class=3D"gmail-m_643=
7089603770748812gmail-p1" style=3D"font-variant-numeric:normal;font-variant=
-east-asian:normal;font-stretch:normal;font-size:12.8px;line-height:normal;=
text-decoration-style:initial;text-decoration-color:initial;margin:0px"><fo=
nt face=3D"Helvetica"><span style=3D"font-size:12px">#9 [ffff88027469fdd0] =
aer_isr at ffffffff81357a38</span></font></p><p class=3D"gmail-m_6437089603=
770748812gmail-p1" style=3D"font-variant-numeric:normal;font-variant-east-a=
sian:normal;font-stretch:normal;font-size:12.8px;line-height:normal;text-de=
coration-style:initial;text-decoration-color:initial;margin:0px"><font face=
=3D"Helvetica"><span style=3D"font-size:12px">#10 [ffff88027469fe28] proces=
s_one_work at ffffffff8105d4c0</span></font></p><p class=3D"gmail-m_6437089=
603770748812gmail-p1" style=3D"font-variant-numeric:normal;font-variant-eas=
t-asian:normal;font-stretch:normal;font-size:12.8px;line-height:normal;text=
-decoration-style:initial;text-decoration-color:initial;margin:0px"><font f=
ace=3D"Helvetica"><span style=3D"font-size:12px">#11 [ffff88027469fe70] wor=
ker_thread at ffffffff8105e251</span></font></p><p class=3D"gmail-m_6437089=
603770748812gmail-p1" style=3D"font-variant-numeric:normal;font-variant-eas=
t-asian:normal;font-stretch:normal;font-size:12.8px;line-height:normal;text=
-decoration-style:initial;text-decoration-color:initial;margin:0px"><font f=
ace=3D"Helvetica"><span style=3D"font-size:12px">#12 [ffff88027469fed0] kth=
read at ffffffff81064260</span></font></p><p class=3D"gmail-m_6437089603770=
748812gmail-p1" style=3D"font-variant-numeric:normal;font-variant-east-asia=
n:normal;font-stretch:normal;font-size:12.8px;line-height:normal;text-decor=
ation-style:initial;text-decoration-color:initial;margin:0px"><font face=3D=
"Helvetica"><span style=3D"font-size:12px">#13 [ffff88027469ff50] ret_from_=
fork at ffffffff81773a38</span></font></p><p class=3D"gmail-m_6437089603770=
748812gmail-p1" style=3D"font-variant-numeric:normal;font-variant-east-asia=
n:normal;font-stretch:normal;font-size:12.8px;line-height:normal;text-decor=
ation-style:initial;text-decoration-color:initial;margin:0px"><font face=3D=
"Helvetica"><span style=3D"font-size:12px"><br></span></font></p><p class=
=3D"gmail-m_6437089603770748812gmail-p1" style=3D"font-variant-numeric:norm=
al;font-variant-east-asian:normal;font-stretch:normal;font-size:12.8px;line=
-height:normal;text-decoration-style:initial;text-decoration-color:initial;=
margin:0px"><font face=3D"Helvetica"><span style=3D"font-size:12px">crash&g=
t;</span></font></p><p class=3D"gmail-m_6437089603770748812gmail-p1" style=
=3D"font-variant-numeric:normal;font-variant-east-asian:normal;font-stretch=
:normal;font-size:12.8px;line-height:normal;text-decoration-style:initial;t=
ext-decoration-color:initial;margin:0px"><font face=3D"Helvetica"><span sty=
le=3D"font-size:12px"><br></span></font></p><p class=3D"gmail-m_64370896037=
70748812gmail-p1" style=3D"font-variant-numeric:normal;font-variant-east-as=
ian:normal;font-stretch:normal;font-size:12.8px;line-height:normal;text-dec=
oration-style:initial;text-decoration-color:initial;margin:0px"><font face=
=3D"Helvetica"><span style=3D"font-size:12px">I have tested it on kernel 3.=
10 . But from source i could see that this case is still relevant for lates=
t Linux source .</span></font></p></span></div><div><span style=3D"backgrou=
nd-color:rgb(255,255,255);text-decoration-style:initial;text-decoration-col=
or:initial;float:none;display:inline"><br></span></div><div><span style=3D"=
background-color:rgb(255,255,255);text-decoration-style:initial;text-decora=
tion-color:initial;float:none;display:inline">--------------------END------=
--------=C2=A0</span></div><div><div class=3D"gmail_extra"><br><div class=
=3D"gmail_quote">On Thu, Aug 2, 2018 at 12:50 PM, Mika Westerberg <span dir=
=3D"ltr">&lt;<a href=3D"mailto:mika.westerberg@linux.intel.com" target=3D"_=
blank">mika.westerberg@linux.intel.com</a>&gt;</span> wrote:<br><blockquote=
 class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc soli=
d;padding-left:1ex">On Wed, Aug 01, 2018 at 07:15:12PM +0200, Lukas Wunner =
wrote:<br>
&gt; On Wed, Aug 01, 2018 at 07:43:58PM +0300, Mika Westerberg wrote:<br>
&gt; &gt; On Tue, Jul 31, 2018 at 07:50:37AM +0200, Lukas Wunner wrote:<br>
&gt; &gt; &gt; -static void remove_board(struct slot *p_slot)<br>
&gt; &gt; &gt; +static void remove_board(struct slot *p_slot, bool safe_rem=
oval)<br>
&gt; &gt; &gt;=C2=A0 {<br>
&gt; &gt; &gt;=C2=A0 =C2=A0struct controller *ctrl =3D p_slot-&gt;ctrl;<br>
&gt; &gt; &gt;=C2=A0 <br>
&gt; &gt; &gt; - pciehp_unconfigure_device(p_<wbr>slot);<br>
&gt; &gt; &gt; + pciehp_unconfigure_device(p_<wbr>slot, safe_removal);<br>
&gt; &gt; <br>
&gt; &gt; Below we turn off power to the slot if it has power controller. E=
ven if<br>
&gt; &gt; we disable slot from sysfs, I think it ends up being inaccessible=
 after<br>
&gt; &gt; power is turned off. I wonder if we should mark the devices disco=
nnected<br>
&gt; &gt; in that case as well?<br>
&gt; &gt; <br>
&gt; &gt; &gt;=C2=A0 <br>
&gt; &gt; &gt;=C2=A0 =C2=A0if (POWER_CTRL(ctrl)) {<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pciehp_power_off_slo=
t(p_slot);<br>
&gt; <br>
&gt; No, when pciehp_unconfigure_device() returns, the PCI devices below<br=
>
&gt; the hotplug bridge are unbound and removed from the system.=C2=A0 They=
&#39;re<br>
&gt; gone, so the bit set in their pci_dev struct would no longer be<br>
&gt; accessible anyway.=C2=A0 Unless of course something is holding a ref o=
n<br>
&gt; the pci_dev, but that would seem to be a bug.=C2=A0 (Accessing a devic=
e<br>
&gt; that&#39;s already removed from the system, that is.)<br>
&gt; <br>
&gt; Calling pci_dev_set_disconnected() only gives the PCI core and the<br>
&gt; driver bound to the device an indication that&#39;s it&#39;s inaccessi=
ble,<br>
&gt; so any code paths during unbound and PCI device teardown can skip<br>
&gt; accesses.=C2=A0 (Because pci_dev_is_disconnected() is currently scoped=
<br>
&gt; to the PCI core, the disconnected status can only be queried from<br>
&gt; drivers that live in the PCI core, such as portdrv and all the<br>
&gt; port services drivers.)=C2=A0 After the pci_dev is removed from the<br=
>
&gt; hierarchy, accessing it seems at least questionable.<br>
&gt; <br>
&gt; Does this make things clearer?=C2=A0 Shout if it not. :-)<br>
<br>
Yes it does. Thank you :)<br>
</blockquote></div><br></div></div></div>

--000000000000e724d705726ec4ae--
