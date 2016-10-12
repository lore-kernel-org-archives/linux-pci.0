Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:40642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753902AbcJLWWG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Oct 2016 18:22:06 -0400
Date: Wed, 12 Oct 2016 17:21:42 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Andrew F. Davis" <afd@ti.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-pci@vger.kernel.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH v2 3/7] PCI: dra7xx: Set drvdata at end of probe function
Message-ID: <20161012222142.GA24545@localhost>
References: <20161012133112.27714.93244.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20161012133258.27714.51056.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <84f6a4b4-d900-844d-545f-cae1aed299e2@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <84f6a4b4-d900-844d-545f-cae1aed299e2@ti.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Oct 12, 2016 at 02:48:02PM -0500, Andrew F. Davis wrote:
> On 10/12/2016 08:32 AM, Bjorn Helgaas wrote:
> > Set the drvdata pointer at the end of probe function for consistency with
> > other drivers. 
> 
> I've seen it done the current way many places.
> 
> > We don't need the drvdata until after the probe completes,
> > and we don't need it at all if the probe fails. 
> 
> Are you sure this will always be true? Why not set it as soon as we have
> the ability to, what do we gain by waiting till the end, something like
> one less instruction in the failure case?

I don't think it's likely anybody will need it before .probe()
completes, because the purpose of drvdata is for an external driver
entry point to locate its device data, and none of those entry points
will be called until after .probe() completes successfully.

But I don't care at all if we do it earlier, as long as all the
drivers do it the same way.

Bjorn
