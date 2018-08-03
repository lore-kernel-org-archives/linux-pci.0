Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35923 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727577AbeHCJJw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Aug 2018 05:09:52 -0400
Received: by mail-wm0-f65.google.com with SMTP id w24-v6so5240290wmc.1
        for <linux-pci@vger.kernel.org>; Fri, 03 Aug 2018 00:14:56 -0700 (PDT)
MIME-Version: 1.0
References: <20180730134316.11719-1-lorenzo.pieralisi@arm.com>
In-Reply-To: <20180730134316.11719-1-lorenzo.pieralisi@arm.com>
From: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
Date: Fri, 3 Aug 2018 12:44:44 +0530
Message-ID: <CAFZiPx2Y8LJXHKh--=8YZe3bPdY500JA-+9n0TWWj43N5fNO9g@mail.gmail.com>
Subject: Re: [PATCH 0/3] PCI: mobiveil: Misc fixes
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Content-Type: multipart/alternative; boundary="0000000000004a3da5057282af0a"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--0000000000004a3da5057282af0a
Content-Type: text/plain; charset="UTF-8"

Lorenzo,
Please go ahead.
Acked by: Subrahmanya lingappa

Thanks for this.
Subrahmanya

On Mon 30 Jul, 2018, 7:13 PM Lorenzo Pieralisi, <lorenzo.pieralisi@arm.com>
wrote:

> Subrahmanya,
>
> I put together this series so that the Mobiveil controller driver
> can compile (successfully). Please review and ack as soon as possible
> since the current situation is a bit embarassing to be honest, we
> should be sending these patches as fixes this week so that they
> can make it for v4.18, currently the driver is in the kernel for
> nothing.
>
> Thank you
> Lorenzo
>
> Cc: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
>
> Lorenzo Pieralisi (3):
>   PCI: mobiveil: Fix struct mobiveil_pcie.pcie_reg_base address type
>   PCI: mobiveil: Add missing ../pci.h include
>   PCI: mobiveil: Add Kconfig/Makefile entries
>
>  drivers/pci/controller/Kconfig         | 10 ++++++++++
>  drivers/pci/controller/Makefile        |  1 +
>  drivers/pci/controller/pcie-mobiveil.c |  4 +++-
>  3 files changed, 14 insertions(+), 1 deletion(-)
>
> --
> 2.15.0
>
>

--0000000000004a3da5057282af0a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Lorenzo,<div dir=3D"auto">Please go ahead.</div><div dir=
=3D"auto">Acked by: Subrahmanya lingappa</div><div dir=3D"auto"><br></div><=
div dir=3D"auto">Thanks for this.</div><div dir=3D"auto">Subrahmanya</div><=
/div><br><div class=3D"gmail_quote"><div dir=3D"ltr">On Mon 30 Jul, 2018, 7=
:13 PM Lorenzo Pieralisi, &lt;<a href=3D"mailto:lorenzo.pieralisi@arm.com">=
lorenzo.pieralisi@arm.com</a>&gt; wrote:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left=
:1ex">Subrahmanya,<br>
<br>
I put together this series so that the Mobiveil controller driver<br>
can compile (successfully). Please review and ack as soon as possible<br>
since the current situation is a bit embarassing to be honest, we<br>
should be sending these patches as fixes this week so that they<br>
can make it for v4.18, currently the driver is in the kernel for<br>
nothing.<br>
<br>
Thank you<br>
Lorenzo<br>
<br>
Cc: Subrahmanya Lingappa &lt;<a href=3D"mailto:l.subrahmanya@mobiveil.co.in=
" target=3D"_blank" rel=3D"noreferrer">l.subrahmanya@mobiveil.co.in</a>&gt;=
<br>
Cc: Bjorn Helgaas &lt;<a href=3D"mailto:bhelgaas@google.com" target=3D"_bla=
nk" rel=3D"noreferrer">bhelgaas@google.com</a>&gt;<br>
<br>
Lorenzo Pieralisi (3):<br>
=C2=A0 PCI: mobiveil: Fix struct mobiveil_pcie.pcie_reg_base address type<b=
r>
=C2=A0 PCI: mobiveil: Add missing ../pci.h include<br>
=C2=A0 PCI: mobiveil: Add Kconfig/Makefile entries<br>
<br>
=C2=A0drivers/pci/controller/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 10 =
++++++++++<br>
=C2=A0drivers/pci/controller/Makefile=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 1 =
+<br>
=C2=A0drivers/pci/controller/pcie-mobiveil.c |=C2=A0 4 +++-<br>
=C2=A03 files changed, 14 insertions(+), 1 deletion(-)<br>
<br>
-- <br>
2.15.0<br>
<br>
</blockquote></div>

--0000000000004a3da5057282af0a--
