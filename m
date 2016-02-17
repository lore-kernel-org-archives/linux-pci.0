Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp07.au.ibm.com ([202.81.31.140]:34371 "EHLO
	e23smtp07.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965133AbcBQEje (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 16 Feb 2016 23:39:34 -0500
Received: from localhost
	by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <andrew.donnellan@au1.ibm.com>;
	Wed, 17 Feb 2016 14:39:32 +1000
Subject: Re: [PATCH v8 04/45] powerpc/powernv: Cleanup on pci_controller_ops
 instances
To: Gavin Shan <gwshan@linux.vnet.ibm.com>,
	linuxppc-dev@lists.ozlabs.org
References: <1455680668-23298-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1455680668-23298-5-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: devicetree@vger.kernel.org, aik@ozlabs.ru,
	linux-pci@vger.kernel.org, grant.likely@linaro.org,
	robherring2@gmail.com, bhelgaas@google.com, dja@axtens.net
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Message-ID: <56C3F948.5090804@au1.ibm.com>
Date: Wed, 17 Feb 2016 15:38:32 +1100
MIME-Version: 1.0
In-Reply-To: <1455680668-23298-5-git-send-email-gwshan@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 17/02/16 14:43, Gavin Shan wrote:
> This cleans up on below data struct instances to use tab instead of
> space indent of statement to avoid complains from scripts/checkpatch.pl.
> No logical changes introduced.
>
>    @pnv_pci_ioda_controller_ops
>    @pnv_npu_ioda_controller_ops
>
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> Reviewed-by: Daniel Axtens <dja@axtens.net>

Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

-- 
Andrew Donnellan              Software Engineer, OzLabs
andrew.donnellan@au1.ibm.com  Australia Development Lab, Canberra
+61 2 6201 8874 (work)        IBM Australia Limited

