Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from nat28.tlf.novell.com ([130.57.49.28]:33056 "EHLO
	nat28.tlf.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751737Ab3B1JIe convert rfc822-to-8bit (ORCPT
	<rfc822;groupwise-linux-pci@vger.kernel.org:3:1>);
	Thu, 28 Feb 2013 04:08:34 -0500
Message-Id: <512F2C9E02000078000C1D07@nat28.tlf.novell.com>
Date: Thu, 28 Feb 2013 09:08:30 +0000
From: "Jan Beulich" <JBeulich@suse.com>
To: "Bjorn Helgaas" <bhelgaas@google.com>
Cc: "xen-devel" <xen-devel@lists.xen.org>, <linux-pci@vger.kernel.org>
Subject: time periods of no resource re-assignment
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Bjorn,

in the context of dealing with the final part of a long known security
issue on Xen, I'd appreciate if you could help me understand
under what conditions (or at which times) MMIO resources for PCI
devices can get re-assigned in Linux. Or really I'm in need to know
under what conditions there won't be any resource re-assignment
(i.e. we particularly need the BARs to be stable that cover the
MSI-X table and the Pending Bit Array).

Right now I'm intending to send the hypervisor a respective
notification in the context of xen-pciback's probe function, after
having called pci_enable_device(). Can you confirm that at this
point, and until the driver lets go of the device again, resources
won't get re-assigned? Or if not, can you suggest a better point
in time for sending such a notification, or additional steps we
may need to take in order to ensure resource stability?

Thanks a lot, Jan

