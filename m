Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:57136 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933928AbeEWTKm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 May 2018 15:10:42 -0400
Subject: pci=earlydump on ARM
To: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Linux PCI <linux-pci@vger.kernel.org>
References: <bug-199671-164391@https.bugzilla.kernel.org/>
 <bug-199671-164391-E4Mtn0How4@https.bugzilla.kernel.org/>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <9756cf4c-0cec-00f7-3cc6-f09e34177cf9@codeaurora.org>
Date: Wed, 23 May 2018 15:10:39 -0400
MIME-Version: 1.0
In-Reply-To: <bug-199671-164391-E4Mtn0How4@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> If that doesn't work or you'd rather brute-force it, you could try doing
> something like "pci=earlydump".  This is currently only implemented for x86, so
> it would be some work to implement something similar for arm64.  It would be a
> nice upstream addition if you *did* implement it.
> 
> In the earlydump output I would be looking for clues about the power state of
> 03:00.0 to try to figure out if the bootloader left it powered off or if Linux
> is doing something to turn it off.
> 

Is it really possible to implement a generic version of this?

PCI on ARM64 is not really unified. There are several host bridge drivers for
different types of access. 

If we limit the functionality to ACPI, the answer is still maybe if we can pass
the base address of the MMCONFIG region. 

All products use a different MMCONFIG region.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
