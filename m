Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:35356 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751746AbbKRCnQ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 17 Nov 2015 21:43:16 -0500
Received: by pacej9 with SMTP id ej9so28422650pac.2
        for <linux-pci@vger.kernel.org>; Tue, 17 Nov 2015 18:43:15 -0800 (PST)
Subject: Re: [PATCH v7 28/50] powerpc/pci: Rename
 pcibios_{add,remove}_pci_devices()
To: Gavin Shan <gwshan@linux.vnet.ibm.com>,
	linuxppc-dev@lists.ozlabs.org
References: <1446642770-4681-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1446642770-4681-29-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	benh@kernel.crashing.org, mpe@ellerman.id.au, bhelgaas@google.com,
	grant.likely@linaro.org, robherring2@gmail.com,
	panto@antoniou-consulting.com, frowand.list@gmail.com
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <564BE5BA.30907@ozlabs.ru>
Date: Wed, 18 Nov 2015 13:43:06 +1100
MIME-Version: 1.0
In-Reply-To: <1446642770-4681-29-git-send-email-gwshan@linux.vnet.ibm.com>
Content-Type: text/plain; charset=koi8-r; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 11/05/2015 12:12 AM, Gavin Shan wrote:
> This renames pcibios_{add,remove}_pci_devices() to avoid conflicts
> with names of the weak functions in PCI subsystem, which have the
> prefix "pcibios". No logical changes introduced.


As you mentioned before, the patchset is organized as "code refactoring,
IO/M32/M64, DMA, PE allocation/releaseing". This patch fits into the 
refactoring category so it goes to the beginning of the series :)


-- 
Alexey
