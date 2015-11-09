Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e28smtp07.in.ibm.com ([122.248.162.7]:41314 "EHLO
	e28smtp07.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752016AbbKIBxi (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 8 Nov 2015 20:53:38 -0500
Received: from /spool/local
	by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Mon, 9 Nov 2015 07:23:35 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
	by d28dlp03.in.ibm.com (Postfix) with ESMTP id 57278125801E
	for <linux-pci@vger.kernel.org>; Mon,  9 Nov 2015 07:23:35 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id tA91rUi01310996
	for <linux-pci@vger.kernel.org>; Mon, 9 Nov 2015 07:23:31 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
	by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id tA91rSZT028564
	for <linux-pci@vger.kernel.org>; Mon, 9 Nov 2015 07:23:29 +0530
Date: Mon, 9 Nov 2015 09:53:27 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, gwshan@linux.vnet.ibm.com,
	bhelgaas@google.com, mpe@ellerman.id.au,
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH V13 0/9] VF EEH on Power8
Message-ID: <20151109015327.GA1443@richards-mbp.cn.ibm.com>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <1446939035-2617-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <563FE06D.4080801@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <563FE06D.4080801@ozlabs.ru>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Nov 09, 2015 at 10:53:17AM +1100, Alexey Kardashevskiy wrote:
>On 11/08/2015 10:30 AM, Wei Yang wrote:
>>This patchset enables EEH on SRIOV VFs. The general idea is to create proper
>>VF edev and VF PE and handle them properly.
>>
>>Different from the Bus PE, VF PE just contain one VF. This introduces the
>>difference of EEH error handling on a VF PE. Generally, it has several
>>differences.
>>
>>First, the VF's removal and re-enumerate rely on its PF. VF has a tight
>>relationship between its PF. This is not proper to enumerate a VF by usual
>>scan procedure. That's why virtfn_add/virtfn_remove are exported in this patch
>>set.
>>
>>Second, the reset/restore of a VF is done in kernel space. FW is not aware of
>>the VF, this means the usual reset function done in FW will not work. One of
>>the patch will imitate the reset/restore function in kernel space.
>>
>>Third, the VF may be removed during the PF's error_detected function. In this
>>case, the original error_detected->slot_reset->resume sequence is not proper
>>to those removed VFs, since they are re-created by PF in a fresh state. A flag
>>in eeh_dev is introduce to mark the eeh_dev is in error state. By doing so, we
>>track whether this device needs to be reset or not.
>>
>>This has been tested both on host and in guest on Power8 with latest kernel
>>version.
>
>
>This does not apply on top of neither Linus master tree
>(git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git sha1
>ce5c2d2) nor Michael's PPC next tree
>(git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git sha1
>8bdf2023). What did you base your work on?
>

I didn't based this on the latest code.

This is based on v4.3, commit "6a13feb Linux 4.3".

>
>-- 
>Alexey

-- 
Richard Yang
Help you, Help me

