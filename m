Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:37186 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752908AbdLFOsp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 Dec 2017 09:48:45 -0500
Subject: Re: [PATCH] pci: provide pci_get_domain_bus_and_slot dummy helper
To: Arnd Bergmann <arnd@arndb.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Matthew Minter <matt@masarand.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20171206141751.757163-1-arnd@arndb.de>
 <616e1d18-df26-f868-ddb9-602621e9240f@codeaurora.org>
 <CAK8P3a1rE1nD0SA_FJQSY4GRYCr5COcmR2V7RCzcRUy6iUGgXQ@mail.gmail.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <12c81260-ca78-d93e-8162-23c2781383f4@codeaurora.org>
Date: Wed, 6 Dec 2017 09:48:42 -0500
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1rE1nD0SA_FJQSY4GRYCr5COcmR2V7RCzcRUy6iUGgXQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 12/6/2017 9:47 AM, Arnd Bergmann wrote:
> On Wed, Dec 6, 2017 at 3:41 PM, Sinan Kaya <okaya@codeaurora.org> wrote:
>> On 12/6/2017 9:17 AM, Arnd Bergmann wrote:
>>
>> I thought Bjorn merged a similar patch yesterday with subject
>>
>> "[PATCH -next] pci: add function stub for pci_get_domain_bus_and_slot()"
> 
> It was probably just a bit too late to make it into today's linux-next.
> 

I see, sorry for the inconvenience. 


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
