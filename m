Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp09.au.ibm.com ([202.81.31.142]:51118 "EHLO
	e23smtp09.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755113Ab3HFPeR (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 6 Aug 2013 11:34:17 -0400
Received: from /spool/local
	by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Wed, 7 Aug 2013 12:29:05 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
	by d23dlp02.au.ibm.com (Postfix) with ESMTP id 5A35F2BB0052
	for <linux-pci@vger.kernel.org>; Wed,  7 Aug 2013 01:34:13 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id r76FY28c66126042
	for <linux-pci@vger.kernel.org>; Wed, 7 Aug 2013 01:34:02 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id r76FYCRH006644
	for <linux-pci@vger.kernel.org>; Wed, 7 Aug 2013 01:34:13 +1000
Date: Tue, 6 Aug 2013 23:34:10 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Yinghai Lu <yinghai@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Ram Pai <linuxram@us.ibm.com>,
	Gavin Shan <shangw@linux.vnet.ibm.com>
Subject: Re: [PATCH 4/4] PCI: fix the io resource alignment calculation in
 pbus_size_io()
Message-ID: <20130806153410.GA10680@weiyang.vnet.ibm.com>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <1375435866-16332-5-git-send-email-weiyang@linux.vnet.ibm.com>
 <CAErSpo5Lv7-Op3hg_ZRgSjzMNYZpZGphQFJyxxP6B8xLpwrSkw@mail.gmail.com>
 <CAE9FiQU3DSZGFSENxy84bQ_URurWUAh2secoq5KN7c3BVXb9OQ@mail.gmail.com>
 <20130805195149.GA19127@google.com>
 <CAE9FiQXjL+=9XqUiFCmJNkU8vedbjs82cvxjGGBZnzaWN0HgTg@mail.gmail.com>
 <CAErSpo4ANAE3ggEcaJhFvGEpP48y37CxnXedn6cFt1gscPR-gw@mail.gmail.com>
 <CAE9FiQVJZWFBvOJPna_CFo=Pt2hGXmx39Q278f+0BOwV_38oRQ@mail.gmail.com>
 <20130805222135.GA29875@google.com>
 <20130806061534.GA10876@weiyang.vnet.ibm.com>
 <20130806133929.GB31970@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130806133929.GB31970@google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Aug 06, 2013 at 07:39:29AM -0600, Bjorn Helgaas wrote:
>> Personal Conclusion
>> ============================================================================
>> I think Bjorn's patch works.
>> Will test on powernv platform and give the result.
>
>Great, let me know what happens.

In both case, with/with out your patch, the assignment result is the same.
Below is the /proc/ioports file.

00010000-0080ffff : /io-hub@3efe00000000/pciex@3efe00080000
  00010000-00010fff : Legacy IO
  00020000-0003ffff : PCI Bus 0000:01
    00020000-0003ffff : PCI Bus 0000:02
      00020000-0002ffff : PCI Bus 0000:40
      00030000-0003ffff : PCI Bus 0000:a0
00820000-0101ffff : /io-hub@3efe00000000/pciex@3efe00090000
  00820000-00820fff : Legacy IO
  00830000-0083ffff : PCI Bus 0001:01
01030000-0182ffff : /io-hub@3efe00000000/pciex@3efe000a0000
  01030000-01030fff : Legacy IO
  01040000-0104ffff : PCI Bus 0002:01
01840000-0203ffff : /io-hub@3efe00000000/pciex@3efe000b0000
  01840000-01840fff : Legacy IO
  01850000-0185ffff : PCI Bus 0003:01
02050000-0284ffff : /io-hub@3efe00000000/pciex@3efe000c0000
  02050000-02050fff : Legacy IO
  02060000-0206ffff : PCI Bus 0004:01
02860000-0305ffff : /io-hub@3efe00000000/pciex@3efe000d0000
  02860000-02860fff : Legacy IO
  02870000-0287ffff : PCI Bus 0005:01

The arch_align is 0x10000. When sizing for Bus 0000:01, its child has a I/O
bridge window with size 0x20000/alignment 0x10000. And the result
[0x20000,0x3ffff] looks like size 0x20000/alignment 0x20000 or size
0x20000/alignment 0x10000. 

But I still think the alignment is 0x10000.

>
>Bjorn
>--
>To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Richard Yang
Help you, Help me

