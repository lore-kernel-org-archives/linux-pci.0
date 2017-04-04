Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:41788 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754147AbdDDSsA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Apr 2017 14:48:00 -0400
To: Linux PCI <linux-pci@vger.kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        iommu@lists.linux-foundation.org
From: Sinan Kaya <okaya@codeaurora.org>
Subject: [RFC] PCI ACS Flags Clarification
Message-ID: <49257b71-6fa1-5870-fba6-1b8c5179b8ec@codeaurora.org>
Date: Tue, 4 Apr 2017 14:47:58 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

I'm looking for a guideline on how Access Control Services (ACS) need to be
implemented in HW for cases where peer to peer is and isn't supported.

I see conflicting information in the code. 

iommu.c calls pci_acs_enabled() from pci_device_group() to determine if
ACS path is enabled for the following flags.

This paragraph lays out the requirements. 

 /*
  * To consider a PCI device isolated, we require ACS to support Source
  * Validation, Request Redirection, Completer Redirection, and Upstream
  * Forwarding.  This effectively means that devices cannot spoof their
  * requester ID, requests and completions cannot be redirected, and all
  * transactions are forwarded upstream, even as it passes through a
  * bridge where the target device is downstream.
  */
#define REQ_ACS_FLAGS   (PCI_ACS_SV | PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF)

I also see the following comment in pci_acs_flags_enabled() which gets
called from pci_acs_enabled()

/*
 * Except for egress control, capabilities are either required
 * or only required if controllable.  Features missing from the
 * capability field can therefore be assumed as hard-wired enabled.
 */

This comment in pci_acs_flags_enabled() is confusing. A capability that reads
0 usually means it is not enabled. This code is assuming enabled. 
Are we trying to say that we'll use the capability bits as a mask while
verifying the requested ACS flags?

For systems that don't support P2P, the code will check PCI_ACS_SV only. 
So, if I summarize this correctly;

The requirement is to have an 
1. ACS capability with PCI_ACS_SV if p2p is not supported
2. ACS capability with PCI_ACS_SV|PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF if p2p
is supported.

Did I get this right?

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
