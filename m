Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e28smtp09.in.ibm.com ([122.248.162.9]:35502 "EHLO
	e28smtp09.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750749AbaFKGBd (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 11 Jun 2014 02:01:33 -0400
Received: from /spool/local
	by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <yan@linux.vnet.ibm.com>;
	Wed, 11 Jun 2014 11:31:30 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
	by d28dlp02.in.ibm.com (Postfix) with ESMTP id B62723940049
	for <linux-pci@vger.kernel.org>; Wed, 11 Jun 2014 11:31:26 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
	by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id s5B62IYN58982520
	for <linux-pci@vger.kernel.org>; Wed, 11 Jun 2014 11:32:18 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
	by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id s5B61N9p023000
	for <linux-pci@vger.kernel.org>; Wed, 11 Jun 2014 11:31:24 +0530
Date: Wed, 11 Jun 2014 14:01:18 +0800
From: Guo Chao <yan@linux.vnet.ibm.com>
To: bhelgaas@google.com, yinghai@kernel.org
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH] pci: Allow very large resource windows
Message-ID: <20140611060118.GB3169@yanx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

>On Mon, May 19, 2014 at 02:03:14PM +0100, Alan wrote:
>> From: Alan <alan@xxxxxxxxxxxxxxx>
>> 
>> This is needed for some of the Xeon Phi type systems.
>> 
>> Signed-off-by: Alan Cox <alan@xxxxxxxxxxxxxxx>
>
> I applied this to my pci/resource branch for v3.16.  Nikhil
> posted essentially the same patch a couple years ago, so I added
> his signed-off-by and adopted his use of ARRAY_SIZE() to connect the
> "order > 13" test with the aligns[] declaration.

Well, that's not enough for our 16G BAR ...

I thought Yinghai fixed it permanently last time:

	http://permalink.gmane.org/gmane.linux.kernel.pci/29142

Are you still working on this, Yinghai?

Thanks,
Guo Chao

