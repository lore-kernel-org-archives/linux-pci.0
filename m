Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp04.au.ibm.com ([202.81.31.146]:36535 "EHLO
	e23smtp04.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753079AbcDTDEF (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 19 Apr 2016 23:04:05 -0400
Received: from localhost
	by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Wed, 20 Apr 2016 13:04:02 +1000
Date: Wed, 20 Apr 2016 12:38:04 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>,
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, benh@kernel.crashing.org,
	mpe@ellerman.id.au, dja@axtens.net, bhelgaas@google.com,
	robherring2@gmail.com, grant.likely@linaro.org
Subject: Re: [PATCH v8 39/45] powerpc/powernv: Select OF_DYNAMIC
Message-ID: <20160420023804.GA3754@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1455680668-23298-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1455680668-23298-40-git-send-email-gwshan@linux.vnet.ibm.com>
 <5715FD69.3060302@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5715FD69.3060302@ozlabs.ru>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Apr 19, 2016 at 07:42:01PM +1000, Alexey Kardashevskiy wrote:
>On 02/17/2016 02:44 PM, Gavin Shan wrote:
>>The device tree will change dynamically in PowerNV PCI hotplug
>>driver. This enables CONFIG_OF_DYNAMIC to support that.
>>
>>Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>>---
>>  arch/powerpc/platforms/powernv/Kconfig | 1 +
>>  1 file changed, 1 insertion(+)
>>
>>diff --git a/arch/powerpc/platforms/powernv/Kconfig b/arch/powerpc/platforms/powernv/Kconfig
>>index 604190c..e7b1ad7 100644
>>--- a/arch/powerpc/platforms/powernv/Kconfig
>>+++ b/arch/powerpc/platforms/powernv/Kconfig
>>@@ -18,6 +18,7 @@ config PPC_POWERNV
>>  	select CPU_FREQ_GOV_ONDEMAND
>>  	select CPU_FREQ_GOV_CONSERVATIVE
>>  	select PPC_DOORBELL
>>+	select OF_DYNAMIC
>
>
>Why not to enable it in 45/45 under config HOTPLUG_PCI_POWERNV? Is there any
>benefit of having it always on if HOTPLUG_PCI_POWERNV is not enabled?
>

Agree, I will move accordingly in next revision. Note that we have to move
it back here once something else depends on OF_DYNAMIC in future.

>>  	default y
>>
>>  config OPAL_PRD
>>
>
>
>-- 
>Alexey
>

