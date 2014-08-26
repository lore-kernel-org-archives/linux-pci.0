Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e28smtp02.in.ibm.com ([122.248.162.2]:34003 "EHLO
	e28smtp02.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933663AbaHZA6T (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 25 Aug 2014 20:58:19 -0400
Received: from /spool/local
	by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Tue, 26 Aug 2014 06:28:16 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
	by d28dlp02.in.ibm.com (Postfix) with ESMTP id 2F671394004E
	for <linux-pci@vger.kernel.org>; Tue, 26 Aug 2014 06:28:13 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
	by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id s7Q10Zwk65929350
	for <linux-pci@vger.kernel.org>; Tue, 26 Aug 2014 06:30:36 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
	by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id s7Q0wB2h018007
	for <linux-pci@vger.kernel.org>; Tue, 26 Aug 2014 06:28:12 +0530
Date: Tue, 26 Aug 2014 10:58:02 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Amir Vadai <amirv@mellanox.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, linux-pci@vger.kernel.org,
	alex.williamson@redhat.com, eli@mellanox.com,
	weiyang@linux.vnet.ibm.com, bhelgaas@google.com
Subject: Re: [PATCH v3] PCI: Mark broken INTx masking for Mellanox devices
Message-ID: <20140826005801.GA4399@shangw>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1407844091-20815-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <53EA01B5.5020900@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <53EA01B5.5020900@mellanox.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Aug 12, 2014 at 02:59:49PM +0300, Amir Vadai wrote:
>On 8/12/2014 2:48 PM, Gavin Shan wrote:

Cc Bjorn so that he can pick it up if possible.

>> The VFIO driver is routing LSI interrupts by capturing, masking,
>> and then delivering. When passing though Mellanox adapters from
>> host to guest, interrupt storm was reported from host and guest.
>> That's because we can't mask the LSI interrupt with help of PCI
>> command register.
>> 
>>  # lspci | grep Mellanox
>>  0001:05:00.0 Ethernet controller: Mellanox Technologies MT27500 \
>>               Family [ConnectX-3]
>>  0005:01:00.0 Ethernet controller: Mellanox Technologies MT26448 \
>>               [ConnectX EN 10GigE, PCIe 2.0 5GT/s] (rev b0)
>> 
>> It's confirmed by Amir Vadai that all Mellanox devices have same
>> problem. The patch marks broken INTx masking for all Mellanox
>> adapters.
>> 
>> Cc: Amir Vadai <amirv@mellanox.com>
>> Suggested-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>> ---
>> v3: Mark broken INTx masking for all Mellanox adapters
>> ---
>>  drivers/pci/quirks.c | 2 ++
>>  1 file changed, 2 insertions(+)
>> 
>
>Acked-By: Amir Vadai <amirv@mellanox.com>
>

Thanks,
Gavin

>--
>To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

