Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lf1-f52.google.com ([209.85.167.52]:39855 "EHLO
        mail-lf1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387519AbeHAUjS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Aug 2018 16:39:18 -0400
Received: by mail-lf1-f52.google.com with SMTP id a134-v6so14049997lfe.6
        for <linux-pci@vger.kernel.org>; Wed, 01 Aug 2018 11:52:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <ecb55fb1-c3af-4f5b-86d2-1c669fa9f9ca@oracle.com>
References: <CAFP4jM9xmXHVnBPObNxTtr1kDo2kbW9G4N5q=BLU5gf5=+M0xg@mail.gmail.com>
 <c5fb4a6a-136f-99f1-104e-32c923f00a22@oracle.com> <CAFP4jM84BuVZ+yKvcVvbu_6LFoO+2iVivWWZTZgbEEy3=oMftg@mail.gmail.com>
 <ecb55fb1-c3af-4f5b-86d2-1c669fa9f9ca@oracle.com>
From: gokul cg <gokuljnpr@gmail.com>
Date: Thu, 2 Aug 2018 00:22:07 +0530
Message-ID: <CAFP4jM-=EvrLyybxEcpObQOrLS1z8CHG0q0xJZYJUxgtNKQBSw@mail.gmail.com>
Subject: Re: Possible race condition in the kernel between PCI driver and AER handling
To: Thomas Tai <thomas.tai@oracle.com>
Cc: linux-pci@vger.kernel.org
Content-Type: multipart/alternative; boundary="0000000000000112c10572643167"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--0000000000000112c10572643167
Content-Type: text/plain; charset="UTF-8"

HI Thomas ,


Yes , its surprise removal .

But as far as I know , linux kernel will handle surprise removal of PCIe
device without panic.

The driver will suddenly start reading all 0xff and will then need to
abort whatever it was doing. Usually all drivers handle this just fine.

Nothing, the driver individually needs to handle the fact that it might
at any time, start getting invalid data. If it doesn't, it needs to be
fixed. Whether AER  driver that does not handle this properly?


Regards,
Gokul

On Wed, Aug 1, 2018 at 11:17 PM, Thomas Tai <thomas.tai@oracle.com> wrote:

>
>
> On 08/01/2018 01:42 AM, gokul cg wrote:
>
>> Hi Thomas,
>>
>> In my hardware, there is i2c power control chip for PCI card, I just
>> powered down using i2c command .
>>
>
> Hi Gokul,
> When you power off the card via the i2c, it forcefully power off the card
> without notify the kernel? That is, during the card power off sequence it
> manages to send a last AER isr to report the error and die? I am kind of
> expect the pcie surprise removal or hot plug driver will handle it
> correctly.
>
> Thanks,
> Thomas
>
>
>> Regards,
>> Gokul
>>
>

--0000000000000112c10572643167
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">HI Thomas ,=C2=A0<div><br></div><div><br></div><div>Yes , =
its surprise removal .</div><div><br></div><div>But as far as I know , linu=
x kernel will handle surprise removal of PCIe device without panic.</div><d=
iv><br></div><div><span style=3D"font-family:&quot;Helvetica Neue&quot;,Ari=
al,sans-serif;text-decoration-style:initial;text-decoration-color:initial;f=
loat:none;display:inline">The</span><span style=3D"font-family:&quot;Helvet=
ica Neue&quot;,Arial,sans-serif;text-decoration-style:initial;text-decorati=
on-color:initial;float:none;display:inline"><span>=C2=A0</span>driver will =
suddenly start reading all 0xff and will then need to</span><br style=3D"fo=
nt-family:&quot;Helvetica Neue&quot;,Arial,sans-serif;text-decoration-style=
:initial;text-decoration-color:initial"><span style=3D"font-family:&quot;He=
lvetica Neue&quot;,Arial,sans-serif;text-decoration-style:initial;text-deco=
ration-color:initial;float:none;display:inline">abort</span><span style=3D"=
font-family:&quot;Helvetica Neue&quot;,Arial,sans-serif;text-decoration-sty=
le:initial;text-decoration-color:initial;float:none;display:inline"><span>=
=C2=A0</span>whatever</span><span style=3D"font-family:&quot;Helvetica Neue=
&quot;,Arial,sans-serif;text-decoration-style:initial;text-decoration-color=
:initial;float:none;display:inline"><span>=C2=A0</span>it was doing</span><=
span style=3D"font-family:&quot;Helvetica Neue&quot;,Arial,sans-serif;text-=
decoration-style:initial;text-decoration-color:initial;float:none;display:i=
nline">. Usually</span><span style=3D"font-family:&quot;Helvetica Neue&quot=
;,Arial,sans-serif;text-decoration-style:initial;text-decoration-color:init=
ial;float:none;display:inline"><span>=C2=A0</span>all drivers handle this j=
ust fine.</span><br></div><div><span style=3D"font-family:&quot;Helvetica N=
eue&quot;,Arial,sans-serif;text-decoration-style:initial;text-decoration-co=
lor:initial;float:none;display:inline"><br></span></div><div><span style=3D=
"font-family:&quot;Helvetica Neue&quot;,Arial,sans-serif;text-decoration-st=
yle:initial;text-decoration-color:initial;float:none;display:inline"><span =
style=3D"text-decoration-style:initial;text-decoration-color:initial;float:=
none;display:inline">Nothing</span><span style=3D"text-decoration-style:ini=
tial;text-decoration-color:initial;float:none;display:inline">, the driver =
individually</span><span style=3D"text-decoration-style:initial;text-decora=
tion-color:initial;float:none;display:inline"><span>=C2=A0</span>needs to h=
andle the fact that it might</span><br style=3D"text-decoration-style:initi=
al;text-decoration-color:initial"><span style=3D"text-decoration-style:init=
ial;text-decoration-color:initial;float:none;display:inline">at any time, s=
tart</span><span style=3D"text-decoration-style:initial;text-decoration-col=
or:initial;float:none;display:inline"><span>=C2=A0</span>getting invalid</s=
pan><span style=3D"text-decoration-style:initial;text-decoration-color:init=
ial;float:none;display:inline"><span>=C2=A0</span>data. If it doesn&#39;t, =
it needs to be</span><br style=3D"text-decoration-style:initial;text-decora=
tion-color:initial"><span style=3D"text-decoration-style:initial;text-decor=
ation-color:initial;float:none;display:inline">fixed. Whether AER=C2=A0 dri=
ver that does not handle this properly?</span><br style=3D"text-decoration-=
style:initial;text-decoration-color:initial"><br></span></div><div><br></di=
v><div><font face=3D"Helvetica Neue, Arial, sans-serif">Regards,</font></di=
v><div><font face=3D"Helvetica Neue, Arial, sans-serif">Gokul=C2=A0</font><=
/div></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Wed=
, Aug 1, 2018 at 11:17 PM, Thomas Tai <span dir=3D"ltr">&lt;<a href=3D"mail=
to:thomas.tai@oracle.com" target=3D"_blank">thomas.tai@oracle.com</a>&gt;</=
span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8e=
x;border-left:1px #ccc solid;padding-left:1ex"><br>
<br>
On 08/01/2018 01:42 AM, gokul cg wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
Hi Thomas,<span class=3D""><br>
<br>
In my hardware, there is i2c power control chip for PCI card, I just powere=
d down using i2c command .<br>
</span></blockquote>
<br>
Hi Gokul,<br>
When you power off the card via the i2c, it forcefully power off the card w=
ithout notify the kernel? That is, during the card power off sequence it ma=
nages to send a last AER isr to report the error and die? I am kind of expe=
ct the pcie surprise removal or hot plug driver will handle it correctly.<b=
r>
<br>
Thanks,<br>
Thomas<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
<br>
Regards,<br>
Gokul<br>
</blockquote>
</blockquote></div><br></div>

--0000000000000112c10572643167--
