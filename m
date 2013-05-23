Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f172.google.com ([209.85.223.172]:54797 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758301Ab3EWVAZ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 23 May 2013 17:00:25 -0400
Received: by mail-ie0-f172.google.com with SMTP id 16so10009636iea.17
        for <linux-pci@vger.kernel.org>; Thu, 23 May 2013 14:00:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAErSpo5vY-DY9_bLWbM5UNrSZdO5dyASx1hLGMQg-ypgZHXLLg@mail.gmail.com>
References: <CAE9FiQX=h4H1gcbW=EfQo_ZtAgHGOZ2GxVxLG59C1iMH+qgH2g@mail.gmail.com>
	<1367732090.11982.38.camel@pasglop>
	<CAE9FiQUN3qqVmdw_EdOC-JZGc219M3tu=roOX98xns+77LJhMw@mail.gmail.com>
	<1367740336.11982.41.camel@pasglop>
	<51871088.4594420a.0ccc.7300SMTPIN_ADDED_BROKEN@mx.google.com>
	<CAE9FiQXGUOM_h_X5tdGbkiuZGZkiFigSLbbftx3YXybFBg6trg@mail.gmail.com>
	<518786a7.64bbec0a.58a0.1f6bSMTPIN_ADDED_BROKEN@mx.google.com>
	<CAErSpo5MJCoaof=heFM4vLxuWz8pFqsyXAC356jZ7rbRvSOt9g@mail.gmail.com>
	<CAE9FiQWsZXfkSSVFzee4-J4bUDP8DdG=y9-k2du+ek90StDvNA@mail.gmail.com>
	<CAE9FiQXw=Q9hDWMS3kx8=G0eSqo2keKh-VP3=LWZ31PfXmrAmg@mail.gmail.com>
	<519dcfbe.89e9420a.4934.488bSMTPIN_ADDED_BROKEN@mx.google.com>
	<CAE9FiQW==Zvwv976-xjtRFj70JWoZW94yQyM0NMTvMpR-yDG9Q@mail.gmail.com>
	<CAErSpo5ASyYvRJgA3TDt7A5xtxL0sqopfAxbnJwDL=z_2hDJag@mail.gmail.com>
	<CAE9FiQX8o97RY-Bd9t1vj+gm_Uri0v_hAUwecaNoF2GwGGTNyA@mail.gmail.com>
	<CAErSpo5vY-DY9_bLWbM5UNrSZdO5dyASx1hLGMQg-ypgZHXLLg@mail.gmail.com>
Date: Thu, 23 May 2013 14:00:24 -0700
Message-ID: <CAE9FiQWyEhdQGjC+hiGxOHdHwZoajfwfcgp26wivqL0s62NPkA@mail.gmail.com>
Subject: Re: Resource assignment oddities
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 23, 2013 at 12:47 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Thu, May 23, 2013 at 11:17 AM, Yinghai Lu <yinghai@kernel.org> wrote:
>> On Thu, May 23, 2013 at 10:12 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>>> On Thu, May 23, 2013 at 11:08 AM, Yinghai Lu <yinghai@kernel.org> wrote:
>>>>
>>>> Good, will resend this as complete form to Bjorn for v3.10.
>>>
>>> I haven't seen anything this actually fixes yet, except that maybe it
>>> removes some "can't assign" messages.  That doesn't sound like v3.10
>>> material.
>>
>> io port "can't assign" still there.
>
> The "can't assign io" message is harmless.  The host bridge doesn't
> support I/O port space, so we'll *never* be able to assign IO space.
> The best we can do for this part of the problem is to get rid of the
> message, and that's not urgent for v3.10.  Actually, I don't think we
> *should* get rid of the message; if we can't assign IO space to an IO
> BAR, I want to know about it.  Maybe the message should be clearer or
> less alarming, but it should be there.

Agreed, that are only harmless message.

>
>> the problem that it fixed: don't fallback wrongly for mmio when ioport
>> fails with must+optional.
>>
>> because if it fall back to mmio must-only, later extending to cover
>> optional will
>> not find extra space as mmio range and mmio-pref range in the bridge
>> is connected
>> together.
>
> I know that we retry when we don't need to.  If the retry results in
> MEM assignments that are *worse* than the original ones, that might be
> a problem we should fix.  But that problem should have nothing to do
> with I/O port space.  Conceptually, if we retry because IO assignment
> failed, the MEM assignments should not change.

Yes, that is what patch try to do. Keep the mmio allocation from first try, and
only retry with io port.

>
> I could probably grope through your logs and figure out whether this
> is happening, but it's your job to do that legwork and convince me
> that a change is necessary.

sure.

Yinghai
