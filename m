Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e28smtp01.in.ibm.com ([122.248.162.1]:36784 "EHLO
	e28smtp01.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750744AbbIIGBy (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 9 Sep 2015 02:01:54 -0400
Received: from /spool/local
	by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Wed, 9 Sep 2015 11:31:51 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
	by d28dlp02.in.ibm.com (Postfix) with ESMTP id ABCB2394005C
	for <linux-pci@vger.kernel.org>; Wed,  9 Sep 2015 11:31:47 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t8961XtJ8323276
	for <linux-pci@vger.kernel.org>; Wed, 9 Sep 2015 11:31:33 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
	by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t8961V0l030674
	for <linux-pci@vger.kernel.org>; Wed, 9 Sep 2015 11:31:32 +0530
Date: Wed, 9 Sep 2015 14:01:29 +0800
From: Richard Yang <weiyang@linux.vnet.ibm.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Richard Yang <weiyang@linux.vnet.ibm.com>,
	Gavin Shan <gwshan@linux.vnet.ibm.com>, bhelgaas@google.com,
	mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH V9 11/11] powerpc/powernv: compound PE for VFs
Message-ID: <20150909060129.GC7684@Richards-MacBook-Pro.local>
Reply-To: Richard Yang <weiyang@linux.vnet.ibm.com>
References: <1437112961-17275-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1437112961-17275-12-git-send-email-weiyang@linux.vnet.ibm.com>
 <20150729031718.GA18069@richard>
 <20150909024820.GA6808@gwshan>
 <20150909033616.GA5148@richards-mbp.cn.ibm.com>
 <55EFC200.10209@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <55EFC200.10209@ozlabs.ru>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Sep 09, 2015 at 03:22:08PM +1000, Alexey Kardashevskiy wrote:
>On 09/09/2015 01:36 PM, Richard Yang wrote:
>>On Wed, Sep 09, 2015 at 12:48:21PM +1000, Gavin Shan wrote:
>>>On Wed, Jul 29, 2015 at 11:17:18AM +0800, Wei Yang wrote:
>>>>Hi, Michael
>>>>
>>>>Hope you didn't take this yet. We may change this patch a little.
>>>>
>>>
>>>[Cc Alexey who might concern the SRIOV status]
>>>
>>>Richard, do you have plan to get it upstream? It seems it's hanged
>>>over here for long time.
>>>
>>
>>The VF EEH is hung since we re-designed the SRIOV. After the re-design, we
>>don't have VF groups.
>>
>>My plan is to push the VF EEH patch set after the SRIOV Redesign is accepted.
>
>
>Can you please rebase on v4.2 (or v4.2 + sriov rework) and repost VF EEH
>patchset just to me? Or share the tree somewhere where I can pull it from?
>Thanks.
>

Yep, this is what I am planning to do.

>As for now, I cannot tell what difference your SRIOV patchset actually makes.
>
>-- 
>Alexey

-- 
Richard Yang
Help you, Help me

