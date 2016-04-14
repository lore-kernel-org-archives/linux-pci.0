Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e28smtp05.in.ibm.com ([125.16.236.5]:36007 "EHLO
	e28smtp05.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751648AbcDNF0V (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 14 Apr 2016 01:26:21 -0400
Received: from localhost
	by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Thu, 14 Apr 2016 10:56:17 +0530
Date: Thu, 14 Apr 2016 15:25:56 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>,
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, benh@kernel.crashing.org,
	mpe@ellerman.id.au, dja@axtens.net, bhelgaas@google.com,
	robherring2@gmail.com, grant.likely@linaro.org
Subject: Re: [PATCH v8 00/45] powerpc/powernv: PCI hotplug support
Message-ID: <20160414052556.GA7402@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1455680668-23298-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <570DF50F.6010805@ozlabs.ru>
 <20160413074236.GA28853@gwshan>
 <570E0E13.6080409@ozlabs.ru>
 <20160413234246.GA5330@gwshan>
 <570F0DFB.9090509@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <570F0DFB.9090509@ozlabs.ru>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Apr 14, 2016 at 01:26:51PM +1000, Alexey Kardashevskiy wrote:

.../...

>>
>>Do you mean physically pull the adapter out and insert the same
>>adapter back? What's the point for the test case?
>
>
>Because this is what the patchset is for - to replace a physical device on a
>physical machine. Powering on/off the slots via sysfs is just an
>approximation (which is fine when you are debugging), something can go wrong
>and require some work but you do not know it for sure.
>

Yes, It's absolutely worthy to be covered by the test cases though case (2)
covers part of that. Anyway, I'll test it through in next revision. Thanks
for your review.

>
>
>-- 
>Alexey
>

