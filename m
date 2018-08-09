Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:55970 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730880AbeHIS0A (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 9 Aug 2018 14:26:00 -0400
Date: Thu, 9 Aug 2018 17:00:35 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Ray Jui <ray.jui@broadcom.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Tomasz Nowicki <tn@semihalf.com>,
        Vladimir Olovyannikov <vladimir.olovyannikov@broadcom.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>
Subject: Re: [RFC] ARM64, PCIe, annd ACPI
Message-ID: <20180809160035.GC20329@red-moon>
References: <89484aa0-08c4-0cff-500d-407d21e2f5fd@broadcom.com>
 <20180808093822.GA25150@e107981-ln.cambridge.arm.com>
 <a32a8761-f49f-f0cf-928b-0c323c2b540e@broadcom.com>
 <20180809085923.GA13428@e107981-ln.cambridge.arm.com>
 <9b5b5918-1492-df65-5b63-678b4a35ecb9@broadcom.com>
 <20180809154151.GB20329@red-moon>
 <27e3dd65-50d9-08a2-9639-b7d229f48227@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <27e3dd65-50d9-08a2-9639-b7d229f48227@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Aug 09, 2018 at 08:44:34AM -0700, Ray Jui wrote:
> Hi Lorenzo,
> 
> On 8/9/2018 8:41 AM, Lorenzo Pieralisi wrote:
> >On Thu, Aug 09, 2018 at 07:57:52AM -0700, Ray Jui wrote:
> >
> >[...]
> >
> >>>As I said ARM64 ACPI PCI kernel support is in the mainline today and I
> >>>am not willing to merge any more MCFG quirks at driver level - the
> >>>information is out there, it is public and must be followed, either
> >>>designers do that or no ACPI PCI support on your platform, sorry.
> >>>
> >>>Lorenzo
> >>>
> >>
> >>I just want to make sure I interpret this properly. This means if
> >>the PCIe controller hardware does not support ECAM, there's pretty
> >>much no way around it with SW based workaround going forward with
> >>mainline kernel?
> >
> >Yes.
> >
> >>What about for the PCIe controller that was designed a few years back?
> >
> >It will bootstrap with DT :)
> 
> Okay, one more quick question, what about for distributions that
> will eventually disable DT and force ACPI?

ACPI PCI support revolves around a FW model that requires, among other
things, ECAM and its firmware description, MCFG table, to work.

If the host controller is not ECAM compliant it is not PCI firmware
compliant, so it is not ACPI compliant, you can't run ACPI only
distributions on it.

It is a model that has been run for decades in basically all
ACPI based systems out there and there is not a reason to
deviate from it, I understand the frustration but that's the
way it is, sorry.

Thanks,
Lorenzo
