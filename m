Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:55623 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751597AbcJDOaJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Oct 2016 10:30:09 -0400
Subject: Re: 4.7 regression: ACPI: No IRQ available for PCI Interrupt Link
 [LNKD]. Try pci=noacpi or acpi=off
To: Ondrej Zary <linux@rainbow-software.org>
References: <201609251512.05657.linux@rainbow-software.org>
 <201610021853.19635.linux@rainbow-software.org>
 <fd149c27-d703-5338-2461-17621b4b1ae5@codeaurora.org>
 <201610030925.58304.linux@rainbow-software.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>, wim@djo.tudelft.nl,
        ravikanth.nalla@hpe.com
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <2d75b1ba-9226-3713-2b1e-7829b89a8856@codeaurora.org>
Date: Tue, 4 Oct 2016 10:30:06 -0400
MIME-Version: 1.0
In-Reply-To: <201610030925.58304.linux@rainbow-software.org>
Content-Type: text/plain; charset=iso-8859-15
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Ondrej,

On 10/3/2016 3:25 AM, Ondrej Zary wrote:
> On Monday 03 October 2016, Sinan Kaya wrote:
>> On 10/2/2016 12:53 PM, Ondrej Zary wrote:
>>>> Can we have some testing coverage? and eventually have tested-by?
>>>
>>> Works on two affected machines. More tests tomorrow.
>>
>> Thanks, appreciate the feedback. Looking forward to hear your other test
>> results.
> 
> The other two affected machines are working too.
> 

Can I have your "tested by" before I repost the new version with updated
commit message?

Sinan

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
