Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e24smtp04.br.ibm.com ([32.104.18.25]:52802 "EHLO
	e24smtp04.br.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753608AbbHXMSm (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 24 Aug 2015 08:18:42 -0400
Received: from /spool/local
	by e24smtp04.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gpiccoli@linux.vnet.ibm.com>;
	Mon, 24 Aug 2015 09:18:39 -0300
Received: from d24relay02.br.ibm.com (d24relay02.br.ibm.com [9.13.184.26])
	by d24dlp01.br.ibm.com (Postfix) with ESMTP id 85F4C352007B
	for <linux-pci@vger.kernel.org>; Mon, 24 Aug 2015 08:17:30 -0400 (EDT)
Received: from d24av04.br.ibm.com (d24av04.br.ibm.com [9.8.31.97])
	by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t7OCGrPT21365160
	for <linux-pci@vger.kernel.org>; Mon, 24 Aug 2015 09:16:53 -0300
Received: from d24av04.br.ibm.com (localhost [127.0.0.1])
	by d24av04.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t7OCIY8o018937
	for <linux-pci@vger.kernel.org>; Mon, 24 Aug 2015 09:18:35 -0300
Subject: Re: [PATCH v2 1/2] PCI: Make pci_msi_setup_pci_dev() non-static for
 use by arch code
To: Michael Ellerman <mpe@ellerman.id.au>
References: <1439945086.23217.5.camel@ellerman.id.au>
 <1439932077-11427-2-git-send-email-gpiccoli@linux.vnet.ibm.com>
 <1440009922-30248-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
 <1440032549.13406.3.camel@ellerman.id.au>
 <55D62636.5050403@linux.vnet.ibm.com>
 <1440401878.15373.2.camel@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
	gwshan@linux.vnet.ibm.com, benh@kernel.crashing.org,
	paulus@samba.org, bhelgaas@google.com, mst@redhat.com
From: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
Message-ID: <55DB0B9A.5090407@linux.vnet.ibm.com>
Date: Mon, 24 Aug 2015 09:18:34 -0300
MIME-Version: 1.0
In-Reply-To: <1440401878.15373.2.camel@ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 08/24/2015 04:37 AM, Michael Ellerman wrote:
>> more: I was testing driver issues on kernel 2.6.32 (RHEL 6.6), and when
>> I tried the mainline kernel, the driver wasn't able to enable MSI-X
>> capabilities. Interestingly, on kernel 4.1 this behavior doesn't happen
>> and the driver can use MSI-X interrupts.
>>
>> So, I figured that something was wrong and found the problem described
>> on the patches. I tried the proposed solution (calling manually the
>> function that is not reachable anymore) and it works.
>>
>> Regarding the bnx2x driver, below are two dmesg outputs:
>>
>> 1) With kernel 4.2-rc7
>> bnx2x 0000:01:00.0: no msix capability found
>
> OK. This is because the initialisation of dev->msix_cap was lost due to commit
> 1851617cd2da.
>
>> 2) With kernel 4.1
>> bnx2x 0000:01:00.0: msix capability found
>> bnx2x 0000:01:00.0 eth2: using MSI-X  IRQs: sp 24  fp[0] 26 ... fp[7] 33
>
> OK. And I assume with these patches you see the above output again.

Exactly. With the proposed patches applied, dev->msix_cap is initialized 
normally, so the driver is able to do its job as usual.


>>> Or anywhere after the first '---', which means the version commentary is
>>> discarded in the final commit.
>>
>> I used scissors, but there's no problem in stop using it in this list.
>
> Thanks, but my scripts don't grok scissors. So I prefer the commentary after
> the '---'.

Thanks for the info.

Cheers

