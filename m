Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp01.au.ibm.com ([202.81.31.143]:37099 "EHLO
	e23smtp01.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423600AbcBQWiL (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 17 Feb 2016 17:38:11 -0500
Received: from localhost
	by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Thu, 18 Feb 2016 08:38:09 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
	by d23dlp02.au.ibm.com (Postfix) with ESMTP id 1DA372BB0045
	for <linux-pci@vger.kernel.org>; Thu, 18 Feb 2016 09:38:06 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id u1HMbwrm8520052
	for <linux-pci@vger.kernel.org>; Thu, 18 Feb 2016 09:38:06 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id u1HMbWX0022389
	for <linux-pci@vger.kernel.org>; Thu, 18 Feb 2016 09:37:33 +1100
Date: Thu, 18 Feb 2016 09:36:38 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Russell Currey <ruscur@russell.cc>, linuxppc-dev@lists.ozlabs.org,
	gwshan@linux.vnet.ibm.com, linux-pci@vger.kernel.org,
	benh@kernel.crashing.org
Subject: Re: [PATCH] MAINTAINERS: Update EEH details and maintainership
Message-ID: <20160217223638.GB6112@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1455689164-12128-1-git-send-email-ruscur@russell.cc>
 <20160217173224.GA28147@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160217173224.GA28147@localhost>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Feb 17, 2016 at 11:32:24AM -0600, Bjorn Helgaas wrote:
>On Wed, Feb 17, 2016 at 05:06:04PM +1100, Russell Currey wrote:
>> Enhanced Error Handling could mean anything in the context of the entire
>> kernel, so change the name to reference that it is both for PCI and
>> powerpc.
>> 
>> EEH covers a bit more than the previously listed files, so add the headers
>> and platform-specific code to the EEH maintained section.
>> 
>> In addition, I am taking over the maintainership.
>> 
>> Signed-off-by: Russell Currey <ruscur@russell.cc>
>
>This is fine with me.  I expect it will be merged via the powerpc tree,
>since I think that's how all of Gavin Shan's recent patches in this area
>are being handled.
>

Bjorn, thanks for your great helps in the past. Yeah, I think the code
will be merged via the powerpc tree as before. Looking forward to your
support Russell's work in future :-)

Thanks,
Gavin

>> ---
>>  MAINTAINERS | 16 +++++++++-------
>>  1 file changed, 9 insertions(+), 7 deletions(-)
>> 
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 28eb61b..95d999e 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -4222,13 +4222,6 @@ M:	Maxim Levitsky <maximlevitsky@gmail.com>
>>  S:	Maintained
>>  F:	drivers/media/rc/ene_ir.*
>>  
>> -ENHANCED ERROR HANDLING (EEH)
>> -M:	Gavin Shan <shangw@linux.vnet.ibm.com>
>> -L:	linuxppc-dev@lists.ozlabs.org
>> -S:	Supported
>> -F:	Documentation/powerpc/eeh-pci-error-recovery.txt
>> -F:	arch/powerpc/kernel/eeh*.c
>> -
>>  EPSON S1D13XXX FRAMEBUFFER DRIVER
>>  M:	Kristoffer Ericson <kristoffer.ericson@gmail.com>
>>  S:	Maintained
>> @@ -8244,6 +8237,15 @@ L:	linux-pci@vger.kernel.org
>>  S:	Supported
>>  F:	Documentation/PCI/pci-error-recovery.txt
>>  
>> +PCI ENHANCED ERROR HANDLING (EEH) FOR POWERPC
>> +M:	Russell Currey <ruscur@russell.cc>
>> +L:	linuxppc-dev@lists.ozlabs.org
>> +S:	Supported
>> +F:	Documentation/powerpc/eeh-pci-error-recovery.txt
>> +F:	arch/powerpc/kernel/eeh*.c
>> +F:	arch/powerpc/platforms/*/eeh*.c
>> +F:	arch/powerpc/include/*/eeh*.h
>> +
>>  PCI SUBSYSTEM
>>  M:	Bjorn Helgaas <bhelgaas@google.com>
>>  L:	linux-pci@vger.kernel.org
>> -- 
>> 2.7.1
>> 
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

