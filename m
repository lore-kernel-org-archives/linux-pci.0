Return-Path: <rjw@rjwysocki.net>
Return-Path: <rjw@rjwysocki.net>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Dongdong Liu <liudongdong3@huawei.com>
Cc: helgaas@kernel.org, arnd@arndb.de, rafael@kernel.org, Lorenzo.Pieralisi@arm.com, tn@semihalf.com, wangzhou1@hisilicon.com, pratyush.anand@gmail.com, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, jcm@redhat.com, gabriele.paoloni@huawei.com, charles.chenxin@huawei.com, hanjun.guo@linaro.org, linuxarm@huawei.com
Subject: Re: [RFC PATCH V2 3/3] PCI/ACPI: hisi: Add ACPI support for HiSilicon SoCs Host Controllers
Date: Fri, 02 Sep 2016 01:38:04 +0200
Message-ID: <2811400.eXt00oZUV7@vostro.rjw.lan>
In-Reply-To: <57C79F3E.4050405@huawei.com>
References: <1472644094-82731-1-git-send-email-liudongdong3@huawei.com> <2194589.LrAdKSkzcT@vostro.rjw.lan> <57C79F3E.4050405@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-pci.vger.kernel.org>

On Thursday, September 01, 2016 11:23:42 AM Dongdong Liu wrote:
>=20
> =E5=9C=A8 2016/9/1 6:56, Rafael J. Wysocki =E5=86=99=E9=81=93:
> > On Wednesday, August 31, 2016 07:48:14 PM Dongdong Liu wrote:
> >> Add specific quirks for PCI config space accessors.This involves:
> >> 1. New initialization call hisi_pcie_acpi_init() to get RC config =
resource
> >> with hardcoded range address and setup ecam mapping.
> >> 2. New entry in common quirk array.
> >>
> >> Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>
> >> Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
> >
> > Well, what exactly is the ACPI support you're adding?  Is it the EC=
AM part only
> > or is there anything more to it?
> >
>=20
> Hi Rafael, thanks for replying.
>=20
> Our host bridge is non ECAM only for the RC bus config space;
> for any other bus underneath the root bus we support ECAM access.
>=20
> In our case we cannot use the standard MCFG object to pass the RC its=
elf config space addresses.
> The more discuss information can be found:
> https://lkml.org/lkml/2016/2/22/1087
> [...]
> I have looked into this and in our case we cannot use the
> standard MCFG object to pass the RC config space addresses.
>=20
> The reason is that in our HW we have the config base addresses of the=

> root complex ports that are less than 0x100000 byte distant one from
> the other as we only map the first 0x10000 bytes.
> Now the MCFG acpi framework always fix the MCFG resource size to 0x10=
0000
> for each bus; therefore if we pass our RC addresses through MCFG we e=
nd
> up with a resource conflict.
> To give you a practical example we are in a situation where we have:
>=20
> port0: [0x00000000b0080000 - 0x00000000b0080000 + 0x10000]
> port1: [0x00000000b0090000 - 0x00000000b0090000 + 0x10000]
> port2: [0x00000000b00A0000 - 0x00000000b00A0000 + 0x10000]
> port3: [0x00000000b00B0000 - 0x00000000b00B0000 + 0x10000]
> So if we pass the base addresses through MCFG the resources
> will overlap as MCFG will consider 0x100000 size for each base
> address of the root complex (only the RC bus uses that address)
> So far I do not see many option other than using _DSD to pass
> these RC config base addresses.

It still is not entirely clear to me what the "ACPI support" is here.

Do you read any configuration information from the ACPI tables or simil=
ar?

If so, where is the format of it documented?

Thanks,
Rafael
