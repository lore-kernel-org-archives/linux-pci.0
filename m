Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e28smtp03.in.ibm.com ([122.248.162.3]:54438 "EHLO
	e28smtp03.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755449Ab3GBBvP (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 1 Jul 2013 21:51:15 -0400
Received: from /spool/local
	by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Tue, 2 Jul 2013 07:15:00 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
	by d28dlp03.in.ibm.com (Postfix) with ESMTP id 5B50F1258054
	for <linux-pci@vger.kernel.org>; Tue,  2 Jul 2013 07:20:17 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
	by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id r621p5Cs21299404
	for <linux-pci@vger.kernel.org>; Tue, 2 Jul 2013 07:21:06 +0530
Received: from d28av05.in.ibm.com (loopback [127.0.0.1])
	by d28av05.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id r621p850003248
	for <linux-pci@vger.kernel.org>; Tue, 2 Jul 2013 11:51:09 +1000
Date: Tue, 2 Jul 2013 09:51:07 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Gavin Shan <shangw@linux.vnet.ibm.com>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, linux-pci@vger.kernel.org,
	linuxram@us.ibm.com
Subject: Re: [PATCH 0/4] optimization/fix/cleanup in
 pci_assign_unassigned_resources
Message-ID: <20130702015107.GA7456@weiyang.vnet.ibm.com>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <1372691432-6440-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <20130701231040.GA8174@shangw.(null)>
 <20130701231540.GA15263@shangw.(null)>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130701231540.GA15263@shangw.(null)>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jul 02, 2013 at 07:15:41AM +0800, Gavin Shan wrote:
>On Tue, Jul 02, 2013 at 07:10:41AM +0800, Gavin Shan wrote:
>>On Mon, Jul 01, 2013 at 11:10:28PM +0800, Wei Yang wrote:
>>>Here is some patches do the optimization/fix/cleanup for the function
>>>pci_assign_unassigned_resources().
>>>
>>
>>It looks good to me. Please make sure to rebase to upstream or linux-next
>>before sending out :-)
>>
>
>You already posted it to public and just realize it.

Yes :-)

This patch set is based on 3.10-rc2, so not the latest one.

Next time I will rebased the patch on the latest one and then send out.

>
>Thanks,
>Gavin

-- 
Richard Yang
Help you, Help me

