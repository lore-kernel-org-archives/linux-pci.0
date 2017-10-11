Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:37812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757163AbdJKT1H (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 11 Oct 2017 15:27:07 -0400
Date: Wed, 11 Oct 2017 14:27:04 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: James Puthukattukaran <james.puthukattukaran@oracle.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7] PCI: Workaround wrong flags completions for IDT switch
Message-ID: <20171011192704.GN25517@bhelgaas-glaptop.roam.corp.google.com>
References: <59C02719.5050103@oracle.com>
 <9741d204-1dd6-2cc2-c133-2ef49c8a404b@codeaurora.org>
 <59CAB001.10207@oracle.com>
 <7084085b-89e7-80fa-d10b-06f121eb57be@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <7084085b-89e7-80fa-d10b-06f121eb57be@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Sep 26, 2017 at 04:03:13PM -0400, Sinan Kaya wrote:
> On 9/26/2017 3:52 PM, James Puthukattukaran wrote:
> >> I think you want to do the part above as part of a quirk that runs before
> >> the probe.
> > 
> > I don't think there's a way to run this early enough?
> 
> Bjorn?
> 
> I have seen multiple quirk types in quirks.c some prefixed with EARLY and
> other LATE.

I'm hoping an early quirk on the switch would be early enough, since
the workaround needs to be done for devices downstream from the
switch.

Bjorn
