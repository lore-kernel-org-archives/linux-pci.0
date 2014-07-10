Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.citrix.com ([66.165.176.89]:2375 "EHLO SMTP.CITRIX.COM"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753718AbaGJND1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 10 Jul 2014 09:03:27 -0400
From: David Vrabel <david.vrabel@citrix.com>
To: <linux-pci@vger.kernel.org>
CC: David Vrabel <david.vrabel@citrix.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	<xen-devel@lists.xenproject.org>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: [PATCHv1 0/2] xen-pciback: allow device reset to work more often
Date: Thu, 10 Jul 2014 14:03:12 +0100
Message-ID: <1404997394-15715-1-git-send-email-david.vrabel@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

When a PCI device is passed through to a different domain, it must be
reset to ensure it works correctly in the new domain.  Usually the
toolstack will request a device reset via the "reset" sysfs file.  But
this file is not present if a function reset is not available.

A common use case is a GPU device and its associated audio function.
In the case where these two devices are simultaneously co-assigned to
the same domain, it is safe to reset them with an SBR.

Patch #1 export pci_probe_reset_function() so pciback can know if an
alternate reset mechanism needs to be proved.

Patch #2 adds a "reset" file to devices bound to pciback that performs
the SBR if it is safe to do so.

David

