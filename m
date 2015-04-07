Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qk0-f179.google.com ([209.85.220.179]:34091 "EHLO
	mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752661AbbDGMSq (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 7 Apr 2015 08:18:46 -0400
Received: by qkgx75 with SMTP id x75so49416246qkg.1
        for <linux-pci@vger.kernel.org>; Tue, 07 Apr 2015 05:18:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAE9FiQVguGRDbYxRW=KNW6ZnUE23ifHJN4WXrf03JZB_P+d21w@mail.gmail.com>
References: <1427857069-6789-1-git-send-email-yinghai@kernel.org>
 <1427857069-6789-4-git-send-email-yinghai@kernel.org> <20150406220638.GH10892@google.com>
 <CAE9FiQWz_VYOmrN+L3nAAmA7OqZdAYawwku2A09RVrNObQn4jQ@mail.gmail.com>
 <20150406224913.GI10892@google.com> <CAE9FiQWGqjyp9YABc=BvzFSm7Tj7reojOoMPDybQZ1RYXD8XZQ@mail.gmail.com>
 <CAErSpo6au3nWwNJCQBOLV=9=5Jy5=MKnky4LLjThKf8J7MJfdg@mail.gmail.com> <CAE9FiQVguGRDbYxRW=KNW6ZnUE23ifHJN4WXrf03JZB_P+d21w@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 7 Apr 2015 07:18:25 -0500
Message-ID: <CAErSpo5tve=YV+iYAXQUu6qkb7WWt40Bpb3R6tF=Hj5AzY+-_g@mail.gmail.com>
Subject: Re: [PATCH 3/3] PCI: Set pref for mem64 resource of pcie device
To: Yinghai Lu <yinghai@kernel.org>
Cc: David Miller <davem@davemloft.net>,
	David Ahern <david.ahern@oracle.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Apr 7, 2015 at 12:23 AM, Yinghai Lu <yinghai@kernel.org> wrote:
> On Mon, Apr 6, 2015 at 8:43 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>> On Mon, Apr 6, 2015 at 8:13 PM, Yinghai Lu <yinghai@kernel.org> wrote:
>>> On Mon, Apr 6, 2015 at 3:49 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>>>>
>>>> For "[PATCH 1/3] PCI: Introduce pci_bus_addr_t", I'm waiting for an updated
>>>> version with Kconfig tweaks so we don't break other arches.
>>>
>>> I was thinking that you will update it manually.
>>
>> I asked you for an updated version, incorporating the documentation
>> updates, to make sure I got everything you intended.  But I did go
>> ahead and do it manually for you.
>
> Good.
>
> http://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/commit/?h=for-linus&id=f70899ff889a38f9697d3c153aaacaed25f501c3
>
> Please consider to split that into two patches.
> First one include changes in : include/linux/types.h and
> Documentation/DMA-API-HOWTO.txt.
> and you should be author for that.

If you want something different, send patches.  I don't have time to
try to figure out your intent and do the work for you.  That's why I
asked you for an updated series in the first place.

Bjorn
