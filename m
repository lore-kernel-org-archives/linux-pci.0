Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lf1-f43.google.com ([209.85.167.43]:40251 "EHLO
        mail-lf1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389627AbeHARIf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Aug 2018 13:08:35 -0400
Received: by mail-lf1-f43.google.com with SMTP id y200-v6so13589591lfd.7
        for <linux-pci@vger.kernel.org>; Wed, 01 Aug 2018 08:22:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <9aece481-b03d-c30a-7911-a07e586c1db4@oracle.com>
References: <CAFP4jM9xmXHVnBPObNxTtr1kDo2kbW9G4N5q=BLU5gf5=+M0xg@mail.gmail.com>
 <c5fb4a6a-136f-99f1-104e-32c923f00a22@oracle.com> <CAFP4jM9VP0jQ77rQt2KzfhuFZdXQRiS54TqxcKBLy39+sR3uMw@mail.gmail.com>
 <9aece481-b03d-c30a-7911-a07e586c1db4@oracle.com>
From: gokul cg <gokuljnpr@gmail.com>
Date: Wed, 1 Aug 2018 20:52:19 +0530
Message-ID: <CAFP4jM-MNYh02fJzr0EPybc-pPs_ePTKZNZNQMxTEfq639rbWw@mail.gmail.com>
Subject: Re: Possible race condition in the kernel between PCI driver and AER handling
To: Thomas Tai <thomas.tai@oracle.com>
Cc: linux-pci@vger.kernel.org
Content-Type: multipart/alternative; boundary="000000000000c4d8bb057261429a"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--000000000000c4d8bb057261429a
Content-Type: text/plain; charset="UTF-8"

Hi Thomas,

>In your case, I am hoping to recreate your issue so that we can work
together to isolate and fix the issue. Do you have any suggestion how to
fix it at this moment?
Yes . I can reproduce issue.

I don't  have any patch right now.
I was thinking about two options ,

1)  Adding generic call back  in pci_dev to notify any when a device get
removed from tree so that aer_driver can also subscribe to it
2)  set_bit(PCI_DEV_DISCONNECTED, &dev->priv_flags) in pci device flags
when it removed from list and let aer driver to mange free , but i fear
whether this will this create memory leak because of race.


Regards
Gokul
On Wed, Aug 1, 2018 at 7:54 PM, Thomas Tai <thomas.tai@oracle.com> wrote:

>
>
> On 08/01/2018 01:53 AM, gokul cg wrote:
>
>> Hi,
>>
>> I see there is a basic design flow. As AER and PCI drivers are
>> independent modules ,
>> locally storing pointer to any data structure from pci linked list in AER
>> driver will create problem as there is no synchronization between the same .
>>
>>
>> https://elixir.bootlin.com/linux/v3.10.99/source/drivers/pci
>> /pcie/aer/aerdrv_core.c#L701
>> Here 'structaer_err_info <https://elixir.bootlin.com/li
>> nux/v3.10.99/ident/aer_err_info>*e_info <https://elixir.bootlin.com/li
>> nux/v3.10.99/ident/e_info>' has pointer to pci dev , which can be
>> removed from pci tree at any time .
>> I think this is the basic issue.
>>
>
> Hi Gokul,
> Agree. We had an issue last week about this e_info storing the pci_dev
> which is removed in the pcie_do_fatal_recovery() and causes use-after-free
> problem.
>
> In your case, I am hoping to recreate your issue so that we can work
> together to isolate and fix the issue. Do you have any suggestion how to
> fix it at this moment?
>
> Thanks,
> Thomas
>
>
>>
>> Regards
>> Gokul
>>
>>
>> On Tue, Jul 31, 2018 at 6:45 PM, Thomas Tai <thomas.tai@oracle.com
>> <mailto:thomas.tai@oracle.com>> wrote:
>>
>>
>>
>>     On 07/31/2018 08:42 AM, gokul cg wrote:
>>
>>         Hi All,
>>
>>
>>         I am suspecting a possible race condition in the kernel between
>>         PCI driver and AER handling.
>>
>>         Because of the same kernel panic happens from worker thread
>>         which handles bottom half of aer irq.
>>
>>
>>         I am seeing this issue when I suddenly power off PCI card which
>>         supports/enabled PCIE AER error reporting.
>>
>>         While powering off PCI device, AER driver will get AER IRQ for
>>         the device, from AER IRQ handler, it will cache AER error code
>>         and schedule worker thread to handle error.
>>
>>
>>     Hi Gokul,
>>
>>     It may be an issue in the AER driver. How do you power off your
>>     device? I've never seen this issue with normal shutdown nor "echo 0
>>      > /sys/bus/pci/slots/xx/power"
>>
>>     Cheers,
>>     Thomas
>>
>>
>>
>>         The PCIe device will get removed from PCI tree before worker
>>         thread completes its task and kernel panic is  happening when
>>         worker thread tries to access PCI device's config space.
>>
>>
>>
>>         Issue:
>>
>>
>>         crash>
>>
>>         crash> bt
>>
>>         PID: 2727   TASK: ffff880272adc530  CPU: 0   COMMAND:
>> "kworker/0:2"
>>
>>         #0 [ffff88027469fac8] machine_kexec at ffffffff8102cf18
>>
>>         #1 [ffff88027469fb28] crash_kexec at ffffffff810a6b05
>>
>>         #2 [ffff88027469fbf0] oops_end at ffffffff8176d960
>>
>>         #3 [ffff88027469fc18] die at ffffffff810060db
>>
>>         #4 [ffff88027469fc48] do_general_protection at ffffffff8176d452
>>
>>         #5 [ffff88027469fc70] general_protection at ffffffff8176cdf2
>>
>>               [exception RIP: pci_bus_read_config_dword+100]
>>
>>               RIP: ffffffff813405f4  RSP: ffff88027469fd20  RFLAGS:
>> 00010046
>>
>>               RAX: 435f494350006963  RBX: ffff880274892000  RCX:
>>         0000000000000004
>>
>>               RDX: 0000000000000100  RSI: 0000000000000060  RDI:
>>         ffff880274892000
>>
>>               RBP: ffff88027469fd48   R8: ffff88027469fd2c   R9:
>>         00000000000012c0
>>
>>               R10: 0000000000000006  R11: 00000000000012bf  R12:
>>         ffff88027469fd5c
>>
>>               R13: 0000000000000246  R14: 0000000000000000  R15:
>>         ffff8802741a4000
>>
>>               ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0000
>>
>>         #6 [ffff88027469fd50] pci_find_next_ext_capability at
>>         ffffffff81345d7b
>>
>>         #7 [ffff88027469fd90] pci_find_ext_capability at ffffffff81347225
>>
>>         #8 [ffff88027469fda0] get_device_error_info at ffffffff81356c4d
>>
>>         #9 [ffff88027469fdd0] aer_isr at ffffffff81357a38
>>
>>         #10 [ffff88027469fe28] process_one_work at ffffffff8105d4c0
>>
>>         #11 [ffff88027469fe70] worker_thread at ffffffff8105e251
>>
>>         #12 [ffff88027469fed0] kthread at ffffffff81064260
>>
>>         #13 [ffff88027469ff50] ret_from_fork at ffffffff81773a38
>>
>>
>>         crash>
>>
>>
>>         I have tested it on kernel 3.10 . But from source i could see
>>         that this case is still relevant for latest Linux source .
>>
>>
>>         Can anybody tell me if this is an issue with AER driver in linux ?
>>
>>
>>
>>
>>         Regards
>>
>>         Gokul CG
>>
>>
>>

--000000000000c4d8bb057261429a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi=C2=A0Thomas,<br></div><div><br></div><div>&gt;<spa=
n style=3D"font-size:small;background-color:rgb(255,255,255);text-decoratio=
n-style:initial;text-decoration-color:initial;float:none;display:inline">In=
 your case, I am hoping to recreate your issue so that we can work together=
 to isolate and fix the issue. Do you have any suggestion how to fix it at =
this moment?</span><br style=3D"font-size:small;background-color:rgb(255,25=
5,255);text-decoration-style:initial;text-decoration-color:initial"></div><=
div>Yes . I can reproduce issue.</div><div><br></div><div>I don&#39;t=C2=A0=
 have any patch right now.=C2=A0</div><div>I was thinking about two options=
 ,=C2=A0</div><div><br></div><div>1)=C2=A0 Adding generic call back=C2=A0 i=
n pci_dev to notify any when a device get removed from tree so that aer_dri=
ver can also subscribe to it</div><div>2)=C2=A0 set_bit(PCI_DEV_DISCONNECTE=
D, &amp;dev-&gt;priv_flags) in pci device flags when it removed from list a=
nd let aer driver to mange free , but i fear whether this will this create =
memory leak because of race.</div><div><br></div><div><div class=3D"gmail_e=
xtra"><br></div><div class=3D"gmail_extra">Regards</div><div class=3D"gmail=
_extra">Gokul=C2=A0</div><div class=3D"gmail_extra"><div class=3D"gmail_quo=
te">On Wed, Aug 1, 2018 at 7:54 PM, Thomas Tai <span dir=3D"ltr">&lt;<a hre=
f=3D"mailto:thomas.tai@oracle.com" target=3D"_blank">thomas.tai@oracle.com<=
/a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">=
<span class=3D"gmail-"><br>
<br>
On 08/01/2018 01:53 AM, gokul cg wrote:<br>
</span><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;=
border-left:1px solid rgb(204,204,204);padding-left:1ex"><span class=3D"gma=
il-">
Hi,<br>
<br>
I see there is a basic design flow. As AER and PCI drivers are independent =
modules ,<br>
locally storing pointer to any data structure from pci linked list in AER d=
river will create problem as there is no synchronization between the same .=
<br>
<br>
<br>
<a href=3D"https://elixir.bootlin.com/linux/v3.10.99/source/drivers/pci/pci=
e/aer/aerdrv_core.c#L701" rel=3D"noreferrer" target=3D"_blank">https://elix=
ir.bootlin.com/lin<wbr>ux/v3.10.99/source/drivers/pci<wbr>/pcie/aer/aerdrv_=
core.c#L701</a><br></span>
Here &#39;structaer_err_info &lt;<a href=3D"https://elixir.bootlin.com/linu=
x/v3.10.99/ident/aer_err_info" rel=3D"noreferrer" target=3D"_blank">https:/=
/elixir.bootlin.com/li<wbr>nux/v3.10.99/ident/aer_err_inf<wbr>o</a>&gt;*e_i=
nfo &lt;<a href=3D"https://elixir.bootlin.com/linux/v3.10.99/ident/e_info" =
rel=3D"noreferrer" target=3D"_blank">https://elixir.bootlin.com/li<wbr>nux/=
v3.10.99/ident/e_info</a>&gt;&#39; has pointer to pci dev , which can be re=
moved from pci tree at any time .<span class=3D"gmail-"><br>
I think this is the basic issue.<br>
</span></blockquote>
<br>
Hi Gokul,<br>
Agree. We had an issue last week about this e_info storing the pci_dev whic=
h is removed in the pcie_do_fatal_recovery() and causes use-after-free prob=
lem.<br>
<br>
In your case, I am hoping to recreate your issue so that we can work togeth=
er to isolate and fix the issue. Do you have any suggestion how to fix it a=
t this moment?<br>
<br>
Thanks,<br>
Thomas<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
<br>
Regards<br>
Gokul<div><div class=3D"gmail-h5"><br>
<br>
On Tue, Jul 31, 2018 at 6:45 PM, Thomas Tai &lt;<a href=3D"mailto:thomas.ta=
i@oracle.com" target=3D"_blank">thomas.tai@oracle.com</a> &lt;mailto:<a hre=
f=3D"mailto:thomas.tai@oracle.com" target=3D"_blank">thomas.tai@oracle.com<=
/a>&gt;<wbr>&gt; wrote:<br>
<br>
<br>
<br>
=C2=A0 =C2=A0 On 07/31/2018 08:42 AM, gokul cg wrote:<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Hi All,<br>
<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 I am suspecting a possible race condition in th=
e kernel between<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 PCI driver and AER handling.<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Because of the same kernel panic happens from w=
orker thread<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 which handles bottom half of aer irq.<br>
<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 I am seeing this issue when I suddenly power of=
f PCI card which<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 supports/enabled PCIE AER error reporting.<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 While powering off PCI device, AER driver will =
get AER IRQ for<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 the device, from AER IRQ handler, it will cache=
 AER error code<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 and schedule worker thread to handle error.<br>
<br>
<br>
=C2=A0 =C2=A0 Hi Gokul,<br>
<br>
=C2=A0 =C2=A0 It may be an issue in the AER driver. How do you power off yo=
ur<br>
=C2=A0 =C2=A0 device? I&#39;ve never seen this issue with normal shutdown n=
or &quot;echo 0<br>
=C2=A0 =C2=A0 =C2=A0&gt; /sys/bus/pci/slots/xx/power&quot;<br>
<br>
=C2=A0 =C2=A0 Cheers,<br>
=C2=A0 =C2=A0 Thomas<br>
<br>
<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 The PCIe device will get removed from PCI tree =
before worker<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 thread completes its task and kernel panic is=
=C2=A0 happening when<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 worker thread tries to access PCI device&#39;s =
config space.<br>
<br>
<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Issue:<br>
<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 crash&gt;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 crash&gt; bt<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 PID: 2727=C2=A0 =C2=A0TASK: ffff880272adc530=C2=
=A0 CPU: 0=C2=A0 =C2=A0COMMAND: &quot;kworker/0:2&quot;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 #0 [ffff88027469fac8] machine_kexec at ffffffff=
8102cf18<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 #1 [ffff88027469fb28] crash_kexec at ffffffff81=
0a6b05<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 #2 [ffff88027469fbf0] oops_end at ffffffff8176d=
960<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 #3 [ffff88027469fc18] die at ffffffff810060db<b=
r>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 #4 [ffff88027469fc48] do_general_protection at =
ffffffff8176d452<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 #5 [ffff88027469fc70] general_protection at fff=
fffff8176cdf2<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0 [exception RIP: pci_b=
us_read_config_dword+100]<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0 RIP: ffffffff813405f4=
=C2=A0 RSP: ffff88027469fd20=C2=A0 RFLAGS: 00010046<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0 RAX: 435f494350006963=
=C2=A0 RBX: ffff880274892000=C2=A0 RCX:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 0000000000000004<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0 RDX: 0000000000000100=
=C2=A0 RSI: 0000000000000060=C2=A0 RDI:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ffff880274892000<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0 RBP: ffff88027469fd48=
=C2=A0 =C2=A0R8: ffff88027469fd2c=C2=A0 =C2=A0R9:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 00000000000012c0<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0 R10: 0000000000000006=
=C2=A0 R11: 00000000000012bf=C2=A0 R12:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ffff88027469fd5c<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0 R13: 0000000000000246=
=C2=A0 R14: 0000000000000000=C2=A0 R15:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ffff8802741a4000<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0 ORIG_RAX: fffffffffff=
fffff=C2=A0 CS: 0010=C2=A0 SS: 0000<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 #6 [ffff88027469fd50] pci_find_next_ext_capabil=
ity at<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ffffffff81345d7b<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 #7 [ffff88027469fd90] pci_find_ext_capability a=
t ffffffff81347225<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 #8 [ffff88027469fda0] get_device_error_info at =
ffffffff81356c4d<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 #9 [ffff88027469fdd0] aer_isr at ffffffff81357a=
38<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 #10 [ffff88027469fe28] process_one_work at ffff=
ffff8105d4c0<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 #11 [ffff88027469fe70] worker_thread at fffffff=
f8105e251<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 #12 [ffff88027469fed0] kthread at ffffffff81064=
260<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 #13 [ffff88027469ff50] ret_from_fork at fffffff=
f81773a38<br>
<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 crash&gt;<br>
<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 I have tested it on kernel 3.10 . But from sour=
ce i could see<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 that this case is still relevant for latest Lin=
ux source .<br>
<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Can anybody tell me if this is an issue with AE=
R driver in linux ?<br>
<br>
<br>
<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Regards<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Gokul CG<br>
<br>
<br>
</div></div></blockquote>
</blockquote></div><br></div></div></div>

--000000000000c4d8bb057261429a--
