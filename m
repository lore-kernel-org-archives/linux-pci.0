Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:41579 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754542AbeCVNqg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 22 Mar 2018 09:46:36 -0400
Message-ID: <1521726371.16434.307.camel@kernel.crashing.org>
Subject: Re: PCIe resets/restore and lack of CRS wait
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: okaya@codeaurora.org
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Michael Neuling <michael.neuling@au1.ibm.com>,
        linux-pci-owner@vger.kernel.org
Date: Fri, 23 Mar 2018 00:46:11 +1100
In-Reply-To: <4d1c04efa51db50dd5095ae258c3c52b@codeaurora.org>
References: <1521691380.16434.287.camel@kernel.crashing.org>
         <f6af9b6e424c469f433735a106b8ee69@codeaurora.org>
         <1521695531.16434.294.camel@kernel.crashing.org>
         <1521699853.16434.301.camel@kernel.crashing.org>
         <4d1c04efa51db50dd5095ae258c3c52b@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 2018-03-22 at 07:25 -0400, okaya@codeaurora.org wrote:
> > > > 
> > 
> > That tells me that there is no guarantee by spec that we'll get
> > ffff's, instead we might get HW stalls, or other really nasty
> > effects when probing a register other than 0 (VID/DID) for CRS.
> 
> AFAIK, spec also mentions that sw needs to observe 0xffffffff for all 
> other registers other than vendor id during CRS period.

This isnt what's in the 3.1a spec at least ... section 2.3.2 explains
the specified behaviour which is, for any register other than 0
(VID/DID), to re-issue the request...

Now, it can have a timeout, and thus might be completed as a failed
transaction after a while, but it's a sub-optimal way (ie, we'll end up
hogging the CPU on loads) and it's not 100% clear that a failed
transaction returns as all 1's (it should but ...).

I can make sure it happens the way the code expects on powerpc, I'm not
too worried about that, but I think for such a generic function, it
would make sense to stick a bit closer to the spec.

Cheers,
Ben.
