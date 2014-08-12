Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp03.au.ibm.com ([202.81.31.145]:37861 "EHLO
	e23smtp03.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751415AbaHLI5m (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 12 Aug 2014 04:57:42 -0400
Received: from /spool/local
	by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Tue, 12 Aug 2014 18:57:40 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
	by d23dlp01.au.ibm.com (Postfix) with ESMTP id 3E41F2CE8040
	for <linux-pci@vger.kernel.org>; Tue, 12 Aug 2014 18:57:36 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id s7C8YJYg66388136
	for <linux-pci@vger.kernel.org>; Tue, 12 Aug 2014 18:34:20 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
	by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id s7C8vYvo016845
	for <linux-pci@vger.kernel.org>; Tue, 12 Aug 2014 18:57:35 +1000
Date: Tue, 12 Aug 2014 18:57:30 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Amir Vadai <amirv@mellanox.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>,
	Wei Yang <weiyang@linux.vnet.ibm.com>,
	linux-pci@vger.kernel.org, alex.williamson@redhat.com,
	Or Gerlitz <ogerlitz@mellanox.com>,
	Yevgeny Petrilin <yevgenyp@mellanox.com>,
	Eli Cohen <eli@mellanox.com>, Peter Paneah <peter@mellanox.com>
Subject: Re: [PATCH v2] PCI: Mark broken INTx masking for Mellanox devices
Message-ID: <20140812085730.GA26678@shangw>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1406868871-350-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <20140811134854.GA5794@richard>
 <20140812035226.GA15421@shangw>
 <53E9C79D.6080704@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <53E9C79D.6080704@mellanox.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Aug 12, 2014 at 10:51:57AM +0300, Amir Vadai wrote:
>On 8/12/2014 6:52 AM, Gavin Shan wrote:
>> On Mon, Aug 11, 2014 at 09:48:54PM +0800, Wei Yang wrote:
>>> >On Fri, Aug 01, 2014 at 02:54:31PM +1000, Gavin Shan wrote:
>>>> >>The VFIO driver is routing LSI interrupts by capturing, masking,
>>>> >>and then delivering. When passing though Mallanox adapters from
>>> >
>>> >one typo                                  Mellanox
>>> >
>>> >Others, looks good to me.
>>> >
>> Thanks, Richard. I'll correct it in next revision. However, I'm
>> still waiting for comments or ACK from Alex/Eli/Amir.
>> 
>> Thanks,
>> Gavin
>> 
>
>Hi Gavin,
>
>Sorry for the delay - wanted to understand the exact limitations with
>our Hardware/Firmware guys.
>
>Please change the device to PCI_ANY_ID since all Mellanox devices
>currently need the quirk.
>The issue will be fixed in the next GA firmwares.
>

Amir, thanks for confirm. I'll update in next revision accordingly.
Please ack next revision if possible.

Thanks,
Gavin

>Thanks,
>Amir
>

