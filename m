Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:59224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752199AbeCVOOF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 22 Mar 2018 10:14:05 -0400
Date: Thu, 22 Mar 2018 09:14:02 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Michael Neuling <michael.neuling@au1.ibm.com>,
        linux-pci-owner@vger.kernel.org
Subject: Re: PCIe resets/restore and lack of CRS wait
Message-ID: <20180322141402.GA242245@bhelgaas-glaptop.roam.corp.google.com>
References: <1521691380.16434.287.camel@kernel.crashing.org>
 <f6af9b6e424c469f433735a106b8ee69@codeaurora.org>
 <1521695531.16434.294.camel@kernel.crashing.org>
 <1521699853.16434.301.camel@kernel.crashing.org>
 <4d1c04efa51db50dd5095ae258c3c52b@codeaurora.org>
 <1521726371.16434.307.camel@kernel.crashing.org>
 <172f0ea9-7eba-1505-bb79-1ee31cc4d692@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <172f0ea9-7eba-1505-bb79-1ee31cc4d692@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Mar 22, 2018 at 08:58:06AM -0500, Sinan Kaya wrote:
> On 3/22/2018 8:46 AM, Benjamin Herrenschmidt wrote:
> > On Thu, 2018-03-22 at 07:25 -0400, okaya@codeaurora.org wrote:
> >>> That tells me that there is no guarantee by spec that we'll get
> >>> ffff's, instead we might get HW stalls, or other really nasty
> >>> effects when probing a register other than 0 (VID/DID) for CRS.
> >>
> >> AFAIK, spec also mentions that sw needs to observe 0xffffffff for all 
> >> other registers other than vendor id during CRS period.
> > 
> > This isnt what's in the 3.1a spec at least ... section 2.3.2 explains
> > the specified behaviour which is, for any register other than 0
> > (VID/DID), to re-issue the request...
> 
> I don't have any hard preference on this. Bjorn wanted code to work for
> systems with and without CRS capability. That was the reason we stayed
> away from 0xffff0001.

CRS SV is optional, so the code has to work when it's absent.  But we
can tell whether it's supported, so if we need to, we can do something
different when it's absent.

> CRS just gives you HW implementation defined retries for non vendor-id
> register like you mentioned. If device does not reply in this period
> of polling time, you should get all 1s eventually back.
> 
> All 1s is the spec way of saying device doesn't exist for config
> transactions.

I remember implementation notes mentioning all 1's data returns, e.g.,
PCIe r4.0, sec 2.3.2, but I don't *think* there's actually a spec
requirement that CRS or other errors be reported that way.  So if
there's a way to avoid relying on all 1's data, I think that would be
a good thing.

Bjorn
