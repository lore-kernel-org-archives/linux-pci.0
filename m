Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e28smtp07.in.ibm.com ([122.248.162.7]:54943 "EHLO
	e28smtp07.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754802Ab3HFGTi (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 6 Aug 2013 02:19:38 -0400
Received: from /spool/local
	by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Tue, 6 Aug 2013 11:41:05 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
	by d28dlp03.in.ibm.com (Postfix) with ESMTP id 0465F1258053
	for <linux-pci@vger.kernel.org>; Tue,  6 Aug 2013 11:49:06 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
	by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id r766Kdgl36110490
	for <linux-pci@vger.kernel.org>; Tue, 6 Aug 2013 11:50:39 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
	by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id r766JSL4032646
	for <linux-pci@vger.kernel.org>; Tue, 6 Aug 2013 11:49:29 +0530
Date: Tue, 6 Aug 2013 14:19:24 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Ram Pai <linuxram@us.ibm.com>,
	Gavin Shan <shangw@linux.vnet.ibm.com>,
	Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH 4/4] PCI: fix the io resource alignment calculation in
 pbus_size_io()
Message-ID: <20130806061924.GB10876@weiyang.vnet.ibm.com>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <1375435866-16332-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1375435866-16332-5-git-send-email-weiyang@linux.vnet.ibm.com>
 <CAErSpo5Lv7-Op3hg_ZRgSjzMNYZpZGphQFJyxxP6B8xLpwrSkw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAErSpo5Lv7-Op3hg_ZRgSjzMNYZpZGphQFJyxxP6B8xLpwrSkw@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 05, 2013 at 11:58:50AM -0600, Bjorn Helgaas wrote:
>[+cc Yinghai]
>
>On Fri, Aug 2, 2013 at 3:31 AM, Wei Yang <weiyang@linux.vnet.ibm.com> wrote:
>> In commit 462d9303 ("PCI: Align P2P windows using pcibios_window_alignment()"),
>> it introduce a new method to calculate the window alignment of P2P bridge.
>>
>> When the io_window_1k is set,  the calculation for the io resource alignment
>> is different from the original one. In the original logic before 462d9303,
>> the alignment is no bigger than 4K even the io_window_1k is set. The logic
>> introduced in 462d9303 will limit the alignment to 1k in this case.
>>
>> This patch fix this issue.
>
>Presumably this fixes a bug, but you don't say what it is.  "different
>from the original" is not a description of a problem.  You need
>something like "with the current code, we allocate the wrong window
>size in situation X, or we allocate a window with incorrect alignment
>in situation Y, etc."
>

With current code, we allocate the wrong window size when upstream bridge
could be 1k aligned and one of the downstream port is 4k aligned.

In this case, the "min_align" should be 4k. But the current code set
"min_align" to 1k.

