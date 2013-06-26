Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:65118 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752559Ab3FZTrm (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 26 Jun 2013 15:47:42 -0400
Received: by mail-ie0-f169.google.com with SMTP id 10so32143732ied.14
        for <linux-pci@vger.kernel.org>; Wed, 26 Jun 2013 12:47:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAErSpo4FNEVTkArbWKQnDxhMpR+sMEdQHjV=iYQZbD9j7e-pkw@mail.gmail.com>
References: <20130626025001.GA25384@google.com>
	<CAE9FiQXmP54PLSOYq17hi54ziDRM0fe+i0sRymz4+yeAxhT3-w@mail.gmail.com>
	<CAErSpo7MELuvuR9stzrLydn78wxsKwMPE1+sCDVbFextd06j7Q@mail.gmail.com>
	<CAE9FiQUWB5vFJ+m+UhQAc=q_BeH9U--o7r6_6Deq-KV1ycBC2w@mail.gmail.com>
	<CAErSpo4FNEVTkArbWKQnDxhMpR+sMEdQHjV=iYQZbD9j7e-pkw@mail.gmail.com>
Date: Wed, 26 Jun 2013 12:47:41 -0700
Message-ID: <CAE9FiQXHGt06bmb1QcJsW9g18Cn=wbQpbCZZkqmcTUUcpgtN-w@mail.gmail.com>
Subject: Re: Current open PCI defects
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jun 26, 2013 at 12:34 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Wed, Jun 26, 2013 at 10:43 AM, Yinghai Lu <yinghai@kernel.org> wrote:
>> On Wed, Jun 26, 2013 at 9:36 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>>> On Tue, Jun 25, 2013 at 11:51 PM, Yinghai Lu <yinghai@kernel.org> wrote:
>>>> On Tue, Jun 25, 2013 at 7:50 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>>>>> Here's a list of the current PCI defects open in https://bugzilla.kernel.org
>>>>>
>>>>> Hint: maintainers really like it when people take the initiative to
>>>>> resolve open issues.
>>>>>
>>>>> Regressions (8 total):
>>>>
>>>>>   57961 ExpressCard hot-remove and hot-add not recognized by acpiphp
>>>>
>>>> for 3.9 stable:
>>>> https://patchwork.kernel.org/patch/2676821/
>>>>
>>>> Greg, can you pick that for 3.9.8?
>>>
>>> That patch is already in Linus' tree and is marked correctly (AFAICS)
>>> for 3.9 stable:
>>
>> Yes, but the one can not be applied to v3.9 cleanly.
>> so at same time you have backporting for 3.9.
>>
>> Greg applied that for 3.9.5 but it has compile error, as v3.9 acpiphp is still
>> able to be complied as module.
>>
>> Per your request, I respin that patch
>>   https://patchwork.kernel.org/patch/2676821/
>> that will call request_module("acpiphp") at first.
>
> Oh, right, I forgot that.  Then I'll just let you take care of sending
> that to Greg in the correct format.

I sent that before.

https://patchwork.kernel.org/patch/2676821/
