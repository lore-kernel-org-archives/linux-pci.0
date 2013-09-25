Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f172.google.com ([209.85.223.172]:37731 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751070Ab3IYVtL (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 25 Sep 2013 17:49:11 -0400
Received: by mail-ie0-f172.google.com with SMTP id x13so344968ief.17
        for <linux-pci@vger.kernel.org>; Wed, 25 Sep 2013 14:49:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20130924231953.GC9302@google.com>
References: <20130910231043.GA31857@linux.intel.com> <20130924231953.GC9302@google.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 25 Sep 2013 15:48:50 -0600
Message-ID: <CAErSpo4C52O0iUxU8s8L2Ei=eedanLxn0u_aFtCnnvLu0yjAtA@mail.gmail.com>
Subject: Re: [PATCH] Intel pci device quirk remove D3 delay
To: Todd E Brandt <todd.e.brandt@linux.intel.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	arjan@linux.intel.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Sep 24, 2013 at 5:19 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Tue, Sep 10, 2013 at 04:10:43PM -0700, Todd E Brandt wrote:
>> The latest Ivy Bridge Intel chipsets have a hardware optimization which
>
> You said "Ivy Bridge" above but use "Haswell" below.  Let me know if
> anything needs to be corrected here.

Reading this again, the text really doesn't make sense as-is.  So
please confirm what this should say.

It sure looks like it should say "The latest *Haswell* Intel chipsets ..."

If you really mean "Ivy Bridge," then you should say something about
how Haswell is related to Ivy Bridge.  No doubt this is all obvious to
Intel folks, but it's not to me :)

Bjorn

>> allows on-chip PCI devices to ignore the 10ms delay before entering
>> or exitting D3 suspend.
>>
>> This patch implements the optimization as a pci quirk, since we want
>> tight control over which devices use it. This way we can test each device
>> individually to be sure there are no issues before we enable the quirk.
>> The first set of devices are from the Haswell platform, which includes
>> every PCI device that is on the northbridge and southbridge.
>>
>> After testing this patch reduces the haswell suspend time from 93 ms to
>> 47 ms and resume time from 160 ms to 64 ms.
