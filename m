Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qg0-f41.google.com ([209.85.192.41]:34512 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751741AbbDBWN6 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 2 Apr 2015 18:13:58 -0400
Received: by qgep97 with SMTP id p97so81381305qge.1
        for <linux-pci@vger.kernel.org>; Thu, 02 Apr 2015 15:13:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAE9FiQV8=tGiPJ0qEJvMBAzk-i2aubmQhkNoa-Gei9y7SXiubw@mail.gmail.com>
References: <1427857069-6789-1-git-send-email-yinghai@kernel.org>
 <20150402.163715.643586069492103151.davem@davemloft.net> <CAE9FiQV8=tGiPJ0qEJvMBAzk-i2aubmQhkNoa-Gei9y7SXiubw@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 2 Apr 2015 17:13:37 -0500
Message-ID: <CAErSpo4uLHddoWUFW4RVrPGkw+2gJgsNaCkz85vUYFsORbOgJw@mail.gmail.com>
Subject: Re: [PATCH 0/3] PCI/sparc: Fix booting with T5-8
To: Yinghai Lu <yinghai@kernel.org>
Cc: David Miller <davem@davemloft.net>,
	David Ahern <david.ahern@oracle.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Apr 2, 2015 at 5:07 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> On Thu, Apr 2, 2015 at 1:37 PM, David Miller <davem@davemloft.net> wrote:
>> From: Yinghai Lu <yinghai@kernel.org>
>> Date: Tue, 31 Mar 2015 19:57:46 -0700
>>
>>> Fix regression by commit d63e2e1f3df9 ("sparc/PCI: Clip bridge windows to
>>> fit in upstream windows").
>>>
>>> That cause bridge bar get clipped wrongly.
>>>
>>> The sparc64 dma_addr_t is 32-bit, we can not use it to check if we can
>>> use 64bit bar, introduce pci_bus_addr_t.
>>>
>>> sparc ofpci does not parse 64bit mem for root bus, add code to
>>> make sure that we get correct resource for root.
>>>
>>> Also there are device 64-bit res does not have pref bit flag, but bridges
>>> do have pref bit set, that cause extra "no compatible window".
>>> Set pref bit for them according to the errata.
>>
>> Just to be clear, who is going to merge this? :-)
>>
>
> Should be you or Bjorn, but one should get ack from another.

I'm just getting back from vacation and would like to have a chance to
look over this.

One first reaction is that if we add a pci_bus_addr_t,
Documentation/DMA-API-HOWTO.txt needs to be updated.  It currently
says a dma_addr_t "can hold any valid DMA or bus address."

Bjorn
