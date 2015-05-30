Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f170.google.com ([209.85.213.170]:38608 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751225AbbE3FqZ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 30 May 2015 01:46:25 -0400
Received: by igbjd9 with SMTP id jd9so29317882igb.1
        for <linux-pci@vger.kernel.org>; Fri, 29 May 2015 22:46:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150529211613.GC12733@google.com>
References: <1432878000-10921-1-git-send-email-yinghai@kernel.org>
	<20150529211613.GC12733@google.com>
Date: Fri, 29 May 2015 22:46:24 -0700
Message-ID: <CAE9FiQUqo-fNhqd-Yg0pdq8TpEh9gEH2piVJjxfybKSi7mB5cQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: keep resource size during alignment reordering
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, May 29, 2015 at 2:16 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Thu, May 28, 2015 at 10:40:00PM -0700, Yinghai Lu wrote:
>> In d74b9027a4da ("PCI: Consider additional PF's IOV BAR alignment in sizing
>> and assigning"), it stores additional alignment in realloc_head and takes
>> this into consideration for assignment.
>> During update the resource before reordering, it does not calculate
>> resource end correctly.
>>
>> We need to keep the original resource size before updating start.
>> otherwise we will smaller size during updating end.
...
> I already merged this fix for the same commit:
>
> http://lkml.kernel.org/r/1432016657-16816-1-git-send-email-weiyang@linux.vnet.ibm.com
>
> Is this a separate fix for a different problem?  Is it a fix for the same
> problem, just implemented differently?

It is a separate fix for different problem.
We should keep the size while changing the alignement.

Thanks

Yinghai
