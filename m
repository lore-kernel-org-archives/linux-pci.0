Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53410 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752935AbdDDTjZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 4 Apr 2017 15:39:25 -0400
Date: Tue, 4 Apr 2017 13:39:23 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
        iommu@lists.linux-foundation.org
Subject: Re: [RFC] PCI ACS Flags Clarification
Message-ID: <20170404133923.5232e424@t450s.home>
In-Reply-To: <49257b71-6fa1-5870-fba6-1b8c5179b8ec@codeaurora.org>
References: <49257b71-6fa1-5870-fba6-1b8c5179b8ec@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 4 Apr 2017 14:47:58 -0400
Sinan Kaya <okaya@codeaurora.org> wrote:

> I'm looking for a guideline on how Access Control Services (ACS) need to be
> implemented in HW for cases where peer to peer is and isn't supported.
> 
> I see conflicting information in the code. 
> 
> iommu.c calls pci_acs_enabled() from pci_device_group() to determine if
> ACS path is enabled for the following flags.
> 
> This paragraph lays out the requirements. 
> 
>  /*
>   * To consider a PCI device isolated, we require ACS to support Source
>   * Validation, Request Redirection, Completer Redirection, and Upstream
>   * Forwarding.  This effectively means that devices cannot spoof their
>   * requester ID, requests and completions cannot be redirected, and all
>   * transactions are forwarded upstream, even as it passes through a
>   * bridge where the target device is downstream.
>   */
> #define REQ_ACS_FLAGS   (PCI_ACS_SV | PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF)
> 
> I also see the following comment in pci_acs_flags_enabled() which gets
> called from pci_acs_enabled()
> 
> /*
>  * Except for egress control, capabilities are either required
>  * or only required if controllable.  Features missing from the
>  * capability field can therefore be assumed as hard-wired enabled.
>  */
> 
> This comment in pci_acs_flags_enabled() is confusing. A capability that reads
> 0 usually means it is not enabled. This code is assuming enabled. 
> Are we trying to say that we'll use the capability bits as a mask while
> verifying the requested ACS flags?

See the language in the PCIe spec:

6.12.1.1. ACS Downstream Ports

- ACS Source Validation: must be implemented.

- ACS Translation Blocking: must be implemented.

- ACS P2P Request Redirect: must be implemented by Root Ports that
  support peer-to-peer traffic with other Root Ports; must be
  implemented by Switch Downstream Ports. 

- ACS P2P Completion Redirect: must be implemented by Root Ports that
  implement ACS P2P Request Redirect; must be implemented by Switch
  Downstream Ports.

- ACS Upstream Forwarding: must be implemented by Root Ports if the RC
  supports Redirected Request Validation; must be implemented by Switch
  Downstream Ports.

- ACS P2P Egress Control: implementation is optional.

Thus for a downstream port, SV and TB must be implemented, period.

RR, CR, and UF must be implemented by switch downstream ports, period.

On a root port, if RR is not implemented, we can assume it does not
support P2P with other root ports.

If the root port supports RR, it must also support CR and UF.

The kernel code takes a bit of a lax approach to this with the items
you've identified above, we assume that if a capability isn't present
then the device is compliant to the spec and not trying to circumvent
it.  It's a generalization trying to also encompass other component
types.


> For systems that don't support P2P, the code will check PCI_ACS_SV
>   only. So, if I summarize this correctly;

For a downstream port or downstream switch port, this would not be spec
compliant.  TB would need to be implemented for either (not that the
kernel cares for isolation) and all except EC would need to be
implemented on a downstream switch port.

> The requirement is to have an 
> 1. ACS capability with PCI_ACS_SV if p2p is not supported
> 2. ACS capability with PCI_ACS_SV|PCI_ACS_RR | PCI_ACS_CR |
>   PCI_ACS_UF if p2p is supported.
> 
> Did I get this right?

I'd suggest following the spec, not the code, that way you always have a
case for how you interpret the spec and the behavior of your hardware.
The code is an attempt to validate the device against the spec, but more
thorough implementations may follow.  REQ_ACS_FLAGS defines the set of
ACS capabilities we think are relevant to device isolation.  In
particular, UF seems like a key feature and our current test for it may
not be fully correct.  Note how RR and CR only specify p2p with other
root ports while UF requires transaction towards to the RC.  Section
6.12.2 further defines Redirected Request Validation as a feature
within the context of RR and CR.  So rather than look at the code,
discuss section 6.12 with the hardware engineers and understand how it
behaves relative to each device and transaction type.  Implement the
capabilities that best match.  Attempting a minimal implementation
based on the current software interpretation may bite later, for
instance if we re-interpret how UF works.  Thanks,

Alex
