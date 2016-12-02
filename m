Return-Path: <SRS0=xjg9=XR=redhat.com=jcm@kernel.org>
Return-Path: <SRS0=xjg9=XR=redhat.com=jcm@kernel.org>
Content-Type: text/plain;
	charset=us-ascii
From: Jon Masters <jcm@redhat.com>
MIME-Version: 1.0
Subject: Re: [PATCH v4 1/1] PCI/ACPI: xgene: Add ECAM quirk for X-Gene PCIe controller
Message-Id: <175F32B0-C73F-4250-9E60-3CE7409F0B0C@redhat.com>
Date: Fri, 2 Dec 2016 03:11:54 -0500 (EST)
References: <20161201183350.GF30746@bhelgaas-glaptop.roam.corp.google.com> <f18738b7096fb06a5865214ddc299ce99630673b.1480644928.git.dhdang@apm.com> <6d593615-e97f-8738-42be-1f8f4906d2f4@redhat.com> <CADaLNDkyCrheZLNG3_9BVgvGBW8WrA-VPWOCezz3U-g+nt5W9w@mail.gmail.com>
To: Duc Dang <dhdang@apm.com>
In-Reply-To: <CADaLNDkyCrheZLNG3_9BVgvGBW8WrA-VPWOCezz3U-g+nt5W9w@mail.gmail.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Rafael Wysocki <rafael@kernel.org>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, Mark Salter <msalter@redhat.com>,
        linux-pci@vger.kernel.org,
        linux-arm <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tomasz Nowicki <tn@semihalf.com>, patches <patches@apm.com>
List-ID: <linux-pci.vger.kernel.org>

You're welcome.

(Unrelated) Note that I added a console=3D and earlycon in my test (and got t=
he baud rate wrong for the console but nevermind...was ssh'd in after the ea=
rlycon output I cared about anyway) because of some other cleanup work for t=
he SPCR parsing that apparently is still not quite fixed for upstream, or ra=
ther, there is a need to match on the 32-bit access required for the UART an=
d that isn't happening so it's not getting setup. Folks are tracking that on=
e and fixing it though.

--=20
Computer Architect | Sent from my 64-bit #ARM Powered phone

> On Dec 2, 2016, at 02:37, Duc Dang <dhdang@apm.com> wrote:
>=20
>> On Thu, Dec 1, 2016 at 11:12 PM, Jon Masters <jcm@redhat.com> wrote:
>>> On 12/01/2016 09:27 PM, Duc Dang wrote:
>>> PCIe controllers in X-Gene SoCs is not ECAM compliant: software
>>> needs to configure additional controller's register to address
>>> device at bus:dev:function.
>>>=20
>>> The quirk will discover controller MMIO register space and configure
>>> controller registers to select and address the target secondary device.
>>>=20
>>> The quirk will only be applied for X-Gene PCIe MCFG table with
>>> OEM revison 1, 2, 3 or 4 (PCIe controller v1 and v2 on X-Gene SoCs).
>>>=20
>>> Signed-off-by: Duc Dang <dhdang@apm.com>
>>=20
>> So far I've tested this on an HPE ProLiant m400 (Moonshot) cartridge
>> and will test it on some other reference platforms soon. Bootlog for
>> the m400 attached in case Bjorn wants to see the output. Here's
>> what I see in /proc/iomem btw on that platform:
>>=20
>> # cat /proc/iomem
>> 10520000-10523fff : APMC0D18:00
>>  10520000-10523fff : APMC0D18:00
>> 10524000-10527fff : APMC0D17:00
>> 10540000-1054a0ff : APMC0D01:00
>>  10546000-10546fff : APMC0D50:00
>>  1054a000-1054a00f : APMC0D12:03
>>    1054a000-1054a00f : APMC0D12:02
>>      1054a000-1054a00f : APMC0D12:01
>>        1054a000-1054a00f : APMC0D12:00
>> 17000000-17000fff : APMC0D01:00
>> 17001000-17001fff : APMC0D01:00
>>  17001000-170013ff : APMC0D15:00
>>    17001000-170013ff : APMC0D15:00
>> 1701c000-1701cfff : APMC0D14:00
>> 1a800000-1a800fff : APMC0D0D:00
>>  1a800000-1a800fff : APMC0D0D:00
>> 1c000200-1c0002ff : APMC0D06:00
>> 1c021000-1c0210ff : APMC0D08:00
>>  1c021000-1c02101f : serial
>> 1c024000-1c024fff : APMC0D07:00
>> 1f230000-1f230fff : APMC0D0D:00
>>  1f230000-1f230fff : APMC0D0D:00
>> 1f23d000-1f23dfff : APMC0D0D:00
>>  1f23d000-1f23dfff : APMC0D0D:00
>> 1f23e000-1f23efff : APMC0D0D:00
>>  1f23e000-1f23efff : APMC0D0D:00
>> 1f2a0000-1f31ffff : APMC0D06:00
>> 1f500000-1f50ffff : PCI Bus 0000:00
>>  1f500000-1f50ffff : PNP0A08:00
>> 78800000-78800fff : APMC0D13:00
>>  78800000-78800fff : APMC0D12:03
>>    78800000-78800fff : APMC0D12:02
>>      78800000-78800fff : APMC0D12:01
>>        78800000-78800fff : APMC0D12:00
>>          78800000-78800fff : APMC0D11:00
>>          78800000-78800fff : APMC0D10:03
>>          78800000-78800fff : APMC0D10:02
>>          78800000-78800fff : APMC0D10:01
>>          78800000-78800fff : APMC0D10:00
>> 79000000-798fffff : APMC0D0E:00
>> 7c000000-7c1fffff : APMC0D12:00
>> 7c200000-7c3fffff : APMC0D12:01
>> 7c400000-7c5fffff : APMC0D12:02
>> 7c600000-7c7fffff : APMC0D12:03
>> 7e000000-7e000fff : APMC0D13:00
>> 7e200000-7e200fff : APMC0D10:03
>>  7e200000-7e200fff : APMC0D10:02
>>    7e200000-7e200fff : APMC0D10:01
>>      7e200000-7e200fff : APMC0D10:00
>> 7e600000-7e600fff : APMC0D11:00
>> 7e700000-7e700fff : APMC0D10:03
>>  7e700000-7e700fff : APMC0D10:02
>>    7e700000-7e700fff : APMC0D10:01
>>      7e700000-7e700fff : APMC0D10:00
>> 7e720000-7e720fff : APMC0D10:03
>>  7e720000-7e720fff : APMC0D10:02
>>    7e720000-7e720fff : APMC0D10:01
>>      7e720000-7e720fff : APMC0D10:00
>> 7e800000-7e800fff : APMC0D10:00
>> 7e840000-7e840fff : APMC0D10:01
>> 7e880000-7e880fff : APMC0D10:02
>> 7e8c0000-7e8c0fff : APMC0D10:03
>> 7e930000-7e930fff : APMC0D13:00
>> 4000000000-4001ffffff : System RAM
>>  4000080000-4000c3ffff : Kernel code
>>  4000db0000-400165ffff : Kernel data
>> 40023a0000-4ff733ffff : System RAM
>> 4ff7340000-4ff77cffff : reserved
>> 4ff77d0000-4ff79cffff : System RAM
>> 4ff79d0000-4ff7e7ffff : reserved
>> 4ff7e80000-4ff7e8ffff : System RAM
>> 4ff7e90000-4ff7efffff : reserved
>> 4ff7f10000-4ff800ffff : reserved
>> 4ff8010000-4fffffffff : System RAM
>> a020000000-a03fffffff : PCI Bus 0000:00
>>  a020000000-a0201fffff : PCI Bus 0000:01
>>    a020000000-a0200fffff : 0000:01:00.0
>>      a020000000-a0200fffff : mlx4_core
>>    a020100000-a0201fffff : 0000:01:00.0
>> a060000000-a07fffffff : PCI Bus 0000:00
>> a0d0000000-a0dfffffff : PCI ECAM
>> a110000000-a14fffffff : PCI Bus 0000:00
>>  a110000000-a121ffffff : PCI Bus 0000:01
>>    a110000000-a111ffffff : 0000:01:00.0
>>      a110000000-a111ffffff : mlx4_core
>>    a112000000-a121ffffff : 0000:01:00.0
>>=20
>> Adding a Tested-by for the record:
>>=20
>> Tested-by: Jon Masters <jcm@redhat.com>
>=20
> Thanks a lot for testing this, Jon.
>>=20
>> Jon.
>>=20
>> --
>> Computer Architect | Sent from my Fedora powered laptop
>>=20
> Regards,
> Duc Dang.
