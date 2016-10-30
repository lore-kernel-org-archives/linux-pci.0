Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Sun, 30 Oct 2016 15:18:57 +0100
From: Peter Wu <peter@lekensteyn.nl>
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
        Rick Kerkhof <rick.2889@gmail.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Moore, Robert" <robert.moore@intel.com>
Subject: Re: Acer Aspire V7-582PG (Haswell, GTX 750M) fails to power off GPU
 via Power Resources
Message-ID: <20161030141857.GA6697@al>
References: <20161027093011.GZ1476@lahna.fi.intel.com>
 <CANni8her35iORgrZOkDzxhfVaOOzObTLG2Ly0kkNZPDTrbyfQQ@mail.gmail.com>
 <20161027095508.GA1476@lahna.fi.intel.com>
 <20161027160648.GF27017@al>
 <20161028085630.GD1476@lahna.fi.intel.com>
 <20161028110930.GA1521@al>
 <20161028111907.GD23812@lahna.fi.intel.com>
 <20161028123041.GB1521@al>
 <20161028141000.GE23812@lahna.fi.intel.com>
 <1AE640813FDE7649BE1B193DEA596E886A25E770@SHSMSX101.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="u3/rZRmxL6MmkK24"
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E886A25E770@SHSMSX101.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

(removing nouveau list since it is an ACPI core issue)

On Sat, Oct 29, 2016 at 12:49:22AM +0000, Zheng, Lv wrote:
> Hi,
> 
> > From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-owner@vger.kernel.org] On Behalf Of Mika
> > Westerberg
> > Subject: Re: Acer Aspire V7-582PG (Haswell, GTX 750M) fails to power off GPU via Power Resources
> > 
> > On Fri, Oct 28, 2016 at 02:30:41PM +0200, Peter Wu wrote:
> > > It was correctly applied. I did some testing with QEMU, it seems that
> > > the \_OSI check is problematic. Removing it makes things work again.
> > 
> > I hope Bob and Lv can answer why _OSI fails.
> > 
> > In the meantime I think we should check flags.power_resources in nouveau
> > driver (in addition to _PR3) so that it falls back to _DSM if there are
> > no power resources (or if we failed to evaluate them for some reason).
> 
> IMO, the problem wasn't _OSI, the problem was "If".
> "If" is module level here.
> So execution order of it in current Linux upstream may be different from Windows.
> 
> You can try to modify acpi_gbl_parse_table_as_term_list to TRUE.
> To see if this can be solved.
> 
> Thanks and best regards
> Lv

It seems that acpi_gbl_parse_table_as_term_list is a new flag in
v4.9-rc1. Changing the flag to TRUE in in include/acpi/acpixf.h has no
effect other than:

    ACPI: Executed 2 blocks of module-level executable AML code

changing into:


    ACPI: 2 ACPI AML tables successfully acquired and loaded

That was tested using v4.9-rc2-40-g9fe68ca + debug patch from previous
mail, but with a slightly modified QEMU command (to allow the device to
become visible in Windows Device Manager) and slightly modified SSDT1:

    qemu-system-x86_64 -M pc,accel=kvm -m 2G -acpitable file=ssdt1.aml \
        -net none -device pci-bridge,addr=12.0,chassis_nr=2,id=head.2 \
        -device isa-debugcon,iobase=0x402,chardev=dbug \
        -chardev file,id=dbug,path=/dev/stdout ...

With this command and Windows 10 (-drive file=w10.qcow2), I can see that
the power resource methods are invoked (stdout | grep PR_TEST):

    PR_TEST: NVP3._ON
    PR_TEST: NVP2._OFF
    PR_TEST: _PS0
    PR_TEST: _S0W
    PR_TEST: NVP3._ON
    PR_TEST: _PS0

Using the above test setup with Linux (-kernel arch/x86/boot/bzImage):

    PR_TEST: _S0W

If you think that the default runtime PM state affects this, note that
the dmesg also shows:

    ACPI: \_SB_.PCI0.S90_: Adding power resources for device:14? 0
-- 
Kind regards,
Peter Wu
https://lekensteyn.nl

--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ssdt1.dsl"

/*
 * Intel ACPI Component Architecture
 * AML/ASL+ Disassembler version 20160831-64
 * Copyright (c) 2000 - 2016 Intel Corporation
 * 
 * Disassembling to symbolic ASL+ operators
 *
 * Disassembly of ssdt1.dat, Wed Oct 26 21:43:27 2016
 *
 * Original Table Header:
 *     Signature        "SSDT"
 *     Length           0x00002CA9 (11433)
 *     Revision         0x01
 *     Checksum         0x8F
 *     OEM ID           "ACRSYS"
 *     OEM Table ID     "ACRPRDCT"
 *     OEM Revision     0x00001000 (4096)
 *     Compiler ID      "1025"
 *     Compiler Version 0x00040000 (262144)
 */
DefinitionBlock ("", "SSDT", 1, "ACRSYS", "ACRPRDCT", 0x00001000)
{
    External (\_SB.PCI0.S90, DeviceObj)
    External (\DBUG, MethodObj)

    Method (DBGM, 1, NotSerialized)
    {
        Concatenate ("PR_TEST: ", Arg0, Local0)
        Debug = Local0
        DBUG(Local0)
    }

    If (\_OSI ("Windows 2013")) {
        Scope (\_SB.PCI0.S90)
        {
            Name (_PR0, Package (0x01)  // _PR0: Power Resources for D0
            {
                NVP3
            })
            Name (_PR2, Package (0x01)  // _PR2: Power Resources for D2
            {
                NVP2
            })
            Name (_PR3, Package (0x01)  // _PR3: Power Resources for D3hot
            {
                NVP3
            })
            Method (_S0W, 0, NotSerialized)  // _S0W: S0 Device Wake State
            {
                DBGM("_S0W")
                // Return(3)
                Return(4)
            }

            Method (_DSW, 3, NotSerialized)  // _DSW: Device Sleep Wake
            {
            }

            Method (_PS0, 0, NotSerialized)  // _PS0: Power State 0
            {
                DBGM("_PS0")
            }

            Method (_PS3, 0, NotSerialized)  // _PS3: Power State 3
            {
                DBGM("_PS3")
            }
        }

        PowerResource (NVP3, 0x00, 0x0000)
        {
            Name (_STA, One)  // _STA: Status

            Method (_ON, 0, NotSerialized)  // _ON_: Power On
            {
                DBGM("NVP3._ON")
                _STA = One
            }

            Method (_OFF, 0, NotSerialized)  // _OFF: Power Off
            {
                DBGM("NVP3._OFF")
                _STA = Zero
            }
        }

        PowerResource (NVP2, 0x00, 0x0000)
        {
            Name (_STA, One)  // _STA: Status
            Method (_ON, 0, NotSerialized)  // _ON_: Power On
            {
                DBGM("NVP2._ON")
                _STA = One
            }

            Method (_OFF, 0, NotSerialized)  // _OFF: Power Off
            {
                DBGM("NVP2._OFF")
                _STA = One
            }
        }
    }
}

--u3/rZRmxL6MmkK24--
