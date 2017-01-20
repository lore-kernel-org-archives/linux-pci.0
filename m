Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from orbyte.nwl.cc ([151.80.46.58]:56757 "EHLO mail.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752522AbdATQ7Q (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 20 Jan 2017 11:59:16 -0500
Date: Fri, 20 Jan 2017 17:59:14 +0100
From: Phil Sutter <phil@nwl.cc>
To: David Miller <davem@davemloft.net>
Cc: bhelgaas@google.com, netdev@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [net-next PATCH 0/3] Retrieve number of VFs in a bus-agnostic way
Message-ID: <20170120165914.GF5197@orbyte.nwl.cc>
References: <20170118130439.15023-1-phil@nwl.cc>
 <20170120.114346.786441265338417344.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170120.114346.786441265338417344.davem@davemloft.net>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jan 20, 2017 at 11:43:46AM -0500, David Miller wrote:
> From: Phil Sutter <phil@nwl.cc>
> Date: Wed, 18 Jan 2017 14:04:36 +0100
> 
> > Previously, it was assumed that only PCI NICs would be capable of having
> > virtual functions - with my proposed enhancement of dummy NIC driver
> > implementing (fake) ones for testing purposes, this is no longer true.
> > 
> > Discussion of said patch has led to the suggestion of implementing a
> > bus-agnostic method for VF count retrieval so rtnetlink could work with
> > both real VF-capable PCI NICs as well as my dummy modifications without
> > introducing ugly hacks.
> > 
> > The following series tries to achieve just that by introducing a bus
> > type callback to retrieve a device's number of VFs, implementing this
> > callback for PCI bus and finally adjusting rtnetlink to make use of the
> > generalized infrastructure.
> 
> This is really nice and clean, compare it to your original approach :-)

Yes, indeed! Thanks a lot for pointing me into the right direction. :)

Cheers, Phil
