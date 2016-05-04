Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp03.au.ibm.com ([202.81.31.145]:41918 "EHLO
	e23smtp03.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751349AbcEDNhA (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 4 May 2016 09:37:00 -0400
Received: from localhost
	by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Wed, 4 May 2016 23:36:58 +1000
Date: Wed, 4 May 2016 23:36:03 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, benh@kernel.crashing.org,
	mpe@ellerman.id.au, aik@ozlabs.ru, bhelgaas@google.com,
	robherring2@gmail.com, dja@axtens.net, alistair@popple.id.au
Subject: Re: [PATCH v9 21/22] drivers/of: Export of_detach_node()
Message-ID: <20160504133603.GA30081@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1462281773-26438-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1462281773-26438-22-git-send-email-gwshan@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1462281773-26438-22-git-send-email-gwshan@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, May 03, 2016 at 11:22:52PM +1000, Gavin Shan wrote:
>This exports of_detach_node() for PowerPC PowerNV PCI hotplug
>driver. No functional changes introduced.
>
>Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

Rob, I'm not sure it's late to cache the 4.7 merge window.
Also, I was told this series is needed by new CAPI driver which
is being developed. The developers hope to push the new CAPI driver
in 4.8 merge window (perhaps) or linux-next before 4.8 merge window
is opened. It means the new CAPI driver depends on this series which
has to be pushed to linux-next before 4.8 merge window.

If it's fine, could you please merge 16 to 21? With them merged to
4.7, the left patches won't depend on FDT changes. Thanks in advance
for your help.

Thanks,
Gavin

>---
> drivers/of/dynamic.c | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
>index c647bd1..75ce30d 100644
>--- a/drivers/of/dynamic.c
>+++ b/drivers/of/dynamic.c
>@@ -311,6 +311,7 @@ int of_detach_node(struct device_node *np)
>
> 	return rc;
> }
>+EXPORT_SYMBOL_GPL(of_detach_node);
>
> /**
>  * of_node_release() - release a dynamically allocated node
>-- 
>2.1.0
>

