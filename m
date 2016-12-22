Return-Path: <SRS0=uU0d=YF=gmail.com=hjmallon@kernel.org>
Return-Path: <SRS0=uU0d=YF=gmail.com=hjmallon@kernel.org>
From: Harry Mallon <hjmallon@gmail.com>
Message-Id: <F9DB0FE1-0518-4799-98A9-DA9053A86AEC@gmail.com>
Content-Type: multipart/mixed;
 boundary="Apple-Mail=_E1435346-E096-4589-BDEF-81A10BD8412A"
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: Re: lspci memory behind bridge reporting
Date: Thu, 22 Dec 2016 13:39:58 +0000
In-Reply-To: <20161221201635.GA31167@bhelgaas-glaptop.roam.corp.google.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Bjorn Helgaas <helgaas@kernel.org>
To: Martin Mares <mj@ucw.cz>
References: <CDB45911-510C-459D-BCDC-17955FCC400D@gmail.com>
 <20161221201635.GA31167@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>


--Apple-Mail=_E1435346-E096-4589-BDEF-81A10BD8412A
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

I attach a patch with behaviour similar to what you describe. It is =
based on the current master branch of pciutils (hash =
4a190235224ff6dfe44adbb07ac929afea612acd).

Here is a sample taken from my machine with -vvv:

        I/O behind bridge: 0000f000-00000fff [size=3DNone]
        Memory behind bridge: f4400000-f47fffff [size=3D4M]
        Prefetchable memory behind bridge: =
00000000cfc00000-00000000cfcfffff [size=3D1M]

With -vv or -v it shows (as before but with size):

        Memory behind bridge: f4400000-f47fffff [size=3D4M]
        Prefetchable memory behind bridge: =
00000000cfc00000-00000000cfcfffff [size=3D1M]

I have not altered anything in the tests folder yet as I am not sure =
about how to run them.

Harry



--Apple-Mail=_E1435346-E096-4589-BDEF-81A10BD8412A
Content-Disposition: attachment;
	filename=0001-Give-more-info-on-X-behind-bridge.patch
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="0001-Give-more-info-on-X-behind-bridge.patch"
Content-Transfer-Encoding: quoted-printable

=46rom=20a8f0d7b68376d5d04a861893278337f2622d9c3a=20Mon=20Sep=2017=20=
00:00:00=202001=0AFrom:=20Harry=20Mallon=20<hjmallon@gmail.com>=0ADate:=20=
Thu,=2022=20Dec=202016=2012:39:54=20+0000=0ASubject:=20[PATCH]=20Give=20=
more=20info=20on=20"X=20behind=20bridge"=0A=0A*=20Show=20size=20of=20=
buffer=0A*=20Show=20[size=3DNone]=20if=20no=20size=0A---=0A=20=
lib/types.h=20|=20=202=20++=0A=20lspci.c=20=20=20=20=20|=2043=20=
+++++++++++++++++++++++++++++++++++++------=0A=202=20files=20changed,=20=
39=20insertions(+),=206=20deletions(-)=0A=0Adiff=20--git=20a/lib/types.h=20=
b/lib/types.h=0Aindex=204d23e69..93a8497=20100644=0A---=20a/lib/types.h=0A=
+++=20b/lib/types.h=0A@@=20-42,10=20+42,12=20@@=20typedef=20unsigned=20=
long=20long=20u64;=0A=20#ifdef=20PCI_HAVE_64BIT_ADDRESS=0A=20typedef=20=
u64=20pciaddr_t;=0A=20#define=20PCIADDR_T_FMT=20"%08"=20PCI_U64_FMT=20=
"x"=0A+#define=20PCIADDR_T_FMT_L=20"%016"=20PCI_U64_FMT=20"x"=0A=20=
#define=20PCIADDR_PORT_FMT=20"%04"=20PCI_U64_FMT=20"x"=0A=20#else=0A=20=
typedef=20u32=20pciaddr_t;=0A=20#define=20PCIADDR_T_FMT=20"%08x"=0A=
+#define=20PCIADDR_T_FMT_L=20PCIADDR_T_FMT=0A=20#define=20=
PCIADDR_PORT_FMT=20"%04x"=0A=20#endif=0A=20=0Adiff=20--git=20a/lspci.c=20=
b/lspci.c=0Aindex=205b6716e..7969248=20100644=0A---=20a/lspci.c=0A+++=20=
b/lspci.c=0A@@=20-344,6=20+344,15=20@@=20show_size(pciaddr_t=20x)=0A=20}=0A=
=20=0A=20static=20void=0A+show_size_or_none(pciaddr_t=20base,=20=
pciaddr_t=20limit)=0A+{=0A+=20=20if=20(limit=20>=3D=20base)=0A+=20=20=20=20=
show_size(limit=20-=20base=20+=201);=0A+=20=20else=0A+=20=20=20=20=
printf("=20[size=3DNone]");=0A+}=0A+=0A+static=20void=0A=20=
show_bases(struct=20device=20*d,=20int=20cnt)=0A=20{=0A=20=20=20struct=20=
pci_dev=20*p=20=3D=20d->dev;=0A@@=20-481,8=20+490,8=20@@=20=
show_htype1(struct=20device=20*d)=0A=20=20=20u32=20mem_base=20=3D=20=
get_conf_word(d,=20PCI_MEMORY_BASE);=0A=20=20=20u32=20mem_limit=20=3D=20=
get_conf_word(d,=20PCI_MEMORY_LIMIT);=0A=20=20=20u32=20mem_type=20=3D=20=
mem_base=20&=20PCI_MEMORY_RANGE_TYPE_MASK;=0A-=20=20u32=20pref_base=20=3D=20=
get_conf_word(d,=20PCI_PREF_MEMORY_BASE);=0A-=20=20u32=20pref_limit=20=3D=20=
get_conf_word(d,=20PCI_PREF_MEMORY_LIMIT);=0A+=20=20pciaddr_t=20=
pref_base=20=3D=20get_conf_word(d,=20PCI_PREF_MEMORY_BASE);=0A+=20=20=
pciaddr_t=20pref_limit=20=3D=20get_conf_word(d,=20=
PCI_PREF_MEMORY_LIMIT);=0A=20=20=20u32=20pref_type=20=3D=20pref_base=20&=20=
PCI_PREF_RANGE_TYPE_MASK;=0A=20=20=20word=20sec_stat=20=3D=20=
get_conf_word(d,=20PCI_SEC_STATUS);=0A=20=20=20word=20brc=20=3D=20=
get_conf_word(d,=20PCI_BRIDGE_CONTROL);=0A@@=20-508,7=20+517,11=20@@=20=
show_htype1(struct=20device=20*d)=0A=20=09=20=20io_limit=20|=3D=20=
(get_conf_word(d,=20PCI_IO_LIMIT_UPPER16)=20<<=2016);=0A=20=09}=0A=20=20=20=
=20=20=20=20if=20(io_base=20<=3D=20io_limit=20||=20verb)=0A-=09=
printf("\tI/O=20behind=20bridge:=20%08x-%08x\n",=20io_base,=20=
io_limit+0xfff);=0A+=09{=0A+=09=20=20printf("\tI/O=20behind=20bridge:=20=
%08x-%08x",=20io_base,=20io_limit+0xfff);=0A+=09=20=20=
show_size_or_none(io_base,=20io_limit+0xfff);=0A+=09=20=20putchar('\n');=0A=
+=09}=0A=20=20=20=20=20}=0A=20=0A=20=20=20if=20(mem_type=20!=3D=20=
(mem_limit=20&=20PCI_MEMORY_RANGE_TYPE_MASK)=20||=0A@@=20-519,12=20=
+532,16=20@@=20show_htype1(struct=20device=20*d)=0A=20=20=20=20=20=20=20=
mem_base=20=3D=20(mem_base=20&=20PCI_MEMORY_RANGE_MASK)=20<<=2016;=0A=20=20=
=20=20=20=20=20mem_limit=20=3D=20(mem_limit=20&=20PCI_MEMORY_RANGE_MASK)=20=
<<=2016;=0A=20=20=20=20=20=20=20if=20(mem_base=20<=3D=20mem_limit=20||=20=
verb)=0A-=09printf("\tMemory=20behind=20bridge:=20%08x-%08x\n",=20=
mem_base,=20mem_limit=20+=200xfffff);=0A+=09{=0A+=09=20=20=
printf("\tMemory=20behind=20bridge:=20%08x-%08x",=20mem_base,=20=
mem_limit=20+=200xfffff);=0A+=09=20=20show_size_or_none(mem_base,=20=
mem_limit=20+=200xfffff);=0A+=09=20=20putchar('\n');=0A+=09}=0A=20=20=20=20=
=20}=0A=20=0A=20=20=20if=20(pref_type=20!=3D=20(pref_limit=20&=20=
PCI_PREF_RANGE_TYPE_MASK)=20||=0A=20=20=20=20=20=20=20(pref_type=20!=3D=20=
PCI_PREF_RANGE_TYPE_32=20&&=20pref_type=20!=3D=20=
PCI_PREF_RANGE_TYPE_64))=0A-=20=20=20=20printf("\t!!!=20Unknown=20=
prefetchable=20memory=20range=20types=20%x/%x\n",=20pref_base,=20=
pref_limit);=0A+=20=20=20=20printf("\t!!!=20Unknown=20prefetchable=20=
memory=20range=20types=20"=20PCIADDR_T_FMT_L=20"/"=20PCIADDR_T_FMT_L=20=
"\n",=20pref_base,=20pref_limit);=0A=20=20=20else=0A=20=20=20=20=20{=0A=20=
=20=20=20=20=20=20pref_base=20=3D=20(pref_base=20&=20=
PCI_PREF_RANGE_MASK)=20<<=2016;=0A@@=20-532,13=20+549,27=20@@=20=
show_htype1(struct=20device=20*d)=0A=20=20=20=20=20=20=20if=20(pref_base=20=
<=3D=20pref_limit=20||=20verb)=0A=20=09{=0A=20=09=20=20if=20(pref_type=20=
=3D=3D=20PCI_PREF_RANGE_TYPE_32)=0A-=09=20=20=20=20=
printf("\tPrefetchable=20memory=20behind=20bridge:=20%08x-%08x\n",=20=
pref_base,=20pref_limit=20+=200xfffff);=0A+=09=20=20=20=20{=0A+=09=20=20=20=
=20=20=20printf("\tPrefetchable=20memory=20behind=20bridge:=20"=20=
PCIADDR_T_FMT_L=20"-"=20PCIADDR_T_FMT_L,=20pref_base,=20pref_limit=20+=20=
0xfffff);=0A+=09=20=20=20=20=20=20show_size_or_none(pref_base,=20=
pref_limit=20+=200xfffff);=0A+=09=20=20=20=20=20=20putchar('\n');=0A+=09=20=
=20=20=20}=0A=20=09=20=20else=0A+#ifdef=20PCI_HAVE_64BIT_ADDRESS=0A+=09=20=
=20=20=20{=0A+=09=20=20=20=20=20=20pref_base=20=3D=20pref_base=20|=20(=20=
(pciaddr_t)get_conf_long(d,=20PCI_PREF_BASE_UPPER32)=20<<=2032);=0A+=09=20=
=20=20=20=20=20pref_limit=20=3D=20pref_limit=20|=20(=20=
(pciaddr_t)get_conf_long(d,=20PCI_PREF_LIMIT_UPPER32)=20<<=2032);=0A+=09=20=
=20=20=20=20=20printf("\tPrefetchable=20memory=20behind=20bridge:=20"=20=
PCIADDR_T_FMT_L=20"-"=20PCIADDR_T_FMT_L,=20pref_base,=20pref_limit=20+=20=
0xfffff);=0A+=09=20=20=20=20=20=20show_size_or_none(pref_base,=20=
pref_limit=20+=200xfffff);=0A+=09=20=20=20=20=20=20putchar('\n');=0A+=09=20=
=20=20=20}=0A+#else=0A=20=09=20=20=20=20printf("\tPrefetchable=20memory=20=
behind=20bridge:=20%08x%08x-%08x%08x\n",=0A=20=09=09=20=20=20=
get_conf_long(d,=20PCI_PREF_BASE_UPPER32),=0A=20=09=09=20=20=20=
pref_base,=0A=20=09=09=20=20=20get_conf_long(d,=20=
PCI_PREF_LIMIT_UPPER32),=0A=20=09=09=20=20=20pref_limit=20+=200xfffff);=0A=
+#endif=0A=20=09}=0A=20=20=20=20=20}=0A=20=0A--=20=0A2.11.0=0A=0A=

--Apple-Mail=_E1435346-E096-4589-BDEF-81A10BD8412A
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii





> On 21 Dec 2016, at 20:16, Bjorn Helgaas <helgaas@kernel.org> wrote:
>=20
> [+cc Martin (lspci maintainer)]
>=20
> On Wed, Dec 21, 2016 at 04:53:30PM +0000, Harry Mallon wrote:
>> Hello all,
>>=20
>> I am currently debugging a PCIE BAR assignment issue and am working =
on a patch to save me some time in future with lspci. Would patches like =
this be considered? Does anyone have any input on the proposed formats =
of the readouts?
>>=20
>> 1. Currently if a bridge has no memory behind bridge it displays =
messages like the following, for reasons of PCI implementation detail.
>>=20
>> I/O behind bridge: 0000f000-00000fff
>> Memory behind bridge: fff00000-000fffff
>> Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
>>=20
>> I would prefer:
>> I/O behind bridge: None
>> Memory behind bridge: None
>> Prefetchable memory behind bridge: None
>=20
> Thanks for the suggestions, Harry.  I would like this, too.  Maybe
> this with "-v":
>=20
>  I/O behind bridge: None
>=20
> and this with "-vv":
>=20
>  I/O behind bridge: None (0000f000-00000fff)
>=20
> There are many register values that disable the windows, and it's
> conceivable that somebody would want to match the actual register
> values with an analyzer trace or a piece of code.
>=20
>> 2. It would be useful for me to have access to the amount of memory =
in these chunks (my mental hex subtraction is pretty terrible). Maybe =
this would be displayed something like
>>=20
>> I/O behind bridge: 0000c000-0000dfff [8.00K]
>> Memory behind bridge: f4000000-f65fffff [38.00M]
>> Prefetchable memory behind bridge: 00000000e0000000-00000000f3ffffff =
[320.00M]
>=20
> This makes sense to me, too, though I would use the same size format
> lspci already uses for endpoint BARs, e.g.,
>=20
>  Memory at f1000000 (64-bit, non-prefetchable) [size=3D8K]
>=20
> Of course, BARs are always a nice power-of-two, so there's no need for
> fractions, while bridge window sizes are much less constrained.  I
> don't know whether it's better to use decimal places as you did, or to
> use the largest unit size (K, M, G) that expresses the size as a whole
> number.
>=20
> Be sure to send any patches to Martin directly; I doubt he monitors
> linux-pci closely.
>=20
> Bjorn


--Apple-Mail=_E1435346-E096-4589-BDEF-81A10BD8412A--
