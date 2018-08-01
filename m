Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lf1-f50.google.com ([209.85.167.50]:40362 "EHLO
        mail-lf1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733098AbeHAH0p (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Aug 2018 03:26:45 -0400
Received: by mail-lf1-f50.google.com with SMTP id y200-v6so12416948lfd.7
        for <linux-pci@vger.kernel.org>; Tue, 31 Jul 2018 22:42:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <c5fb4a6a-136f-99f1-104e-32c923f00a22@oracle.com>
References: <CAFP4jM9xmXHVnBPObNxTtr1kDo2kbW9G4N5q=BLU5gf5=+M0xg@mail.gmail.com>
 <c5fb4a6a-136f-99f1-104e-32c923f00a22@oracle.com>
From: gokul cg <gokuljnpr@gmail.com>
Date: Wed, 1 Aug 2018 11:12:51 +0530
Message-ID: <CAFP4jM84BuVZ+yKvcVvbu_6LFoO+2iVivWWZTZgbEEy3=oMftg@mail.gmail.com>
Subject: Re: Possible race condition in the kernel between PCI driver and AER handling
To: Thomas Tai <thomas.tai@oracle.com>
Cc: linux-pci@vger.kernel.org
Content-Type: multipart/alternative; boundary="00000000000062a0960572592a40"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--00000000000062a0960572592a40
Content-Type: text/plain; charset="UTF-8"

Hi Thomas,

In my hardware, there is i2c power control chip for PCI card, I just
powered down using i2c command .

Regards,
Gokul

On Tue, Jul 31, 2018 at 6:45 PM, Thomas Tai <thomas.tai@oracle.com> wrote:

>
>
> On 07/31/2018 08:42 AM, gokul cg wrote:
>
>> Hi All,
>>
>>
>> I am suspecting a possible race condition in the kernel between PCI
>> driver and AER handling.
>>
>> Because of the same kernel panic happens from worker thread which handles
>> bottom half of aer irq.
>>
>>
>> I am seeing this issue when I suddenly power off PCI card which
>> supports/enabled PCIE AER error reporting.
>>
>> While powering off PCI device, AER driver will get AER IRQ for the
>> device, from AER IRQ handler, it will cache AER error code and schedule
>> worker thread to handle error.
>>
>
> Hi Gokul,
>
> It may be an issue in the AER driver. How do you power off your device?
> I've never seen this issue with normal shutdown nor "echo 0 >
> /sys/bus/pci/slots/xx/power"
>
> Cheers,
> Thomas
>
>
>
>> The PCIe device will get removed from PCI tree before worker thread
>> completes its task and kernel panic is  happening when worker thread tries
>> to access PCI device's config space.
>>
>>
>>
>> Issue:
>>
>>
>> crash>
>>
>> crash> bt
>>
>> PID: 2727   TASK: ffff880272adc530  CPU: 0   COMMAND: "kworker/0:2"
>>
>> #0 [ffff88027469fac8] machine_kexec at ffffffff8102cf18
>>
>> #1 [ffff88027469fb28] crash_kexec at ffffffff810a6b05
>>
>> #2 [ffff88027469fbf0] oops_end at ffffffff8176d960
>>
>> #3 [ffff88027469fc18] die at ffffffff810060db
>>
>> #4 [ffff88027469fc48] do_general_protection at ffffffff8176d452
>>
>> #5 [ffff88027469fc70] general_protection at ffffffff8176cdf2
>>
>>      [exception RIP: pci_bus_read_config_dword+100]
>>
>>      RIP: ffffffff813405f4  RSP: ffff88027469fd20  RFLAGS: 00010046
>>
>>      RAX: 435f494350006963  RBX: ffff880274892000  RCX: 0000000000000004
>>
>>      RDX: 0000000000000100  RSI: 0000000000000060  RDI: ffff880274892000
>>
>>      RBP: ffff88027469fd48   R8: ffff88027469fd2c   R9: 00000000000012c0
>>
>>      R10: 0000000000000006  R11: 00000000000012bf  R12: ffff88027469fd5c
>>
>>      R13: 0000000000000246  R14: 0000000000000000  R15: ffff8802741a4000
>>
>>      ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0000
>>
>> #6 [ffff88027469fd50] pci_find_next_ext_capability at ffffffff81345d7b
>>
>> #7 [ffff88027469fd90] pci_find_ext_capability at ffffffff81347225
>>
>> #8 [ffff88027469fda0] get_device_error_info at ffffffff81356c4d
>>
>> #9 [ffff88027469fdd0] aer_isr at ffffffff81357a38
>>
>> #10 [ffff88027469fe28] process_one_work at ffffffff8105d4c0
>>
>> #11 [ffff88027469fe70] worker_thread at ffffffff8105e251
>>
>> #12 [ffff88027469fed0] kthread at ffffffff81064260
>>
>> #13 [ffff88027469ff50] ret_from_fork at ffffffff81773a38
>>
>>
>> crash>
>>
>>
>> I have tested it on kernel 3.10 . But from source i could see that this
>> case is still relevant for latest Linux source .
>>
>>
>> Can anybody tell me if this is an issue with AER driver in linux ?
>>
>>
>>
>>
>> Regards
>>
>> Gokul CG
>>
>>

--00000000000062a0960572592a40
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi=C2=A0<span style=3D"font-size:12.8px;text-decoration-st=
yle:initial;text-decoration-color:initial;float:none;display:inline">Thomas=
,</span><div><span style=3D"font-size:12.8px;text-decoration-style:initial;=
text-decoration-color:initial;float:none;display:inline"><br></span></div><=
div><span style=3D"font-size:12.8px;text-decoration-style:initial;text-deco=
ration-color:initial;float:none;display:inline">In my hardware, there is i2=
c power control chip for PCI card, I just powered down using i2c command .=
=C2=A0</span></div><div><span style=3D"font-size:12.8px;text-decoration-sty=
le:initial;text-decoration-color:initial;float:none;display:inline"><br></s=
pan></div><div><span style=3D"font-size:12.8px;text-decoration-style:initia=
l;text-decoration-color:initial;float:none;display:inline">Regards,</span><=
/div><div><span style=3D"font-size:12.8px;text-decoration-style:initial;tex=
t-decoration-color:initial;float:none;display:inline">Gokul=C2=A0</span></d=
iv></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Tue, =
Jul 31, 2018 at 6:45 PM, Thomas Tai <span dir=3D"ltr">&lt;<a href=3D"mailto=
:thomas.tai@oracle.com" target=3D"_blank">thomas.tai@oracle.com</a>&gt;</sp=
an> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;=
border-left:1px #ccc solid;padding-left:1ex"><span class=3D""><br>
<br>
On 07/31/2018 08:42 AM, gokul cg wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
Hi All,<br>
<br>
<br>
I am suspecting a possible race condition in the kernel between PCI driver =
and AER handling.<br>
<br>
Because of the same kernel panic happens from worker thread which handles b=
ottom half of aer irq.<br>
<br>
<br>
I am seeing this issue when I suddenly power off PCI card which supports/en=
abled PCIE AER error reporting.<br>
<br>
While powering off PCI device, AER driver will get AER IRQ for the device, =
from AER IRQ handler, it will cache AER error code and schedule worker thre=
ad to handle error.<br>
</blockquote>
<br></span>
Hi Gokul,<br>
<br>
It may be an issue in the AER driver. How do you power off your device? I&#=
39;ve never seen this issue with normal shutdown nor &quot;echo 0 &gt; /sys=
/bus/pci/slots/xx/power&quot;<br>
<br>
Cheers,<br>
Thomas<div class=3D"HOEnZb"><div class=3D"h5"><br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
<br>
The PCIe device will get removed from PCI tree before worker thread complet=
es its task and kernel panic is=C2=A0 happening when worker thread tries to=
 access PCI device&#39;s config space.<br>
<br>
<br>
<br>
Issue:<br>
<br>
<br>
crash&gt;<br>
<br>
crash&gt; bt<br>
<br>
PID: 2727=C2=A0 =C2=A0TASK: ffff880272adc530=C2=A0 CPU: 0=C2=A0 =C2=A0COMMA=
ND: &quot;kworker/0:2&quot;<br>
<br>
#0 [ffff88027469fac8] machine_kexec at ffffffff8102cf18<br>
<br>
#1 [ffff88027469fb28] crash_kexec at ffffffff810a6b05<br>
<br>
#2 [ffff88027469fbf0] oops_end at ffffffff8176d960<br>
<br>
#3 [ffff88027469fc18] die at ffffffff810060db<br>
<br>
#4 [ffff88027469fc48] do_general_protection at ffffffff8176d452<br>
<br>
#5 [ffff88027469fc70] general_protection at ffffffff8176cdf2<br>
<br>
=C2=A0=C2=A0 =C2=A0 [exception RIP: pci_bus_read_config_dword+100]<br>
<br>
=C2=A0=C2=A0 =C2=A0 RIP: ffffffff813405f4=C2=A0 RSP: ffff88027469fd20=C2=A0=
 RFLAGS: 00010046<br>
<br>
=C2=A0=C2=A0 =C2=A0 RAX: 435f494350006963=C2=A0 RBX: ffff880274892000=C2=A0=
 RCX: 0000000000000004<br>
<br>
=C2=A0=C2=A0 =C2=A0 RDX: 0000000000000100=C2=A0 RSI: 0000000000000060=C2=A0=
 RDI: ffff880274892000<br>
<br>
=C2=A0=C2=A0 =C2=A0 RBP: ffff88027469fd48=C2=A0 =C2=A0R8: ffff88027469fd2c=
=C2=A0 =C2=A0R9: 00000000000012c0<br>
<br>
=C2=A0=C2=A0 =C2=A0 R10: 0000000000000006=C2=A0 R11: 00000000000012bf=C2=A0=
 R12: ffff88027469fd5c<br>
<br>
=C2=A0=C2=A0 =C2=A0 R13: 0000000000000246=C2=A0 R14: 0000000000000000=C2=A0=
 R15: ffff8802741a4000<br>
<br>
=C2=A0=C2=A0 =C2=A0 ORIG_RAX: ffffffffffffffff=C2=A0 CS: 0010=C2=A0 SS: 000=
0<br>
<br>
#6 [ffff88027469fd50] pci_find_next_ext_capability at ffffffff81345d7b<br>
<br>
#7 [ffff88027469fd90] pci_find_ext_capability at ffffffff81347225<br>
<br>
#8 [ffff88027469fda0] get_device_error_info at ffffffff81356c4d<br>
<br>
#9 [ffff88027469fdd0] aer_isr at ffffffff81357a38<br>
<br>
#10 [ffff88027469fe28] process_one_work at ffffffff8105d4c0<br>
<br>
#11 [ffff88027469fe70] worker_thread at ffffffff8105e251<br>
<br>
#12 [ffff88027469fed0] kthread at ffffffff81064260<br>
<br>
#13 [ffff88027469ff50] ret_from_fork at ffffffff81773a38<br>
<br>
<br>
crash&gt;<br>
<br>
<br>
I have tested it on kernel 3.10 . But from source i could see that this cas=
e is still relevant for latest Linux source .<br>
<br>
<br>
Can anybody tell me if this is an issue with AER driver in linux ?<br>
<br>
<br>
<br>
<br>
Regards<br>
<br>
Gokul CG<br>
<br>
</blockquote>
</div></div></blockquote></div><br></div>

--00000000000062a0960572592a40--
