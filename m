Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp02.citrix.com ([66.165.176.63]:57203 "EHLO
	SMTP02.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751180AbaJ0LJo (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 27 Oct 2014 07:09:44 -0400
Message-ID: <544E27F6.8010607@citrix.com>
Date: Mon, 27 Oct 2014 11:09:42 +0000
From: David Vrabel <david.vrabel@citrix.com>
MIME-Version: 1.0
To: Yijing Wang <wangyijing@huawei.com>,
	Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <xen-devel@lists.xenproject.org>,
	David Vrabel <david.vrabel@citrix.com>
Subject: Re: [Xen-devel] [PATCH 1/3] x86/xen: Introduce a global flag to fix
 the MSI mask bug
References: <1414377878-23497-1-git-send-email-wangyijing@huawei.com> <1414377878-23497-2-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1414377878-23497-2-git-send-email-wangyijing@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 27/10/14 02:44, Yijing Wang wrote:
> Commit 0e4ccb1505a9 ("PCI: Add x86_msi.msi_mask_irq() and msix_mask_irq()")
> fixed MSI mask bug which may cause kernel crash. But the commit
> made MSI code complex. Introduce a new global flag "pci_msi_ignore_mask"
> to ignore MSI/MSI-X to fix this issue, it's a cleaner solution.
> And the commit 0e4ccb1505a9 will be reverted in the later patch.

Reviewed-by: David Vrabel <david.vrabel@citrix.com>

In the sense that it keeps the odd Xen behaviour.  But...

Konrad, why was this fixed like this in the first place?  IMO, it would
have been better to get Xen to trap-and-emulate accesses to the relevant
MSI/MSI-X registers.  The mask/unmask on setup/teardown isn't
performance critical.

David
