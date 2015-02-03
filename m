Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:40200 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965989AbbBCP3r (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 3 Feb 2015 10:29:47 -0500
Received: by mail-qa0-f46.google.com with SMTP id j7so34263233qaq.5
        for <linux-pci@vger.kernel.org>; Tue, 03 Feb 2015 07:29:47 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1422923108.4625.2.camel@ellerman.id.au>
References: <1422712065-9403-1-git-send-email-haokexin@gmail.com>
 <1422712065-9403-2-git-send-email-haokexin@gmail.com> <1422844101.11325.4.camel@ellerman.id.au>
 <CAErSpo7B3yDQiD0XA9nBxb4tFW0BktT0EZ3HCZENOYQqMy0m_Q@mail.gmail.com> <1422923108.4625.2.camel@ellerman.id.au>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 3 Feb 2015 09:29:25 -0600
Message-ID: <CAErSpo4Q8Oj3Yk6mFfZGmEfLGFdum9LJRumhT5yE4x0ctC3mGw@mail.gmail.com>
Subject: Re: [PATCH 01/15] PCI: introduce pci_device_to_OF_node() for !CONFIG_OF
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Kevin Hao <haokexin@gmail.com>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Feb 2, 2015 at 6:25 PM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> On Mon, 2015-02-02 at 09:47 -0600, Bjorn Helgaas wrote:
>> On Sun, Feb 1, 2015 at 8:28 PM, Michael Ellerman <mpe@ellerman.id.au> wrote:
>> > On Sat, 2015-01-31 at 21:47 +0800, Kevin Hao wrote:
>> >> So we can avoid the ugly #ifdef in some drivers.
>> >>
>> >> Signed-off-by: Kevin Hao <haokexin@gmail.com>
>> >> ---
>> >>  include/linux/pci.h | 2 ++
>> >>  1 file changed, 2 insertions(+)
>> >
>> >
>> > Hi Bjorn,
>> >
>> > Do you mind putting this into your next for 3.20? Or giving us an ACK for it if
>> > you prefer.
>>
>> I think it makes more sense to merge this along with the other 14
>> patches that remove the #ifdefs (at least, I assume that's what they
>> do; I haven't seen them).
>
> Yeah that is what they do.
>
> The problem with doing it that way is the rest of the patches are splattered
> all across the tree, so getting them merged as a series will require a lot of
> searching for acks.
>
> If you merged this one for 3.20 we could then merge the rest of the series one
> at a time as the respective maintainers get around to it during the 3.21 cycle.
>
> I probably should have said all that in my original mail :)
>
> Anyway it's not a big deal, but that's why it'd be nice if you could take it.

OK, sure, I didn't get the hint that it would be preferable for me to
take it.  I'll merge it for v3.20.

Bjorn
