Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:54811 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752808AbcHXP4V (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Aug 2016 11:56:21 -0400
To: Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vikram Sethi <vikrams@codeaurora.org>
From: Sinan Kaya <okaya@codeaurora.org>
Subject: PCI CRS Support
Message-ID: <f114c582-8e55-ee1a-a72d-864483077fd0@codeaurora.org>
Date: Wed, 24 Aug 2016 11:56:18 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,
I see that the kernel has support for Configuration Request Retry Status (CRS) visibility
support and it gets discovered and enabled as part of the probe function.

Let's assume a system with CRS capability and have its visibility set as above.
I do not see any code in the failure/reset path to support the CRS requests
returned by the endpoint.

An endpoint is allowed to return CRS after several reset types. I'm pasting the part of
the spec for you at 2.3.1 Request Handling Rules of 3.1 spec.

"For Configuration Requests only, following reset it is possible for a device to terminate the request 
but indicate that it is temporarily unable to process the Request, but will be able to process the Request 
in the future – in this case, the Configuration Request Retry 10 Status (CRS) Completion Status is used 
(see Section 6.6). Valid reset conditions after which a device is permitted to return CRS are:

- Cold, Warm, and Hot Resets
- FLRs
- A reset initiated in response to a D3hot to D0uninitialized device state transition."

I have identified the following functions that have problems for warm and hot resets.

Some callers of pci_reset_bridge_secondary_bus such as pciehp_reset_slot, aer_root_reset.
Other higher level callers such as pci_bus_reset, pci_try_reset_bus and their callers from VFIO.
All these places are impacted by a CRS call. They do the secondary bus reset but do not wait for the
endpoint to respond. Waiting for 1 second is not a guarantee that the endpoint will start responding
immediately. A CRS capable OS needs to interpret the incoming CRS response and poll longer
since CRS visibility is et.

All of this was warm and hot reset.

I also see another problem in the FLR path too. There is some best effort wait up to 1 second in
pci_flr_wait.

Where do we go from here? I was thinking of putting something deep down into the reset secondary
bus function but I'm afraid it will break things especially when we wait up to 60 seconds.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
