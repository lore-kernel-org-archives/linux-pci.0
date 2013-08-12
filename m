Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp09.au.ibm.com ([202.81.31.142]:41584 "EHLO
	e23smtp09.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754419Ab3HLLhM (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 12 Aug 2013 07:37:12 -0400
Received: from /spool/local
	by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <naveen.n.rao@linux.vnet.ibm.com>;
	Tue, 13 Aug 2013 08:31:49 +1000
Message-ID: <5208C8DD.3050204@linux.vnet.ibm.com>
Date: Mon, 12 Aug 2013 17:07:01 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Steven Rostedt <rostedt@goodmis.org>
CC: tony.luck@intel.com, bp@alien8.de, bhelgaas@google.com,
	rjw@sisk.pl, lance.ortiz@hp.com, m.chehab@samsung.com,
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] mce: acpi/apei: trace: Include PCIe AER trace event
 conditionally
References: <1375986471-27113-1-git-send-email-naveen.n.rao@linux.vnet.ibm.com> <1375986471-27113-2-git-send-email-naveen.n.rao@linux.vnet.ibm.com> <20130808152329.1f98b5e0@gandalf.local.home>
In-Reply-To: <20130808152329.1f98b5e0@gandalf.local.home>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 08/09/2013 12:53 AM, Steven Rostedt wrote:
> [ attempting to try out claws-mail, hopefully this messages isn't
> scrambled ;-) ]

Works just fine :)

>
> On Thu,  8 Aug 2013 23:57:49 +0530
> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
>
>> Since we'll be adding multiple trace events to ras.h, we need to protect
>> each block appropriately so that they only get included in the right
>> places. Update PCIe AER trace event for this purpose.
>
> Why not make a separate file for each? You will have to define

The idea was to have all RAS-related trace points in a single place. 
This was discussed back when the PCIe AER trace event was added and so I 
chose to add the new event here as well.

> TRACE_EVENT_PCIE_AER for the users as well. That is, the places that
> include ras.h and use the trace_aer_*() tracepoints.

Do you mean the change I've done to aerdrv-errprint.c below? This trace 
point is currently only used there, so I guess we are ok?

Thanks,
Naveen


>
>
>>
>> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
>> ---
>>   drivers/pci/pcie/aer/aerdrv_errprint.c | 1 +
>>   include/trace/events/ras.h             | 2 +-
>>   2 files changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/pcie/aer/aerdrv_errprint.c b/drivers/pci/pcie/aer/aerdrv_errprint.c
>> index 2c7c9f5..4d06859 100644
>> --- a/drivers/pci/pcie/aer/aerdrv_errprint.c
>> +++ b/drivers/pci/pcie/aer/aerdrv_errprint.c
>> @@ -24,6 +24,7 @@
>>   #include "aerdrv.h"
>>
>>   #define CREATE_TRACE_POINTS
>> +#define TRACE_EVENT_PCIE_AER
>>   #include <trace/events/ras.h>
>>
>>   #define AER_AGENT_RECEIVER		0
>> diff --git a/include/trace/events/ras.h b/include/trace/events/ras.h
>> index 88b8783..4a66142 100644
>> --- a/include/trace/events/ras.h
>> +++ b/include/trace/events/ras.h
>> @@ -1,7 +1,7 @@
>>   #undef TRACE_SYSTEM
>>   #define TRACE_SYSTEM ras
>>
>> -#if !defined(_TRACE_AER_H) || defined(TRACE_HEADER_MULTI_READ)
>> +#if (!defined(_TRACE_AER_H) || defined(TRACE_HEADER_MULTI_READ)) && defined()
>
> I think it would look cleaner to encapsulate the one define with the
> other:
>
> #ifdef TRACE_EVENT_PCIE_AER
> #if !defined(_TRACE_AER_H) || defined(TRACE_HEADER_MULTI_READ)
>
>
> -- Steve
>
>>   #define _TRACE_AER_H
>>
>>   #include <linux/tracepoint.h>
>

