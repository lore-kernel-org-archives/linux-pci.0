Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp07.au.ibm.com ([202.81.31.140]:60889 "EHLO
	e23smtp07.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932066AbbELIHj (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 12 May 2015 04:07:39 -0400
Received: from /spool/local
	by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Tue, 12 May 2015 18:07:35 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
	by d23dlp01.au.ibm.com (Postfix) with ESMTP id 177312CE804E
	for <linux-pci@vger.kernel.org>; Tue, 12 May 2015 18:07:34 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t4C87Pw638600724
	for <linux-pci@vger.kernel.org>; Tue, 12 May 2015 18:07:34 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t4C870Hn000425
	for <linux-pci@vger.kernel.org>; Tue, 12 May 2015 18:07:01 +1000
Date: Tue, 12 May 2015 16:06:43 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, bhelgaas@google.com,
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH V3 6/9] powerpc/powernv: create/release eeh_dev for VF
Message-ID: <20150512080643.GC16788@richard>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <1430723258-21299-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1430723258-21299-7-git-send-email-weiyang@linux.vnet.ibm.com>
 <20150511024856.GB8816@gwshan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150511024856.GB8816@gwshan>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, May 11, 2015 at 12:48:56PM +1000, Gavin Shan wrote:
>On Mon, May 04, 2015 at 03:07:35PM +0800, Wei Yang wrote:
>
>Please order this patch and PATCH[5] because EEH device is expected to
>be created before EEH PE.
>
>>EEH on powerpc platform needs eeh_dev structure to track the pci device
>                                                              ^^^
>							      PCI
>
>>status. Since VFs are created/released dynamically, VF's eeh_dev is also
>>dynamically created/released in system.
>>
>>This patch creates/removes eeh_dev when pci_dn is created/removed for VFs,
>>and marks it with EEH_DEV_VF type.
>>
>>Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
>>---
>> arch/powerpc/include/asm/eeh.h |    7 +++++++
>> arch/powerpc/kernel/eeh.c      |    4 ++++
>> arch/powerpc/kernel/eeh_dev.c  |   20 ++++++++++++++++++++
>> arch/powerpc/kernel/pci_dn.c   |    7 +++++++
>> 4 files changed, 38 insertions(+)
>>
>>diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
>>index 56e8cd9..2067de4 100644
>>--- a/arch/powerpc/include/asm/eeh.h
>>+++ b/arch/powerpc/include/asm/eeh.h
>>@@ -124,6 +124,7 @@ static inline bool eeh_pe_passed(struct eeh_pe *pe)
>> #define EEH_DEV_NO_HANDLER	(1 << 8)	/* No error handler	*/
>> #define EEH_DEV_SYSFS		(1 << 9)	/* Sysfs created	*/
>> #define EEH_DEV_REMOVED		(1 << 10)	/* Removed permanently	*/
>>+#define EEH_DEV_VF		(1 << 11)	/* VF port		*/
>>
>
>Why you need this flag? I guess "edev->physfn" can be used to distinguish
>it's a normal or VF eeh_dev.
>

Just like we have EEH_DEV_BRIDGE and EEH_DEV_DS_PORT, I use the flag
EEH_DEV_VF to mark it a VF eeh_dev.


-- 
Richard Yang
Help you, Help me

