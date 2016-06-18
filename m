Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:17819 "EHLO
	mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932065AbcFRDSm (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 17 Jun 2016 23:18:42 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id u5I3IdeL113662
	for <linux-pci@vger.kernel.org>; Fri, 17 Jun 2016 23:18:41 -0400
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [125.16.236.9])
	by mx0a-001b2d01.pphosted.com with ESMTP id 23mtd1mq81-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 17 Jun 2016 23:18:40 -0400
Received: from localhost
	by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Sat, 18 Jun 2016 08:48:36 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
	by d28dlp01.in.ibm.com (Postfix) with ESMTP id 10578E0045
	for <linux-pci@vger.kernel.org>; Sat, 18 Jun 2016 08:52:12 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
	by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id u5I3HoTi18612624
	for <linux-pci@vger.kernel.org>; Sat, 18 Jun 2016 08:47:50 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
	by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id u5I3IQIK020990
	for <linux-pci@vger.kernel.org>; Sat, 18 Jun 2016 08:48:31 +0530
Date: Sat, 18 Jun 2016 13:18:22 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>,
	linuxppc-dev@lists.ozlabs.org, aik@ozlabs.ru,
	linux-pci@vger.kernel.org, alistair@popple.id.au
Subject: Re: [v10,17/18] powerpc/powernv: Functions to get/set PCI slot state
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1463726502-14679-18-git-send-email-gwshan@linux.vnet.ibm.com>
 <3rWGlZ2Qs5z9t0v@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3rWGlZ2Qs5z9t0v@ozlabs.org>
Message-Id: <20160618031822.GA6937@gwshan>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jun 17, 2016 at 08:32:10PM +1000, Michael Ellerman wrote:
>On Fri, 2016-20-05 at 06:41:41 UTC, Gavin Shan wrote:
>> diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
>> index 9bb8ddf..2417c86 100644
>> --- a/arch/powerpc/include/asm/opal-api.h
>> +++ b/arch/powerpc/include/asm/opal-api.h
>> @@ -344,6 +348,18 @@ enum OpalPciResetState {
>>  	OPAL_ASSERT_RESET   = 1
>>  };
>>  
>> +enum OpalPciSlotPresentenceState {
>
>In skiboot this is called "OpalPciSlotPresence".
>
>I've renamed it.
>
>> +	OPAL_PCI_SLOT_EMPTY	= 0,
>> +	OPAL_PCI_SLOT_PRESENT	= 1
>> +};
>> +
>> +enum OpalPciSlotPowerState {
>
>In skiboot this is called "OpalPciSlotPower".
>
>I've renamed it.
>
>> +	OPAL_PCI_SLOT_POWER_OFF	= 0,
>> +	OPAL_PCI_SLOT_POWER_ON	= 1,
>> +	OPAL_PCI_SLOT_OFFLINE	= 2,
>> +	OPAL_PCI_SLOT_ONLINE	= 3
>> +};
>> +
>>  enum OpalSlotLedType {
>>  	OPAL_SLOT_LED_TYPE_ID = 0,	/* IDENTIFY LED */
>>  	OPAL_SLOT_LED_TYPE_FAULT = 1,	/* FAULT LED */
>> @@ -378,6 +394,7 @@ enum opal_msg_type {
>>  	OPAL_MSG_DPO		= 5,
>>  	OPAL_MSG_PRD		= 6,
>>  	OPAL_MSG_OCC		= 7,
>> +	OPAL_MSG_PCI_HOTPLUG	= 8,
>
>I don't see this in skiboot?
>
>It also doesn't seem to be used, so I've dropped it.
>

Thanks, Michael. All the changes are correct. The enum name was changed
in the last skiboot patchset that was merged couple days ago. At same
time, OPAL_MSG_PCI_HOTPLUG isn't needed as PCI hotplug won't have one
dedicated message type, an asychornous message is used instead.

Thanks,
Gavin


>>  	OPAL_MSG_TYPE_MAX,
>>  };
>>  
>
>cheers
>

