Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qg0-f46.google.com ([209.85.192.46]:37064 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752667AbaGKSke (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 11 Jul 2014 14:40:34 -0400
Received: by mail-qg0-f46.google.com with SMTP id q107so1278479qgd.5
        for <linux-pci@vger.kernel.org>; Fri, 11 Jul 2014 11:40:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CA+55aFwyfaAa3opKsDth7b4RXb7E2_Thb581VWvg9V-GvJCYbg@mail.gmail.com>
References: <20140611060118.GB3169@yanx> <CAE9FiQWe2bf7QbKn9kmZS34a4cMewsdD-9qAELdXs-dEtx70GQ@mail.gmail.com>
 <20140702210736.GB28852@google.com> <CAE9FiQU5Ltu89zmRG0h2aXfXH0oCcTEP=jF7b=zHi=SaOA2rKg@mail.gmail.com>
 <20140703131526.GG28852@google.com> <CAE9FiQWPGXMBYmpzyk8cicKZ1ELUZiARkZjr2vvgntmt3bt1jQ@mail.gmail.com>
 <20140703221152.GH28852@google.com> <CAE9FiQX69x_YgHihYM-+tahTvbuk6MATBXvm9Rz5kiQ9UpKNPg@mail.gmail.com>
 <CAErSpo4DzJ112NxfjXT=NbXMxNqre_Vo61fS0Mem=MWCz+OvcA@mail.gmail.com>
 <CAE9FiQWUPd4d9DWeiuDqQ=tKKe+5ZofUEw3JViXYs6+9zBG6Sg@mail.gmail.com> <CA+55aFwyfaAa3opKsDth7b4RXb7E2_Thb581VWvg9V-GvJCYbg@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 11 Jul 2014 12:40:14 -0600
Message-ID: <CAErSpo4GvYgP5zRq0vzFrCGzrYBF9u=KWus8PPNGKpyJVZzYkA@mail.gmail.com>
Subject: Re: [PATCH] pci: Allow very large resource windows
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Yinghai Lu <yinghai@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Guo Chao <yan@linux.vnet.ibm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jul 11, 2014 at 12:21 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Fri, Jul 11, 2014 at 11:09 AM, Yinghai Lu <yinghai@kernel.org> wrote:
>>
>> If the BAR have all 0, cpu can not access it as hw will forward access to ram
>> controller according to routing table.
>
> On PC's, yes (also likely with many devices - there are definitely
> devices out there were setting the BAR to zero disables it).

Ooh, we might trip over this some day on a platform with host bridge
address translation that maps to PCI bus address 0.  I don't think we
have anything in the allocator that avoids bus address 0 in that case.

Bjorn
