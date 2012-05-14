Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp04.au.ibm.com ([202.81.31.146]:53275 "EHLO
	e23smtp04.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753730Ab2ENBzq (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 13 May 2012 21:55:46 -0400
Received: from /spool/local
	by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Mon, 14 May 2012 01:36:21 +1000
Date: Mon, 14 May 2012 09:55:36 +0800
From: Richard Yang <weiyang@linux.vnet.ibm.com>
To: yinghai@kernel.org
Cc: Richard Yang <weiyang@linux.vnet.ibm.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: One problem in reassign pci bus number?
Message-ID: <20120514015536.GA3331@richard>
Reply-To: Richard Yang <weiyang@linux.vnet.ibm.com>
References: <20120410090306.GA7056@richard>
 <20120422155202.GA13540@richard>
 <4F95B17B.3030401@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4F95B17B.3030401@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Apr 23, 2012 at 03:46:03PM -0400, Don Dutile wrote:
>On 04/22/2012 11:52 AM, Richard Yang wrote:
>>All,
>>
>>I am reading the pci_scan_bridge() and not sure what will happen in
>>following situation.
>>
>>Suppose the kernel is not passed the pci=assign-busses.
>>
>>Below is a picture about the pci system.
>>
>>                    +-------+
>>                    |       | root bridge(0,255)
>>                    +---+---+
>>                        |          Bus 0
>>       -----+-----------+------------------------------+--
>>            |                                          |
>>            |                                          |
>>            |                                          |
>>       +----+----+                               +-----+-----+
>>       |         |  B1(1,15)                     |           |B2(16,28)
>>       +----+----+                               +-----+-----+
>>            |  Bus 1                                   |    Bus 16
>>       -----+-----------------------         ----------+----------------
>>                             |
>>                        +----+----+
>>                        |         | B3
>>                        +---------+
>>
>>Suppose B1 and B2 works fine with the BIOS, which get the right bus
>>number and range.
>>
>>B3 does not works fine with the BIOS, which doesn't get the bus number.
>>
>>So in pci_scan_bridge(), B3 will be met in the second pass and get bus
>>number 16?
>
Yinghai,

Take my original question. 

B3 doesn't get the bus number, which its parent doesn't have free bus
number and there is no gap between B1 and B2. 

So in this case, the probe_resource() can't find bus number for B3. 
Then cause pci_bridge_probe_busn_res() return non-zero. 

Then B3 couldn't work fine?

-- 
Richard Yang
Help you, Help me

