Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e28smtp04.in.ibm.com ([122.248.162.4]:58947 "EHLO
	e28smtp04.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751139AbaGVB71 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 21 Jul 2014 21:59:27 -0400
Received: from /spool/local
	by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <qiudayu@linux.vnet.ibm.com>;
	Tue, 22 Jul 2014 07:29:24 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
	by d28dlp03.in.ibm.com (Postfix) with ESMTP id 93D0A125804D
	for <linux-pci@vger.kernel.org>; Tue, 22 Jul 2014 07:29:14 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
	by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id s6M21A2G56885348
	for <linux-pci@vger.kernel.org>; Tue, 22 Jul 2014 07:31:10 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
	by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id s6M1xMWg008278
	for <linux-pci@vger.kernel.org>; Tue, 22 Jul 2014 07:29:22 +0530
Message-ID: <53CDC578.3090800@linux.vnet.ibm.com>
Date: Tue, 22 Jul 2014 09:59:20 +0800
From: Mike Qiu <qiudayu@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Tuomas Tynkkynen <ttynkkynen@nvidia.com>
Subject: Re: [PATCH] Fix build warnings in aer.h
References: <1405498124-11519-1-git-send-email-qiudayu@linux.vnet.ibm.com> <CAErSpo47WBkOuThU6ZW0htSm9s2P_r0ebZ6T3TM0dWiSdaGaBA@mail.gmail.com>
In-Reply-To: <CAErSpo47WBkOuThU6ZW0htSm9s2P_r0ebZ6T3TM0dWiSdaGaBA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 07/17/2014 02:08 AM, Bjorn Helgaas wrote:
> On Wed, Jul 16, 2014 at 2:08 AM, Mike Qiu <qiudayu@linux.vnet.ibm.com> wrote:
>> build log:
>>
>> In file included from include/ras/ras_event.h:11:0,
>>                   from drivers/ras/ras.c:13:
>> include/linux/aer.h:42:129: warning: ‘struct pci_dev’
>> declared inside parameter list [enabled by default]
>>
>> include/linux/aer.h:42:129: warning: its scope is only
>> this definition or declaration, which is probably not
>> what you want [enabled by default]
>>
>> include/linux/aer.h:46:130: warning: ‘struct pci_dev’
>> declared inside parameter list [enabled by default]
>>
>> include/linux/aer.h:50:136: warning: ‘struct pci_dev’
>> declared inside parameter list [enabled by default]
>>
>> include/linux/aer.h:57:14: warning: ‘struct pci_dev’
>> declared inside parameter list [enabled by default]
>>
>> Signed-off-by: Mike Qiu <qiudayu@linux.vnet.ibm.com>
> Hi Mike,
>
> How did you reproduce this build error?  There are other include files
> that use pci_dev without a previous declaration or include of
> include/linux/pci.h, e.g., include/linux/msi.h, so I want to make sure
> we don't have similar problems elsewhere.
( I have reply it before but seems haven't send out successful, just 
resend it, if you have seen, pls ignore this)
I checkout to linux-next master branch, see the top commit is:

commit b997a07604562f1a54cc531fe1cf7447f0ed6078
Author: Stephen Rothwell <sfr@canb.auug.org.au>
Date:   Tue Jul 15 18:34:28 2014 +1000

     Add linux-next specific files for 20140715

     Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Use default config file(copy from /boot/) then use command "make -j60",  
and it will show that message. but for "msi.h" I haven't see this warning.

Thanks,
Mike
> Bjorn
>
>> ---
>>   include/linux/aer.h | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/include/linux/aer.h b/include/linux/aer.h
>> index 4dbaa70..c826d1c 100644
>> --- a/include/linux/aer.h
>> +++ b/include/linux/aer.h
>> @@ -11,6 +11,8 @@
>>   #define AER_FATAL                      1
>>   #define AER_CORRECTABLE                        2
>>
>> +struct pci_dev;
>> +
>>   struct aer_header_log_regs {
>>          unsigned int dw0;
>>          unsigned int dw1;
>> --
>> 1.8.1.4
>>

