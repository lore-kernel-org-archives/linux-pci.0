Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:59331 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752195AbeCVFMg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 22 Mar 2018 01:12:36 -0400
Message-ID: <1521695531.16434.294.camel@kernel.crashing.org>
Subject: Re: PCIe resets/restore and lack of CRS wait
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: okaya@codeaurora.org
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Michael Neuling <michael.neuling@au1.ibm.com>,
        linux-pci-owner@vger.kernel.org
Date: Thu, 22 Mar 2018 16:12:11 +1100
In-Reply-To: <f6af9b6e424c469f433735a106b8ee69@codeaurora.org>
References: <1521691380.16434.287.camel@kernel.crashing.org>
         <f6af9b6e424c469f433735a106b8ee69@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 2018-03-22 at 00:36 -0400, okaya@codeaurora.org wrote:
> On 2018-03-22 00:03, Benjamin Herrenschmidt wrote:
> > Hi Folks !
> > 
> > So while chasing some issues in our EEH error handling, we noticed that
> > the generic code has about a bazillion of "reset" path for devices,
> > most of them seemingly missing a wait for CRS after the reset.
> > 
> > That includes PM based resets or wakeups (can a D3->D0 transition cause
> > CRS to be returned ? Unclear but we should try to be safe), but mostly
> > it includes anything that resets the pcie port (PERST) or the secondary
> > bridge reset (hot resets).
> > 
> > For example take __pci_reset_function_locked(...), it can call
> > pci_parent_bus_reset() which will perform a hot reset but will *not*
> > wait for CRS.
> > 
> > There are a plethora of reset path in there that are similar, it's
> > actually hard to figure out which is what, but they all have in common
> > that they don't wait for CRS with the notable exception of the FLR
> > case.
> 
> Bjorn merged my change for 4.17. Kernel should handle these now.

Ah nice ! I'll check that out, I was checking 4.16-rc6 !

> > I'm keen on doing a rather "blanket" fix by adding a CRS wait inside
> > pci_dev_restore(). Would you guys agree ?
> > 
> > Also why does pci_flr_wait() not use vendor/device ID but instead waits
> > on the COMMAND register being all 1's ? It's not clear to me ...
> > VID/DID will give a very specific signature for CRS which is ffff0001
> > while COMMAND could return all 1's for other reasons (device unplugged
> > for example).
> > 
> 
> Because if you read vendor id of a virtual function, you get 0xffffffff

Ah indeed, I forgot about that... 

Thanks !

Cheers,
Ben.
