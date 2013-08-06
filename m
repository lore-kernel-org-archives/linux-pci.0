Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp03.au.ibm.com ([202.81.31.145]:49201 "EHLO
	e23smtp03.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755840Ab3HFPru (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 6 Aug 2013 11:47:50 -0400
Received: from /spool/local
	by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Wed, 7 Aug 2013 01:37:12 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
	by d23dlp02.au.ibm.com (Postfix) with ESMTP id 0A1C02BB0057
	for <linux-pci@vger.kernel.org>; Wed,  7 Aug 2013 01:47:47 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id r76FlakY61014182
	for <linux-pci@vger.kernel.org>; Wed, 7 Aug 2013 01:47:36 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id r76Flj7Z018854
	for <linux-pci@vger.kernel.org>; Wed, 7 Aug 2013 01:47:46 +1000
Date: Tue, 6 Aug 2013 23:47:42 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Ram Pai <linuxram@us.ibm.com>,
	Gavin Shan <shangw@linux.vnet.ibm.com>,
	Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH 4/4] PCI: fix the io resource alignment calculation in
 pbus_size_io()
Message-ID: <20130806154742.GB10680@weiyang.vnet.ibm.com>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <1375435866-16332-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1375435866-16332-5-git-send-email-weiyang@linux.vnet.ibm.com>
 <CAErSpo5Lv7-Op3hg_ZRgSjzMNYZpZGphQFJyxxP6B8xLpwrSkw@mail.gmail.com>
 <20130806061924.GB10876@weiyang.vnet.ibm.com>
 <20130806134421.GD31970@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130806134421.GD31970@google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Aug 06, 2013 at 07:44:21AM -0600, Bjorn Helgaas wrote:
>On Tue, Aug 06, 2013 at 02:19:24PM +0800, Wei Yang wrote:
>> On Mon, Aug 05, 2013 at 11:58:50AM -0600, Bjorn Helgaas wrote:
>> >[+cc Yinghai]
>> >
>> >On Fri, Aug 2, 2013 at 3:31 AM, Wei Yang <weiyang@linux.vnet.ibm.com> wrote:
>> >> In commit 462d9303 ("PCI: Align P2P windows using pcibios_window_alignment()"),
>> >> it introduce a new method to calculate the window alignment of P2P bridge.
>> >>
>> >> When the io_window_1k is set,  the calculation for the io resource alignment
>> >> is different from the original one. In the original logic before 462d9303,
>> >> the alignment is no bigger than 4K even the io_window_1k is set. The logic
>> >> introduced in 462d9303 will limit the alignment to 1k in this case.
>> >>
>> >> This patch fix this issue.
>> >
>> >Presumably this fixes a bug, but you don't say what it is.  "different
>> >from the original" is not a description of a problem.  You need
>> >something like "with the current code, we allocate the wrong window
>> >size in situation X, or we allocate a window with incorrect alignment
>> >in situation Y, etc."
>> >
>> 
>> With current code, we allocate the wrong window size when upstream bridge
>> could be 1k aligned and one of the downstream port is 4k aligned.
>> 
>> In this case, the "min_align" should be 4k. But the current code set
>> "min_align" to 1k.
>

Hmm... sorry I should say. 

With current code, we allocate the wrong window size and alignment when upstream 
bridge could be 1k aligned and one of the downstream port is 4k aligned.

In this case, the "min_align" should be 4k. But the current code set
"min_align" to 1k.

>I would expect that we allocate a window with incorrect *alignment*,
>not incorrect size.  If you include a dmesg log and lspci output and point
>out the problem, that will avoid a lot of confusion.

Agree. 

I notice this potential problem during the code reading and found
the io_window_1k is set only for Intel P64H2 bridge. Currently I don't have
this device, not sure how to create this senario.

Sorry for the confusion, I should state the problem more clearly.

>
>Bjorn

-- 
Richard Yang
Help you, Help me

