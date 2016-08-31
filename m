Return-Path: <roland.singer@desertbit.com>
Return-Path: <roland.singer@desertbit.com>
Subject: Re: Kernel Freeze with American Megatrends BIOS
To: Peter Wu <peter@lekensteyn.nl>, Bjorn Helgaas <helgaas@kernel.org>
References: <004c7dbe-2014-c691-29d1-7a45f3b73dfa@desertbit.com>
 <20160829160210.GA24451@localhost> <20160830195337.GA18805@al>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org, dri-devel@lists.freedesktop.org,
 emil.l.velikov@gmail.com,
 "imirkin@alum.mit.edu >> Ilia Mirkin" <imirkin@alum.mit.edu>
From: Roland Singer <roland.singer@desertbit.com>
Message-ID: <e7318236-9737-518e-c360-398c66220961@desertbit.com>
Date: Wed, 31 Aug 2016 13:27:36 +0200
MIME-Version: 1.0
In-Reply-To: <20160830195337.GA18805@al>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-pci.vger.kernel.org>

Am 30.08.2016 um 21:53 schrieb Peter Wu:
> On Mon, Aug 29, 2016 at 11:02:10AM -0500, Bjorn Helgaas wrote:
>> [+cc linux-acpi, linux-kernel, dri-devel]
>>
>> Hi Roland,
>>
>> I have no idea how to debug this problem.  Are you seeing something
>> that suggests it may be a PCI problem?
> 
> Yes I suspect there is an ACPI and/ or PCI problem, possibly
> device-specific. Steps to reproduce on the affected machines:
> 
>  1. Load nouveau.
>  2. Wait for it to runtime suspend.
>  2. Invoke 'lspci', this resumes the Nvidia PCI device via nouveau.
>  3. lspci never returns, few moments later an AML_INFINITE_LOOP is
>     reported.
> 

I can confirm this. Same result on my machine.

Here is a link to my ACPI tables:
https://bugs.launchpad.net/lpbugreporter/+bug/752542/+attachment/4722651/+files/Razer-Blade.tar.gz

The specific source for the NVIDIA card can be found in the ssdt5.dsl file.


    Method (PGON, 1, Serialized)
    {
        /* ... */

        GPPR (PION, One)
        If ((OSYS == 0x07D9))  /* Is Windows 2009 - In my case, setting to Windows 2009 only works! */
        {
            If ((PION == Zero))
            {
                P0AP = Zero
                P0RM = Zero
            }
            ElseIf ((PION == One))
            {
                P1AP = Zero
                P1RM = Zero
            }
            ElseIf ((PION == 0x02))
            {
                P2AP = Zero
                P2RM = Zero
            }

            If ((PBGE != Zero))
            {
                If (SBDL (PION))
                {
                    PUAB (PION)
                    CBDL = GUBC (PION)
                    MBDL = GMXB (PION)
                    If ((CBDL > MBDL))
                    {
                        CBDL = MBDL /* \_SB_.PCI0.MBDL */
                    }

                    PDUB (PION, CBDL)
                }
            }

            If ((PION == Zero))
            {
                P0LD = Zero
                P0TR = One
                TCNT = Zero
                While ((TCNT < LDLY))
                {
                    If ((P0VC == Zero))
                    {
                        Break
                    }

                    Sleep (0x10)
                    TCNT += 0x10
                }
            }
            ElseIf ((PION == One))
            {
                P1LD = Zero
                P1TR = One
                TCNT = Zero
                While ((TCNT < LDLY))
                {
                    If ((P1VC == Zero))
                    {
                        Break
                    }

                    Sleep (0x10)
                    TCNT += 0x10
                }
            }
            ElseIf ((PION == 0x02))
            {
                P2LD = Zero
                P2TR = One
                TCNT = Zero
                While ((TCNT < LDLY))
                {
                    If ((P2VC == Zero))
                    {
                        Break
                    }

                    Sleep (0x10)
                    TCNT += 0x10
                }
            }
        }
        Else
        {
            LKEN (PION)
        }

        /* ... */
        
        Return (Zero)
    }



If not set to Windows 2009, then this is triggered:


    Method (LKEN, 1, NotSerialized)
    {
        Local3 = (CPEX & 0x0F)
        If ((Local3 == Zero))
        {
            If ((Arg0 == Zero))
            {
                P0L0 = One
                Sleep (0x10)
                Local0 = Zero
                While (P0L0)
                {
                    If ((Local0 > 0x04))
                    {
                        Break
                    }

                    Sleep (0x10)
                    Local0++
                }
            }
            ElseIf ((Arg0 == One))
            {
                P1L0 = One
                Sleep (0x10)
                Local0 = Zero
                While (P0L0)
                {
                    If ((Local0 > 0x04))
                    {
                        Break
                    }

                    Sleep (0x10)
                    Local0++
                }
            }
            ElseIf ((Arg0 == 0x02))
            {
                P2L0 = One
                Sleep (0x10)
                Local0 = Zero
                While (P0L0)
                {
                    If ((Local0 > 0x04))
                    {
                        Break
                    }

                    Sleep (0x10)
                    Local0++
                }
            }
        }
        ElseIf ((Local3 != Zero))
        {
            If ((Arg0 == Zero))
            {
                Q0L0 = One
                Sleep (0x10)
                Local0 = Zero
                While (Q0L0)
                {
                    If ((Local0 > 0x04))
                    {
                        Break
                    }

                    Sleep (0x10)
                    Local0++
                }
            }
            ElseIf ((Arg0 == One))
            {
                Q1L0 = One
                Sleep (0x10)
                Local0 = Zero
                While (Q1L0)
                {
                    If ((Local0 > 0x04))
                    {
                        Break
                    }

                    Sleep (0x10)
                    Local0++
                }
            }
            ElseIf ((Arg0 == 0x02))
            {
                Q2L0 = One
                Sleep (0x10)
                Local0 = Zero
                While (Q2L0)
                {
                    If ((Local0 > 0x04))
                    {
                        Break
                    }

                    Sleep (0x10)
                    Local0++
                }
            }
        }
    }


Is it possible to override the specific ACPI table functions (SSDT) in the DSDT?
This way I could try to debug to find some more information...
