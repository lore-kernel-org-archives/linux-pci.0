Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:33590 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752608AbbHJGFs (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 10 Aug 2015 02:05:48 -0400
Received: by pabyb7 with SMTP id yb7so99057120pab.0
        for <linux-pci@vger.kernel.org>; Sun, 09 Aug 2015 23:05:47 -0700 (PDT)
Subject: Re: [PATCH v6 00/42] powerpc/powernv: PCI hotplug suppport
To: Gavin Shan <gwshan@linux.vnet.ibm.com>,
	linuxppc-dev@lists.ozlabs.org
References: <1438834307-26960-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	benh@kernel.crashing.org, mpe@ellerman.id.au, bhelgaas@google.com,
	grant.likely@linaro.org, robherring2@gmail.com,
	panto@antoniou-consulting.com
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <55C83F34.9040306@ozlabs.ru>
Date: Mon, 10 Aug 2015 16:05:40 +1000
MIME-Version: 1.0
In-Reply-To: <1438834307-26960-1-git-send-email-gwshan@linux.vnet.ibm.com>
Content-Type: text/plain; charset=koi8-r; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 08/06/2015 02:11 PM, Gavin Shan wrote:
> The series of patches intend to support PCI slot for PowerPC PowerNV platform,
> which is running on top of skiboot firmware. The patchset requires corresponding
> changes from skiboot firmware, which is sent to skiboot@lists.ozlabs.org
> for review. The PCI slots are exposed by skiboot with device node properties,
> and kernel utilizes those properties to populated PCI slots accordingly.


This does not apply on top of any actual trees I have - torvalds/master, 
powerpc/master, powerpc/next.

The problem patches are (at least):
powerpc/powernv: Enable M64 on P7IOC
powerpc/powernv: Release PEs dynamically

What did you base them on (sha1)? It is always worth mentioning.




-- 
Alexey
