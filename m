Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f182.google.com ([209.85.214.182]:56162 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751188Ab3IYXBe (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 25 Sep 2013 19:01:34 -0400
Received: by mail-ob0-f182.google.com with SMTP id wo20so799486obc.13
        for <linux-pci@vger.kernel.org>; Wed, 25 Sep 2013 16:01:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <524360E5.5060708@linux.intel.com>
References: <20130910231043.GA31857@linux.intel.com> <20130924231953.GC9302@google.com>
 <CAErSpo4C52O0iUxU8s8L2Ei=eedanLxn0u_aFtCnnvLu0yjAtA@mail.gmail.com> <524360E5.5060708@linux.intel.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 25 Sep 2013 17:01:13 -0600
Message-ID: <CAErSpo7dKiN3HoqbLZBN--NB2WpGLE1K_1kEa2e4zqZS5tfz-g@mail.gmail.com>
Subject: Re: [PATCH] Intel pci device quirk remove D3 delay
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: Todd E Brandt <todd.e.brandt@linux.intel.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Sep 25, 2013 at 4:17 PM, Arjan van de Ven <arjan@linux.intel.com> wrote:
> On 9/25/2013 2:48 PM, Bjorn Helgaas wrote:
>>
>> On Tue, Sep 24, 2013 at 5:19 PM, Bjorn Helgaas <bhelgaas@google.com>
>> wrote:
>>>
>>> On Tue, Sep 10, 2013 at 04:10:43PM -0700, Todd E Brandt wrote:
>>>>
>>>> The latest Ivy Bridge Intel chipsets have a hardware optimization which
>>>
>>>
>>> You said "Ivy Bridge" above but use "Haswell" below.  Let me know if
>>> anything needs to be corrected here.
>>
>>
>> Reading this again, the text really doesn't make sense as-is.  So
>> please confirm what this should say.
>>
>> It sure looks like it should say "The latest *Haswell* Intel chipsets ..."
>>
>> If you really mean "Ivy Bridge," then you should say something about
>> how Haswell is related to Ivy Bridge.  No doubt this is all obvious to
>> Intel folks, but it's not to me :)
>
>
> it should read "Haswell".

Fixed, thanks!

Bjorn
