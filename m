Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:48656 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751759AbdKVICu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 22 Nov 2017 03:02:50 -0500
Date: Wed, 22 Nov 2017 08:02:40 +0000
From: Marc Zyngier <marc.zyngier@arm.com>
To: subrahmanya l <l.subrahmanya@mobiveil.co.in>
Cc: Christoph Hellwig <hch@infradead.org>, linux-pci@vger.kernel.org,
        tglx@linutronix.de, jason@lakedaemon.net
Subject: Re: [Patch] export irq_set_msi_desc
Message-ID: <20171122080240.6bd46a28@why.wild-wind.fr.eu.org>
In-Reply-To: <CAFZiPx0wbm=hA0qXMjJihOaeRHhKzgZdSLTwTZdGZ2aoMM-3Rw@mail.gmail.com>
References: <CAFZiPx1sgxr8X9mtW11fK1XMPuk+4jUFb5Cc-pVJn06ZztHwng@mail.gmail.com>
        <20171108172424.GA19449@infradead.org>
        <CAFZiPx0wbm=hA0qXMjJihOaeRHhKzgZdSLTwTZdGZ2aoMM-3Rw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 9 Nov 2017 10:42:06 +0530
subrahmanya l <l.subrahmanya@mobiveil.co.in> wrote:

> Christoph,
> 
> Xilinx MSI driver uses it.
> 
> file path: https://github.com/Xilinx/linux-xlnx/blob/master/drivers/pci/host/pcie-xilinx.c#L286
> 
> I used the same driver as reference to write another Rootport driver
> which needs it too.

You shouldn't need this at all. The driver you are looking at is using
a deprecated API, and you should implement the MSI part of your driver
using the generic MSI layer which takes care of this and shouldn't
require exporting this function.

There is a number of drivers in the tree that have been converted to
generic MSI, such as pcie-tango.c for example.

Thanks,

	M.
-- 
Without deviation from the norm, progress is not possible.
