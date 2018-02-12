Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 12 Feb 2018 11:43:41 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Arjun Vynipadath <arjun@chelsio.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, davem@davemloft.net,
        netdev@vger.kernel.org, leedom@chelsio.com, santosh@chelsio.com,
        ganeshgr@chelsio.com, nirranjan@chelsio.com, kumaras@chelsio.com,
        swise@opengridcomputing.com, hare@suse.de
Subject: Re: [REGRESSION, bisect] pci: cxgb4 probe fails after commit
 104daa71b3961434 ("PCI: Determine actual VPD size on first access")
Message-ID: <20180212174341.GC75542@bhelgaas-glaptop.roam.corp.google.com>
References: <1516710549-26660-1-git-send-email-arjun@chelsio.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1516710549-26660-1-git-send-email-arjun@chelsio.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jan 23, 2018 at 05:59:09PM +0530, Arjun Vynipadath wrote:
> Sending on behalf of "Casey Leedom <leedom@chelsio.com>"
> 
> Way back on April 11, 2016 we reported a regression in Linux kernel 4.6-rc2 
> brought on by kernel.org commit 104daa71b396. This commit calculates the 
> size of a PCI Device's VPD area by parsing the VPD Structure at offset 0x000, 
> and restricts accesses to the VPD to that computed size.
> 
> Our devices have a second VPD structure which is located starting at offset 
> 0x400 which is the "real" VPD[1].  The 104daa71b396 commit (plus a follow on 
> commit 408641e93aa5) caused efforts to read past the end of that computed 
> length of the VPD to return silently without error leaving stack junk in the 
> VPD read buffers.
> 
> We introduced kernel.org commit cb92148b to allow a driver to tell the 
> kernel how large the VPD area really is, introducing a new API 
> pci_set_vpd_size() for this purpose.
> 
> Now we've discovered a new subtlety to the problem.
> 
> We have a KVM Hypervisor running a 4.9.70 kernel.  So it has all of the 
> above commits.  When we attach our Physical Function 4 to a Virtual Machine 
> and attempt to run cxgb4 in that VM, we see the problem again.  The issue is 
> that all of the VM Guest OS's efforts to access the PCIe VPD Capability are 
> trapped into the KVM 4.9.70 kernel and executed there, with the results 
> routed back to the VM Guest OS.  The cxgb4 driver in the VM Guest OS uses 
> the new pci_set_vpd_size() to notify the OS of the true size of the VPD, but 
> that information of course is never sent to the KVM 4.9.70 Hypervisor. 
> (And, truth be told, if the Guest OS were older than 4.6, it wouldn't even 
> know that it needed to do this.)  The result is that again we get silent VPD 
> read failures with random stack garbage in the VPD read buffers. (sigh) 

Let me pull out one tiny piece of this problem: If the VPD read
returns failure, the caller should not look at the read buffer.  But
we should *never* copy random stack garbage into the read buffer, no
matter what the VPD read returns.

I guess it's the 4.9.70 kernel that's putting garbage into the VPD
read buffer?  Is this something that needs to be fixed in the current
upstream kernel?
