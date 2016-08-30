Return-Path: <peter@lekensteyn.nl>
Return-Path: <peter@lekensteyn.nl>
Date: Tue, 30 Aug 2016 21:53:37 +0200
From: Peter Wu <peter@lekensteyn.nl>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Roland Singer <roland.singer@desertbit.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: Re: Kernel Freeze with American Megatrends BIOS
Message-ID: <20160830195337.GA18805@al>
References: <004c7dbe-2014-c691-29d1-7a45f3b73dfa@desertbit.com>
 <20160829160210.GA24451@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160829160210.GA24451@localhost>
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 29, 2016 at 11:02:10AM -0500, Bjorn Helgaas wrote:
> [+cc linux-acpi, linux-kernel, dri-devel]
> 
> Hi Roland,
> 
> I have no idea how to debug this problem.  Are you seeing something
> that suggests it may be a PCI problem?

Yes I suspect there is an ACPI and/ or PCI problem, possibly
device-specific. Steps to reproduce on the affected machines:

 1. Load nouveau.
 2. Wait for it to runtime suspend.
 2. Invoke 'lspci', this resumes the Nvidia PCI device via nouveau.
 3. lspci never returns, few moments later an AML_INFINITE_LOOP is
    reported.

If you use the external bbswitch module, the effect is the same. I have
been trying to debug this for some time on nouveau with no luck. The
PCI/PM D3cold patches from Mika makes no difference.

Runtime resume via nouveau triggers some ACPI methods (I'll assume the
Windows 8-style PR method and take the Clevo P651 as example):

    \_SB.PCI0.PEG0.PG00._ON () ->
        \_SB.PCI0.PGON (0)

Then:

    Method (PGON, 1, Serialized) {
        PION = Arg0     // note: 0 for PG00
        // ...
        If ((OSYS != 0x07DF)) { /* Not Windows 2015 (Windows 10), see below */ }
        Else {
            LKEN (PION)
        }
        // this is the infinite loop: it tries to bring the PCIe link to
        // full speed, but fails to do so.
        While ((\_SB.PCI0.PEG0.LNKS < 0x07)) {
            Local0 = 0x20
            While (Local0) {
                If ((\_SB.PCI0.PEG0.LNKS < 0x07)) {
                    Stall (0x64)
                    Local0--
                } Else { Break }
            }
            If ((Local0 == Zero)) {
                \_SB.PCI0.PEG0.RTLK = One
                Stall (0x64)
            }
        }
        // ...
    }

Without any workaround, this piece of code is invoked:

    Method (LKEN, 1, NotSerialized) {
        Local3 = (CPEX & 0x0F)  // CPEX at 0x5ff9be7f and has value 000506e3
        If ((Local3 == Zero)) {
            /* Similar to below, but with Q0L0 -> P0L0 (register 0xBC bit 6) */
        } ElseIf ((Local3 != Zero)) {
            If ((Arg0 == Zero)) {
                /* Enter L0 Activate state.
                 * (LKDS tries to enter L2, deep-energy-saving state.) */
                Q0L0 = One      // register 0x249 bit 0; \_SB.PCI0.OPG0.Q0L0 00:01.0
                Sleep (0x10)
                Local0 = Zero
                While (Q0L0) {
                    If ((Local0 > 0x04)) { Break }
                    Sleep (0x10)
                    Local0++
                }
            } else { /* other cases, but we are only interested in PGON(0) */ }
        }
    }

The acpi_osi="!Windows 2015" workaround will invoke this instead:

    If ((OSYS != 0x07DF)) {
        If ((PION == Zero)) {
            P0AP = Zero  /* PGOF writes 3 */
            P0RM = Zero  /* PGOF writes 1 */
        }
        If ((PBGE != Zero)) { /* Observed to be false (PBGE == 0) */
            If (SBDL (PION)) {
                PUAB (PION)
                CBDL = GUBC (PION)
                MBDL = GMXB (PION)
                If ((CBDL > MBDL)) {
                    CBDL = MBDL /* \_SB_.PCI0.MBDL */
                }
                PDUB (PION, CBDL)
            }
        }
        If ((PION == Zero)) {
            P0LD = Zero     /* Link Disable = 0, PGOF sets 1 instead. */
            P0TR = One      /* Train? (PGOF does not set this). */
            TCNT = Zero
            While ((TCNT < LDLY)) { /* LDLY = 300 */
                If ((P0VC == Zero)) {
                    /* VC Negotiation Pending 0 means VC negotation is complete. */
                    Break
                }
                Sleep (0x10)
                TCNT += 0x10 /* At most 19 iterations, sleeping for 304ms. */
            }
        }
    }

The comments above are my own interpretation based on the acpidumps I
extracted from the machine. These notes and ACPI tables can be found at
https://github.com/Lekensteyn/acpi-stuff/blob/master/Clevo-P651RA/notes.txt
https://github.com/Lekensteyn/acpi-stuff/tree/master/dsl/Clevo_P651RA

Other affected devices have similar code, differences are small:
 - No check for LNKS (avoids the infinite loop, but device is still off)
 - Instead of a check for != "Windows 2015", they check for == "Windows
   2009" or even for == "Windows 2009" || "Windows 2013" (Dell Inspiron
   7559).

The tested kernels (with bbswitch or nouveau) were Linux 4.4.0, 4.6,
4.7 (nouveau + PCI/PM + nouveau PR patches). The PCIe device is
something from the GTX 9xxM family in all cases.

I have a bunch of PCI config dumps from Windows and Linux, but there is
nothing extraordinary. Also did an ACPI trace via a Checked/Debug build
of Windows, but it just confirms that the ACPI method we use for the
Nvidia device is the correct one.

Let me know if you need more information, I would be glad to provide.

Kind regards,
Peter

> On Tue, Aug 23, 2016 at 11:23:45AM +0200, Roland Singer wrote:
> > Hi,
> > 
> > hope somebody can help me fix this kernel problem which affects the following machines:
> > 
> > - Clevo P651RA (i7-6700HQ/GTX 965M, part of the P6xxRx family which are also affected)
> > - MSI GE62 Apache Pro (i7-6700HQ/GTX 960M)
> > - Gigabyte P35V5 (i7-6700HQ/GTX 970M)
> > - Razer Blade 14" (2016) (i7-6700HQ/GTX 970M) (BIOS 5.11, 04/07/2016)
> > 
> > 
> > The kernel freezes if the graphical user session (Xorg & Wayland) is
> > started with a switched off discrete GPU card (NVIDIA).
> > If the discrete GPU is switched off after the graphical session start,
> > then everything works as expected, until the graphical session is restarted.
> > 
> > This problem seams to be linked to specific BIOS settings. If the computer
> > is started with the following command line:
> > 
> > acpi_osi=! acpi_osi="Windows 2009"
> > 
> > then the kernel freeze does not occur anymore. However this required a special
> > ACPI DSDT firmware patch for the Razer Blade 2016 laptop:
> > 
> > https://github.com/m4ng0squ4sh/razer_blade_14_2016_acpi_dsdt
> > 
> > I strongly recommend to fix this in the kernel and I am ready to help and solve
> > this problem with some help.
> > 
> > Here is a link to the GitHub issue with further information:
> > 
> > https://github.com/Bumblebee-Project/Bumblebee/issues/764#issuecomment-241212595
> > 
> > Here are some more detailed information:
> > 
> > https://github.com/Lekensteyn/acpi-stuff/blob/master/Clevo-P651RA/notes.txt
> > 
> > Hope somebody can help.
