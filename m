Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp-out4.electric.net ([192.162.216.185]:53658 "EHLO
        smtp-out4.electric.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752180AbdKBRrm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Nov 2017 13:47:42 -0400
Received: from 1eAJad-0002k0-Ut by out4a.electric.net with emc1-ok (Exim 4.87)
        (envelope-from <David.Laight@ACULAB.COM>)
        id 1eAJae-0002ms-To
        for linux-pci@vger.kernel.org; Thu, 02 Nov 2017 10:47:40 -0700
Received: from [156.67.243.126] (helo=AcuExch.aculab.com)
        by out4a.electric.net with esmtps (TLSv1:AES128-SHA:128)
        (Exim 4.87)
        (envelope-from <David.Laight@ACULAB.COM>)
        id 1eAJad-0002k0-Ut
        for linux-pci@vger.kernel.org; Thu, 02 Nov 2017 10:47:39 -0700
From: David Laight <David.Laight@ACULAB.COM>
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: PCIe AER testing
Date: Thu, 2 Nov 2017 17:47:58 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DD00ACDDE@AcuExch.aculab.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

I'm (still) trying to provoke aerdrv to report a PCIe error.
I've found a system where a 4.13 kernel (ubuntu 17.0) reports
'_OSC: OS now control [... AER ...]' and aerdrv (and PCIe PME)
use interrupts 125 and 126.

One of those host ports is connected to an igb ethernet chip,
the other to one of our cards.

I can generate PCIe read or write cycles that are outside the
BARs - and the card duly fills in data into own AER registers.
But I'm not seeing any messages from aerdrv or even the interrupt
count going up.

CPU is an i7-7700 (according to /proc/cpuinfo).

The root port's (Intel Sunrise Point-H) AER registers are:
        Capabilities: [100 v1] Advanced Error Reporting
                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt+ RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UESvrt: DLP+ SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
                CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
                AERCap: First Error Pointer: 00, ECRCGenCap- ECRCGenEn- ECRCChkCap- ECRCChkEn-
                        MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
                HeaderLog: 00000000 00000000 00000000 00000000
                RootCmd: CERptEn+ NFERptEn+ FERptEn+
                RootSta: CERcvd- MultCERcvd- UERcvd- MultUERcvd-
                         FirstFatal- NonFatalMsg- FatalMsg- IntMsg 0
                ErrorSrc: ERR_COR: 0000 ERR_FATAL/NONFATAL: 0000

Our card's are:
        Capabilities: [800 v1] Advanced Error Reporting
                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol-
                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
                CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
                AERCap: First Error Pointer: 14, ECRCGenCap- ECRCGenEn- ECRCChkCap- ECRCChkEn-
                        MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
                HeaderLog: 40000001 0000000f df202000 00000000

The HeaderLog is that of a write beyond the end of BAR2.
If I unmask NonFatalErr the HeaderLog contains that of invalid reads.
(Writing to the status bits clears them.)

I think the endpoint should be sending some kind of TLP to the root that
would update the status registers and then interrupt the host.
Unfortunately I can only trace TLP that match the BARs.

I can try taking down the PCIe link - I believe the root port should log
that itself?

Any ideas?
Is it worth me trying to get the igb to generate the same errors?

	David
