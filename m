Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:17855 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751961Ab3IYWRK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 25 Sep 2013 18:17:10 -0400
Message-ID: <524360E5.5060708@linux.intel.com>
Date: Wed, 25 Sep 2013 15:17:09 -0700
From: Arjan van de Ven <arjan@linux.intel.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Todd E Brandt <todd.e.brandt@linux.intel.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] Intel pci device quirk remove D3 delay
References: <20130910231043.GA31857@linux.intel.com> <20130924231953.GC9302@google.com> <CAErSpo4C52O0iUxU8s8L2Ei=eedanLxn0u_aFtCnnvLu0yjAtA@mail.gmail.com>
In-Reply-To: <CAErSpo4C52O0iUxU8s8L2Ei=eedanLxn0u_aFtCnnvLu0yjAtA@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 9/25/2013 2:48 PM, Bjorn Helgaas wrote:
> On Tue, Sep 24, 2013 at 5:19 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>> On Tue, Sep 10, 2013 at 04:10:43PM -0700, Todd E Brandt wrote:
>>> The latest Ivy Bridge Intel chipsets have a hardware optimization which
>>
>> You said "Ivy Bridge" above but use "Haswell" below.  Let me know if
>> anything needs to be corrected here.
>
> Reading this again, the text really doesn't make sense as-is.  So
> please confirm what this should say.
>
> It sure looks like it should say "The latest *Haswell* Intel chipsets ..."
>
> If you really mean "Ivy Bridge," then you should say something about
> how Haswell is related to Ivy Bridge.  No doubt this is all obvious to
> Intel folks, but it's not to me :)

it should read "Haswell".

