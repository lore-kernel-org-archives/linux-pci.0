Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46427 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731988AbeGaOW2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 Jul 2018 10:22:28 -0400
Received: by mail-lj1-f194.google.com with SMTP id 203-v6so13548831ljj.13
        for <linux-pci@vger.kernel.org>; Tue, 31 Jul 2018 05:42:17 -0700 (PDT)
MIME-Version: 1.0
From: gokul cg <gokuljnpr@gmail.com>
Date: Tue, 31 Jul 2018 18:12:15 +0530
Message-ID: <CAFP4jM9xmXHVnBPObNxTtr1kDo2kbW9G4N5q=BLU5gf5=+M0xg@mail.gmail.com>
Subject: Possible race condition in the kernel between PCI driver and AER handling
To: linux-pci@vger.kernel.org
Content-Type: multipart/alternative; boundary="0000000000006ab6a905724ae861"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--0000000000006ab6a905724ae861
Content-Type: text/plain; charset="UTF-8"

Hi All,


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


Can anybody tell me if this is an issue with AER driver in linux ?




Regards

Gokul CG

--0000000000006ab6a905724ae861
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">




<span></span>





<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-stretch:normal;line-height:normal"><font fac=
e=3D"Helvetica"><span style=3D"font-size:12px">Hi All,</span></font></p><p =
class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-var=
iant-east-asian:normal;font-stretch:normal;line-height:normal"><font face=
=3D"Helvetica"><span style=3D"font-size:12px"><br></span></font></p><p clas=
s=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-variant=
-east-asian:normal;font-stretch:normal;line-height:normal"><span style=3D"f=
ont-size:12px;font-family:Helvetica">I am suspecting a possible race condit=
ion in the kernel between PCI driver and AER handling.</span><br></p><p cla=
ss=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-varian=
t-east-asian:normal;font-stretch:normal;line-height:normal"><font face=3D"H=
elvetica"><span style=3D"font-size:12px">Because of the same kernel panic h=
appens from worker thread which handles bottom half of aer irq.</span></fon=
t></p><p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal=
;font-variant-east-asian:normal;font-stretch:normal;line-height:normal"><fo=
nt face=3D"Helvetica"><span style=3D"font-size:12px"><br></span></font></p>=
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-stretch:normal;line-height:normal"><font fac=
e=3D"Helvetica"><span style=3D"font-size:12px">I am seeing this issue when =
I suddenly power off PCI card which supports/enabled PCIE AER error reporti=
ng.</span></font></p><p class=3D"gmail-p1" style=3D"margin:0px;font-variant=
-numeric:normal;font-variant-east-asian:normal;font-stretch:normal;line-hei=
ght:normal"><font face=3D"Helvetica"><span style=3D"font-size:12px">While p=
owering off PCI device, AER driver will get AER IRQ for the device, from AE=
R IRQ handler, it will cache AER error code and schedule worker thread to h=
andle error.</span></font></p><p class=3D"gmail-p1" style=3D"margin:0px;fon=
t-variant-numeric:normal;font-variant-east-asian:normal;font-stretch:normal=
;line-height:normal"><font face=3D"Helvetica"><span style=3D"font-size:12px=
">The PCIe device will get removed from PCI tree before worker thread compl=
etes its task and kernel panic is=C2=A0 happening when worker thread tries =
to access PCI device&#39;s config space.</span></font></p><p class=3D"gmail=
-p1" style=3D"margin:0px;font-variant-numeric:normal;font-variant-east-asia=
n:normal;font-stretch:normal;line-height:normal"><font face=3D"Helvetica"><=
span style=3D"font-size:12px"><br></span></font></p><p class=3D"gmail-p1" s=
tyle=3D"margin:0px;font-variant-numeric:normal;font-variant-east-asian:norm=
al;font-stretch:normal;line-height:normal"><font face=3D"Helvetica"><span s=
tyle=3D"font-size:12px"><br></span></font></p><p class=3D"gmail-p1" style=
=3D"font-variant-numeric:normal;font-variant-east-asian:normal;font-stretch=
:normal;font-size:small;line-height:normal;text-decoration-style:initial;te=
xt-decoration-color:initial;margin:0px"><font face=3D"Helvetica"><span styl=
e=3D"font-size:12px">Issue:</span></font></p><br class=3D"gmail-Apple-inter=
change-newline"><p class=3D"gmail-p1" style=3D"margin:0px;font-variant-nume=
ric:normal;font-variant-east-asian:normal;font-stretch:normal;line-height:n=
ormal"><font face=3D"Helvetica"><span style=3D"font-size:12px">crash&gt;</s=
pan></font></p><p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numer=
ic:normal;font-variant-east-asian:normal;font-stretch:normal;line-height:no=
rmal"><font face=3D"Helvetica"><span style=3D"font-size:12px">crash&gt; bt<=
/span></font></p><p class=3D"gmail-p1" style=3D"margin:0px;font-variant-num=
eric:normal;font-variant-east-asian:normal;font-stretch:normal;line-height:=
normal"><font face=3D"Helvetica"><span style=3D"font-size:12px">PID: 2727=
=C2=A0 =C2=A0TASK: ffff880272adc530=C2=A0 CPU: 0=C2=A0 =C2=A0COMMAND: &quot=
;kworker/0:2&quot;</span></font></p><p class=3D"gmail-p1" style=3D"margin:0=
px;font-variant-numeric:normal;font-variant-east-asian:normal;font-stretch:=
normal;line-height:normal"><font face=3D"Helvetica"><span style=3D"font-siz=
e:12px">#0 [ffff88027469fac8] machine_kexec at ffffffff8102cf18</span></fon=
t></p><p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal=
;font-variant-east-asian:normal;font-stretch:normal;line-height:normal"><fo=
nt face=3D"Helvetica"><span style=3D"font-size:12px">#1 [ffff88027469fb28] =
crash_kexec at ffffffff810a6b05</span></font></p><p class=3D"gmail-p1" styl=
e=3D"margin:0px;font-variant-numeric:normal;font-variant-east-asian:normal;=
font-stretch:normal;line-height:normal"><font face=3D"Helvetica"><span styl=
e=3D"font-size:12px">#2 [ffff88027469fbf0] oops_end at ffffffff8176d960</sp=
an></font></p><p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeri=
c:normal;font-variant-east-asian:normal;font-stretch:normal;line-height:nor=
mal"><font face=3D"Helvetica"><span style=3D"font-size:12px">#3 [ffff880274=
69fc18] die at ffffffff810060db</span></font></p><p class=3D"gmail-p1" styl=
e=3D"margin:0px;font-variant-numeric:normal;font-variant-east-asian:normal;=
font-stretch:normal;line-height:normal"><font face=3D"Helvetica"><span styl=
e=3D"font-size:12px">#4 [ffff88027469fc48] do_general_protection at fffffff=
f8176d452</span></font></p><p class=3D"gmail-p1" style=3D"margin:0px;font-v=
ariant-numeric:normal;font-variant-east-asian:normal;font-stretch:normal;li=
ne-height:normal"><font face=3D"Helvetica"><span style=3D"font-size:12px">#=
5 [ffff88027469fc70] general_protection at ffffffff8176cdf2</span></font></=
p><p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;fon=
t-variant-east-asian:normal;font-stretch:normal;line-height:normal"><font f=
ace=3D"Helvetica"><span style=3D"font-size:12px">=C2=A0 =C2=A0 [exception R=
IP: pci_bus_read_config_dword+100]</span></font></p><p class=3D"gmail-p1" s=
tyle=3D"margin:0px;font-variant-numeric:normal;font-variant-east-asian:norm=
al;font-stretch:normal;line-height:normal"><font face=3D"Helvetica"><span s=
tyle=3D"font-size:12px">=C2=A0 =C2=A0 RIP: ffffffff813405f4=C2=A0 RSP: ffff=
88027469fd20=C2=A0 RFLAGS: 00010046</span></font></p><p class=3D"gmail-p1" =
style=3D"margin:0px;font-variant-numeric:normal;font-variant-east-asian:nor=
mal;font-stretch:normal;line-height:normal"><font face=3D"Helvetica"><span =
style=3D"font-size:12px">=C2=A0 =C2=A0 RAX: 435f494350006963=C2=A0 RBX: fff=
f880274892000=C2=A0 RCX: 0000000000000004</span></font></p><p class=3D"gmai=
l-p1" style=3D"margin:0px;font-variant-numeric:normal;font-variant-east-asi=
an:normal;font-stretch:normal;line-height:normal"><font face=3D"Helvetica">=
<span style=3D"font-size:12px">=C2=A0 =C2=A0 RDX: 0000000000000100=C2=A0 RS=
I: 0000000000000060=C2=A0 RDI: ffff880274892000</span></font></p><p class=
=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-variant-=
east-asian:normal;font-stretch:normal;line-height:normal"><font face=3D"Hel=
vetica"><span style=3D"font-size:12px">=C2=A0 =C2=A0 RBP: ffff88027469fd48=
=C2=A0 =C2=A0R8: ffff88027469fd2c=C2=A0 =C2=A0R9: 00000000000012c0</span></=
font></p><p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:nor=
mal;font-variant-east-asian:normal;font-stretch:normal;line-height:normal">=
<font face=3D"Helvetica"><span style=3D"font-size:12px">=C2=A0 =C2=A0 R10: =
0000000000000006=C2=A0 R11: 00000000000012bf=C2=A0 R12: ffff88027469fd5c</s=
pan></font></p><p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numer=
ic:normal;font-variant-east-asian:normal;font-stretch:normal;line-height:no=
rmal"><font face=3D"Helvetica"><span style=3D"font-size:12px">=C2=A0 =C2=A0=
 R13: 0000000000000246=C2=A0 R14: 0000000000000000=C2=A0 R15: ffff8802741a4=
000</span></font></p><p class=3D"gmail-p1" style=3D"margin:0px;font-variant=
-numeric:normal;font-variant-east-asian:normal;font-stretch:normal;line-hei=
ght:normal"><font face=3D"Helvetica"><span style=3D"font-size:12px">=C2=A0 =
=C2=A0 ORIG_RAX: ffffffffffffffff=C2=A0 CS: 0010=C2=A0 SS: 0000</span></fon=
t></p><p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal=
;font-variant-east-asian:normal;font-stretch:normal;line-height:normal"><fo=
nt face=3D"Helvetica"><span style=3D"font-size:12px">#6 [ffff88027469fd50] =
pci_find_next_ext_capability at ffffffff81345d7b</span></font></p><p class=
=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-variant-=
east-asian:normal;font-stretch:normal;line-height:normal"><font face=3D"Hel=
vetica"><span style=3D"font-size:12px">#7 [ffff88027469fd90] pci_find_ext_c=
apability at ffffffff81347225</span></font></p><p class=3D"gmail-p1" style=
=3D"margin:0px;font-variant-numeric:normal;font-variant-east-asian:normal;f=
ont-stretch:normal;line-height:normal"><font face=3D"Helvetica"><span style=
=3D"font-size:12px">#8 [ffff88027469fda0] get_device_error_info at ffffffff=
81356c4d</span></font></p><p class=3D"gmail-p1" style=3D"margin:0px;font-va=
riant-numeric:normal;font-variant-east-asian:normal;font-stretch:normal;lin=
e-height:normal"><font face=3D"Helvetica"><span style=3D"font-size:12px">#9=
 [ffff88027469fdd0] aer_isr at ffffffff81357a38</span></font></p><p class=
=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-variant-=
east-asian:normal;font-stretch:normal;line-height:normal"><font face=3D"Hel=
vetica"><span style=3D"font-size:12px">#10 [ffff88027469fe28] process_one_w=
ork at ffffffff8105d4c0</span></font></p><p class=3D"gmail-p1" style=3D"mar=
gin:0px;font-variant-numeric:normal;font-variant-east-asian:normal;font-str=
etch:normal;line-height:normal"><font face=3D"Helvetica"><span style=3D"fon=
t-size:12px">#11 [ffff88027469fe70] worker_thread at ffffffff8105e251</span=
></font></p><p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:=
normal;font-variant-east-asian:normal;font-stretch:normal;line-height:norma=
l"><font face=3D"Helvetica"><span style=3D"font-size:12px">#12 [ffff8802746=
9fed0] kthread at ffffffff81064260</span></font></p><p class=3D"gmail-p1" s=
tyle=3D"margin:0px;font-variant-numeric:normal;font-variant-east-asian:norm=
al;font-stretch:normal;line-height:normal"><font face=3D"Helvetica"><span s=
tyle=3D"font-size:12px">#13 [ffff88027469ff50] ret_from_fork at ffffffff817=
73a38</span></font></p><p class=3D"gmail-p1" style=3D"margin:0px;font-varia=
nt-numeric:normal;font-variant-east-asian:normal;font-stretch:normal;line-h=
eight:normal"><font face=3D"Helvetica"><span style=3D"font-size:12px"><br><=
/span></font></p><p class=3D"gmail-p1" style=3D"margin:0px;font-variant-num=
eric:normal;font-variant-east-asian:normal;font-stretch:normal;line-height:=
normal"><font face=3D"Helvetica"><span style=3D"font-size:12px">crash&gt;</=
span></font></p><p class=3D"gmail-p1" style=3D"margin:0px;font-variant-nume=
ric:normal;font-variant-east-asian:normal;font-stretch:normal;line-height:n=
ormal"><font face=3D"Helvetica"><span style=3D"font-size:12px"><br></span><=
/font></p><p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:no=
rmal;font-variant-east-asian:normal;font-stretch:normal;line-height:normal"=
><font face=3D"Helvetica"><span style=3D"font-size:12px">I have tested it o=
n kernel 3.10 . But from source i could see that this case is still relevan=
t for latest Linux source .</span></font></p><p class=3D"gmail-p1" style=3D=
"margin:0px;font-variant-numeric:normal;font-variant-east-asian:normal;font=
-stretch:normal;line-height:normal"><font face=3D"Helvetica"><span style=3D=
"font-size:12px"><br></span></font></p><p class=3D"gmail-p1" style=3D"margi=
n:0px;font-variant-numeric:normal;font-variant-east-asian:normal;font-stret=
ch:normal;line-height:normal"><font face=3D"Helvetica"><span style=3D"font-=
size:12px">Can anybody tell me if this is an issue with AER driver in linux=
 ?</span></font></p><p class=3D"gmail-p1" style=3D"margin:0px;font-variant-=
numeric:normal;font-variant-east-asian:normal;font-stretch:normal;line-heig=
ht:normal"><font face=3D"Helvetica"><span style=3D"font-size:12px"><br></sp=
an></font></p><p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeri=
c:normal;font-variant-east-asian:normal;font-stretch:normal;line-height:nor=
mal"><font face=3D"Helvetica"><span style=3D"font-size:12px"><br></span></f=
ont></p><p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:norm=
al;font-variant-east-asian:normal;font-stretch:normal;line-height:normal"><=
font face=3D"Helvetica"><span style=3D"font-size:12px"><br></span></font></=
p><p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;fon=
t-variant-east-asian:normal;font-stretch:normal;line-height:normal"><font f=
ace=3D"Helvetica"><span style=3D"font-size:12px">Regards</span></font></p><=
p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-v=
ariant-east-asian:normal;font-stretch:normal;line-height:normal"><font face=
=3D"Helvetica"><span style=3D"font-size:12px">Gokul CG=C2=A0</span></font><=
/p></div>

--0000000000006ab6a905724ae861--
