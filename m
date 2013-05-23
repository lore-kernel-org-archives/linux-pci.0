Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f178.google.com ([209.85.223.178]:58471 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757984Ab3EWRR3 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 23 May 2013 13:17:29 -0400
Received: by mail-ie0-f178.google.com with SMTP id f4so2088659iea.37
        for <linux-pci@vger.kernel.org>; Thu, 23 May 2013 10:17:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAErSpo5ASyYvRJgA3TDt7A5xtxL0sqopfAxbnJwDL=z_2hDJag@mail.gmail.com>
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
Date: Thu, 23 May 2013 10:17:28 -0700
Message-ID: <CAE9FiQX8o97RY-Bd9t1vj+gm_Uri0v_hAUwecaNoF2GwGGTNyA@mail.gmail.com>
Subject: Re: Resource assignment oddities
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 23, 2013 at 10:12 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Thu, May 23, 2013 at 11:08 AM, Yinghai Lu <yinghai@kernel.org> wrote:
>>
>> Good, will resend this as complete form to Bjorn for v3.10.
>
> I haven't seen anything this actually fixes yet, except that maybe it
> removes some "can't assign" messages.  That doesn't sound like v3.10
> material.

io port "can't assign" still there.

the problem that it fixed: don't fallback wrongly for mmio when ioport
fails with must+optional.

because if it fall back to mmio must-only, later extending to cover
optional will
not find extra space as mmio range and mmio-pref range in the bridge
is connected
together.

Yinghai
