Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.citrix.com ([66.165.176.89]:13900 "EHLO SMTP.CITRIX.COM"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752713AbaJ0LKe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 27 Oct 2014 07:10:34 -0400
Message-ID: <544E2828.9060901@citrix.com>
Date: Mon, 27 Oct 2014 11:10:32 +0000
From: David Vrabel <david.vrabel@citrix.com>
MIME-Version: 1.0
To: Yijing Wang <wangyijing@huawei.com>,
	Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	<xen-devel@lists.xenproject.org>
Subject: Re: [PATCH 2/3] x86/xen: Revert "PCI: Add x86_msi.msi_mask_irq()
 and msix_mask_irq()"
References: <1414377878-23497-1-git-send-email-wangyijing@huawei.com> <1414377878-23497-3-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1414377878-23497-3-git-send-email-wangyijing@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 27/10/14 02:44, Yijing Wang wrote:
> Commit 0e4ccb1505a9 ("PCI: Add x86_msi.msi_mask_irq() and msix_mask_irq()")
> introduced two __weak arch functions arch_msix_mask_irq() and
> arch_msi_mask_irq() to work around a bug when running xen in x86.
> These two functions made msi code more complex. We have introduced
> a global flag to ignore MSI mask to fix the issue in previous patch,
> so we can revert the commit safely. This patch is also preparation
> to use MSI chip framework instead of weak arch MSI functions in all
> platforms. Because s390 MSI also use default_msi_mask_irq() functions
> introduced by commit 0e4ccb1505a9. We keep default_msi_mask_irq()
> and default_msix_mask_irq() temporarily. They will be removed in later
> patch.

Acked-by: David Vrabel <david.vrabel@citrix.com>

David
