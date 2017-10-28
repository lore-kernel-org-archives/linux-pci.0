Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:36092 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751327AbdJ1SBx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 28 Oct 2017 14:01:53 -0400
Subject: Re: [RFC PATCH v8 7/7] PCI / PM: Add support for the PCIe WAKE#
 signal for OF
To: Brian Norris <briannorris@chromium.org>
Cc: Jeffy Chen <jeffy.chen@rock-chips.com>,
        linux-kernel@vger.kernel.org, bhelgaas@google.com,
        linux-pm@vger.kernel.org, tony@atomide.com,
        shawn.lin@rock-chips.com, rjw@rjwysocki.net, dianders@chromium.org,
        linux-pci@vger.kernel.org
References: <20171026132840.20946-1-jeffy.chen@rock-chips.com>
 <20171026132840.20946-8-jeffy.chen@rock-chips.com>
 <334be327-543f-d379-83de-ce84799fa49a@codeaurora.org>
 <20171028000400.GE105121@google.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <9460e098-a797-296a-1d03-0d19512457c2@codeaurora.org>
Date: Sat, 28 Oct 2017 14:01:46 -0400
MIME-Version: 1.0
In-Reply-To: <20171028000400.GE105121@google.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 10/27/2017 8:04 PM, Brian Norris wrote:
>> I think you can make this code common by abstracting the IRQ number and
>> have some generic code like pci-wake.c in pci directory without the of prefix
>> in this file.
> Why would 'pci-wake' be a good name for this? We're doing basically the
> same things that pci-acpi.c is doing (it also can configure the WAKE#
> signal, via ACPI firmware calls).
> 

I was looking for some code that can be used between OF and ACPI rather than
duplicating the code in two different places just to extract some information
from the platform firmware. 

My initial look at your code suggested it to be very generic except the IRQ
read function. 

I was expecting that the kernel's PCI Wake handling to be common whether the IRQ
information is coming from DT/ACPI.

There are different approaches to portability.

* One approach is to keep of specific stuff in OF directory. 
* Another approach is keep some common code can call it from multiple platform firmware
or from the ARCH directory.
* Another approach is have one file but put OF and ACPI specific pieces at the bottom.

It depends on the code. 

Bjorn should chime in here with his preference.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
