Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:52175 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756806Ab3EVVAB (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 22 May 2013 17:00:01 -0400
Received: by mail-ie0-f174.google.com with SMTP id 10so6407593ied.33
        for <linux-pci@vger.kernel.org>; Wed, 22 May 2013 14:00:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1369255424.3870.18.camel@pasglop>
References: <1367712653.11982.19.camel@pasglop>
	<1367712932.11982.20.camel@pasglop>
	<CAE9FiQX=h4H1gcbW=EfQo_ZtAgHGOZ2GxVxLG59C1iMH+qgH2g@mail.gmail.com>
	<1367732090.11982.38.camel@pasglop>
	<CAE9FiQUN3qqVmdw_EdOC-JZGc219M3tu=roOX98xns+77LJhMw@mail.gmail.com>
	<1367740336.11982.41.camel@pasglop>
	<51871088.4594420a.0ccc.7300SMTPIN_ADDED_BROKEN@mx.google.com>
	<CAE9FiQXGUOM_h_X5tdGbkiuZGZkiFigSLbbftx3YXybFBg6trg@mail.gmail.com>
	<518786a7.64bbec0a.58a0.1f6bSMTPIN_ADDED_BROKEN@mx.google.com>
	<CAErSpo5MJCoaof=heFM4vLxuWz8pFqsyXAC356jZ7rbRvSOt9g@mail.gmail.com>
	<CAE9FiQWsZXfkSSVFzee4-J4bUDP8DdG=y9-k2du+ek90StDvNA@mail.gmail.com>
	<1369255424.3870.18.camel@pasglop>
Date: Wed, 22 May 2013 14:00:00 -0700
Message-ID: <CAE9FiQU48-t5HP8w29gL7JY0eqa=fS=jhCU7bRU2hvMt0iRy6A@mail.gmail.com>
Subject: Re: Resource assignment oddities
From: Yinghai Lu <yinghai@kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Gavin Shan <shangw@linux.vnet.ibm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 22, 2013 at 1:43 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:

> The simpler thing to do would have been to do the entire thing in two
> separate passes, one for MMIO and one for IO, and skip the second one
> entirely if there's no IO at the host bridge level :-)

that will need more changes.

also how about hostbridge only has mmio pref 64bit?

Yinghai
