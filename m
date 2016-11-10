Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39318 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S934229AbcKJVa5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Nov 2016 16:30:57 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id uAALTFsV013877
        for <linux-pci@vger.kernel.org>; Thu, 10 Nov 2016 16:30:56 -0500
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
        by mx0b-001b2d01.pphosted.com with ESMTP id 26mwr9vr0w-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-pci@vger.kernel.org>; Thu, 10 Nov 2016 16:30:56 -0500
Received: from localhost
        by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pci@vger.kernel.org> from <benh@au1.ibm.com>;
        Fri, 11 Nov 2016 07:30:53 +1000
Subject: Re: [PATCH] of/irq: improve error message on irq discovery process
 failure
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
Reply-To: benh@au1.ibm.com
To: Mark Rutland <mark.rutland@arm.com>,
        "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
Cc: devicetree@vger.kernel.org, marc.zyngier@arm.com,
        frowand.list@gmail.com, robh+dt@kernel.org,
        linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Fri, 11 Nov 2016 08:30:43 +1100
In-Reply-To: <20161109190457.GC837@leverpostej>
References: <1478700308-25481-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
         <20161109190457.GC837@leverpostej>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1478813443.2592.2.camel@au1.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 2016-11-09 at 19:04 +0000, Mark Rutland wrote:
> 
> 
> If we don't have an interrupt-map on a PCI controller, why don't we
> instead log a message regarding that being missing, and give up
> early?

Why ? It's legit to not support LSIs.

> That sounds like a more generically useful error message; it's also
> possible that a DT author simply forgot to add the map, and the
> platform has suitable interrupts wired up.

But it's not necessarily an error...

> > This patch introduces a different message for this specific case,
> > and it also reduces the level of the message from error to warning.
> > Before this patch, when an adapter was plugged in a slot without
> Level
> > interrupts capabilities, we saw generic error messages like this:
> > 
> >     [54.239] pci 002d:70:00.0: of_irq_parse_pci() failed with rc=-
> 22
> > 
> > Now, with this applied, we see the following specific message:
> > 
> >     [19.947] pci 0014:60:00.0: of_irq_parse_pci() gave up. The slot
> of this
> >     device has no Level-triggered Interrupts capability.
> 
> Following my above example, this has gone from opaque to potentially
> misleading

I'm not sure. At least for some of our platforms this is the correct
message :-) Our Hypervisor doesn't allow LSIs on some slots.

I think it's not that misleading. It's obvious something is wrong with
LSIs, which you can easily figure out from there.

Cheers,
Ben.

