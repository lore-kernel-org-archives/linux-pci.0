Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qk0-f196.google.com ([209.85.220.196]:43635 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732163AbeHISKH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Aug 2018 14:10:07 -0400
Received: by mail-qk0-f196.google.com with SMTP id z74-v6so4309717qkb.10
        for <linux-pci@vger.kernel.org>; Thu, 09 Aug 2018 08:44:38 -0700 (PDT)
Subject: Re: [RFC] ARM64, PCIe, annd ACPI
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Tomasz Nowicki <tn@semihalf.com>,
        Vladimir Olovyannikov <vladimir.olovyannikov@broadcom.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>
References: <89484aa0-08c4-0cff-500d-407d21e2f5fd@broadcom.com>
 <20180808093822.GA25150@e107981-ln.cambridge.arm.com>
 <a32a8761-f49f-f0cf-928b-0c323c2b540e@broadcom.com>
 <20180809085923.GA13428@e107981-ln.cambridge.arm.com>
 <9b5b5918-1492-df65-5b63-678b4a35ecb9@broadcom.com>
 <20180809154151.GB20329@red-moon>
From: Ray Jui <ray.jui@broadcom.com>
Message-ID: <27e3dd65-50d9-08a2-9639-b7d229f48227@broadcom.com>
Date: Thu, 9 Aug 2018 08:44:34 -0700
MIME-Version: 1.0
In-Reply-To: <20180809154151.GB20329@red-moon>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Lorenzo,

On 8/9/2018 8:41 AM, Lorenzo Pieralisi wrote:
> On Thu, Aug 09, 2018 at 07:57:52AM -0700, Ray Jui wrote:
> 
> [...]
> 
>>> As I said ARM64 ACPI PCI kernel support is in the mainline today and I
>>> am not willing to merge any more MCFG quirks at driver level - the
>>> information is out there, it is public and must be followed, either
>>> designers do that or no ACPI PCI support on your platform, sorry.
>>>
>>> Lorenzo
>>>
>>
>> I just want to make sure I interpret this properly. This means if
>> the PCIe controller hardware does not support ECAM, there's pretty
>> much no way around it with SW based workaround going forward with
>> mainline kernel?
> 
> Yes.
> 
>> What about for the PCIe controller that was designed a few years back?
> 
> It will bootstrap with DT :)

Okay, one more quick question, what about for distributions that will 
eventually disable DT and force ACPI?

> 
> Thanks,
> Lorenzo
> 

Thanks,

Ray
