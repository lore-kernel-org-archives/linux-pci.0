Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qa0-f50.google.com ([209.85.216.50]:37774 "EHLO
	mail-qa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754941AbaIDVFX (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 4 Sep 2014 17:05:23 -0400
Received: by mail-qa0-f50.google.com with SMTP id cm18so10254616qab.9
        for <linux-pci@vger.kernel.org>; Thu, 04 Sep 2014 14:05:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5405D9C8.1000308@ti.com>
References: <20140819044050.GA15551@google.com> <53F368F7.1070707@ti.com>
 <CAErSpo6GfCE8yT2Dda1JJsoPQhFD_b0GhB=OZ6w854ZB_B6eqA@mail.gmail.com> <5405D9C8.1000308@ti.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 4 Sep 2014 15:05:02 -0600
Message-ID: <CAErSpo5xi6evzeLB4H=+6SHjh=bp+7ZWDO8DP_sMLbE0xQePmQ@mail.gmail.com>
Subject: Re: [GIT PULL] PCI changes for v3.17 (part 3)
To: Murali Karicheri <m-karicheri2@ti.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Sep 2, 2014 at 8:52 AM, Murali Karicheri <m-karicheri2@ti.com> wrote:
> On 08/19/2014 12:30 PM, Bjorn Helgaas wrote:
>>
>> On Tue, Aug 19, 2014 at 10:10 AM, Murali Karicheri<m-karicheri2@ti.com>
>> wrote:
>>>
>>> Hi Bjorn,
>>>
>>> I see you have pulled in my designware related patches for Keystone PCI
>>> in
>>> this request. When do you think you can pull in Keystone PCI driver (v8)
>>> on
>>> the list?
>>
>>
>> The things in this pull request have been in linux-next for a month.
>> I'm ready to apply the Keystone driver, but since we're after the
>> merge window and the Keystone driver hasn't been in -next at all, I
>> plan to put it in v3.18.
>>
> BJorn,
>
> Do you have a v3.18 next branch that you can add this patch to? I need to
> send out additional patches on top of this to support PCIe and SATA on
> another K2 platform, K2E and will be good if I can base it on a merged
> branch. Also I am afraid, we will have nasty merge issues to deal with if
> others start making changes in parallel and conflict with this patch series.

Yes.  I put it on a pci/host-keystone branch for v3.18.

Bjorn
