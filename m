Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:33590 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751441AbbKHXxY (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 8 Nov 2015 18:53:24 -0500
Received: by pabfh17 with SMTP id fh17so179135152pab.0
        for <linux-pci@vger.kernel.org>; Sun, 08 Nov 2015 15:53:23 -0800 (PST)
Subject: Re: [PATCH V13 0/9] VF EEH on Power8
To: Wei Yang <weiyang@linux.vnet.ibm.com>, gwshan@linux.vnet.ibm.com,
	bhelgaas@google.com, mpe@ellerman.id.au
References: <1446939035-2617-1-git-send-email-weiyang@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <563FE06D.4080801@ozlabs.ru>
Date: Mon, 9 Nov 2015 10:53:17 +1100
MIME-Version: 1.0
In-Reply-To: <1446939035-2617-1-git-send-email-weiyang@linux.vnet.ibm.com>
Content-Type: text/plain; charset=koi8-r; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 11/08/2015 10:30 AM, Wei Yang wrote:
> This patchset enables EEH on SRIOV VFs. The general idea is to create proper
> VF edev and VF PE and handle them properly.
>
> Different from the Bus PE, VF PE just contain one VF. This introduces the
> difference of EEH error handling on a VF PE. Generally, it has several
> differences.
>
> First, the VF's removal and re-enumerate rely on its PF. VF has a tight
> relationship between its PF. This is not proper to enumerate a VF by usual
> scan procedure. That's why virtfn_add/virtfn_remove are exported in this patch
> set.
>
> Second, the reset/restore of a VF is done in kernel space. FW is not aware of
> the VF, this means the usual reset function done in FW will not work. One of
> the patch will imitate the reset/restore function in kernel space.
>
> Third, the VF may be removed during the PF's error_detected function. In this
> case, the original error_detected->slot_reset->resume sequence is not proper
> to those removed VFs, since they are re-created by PF in a fresh state. A flag
> in eeh_dev is introduce to mark the eeh_dev is in error state. By doing so, we
> track whether this device needs to be reset or not.
>
> This has been tested both on host and in guest on Power8 with latest kernel
> version.


This does not apply on top of neither Linus master tree 
(git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git sha1 
ce5c2d2) nor Michael's PPC next tree 
(git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git sha1 
8bdf2023). What did you base your work on?


-- 
Alexey
