Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:50310 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753172AbaIKINF (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 11 Sep 2014 04:13:05 -0400
Message-ID: <54115995.5020107@canonical.com>
Date: Thu, 11 Sep 2014 10:13:09 +0200
From: David Henningsson <david.henningsson@canonical.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Andreas Noever <andreas.noever@gmail.com>
Subject: Re: [PATCH] Add pci=assign-busses quirk to Dell Latitude D505
References: <1409303414-5196-1-git-send-email-david.henningsson@canonical.com> <CAErSpo5v82xeYGqsiWXpfQdr8kF9x+1K4gjYremfCh3fNQ8Unw@mail.gmail.com> <540091D1.1040902@canonical.com> <CAErSpo6D+8KwM9LJC4VFCtGbQ65zh_2ZjNOuP-JQB1bmt5dwCw@mail.gmail.com> <CAErSpo6DDCkrew8rwkNX8=gzc19vErY5iafPBN4oKw_Ww792=g@mail.gmail.com>
In-Reply-To: <CAErSpo6DDCkrew8rwkNX8=gzc19vErY5iafPBN4oKw_Ww792=g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 2014-09-10 20:08, Bjorn Helgaas wrote:
> [+cc Andreas]
> v3.16 fails with:
>
>    pci 0000:01:01.0: can't allocate child bus 01 from [bus 01]
>
> which Andreas added with fc1b253141b3 ("PCI: Don't scan random busses
> in pci_scan_bridge()").  But I don't understand that code well enough
> to know whether this commit is actually the cause of the problem.
>
> And I also haven't figured out how "pci=assign-busses" makes a difference.
>
> David, would you mind turning on CONFIG_DYNAMIC_DEBUG=y in your v3.16
> kernel, adding  'dyndbg="file probe.c +p"' to your boot arguments, and
> collecting another dmesg log?

Thanks for looking at this (and sorry for not having done a bisect yet).

Anyhow, a new dmesg log has now been posted at kernel bugzilla #83441. 
It has a few more lines starting with "pci_bus" but nothing that really 
stands out AFAICT.


-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
