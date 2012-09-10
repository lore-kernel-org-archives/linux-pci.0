Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:56492 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752861Ab2IJWnL (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 10 Sep 2012 18:43:11 -0400
Received: by lagy9 with SMTP id y9so1489827lag.19
        for <linux-pci@vger.kernel.org>; Mon, 10 Sep 2012 15:43:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1347061864.2385.59.camel@pasglop>
References: <1346994035-16218-1-git-send-email-shangw@linux.vnet.ibm.com>
 <CAErSpo559Hr-fnZTDZGOfz9T6_GSHKhoKChgNbq-apLuLqbaYQ@mail.gmail.com> <1347061864.2385.59.camel@pasglop>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 10 Sep 2012 16:42:49 -0600
Message-ID: <CAErSpo41vr4f4YkLZc-QwHU8CTQv1FxzGF9h5-eu85NaTUhPaw@mail.gmail.com>
Subject: Re: [PATCH V9 0/5] Minimal alignment for p2p bars
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Sep 7, 2012 at 5:51 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Fri, 2012-09-07 at 15:49 -0700, Bjorn Helgaas wrote:
>>
>> http://git.kernel.org/?p=linux/kernel/git/helgaas/pci.git;a=shortlog;h=refs/heads/pci/gavin-window-alignment
>>
>> Assuming they pass Fengguang's build/smoke test, I'll merge that to my
>> "next" branch soon.  Thanks!
>
> Thanks !
>
> Any chance you can poke me when you do so ? At that point I'll include
> them as well along with the rest of the stuff that depends on them.

I merged these to my "next" branch and pushed it.  Are you sure you
want to pull that as opposed to just using the
pci/gavin-window-alignment branch?  Both "next" and
"pci/gavin-window-alignment" have identical commits, but
"pci/gavin-window-alignment" is less likely to be rebased.

Bjorn
