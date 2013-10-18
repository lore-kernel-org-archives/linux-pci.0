Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:64536 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751185Ab3JRFbf (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 18 Oct 2013 01:31:35 -0400
From: Jingoo Han <jg1.han@samsung.com>
To: 'Zhenzhong Duan ' <zhenzhong.duan@oracle.com>,
	'Bjorn Helgaas' <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	'xen-devel' <xen-devel@lists.xen.org>,
	'Konrad Rzeszutek Wilk' <konrad.wilk@oracle.com>,
	'Feng Jin' <joe.jin@oracle.com>,
	'Sucheta Chakraborty' <sucheta.chakraborty@qlogic.com>,
	'Jingoo Han' <jg1.han@samsung.com>
References: <525E32FC.3010604@oracle.com>
In-reply-to: <525E32FC.3010604@oracle.com>
Subject: Re: [PATCH 1/3] PCI: Refactor restore_msi_irqs - code movement
Date: Fri, 18 Oct 2013 14:31:15 +0900
Message-id: <000001cecbc3$43853e30$ca8fba90$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, October 16, 2013 3:32 PM, Zhenzhong Duan wrote:
> 
> Move default_restore_msi_irqs down to reference msi_mask_irq and msix_mask_irq.
> 
> This patch lays the groundwork for patch titled:
> 'PCI: Refactor MSI/MSIX mask restore code to fix interrupt lost issue'
> 
> Tested-by: Sucheta Chakraborty <sucheta.chakraborty@qlogic.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
> Acked-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

Reviewed-by: Jingoo Han <jg1.han@samsung.com>

It looks good. Also, I tested this patch on Exynos5440.

Best regards,
Jingoo Han

