Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:37036 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756523Ab2CACyf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 29 Feb 2012 21:54:35 -0500
MIME-Version: 1.0
In-Reply-To: <CAErSpo5N72zkfvvgSNg0MsKAZwcR5TOsxH+Y7BkVbOBYWbdaKQ@mail.gmail.com>
References: <1330556858-11768-1-git-send-email-yinghai@kernel.org>
	<1330556858-11768-3-git-send-email-yinghai@kernel.org>
	<CAErSpo62VuJw+3caNUhmg5moh3h4cn5z4kCsqTWZW-XqSzpk4Q@mail.gmail.com>
	<CAE9FiQW=NXnaEY+fmUS_cyJy_BE-1+pWy8kfAoPA_s=vwDq4Mw@mail.gmail.com>
	<CAErSpo5N72zkfvvgSNg0MsKAZwcR5TOsxH+Y7BkVbOBYWbdaKQ@mail.gmail.com>
Date: Wed, 29 Feb 2012 18:54:34 -0800
Message-ID: <CAE9FiQVfm0B-7gZXLoUjAU=pmyz2E=XNHvi6vi_Q0q9rN24UKw@mail.gmail.com>
Subject: Re: [PATCH 02/39] x86, PCI: have own version for pcibios_bus_to_resource
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Tony Luck <tony.luck@intel.com>,
	David Miller <davem@davemloft.net>, x86 <x86@kernel.org>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Feb 29, 2012 at 4:42 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Wed, Feb 29, 2012 at 4:33 PM, Yinghai Lu <yinghai@kernel.org> wrote:
>> On Wed, Feb 29, 2012 at 3:20 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>>> On Wed, Feb 29, 2012 at 4:07 PM, Yinghai Lu <yinghai@kernel.org> wrote:
>>>> x86 does not need to offset the address. So we can skip that costing offset
>>>> searching.
>>>
>>> I tried to start a discussion about this patch (and others), but I
>>> don't think you responded:
>>> http://marc.info/?l=linux-pci&m=133036414506921&w=2
>>
>> this patch does reduce some not needed ops.
>>
>> and it does not affects your effects,
>
> It does affect my efforts in that this patch adds back x86 complexity
> that I don't think is necessary.
>
> And this patch makes it so the pci_add_resource_offset() interface
> exists and appears to work on x86, but if somebody tries to use it, it
> *doesn't* work.  I don't like to write code like that.  I think it's
> poor style.
>
>> and it just make x86 not get punished.
>
> What punishment are you worried about?  I really don't think you'll be
> able to measure any performance impact.
>
> I agree that the x86 code you add *is* simpler than the generic
> version.  But I think the *overall* complexity is higher because now
> you have to look at two versions (generic and x86) and convince
> yourself that it's safe to use the x86 version.
>

fine, i will that patch.

Yinghai
