Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e28smtp05.in.ibm.com ([122.248.162.5]:53520 "EHLO
	e28smtp05.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755058Ab3DVJo4 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 22 Apr 2013 05:44:56 -0400
Received: from /spool/local
	by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <qiudayu@linux.vnet.ibm.com>;
	Mon, 22 Apr 2013 15:11:22 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
	by d28dlp02.in.ibm.com (Postfix) with ESMTP id 84941394002D
	for <linux-pci@vger.kernel.org>; Mon, 22 Apr 2013 15:14:50 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
	by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id r3M9ihEM524586
	for <linux-pci@vger.kernel.org>; Mon, 22 Apr 2013 15:14:44 +0530
Received: from d28av05.in.ibm.com (loopback [127.0.0.1])
	by d28av05.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id r3M9inZg022209
	for <linux-pci@vger.kernel.org>; Mon, 22 Apr 2013 19:44:49 +1000
Message-ID: <5175067F.3030307@linux.vnet.ibm.com>
Date: Mon, 22 Apr 2013 17:44:31 +0800
From: Mike Qiu <qiudayu@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: linux-pci@vger.kernel.org, tglx@linutronix.de
Subject: Re: [PATCH] PowerNV/PCI: Fix NULL PCI controller
References: <1366611236-1811-1-git-send-email-qiudayu@linux.vnet.ibm.com> <1366612577.2723.21.camel@pasglop> <5174E9C3.6080203@linux.vnet.ibm.com> <1366617867.2723.23.camel@pasglop>
In-Reply-To: <1366617867.2723.23.camel@pasglop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

于 2013/4/22 16:04, Benjamin Herrenschmidt 写道:
> On Mon, 2013-04-22 at 15:41 +0800, Mike Qiu wrote:
>> Anyway, I think it's better to remove the check code as it is useless,
>> as it
>> will shows that this "NULL" pci_controller pointer may happen...
> Ok. It *might* still be worth adding a BUG_ON then in pci_bus_to_host()
> itself ... no big deal either way.
OK, you mean the code will remain the same and my patch is worthless?

Anyway, it will be OK for me. But I hope it can be accept for more stable
reason.

Thanks
Mike
> Cheers,
> Ben.
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>

