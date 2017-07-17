Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qk0-f195.google.com ([209.85.220.195]:36298 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751316AbdGQTlY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Jul 2017 15:41:24 -0400
Received: by mail-qk0-f195.google.com with SMTP id d136so2356587qkg.3
        for <linux-pci@vger.kernel.org>; Mon, 17 Jul 2017 12:41:23 -0700 (PDT)
From: "Jingoo Han" <jingoohan1@gmail.com>
To: "'Z.q. Hou'" <zhiqiang.hou@nxp.com>,
        "'Joao Pinto'" <Joao.Pinto@synopsys.com>,
        <linux-pci@vger.kernel.org>, <bhelgaas@google.com>
References: <1499322829-23018-1-git-send-email-Zhiqiang.Hou@nxp.com> <a4510ddb-3037-0787-c00e-b2703d66d54b@synopsys.com> <AM5PR0402MB2771B6A74E7DBF156BA066A484AA0@AM5PR0402MB2771.eurprd04.prod.outlook.com> <7cebf6a4-bedd-015f-9d1a-1e82fa42d41d@synopsys.com> <AM5PR0402MB2771C3717050F4D2D69EB74384AE0@AM5PR0402MB2771.eurprd04.prod.outlook.com>
In-Reply-To: <AM5PR0402MB2771C3717050F4D2D69EB74384AE0@AM5PR0402MB2771.eurprd04.prod.outlook.com>
Subject: Re: [PATCH 1/3] PCI: designware: add accessors for write permission of DBI read-only registers
Date: Mon, 17 Jul 2017 15:41:21 -0400
Message-ID: <000d01d2ff34$ab71cd30$02556790$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday, July 11, 2017 12:11 AM, Z.q. Hou wrote:
>=20
> Hi Bjorn,
>=20
> Due to all Freescale Layerscpe PCIe controllers have to fix the Class =
code,
> and this fixup existed in both Layerscape pcie driver and DWC common =
code,
> so I want to reuse the fixup in DWC common code.
> Can you give me any suggestion?

Please don't add your comment on top of the email.


>=20
> > -----Original Message-----
> > From: Joao Pinto [mailto:Joao.Pinto@synopsys.com]
> > Sent: 2017=E5=B9=B47=E6=9C=887=E6=97=A5 16:53
> > To: Z.q. Hou <zhiqiang.hou@nxp.com>; Joao Pinto
> > <Joao.Pinto@synopsys.com>; linux-pci@vger.kernel.org;
> > bhelgaas@google.com
> > Cc: jingoohan1@gmail.com
> > Subject: Re: [PATCH 1/3] PCI: designware: add accessors for write
> permission
> > of DBI read-only registers
> >
> >
> > Hi Zhiqiang,
> >
> > =C3=80s 4:48 AM de 7/7/2017, Z.q. Hou escreveu:
> > > Hi Joao,
> > >
> > >
> > >
> > > Thanks a lot for your comments!
> > >
> > >
> > >
> > >> -----Original Message-----
> > >
> > >> From: Joao Pinto [mailto:Joao.Pinto@synopsys.com]
> > >
> > >> Sent: 2017=E5=B9=B47=E6=9C=886=E6=97=A5 17:44
> > >
> > >> To: Z.q. Hou <zhiqiang.hou@nxp.com>; linux-pci@vger.kernel.org;
> > >
> > >> Joao.Pinto@synopsys.com
> > >
> > >> Cc: bhelgaas@google.com; jingoohan1@gmail.com
> > >
> > >> Subject: Re: [PATCH 1/3] PCI: designware: add accessors for write
> > >> permission
> > >
> > >> of DBI read-only registers
> > >
> > >>
> > >
> > >>
> > >
> > >> Hi Zhiqiang,
> > >
> > >>
> > >
> > >> =C3=80s 7:33 AM de 7/6/2017, Zhiqiang Hou escreveu:
> > >
> > >>> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> > >
> > >>>
> > >
> > >>> The read-only DBI registers can be written over the DBI when set =
the
> > >
> > >>> "Write to RO Registers Using DBI" (DBI_RO_WR_EN) field of the
> > >
> > >>> MISC_CONTROL_1_OFF register.
> > >
> > >>
> > >
> > >> I would suggest you to add a cover-letter next time to explain =
the
> > >> global
> > >
> > >> picture of the patch-set.
> > >
> > >
> > >
> > > Thanks, I will.
> > >
> > >
> > >
> > >>
> > >
> > >> I understand your need for this patch, but I don't agree on the
> approach.
> > >
> > >
> > >
> > > In the DWC common code, there is a function write a DBI read-only
> register
> > 'Device class code', and the first 2 patches is to fix it.
> > >
> > > The 3rd patch is to refactor the Layerscape PCIe driver's =
host_init
> function
> > and reuse the new added accessors.
> > >
> > >
> > >
> > >> Sometimes the people in charge of the hardware design /
> > >> configuration, forget
> > >
> > >> to specify the device class and that can be problematic for some
> > >> drivers, and
> > >
> > >> so the typical workaround is to set it in the driver using a =
quirk
> for example.
> > >
> > >>
> > >
> > >> You can see some examples here:
> > >
> > >> =
https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__git.kernel.org_p
> > >> =
ub_scm_linux_kernel_git_torvalds_linux.git_tree_drivers_&d=3DDwIGaQ&c=3DD=

> > >>
> > PL6_X_6JkXFx7AXWqB0tg&r=3Ds2fO0hii0OGNOv9qQy_HRXy-xAJUD1NNoEcc3io
> > _kx0&m
> > >>
> > =3D0DrBCvOc_J7LaMXBei1qCXxxfbLxWaVErKZ6Rkm6bUc&s=3DsOEmExQFqrCEmpA
> > x9LjSeK
> > >> RvkW1D-W82ckX5WGCgFWw&e=3D
> > >
> > >> pci/quirks.c
> > >
> > >
> > >
> > > I don't know the PCI quirks, do you mean remove the pci Device =
Class
> fix
> > code from the DWC common code and add it to quirks?
> > >
> >
> > In my opinion adding fixes to a common code is not a good approach. =
I
> would
> > suggest the fix to go into the quirks file.

Your answer should be added to here.
Then, it will help other people follow this email thread.

Best regards,
Jingoo Han

> >
> > @Bjorn: The quirks file is the best place for this type of fixes =
right?
>=20
> Thanks,
> Zhiqiang
>=20
