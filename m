Return-Path: <SRS0=Xdb0=YS=gmail.com=hjmallon@kernel.org>
Return-Path: <SRS0=Xdb0=YS=gmail.com=hjmallon@kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: Re: Diagnosing BAR allocation problems with complex bridge structure
From: Harry Mallon <hjmallon@gmail.com>
In-Reply-To: <20170103180718.GA25398@bhelgaas-glaptop.roam.corp.google.com>
Date: Wed, 4 Jan 2017 16:22:39 +0000
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Message-Id: <B6DCCEA6-184A-476A-B19B-2A1287B91545@gmail.com>
References: <B56F52C5-7298-4E9D-8AE2-8497527C5D39@gmail.com>
 <20170103180718.GA25398@bhelgaas-glaptop.roam.corp.google.com>
To: Bjorn Helgaas <helgaas@kernel.org>
List-ID: <linux-pci.vger.kernel.org>


> On 3 Jan 2017, at 18:07, Bjorn Helgaas <helgaas@kernel.org> wrote:
>=20
> Hi Harry,
>=20
> On Tue, Jan 03, 2017 at 03:35:13PM +0000, Harry Mallon wrote:
>> Hi,
>>=20
>> In this email I am asking for advice on how to diagnose problems in =
assigning memory for PCI-E devices and bridges. I can reproduce my issue =
on the current mainline kernel but I am not currently planning to target =
any fixes for the mainline kernel (unless they prove to be useful =
outside of this machine). I am planning to target the CentOS 3.10.0 =
based kernel. I understand that I am not owed any help/patches etc from =
anyone here, especially not as I am using a non mainline kernel.
>>=20
>> I am working on a machine with an odd PCI structure, it has 4 =
different PLX bridges and requires hotplug to work on at least 2 of =
these. We were previously using a kernel based on 3.3 and had to add a =
few (hacky, machine specific) patches to that to make it work correctly. =
We also use "pci=3Drealloc,pcie_bus_safe" in the kernel cmdline. I am =
currently using that kernel as a reference to compare to my development =
version.
>>=20
>> On my current setup some devices don't work, using "lspci -vvv" I can =
see that they are not all receiving the memory allocations that they =
need. They report like one of the two following (it changes depending on =
another PCI-E card being in or out):
>>=20
>> 05:00.0 VGA compatible controller: NVIDIA Corporation GP102 [TITAN X] =
(rev a1) (prog-if 00 [VGA controller])
>>        Subsystem: NVIDIA Corporation Device 119a
>>        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- =
ParErr- Stepping- SERR- FastB2B- DisINTx-
>>        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast =
>TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>>        Interrupt: pin A routed to IRQ 11
>>        Region 0: Memory at <ignored> (32-bit, non-prefetchable) =
[disabled]
>>        Region 1: Memory at e0000000 (64-bit, prefetchable) [disabled] =
[size=3D256M]
>>        Region 3: Memory at f0000000 (64-bit, prefetchable) [disabled] =
[size=3D32M]
>>        Region 5: I/O ports at 4000 [disabled] [size=3D128]
>>        Expansion ROM at <ignored> [disabled]
>>=20
>> 05:00.0 VGA compatible controller: NVIDIA Corporation GK110B [GeForce =
GTX TITAN Black] (rev ff) (prog-if ff)
>> 	!!! Unknown header type 7f
>>=20
>> What tools and techniques can anyone recommend for diagnosing this =
type of problem? Is there a way to export all the bridge memory ranges =
in a way that can be visualised (maybe the newer kernel cannot allocate =
enough aligned space)? Is there a way to enable extra PCI debug in the =
kernel? Is there a way to make the kernel panic and=20
>> report when it fails to assign memory on boot instead of continuing =
with non-functional hardware?
>=20
> A complete dmesg log from a current kernel and complete "lspci -vv"
> output is the best place to start.  The goal is that all your devices
> should work without requiring any machine-specific patches or
> command-line parameters.  Our resource allocation code is not really
> very robust, so unusual topologies don't always work out of the box.
>=20
> You can open a bug report at https://bugzilla.kernel.org in the
> drivers/PCI area, attach the dmesg and lspci output, and respond with
> the URL here.

https://bugzilla.kernel.org/show_bug.cgi?id=3D191921

I have attached messages log (zipped, wouldn't let me do the whole =
thing) and lspci.

>=20
> Bjorn
