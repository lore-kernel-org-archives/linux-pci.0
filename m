Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:57847 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751362Ab2GZBlG (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 25 Jul 2012 21:41:06 -0400
Received: by pbbrp8 with SMTP id rp8so2347858pbb.19
        for <linux-pci@vger.kernel.org>; Wed, 25 Jul 2012 18:41:06 -0700 (PDT)
Message-ID: <5010A025.5000002@gmail.com>
Date: Thu, 26 Jul 2012 09:40:53 +0800
From: Jiang Liu <liuj97@gmail.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: PCI mini-summit
References: <CAErSpo5Ea_Rd2QSUXT13riDgHrkMGiN43+QiFTZYepHi-rg0Vw@mail.gmail.com>
In-Reply-To: <CAErSpo5Ea_Rd2QSUXT13riDgHrkMGiN43+QiFTZYepHi-rg0Vw@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,
	Really want to attend the mini-summit, have strong interests in host 
bridge hotplug and PCI hotplug core rework. But it may be a little later
for me to apply for VISA:(
	I'll try to send out a draft version for PCI hotplug rework for
comments soon.

	Thanks!
	Gerry

On 07/25/2012 11:33 AM, Bjorn Helgaas wrote:
> We're planning a PCI mini-summit on Tuesday, August 28, in San Diego.
> If you'd like an invitation, let me know.
> 
> We haven't drafted an agenda yet, but based on ideas we've heard so
> far, we'll likely talk about some of the following topics:
> 
>       Host bridge hotplug
>       PCI hotplug core rework
>       VFIO v2 for KVM
>       Dynamic resource assignment
>       SRIOV
>           Management: driver (module parms) vs core (sysfs?)
>           Dynamic/static: changing number of VFs requires driver cooperation
>       Candidates for unification/moving from arch code to the core:
>           res->parent usage
>           Claiming resources
>           Unassigned BAR detection
>           ECAM (a.k.a. MMCONFIG)
>           Domain (a.k.a. PCI segment) support
>           MPS config
>           MPS safety with respect to hotplug
> 
> I've also heard that PCI-on-ARM may be of interest, so if you want to
> talk about that and possibly add some topics, let me know.
> 
> Bjorn
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

