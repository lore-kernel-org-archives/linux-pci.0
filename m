Return-Path: <SRS0=Hio3=OO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99078C04EB9
	for <linux-pci@archiver.kernel.org>; Wed,  5 Dec 2018 10:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50D6520672
	for <linux-pci@archiver.kernel.org>; Wed,  5 Dec 2018 10:40:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50D6520672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbeLEKkf (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 5 Dec 2018 05:40:35 -0500
Received: from mga01.intel.com ([192.55.52.88]:23467 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726937AbeLEKkf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 5 Dec 2018 05:40:35 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Dec 2018 02:40:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,317,1539673200"; 
   d="scan'208";a="107459302"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by orsmga003.jf.intel.com with SMTP; 05 Dec 2018 02:40:29 -0800
Received: by lahna (sSMTP sendmail emulation); Wed, 05 Dec 2018 12:40:29 +0200
Date:   Wed, 5 Dec 2018 12:40:29 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kedar A Dongre <kedar.a.dongre@intel.com>,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH] PCI: Blacklist power management of Gigabyte X299
 DESIGNARE EX PCIe ports
Message-ID: <20181205104029.GL2469@lahna.fi.intel.com>
References: <20181204112048.35378-1-mika.westerberg@linux.intel.com>
 <20181204204049.4zr7onei267t4pic@wunner.de>
 <20181205092034.GI2469@lahna.fi.intel.com>
 <20181205094818.jmdy2mg6b6is7jy3@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181205094818.jmdy2mg6b6is7jy3@wunner.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Dec 05, 2018 at 10:48:18AM +0100, Lukas Wunner wrote:
> Does the root port have a _RMV and/or _SUN object?  We could e.g.
> disallow runtime PM for any bridge with _RMV present and the HPC
> bit not set in the Slot Capabilities.

Unfortunately it does not have either of those methods :/ It pretty much
looks like a "normal root port" from OS perspective.

Below is the ASL related to the root port (RP05) in question:

    Device (RP05)
    {
        Name (_ADR, 0x001C0004)  // _ADR: Address
        Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
        {
            If (PICM)
            {
                Return (AG5C) /* \_SB_.AG5C */
            }

            Return (PG5C) /* \_SB_.PG5C */
        }
    }

    Scope (RP05)
    {
        Method (_INI, 0, NotSerialized)  // _INI: Initialize
        {
            LTRZ = LTR5 /* \LTR5 */
            LMSL = PML5 /* \PML5 */
            LNSL = PNL5 /* \PNL5 */
            OBFZ = OBF5 /* \OBF5 */
        }

        OperationRegion (PXCS, PCI_Config, 0x00, 0x0480)
        Field (PXCS, AnyAcc, NoLock, Preserve)
        {
            VDID,   32, 
            Offset (0x50), 
            L0SE,   1, 
                ,   3, 
            LDIS,   1, 
            Offset (0x51), 
            Offset (0x52), 
                ,   13, 
            LASX,   1, 
            Offset (0x5A), 
            ABPX,   1, 
                ,   2, 
            PDCX,   1, 
                ,   2, 
            PDSX,   1, 
            Offset (0x5B), 
            Offset (0x60), 
            Offset (0x62), 
            PSPX,   1, 
            PMEP,   1, 
            Offset (0xA4), 
            D3HT,   2, 
            Offset (0xD8), 
                ,   30, 
            HPEX,   1, 
            PMEX,   1, 
            Offset (0xE2), 
                ,   2, 
            L23E,   1, 
            L23R,   1, 
            Offset (0x324), 
                ,   3, 
            LEDM,   1, 
            Offset (0x420), 
                ,   30, 
            DPGE,   1
        }

        Field (PXCS, AnyAcc, NoLock, WriteAsZeros)
        {
            Offset (0xDC), 
                ,   30, 
            HPSX,   1, 
            PMSX,   1
        }

        Name (LTRV, Package (0x04)
        {
            0x00, 
            0x00, 
            0x00, 
            0x00
        })
        Method (_DSM, 4, Serialized)  // _DSM: Device-Specific Method
        {
            If ((Arg0 == ToUUID ("e5c937d0-3553-4d7a-9117-ea4d19c3434d") /* Device Labeling Interface */))
            {
                Switch (ToInteger (Arg2))
                {
                    Case (0x00)
                    {
                        Name (OPTS, Buffer (0x02)
                        {
                             0x00, 0x00                                       // ..
                        })
                        CreateBitField (OPTS, 0x00, FUN0)
                        CreateBitField (OPTS, 0x04, FUN4)
                        CreateBitField (OPTS, 0x06, FUN6)
                        CreateBitField (OPTS, 0x08, FUN8)
                        CreateBitField (OPTS, 0x09, FUN9)
                        If ((Arg1 >= 0x02))
                        {
                            FUN0 = 0x01
                            If (LTRE)
                            {
                                FUN6 = 0x01
                            }

                            If (OBFF)
                            {
                                FUN4 = 0x01
                            }

                            If ((ECR1 == 0x01))
                            {
                                If ((Arg1 >= 0x03))
                                {
                                    FUN8 = 0x01
                                    FUN9 = 0x01
                                }
                            }
                        }

                        Return (OPTS) /* \_SB_.PC00.RP05._DSM.OPTS */
                    }
                    Case (0x04)
                    {
                        If ((Arg1 >= 0x02))
                        {
                            If (OBFZ)
                            {
                                Return (Buffer (0x10)
                                {
                                    /* 0000 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                                    /* 0008 */  0x00, 0x00, 0x00, 0x08, 0x00, 0x00, 0x00, 0x00   // ........
                                })
                            }
                            Else
                            {
                                Return (Buffer (0x10)
                                {
                                    /* 0000 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                                    /* 0008 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00   // ........
                                })
                            }
                        }
                    }
                    Case (0x06)
                    {
                        If ((Arg1 >= 0x02))
                        {
                            If (LTRZ)
                            {
                                If (((LMSL == 0x00) || (LNSL == 0x00)))
                                {
                                    If ((PCHS == SPTH))
                                    {
                                        LMSL = 0x0846
                                        LNSL = 0x0846
                                    }
                                    ElseIf ((PCHS == SPTL))
                                    {
                                        LMSL = 0x1003
                                        LNSL = 0x1003
                                    }
                                }

                                LTRV [0x00] = ((LMSL >> 0x0A) & 0x07)
                                LTRV [0x01] = (LMSL & 0x03FF)
                                LTRV [0x02] = ((LNSL >> 0x0A) & 0x07)
                                LTRV [0x03] = (LNSL & 0x03FF)
                                Return (LTRV) /* \_SB_.PC00.RP05.LTRV */
                            }
                            Else
                            {
                                Return (0x00)
                            }
                        }
                    }
                    Case (0x08)
                    {
                        If ((ECR1 == 0x01))
                        {
                            If ((Arg1 >= 0x03))
                            {
                                Return (0x01)
                            }
                        }
                    }
                    Case (0x09)
                    {
                        If ((ECR1 == 0x01))
                        {
                            If ((Arg1 >= 0x03))
                            {
                                Return (Package (0x05)
                                {
                                    0xC350, 
                                    Ones, 
                                    Ones, 
                                    0xC350, 
                                    Ones
                                })
                            }
                        }
                    }

                }
            }

            Return (Buffer (0x01)
            {
                 0x00                                             // .
            })
        }

        Device (PXSX)
        {
            Name (_ADR, 0x00)  // _ADR: Address
            Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
            {
                Return (GPRW (0x69, 0x04))
            }
        }

        Method (HPME, 0, Serialized)
        {
            If (((VDID != 0xFFFFFFFF) && (PMSX == 0x01)))
            {
                Notify (PXSX, 0x02) // Device Wake
                PMSX = 0x01
                PSPX = 0x01
            }
        }

        Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
        {
            Return (GPRW (0x69, 0x04))
        }
    }
