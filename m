Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f180.google.com ([209.85.223.180]:34220 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751219Ab3LQWPB (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 17 Dec 2013 17:15:01 -0500
Received: by mail-ie0-f180.google.com with SMTP id tp5so9256497ieb.39
        for <linux-pci@vger.kernel.org>; Tue, 17 Dec 2013 14:15:01 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20131217204909.GO2609@titan.lakedaemon.net>
References: <1386178241-10453-1-git-send-email-andrew@lunn.ch>
 <20131217204510.GA2281@lunn.ch> <20131217204909.GO2609@titan.lakedaemon.net>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 17 Dec 2013 15:14:41 -0700
Message-ID: <CAErSpo6GvY1G0HNznTf+m5q0DbnAWPmUp2K2-TcV3JQ0k9bTQg@mail.gmail.com>
Subject: Re: [PATCH] PCI: MVEBU: Remove duplicate clock get
To: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Dec 17, 2013 at 1:49 PM, Jason Cooper <jason@lakedaemon.net> wrote:
> Andrew,
>
> On Tue, Dec 17, 2013 at 09:45:10PM +0100, Andrew Lunn wrote:
>> On Wed, Dec 04, 2013 at 06:30:41PM +0100, Andrew Lunn wrote:
>> > Probably due to a merge conflict resolution gone bad, the pci clock is
>> > got twice. Remove the second redundent of_clk_get_by_name().
>> >
>> > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
>> > ---
>> >  drivers/pci/host/pci-mvebu.c | 8 --------
>> >  1 file changed, 8 deletions(-)
>>
>> Hi Folks
>>
>> This patch has been Acked by Jingoo Han.
>>
>> So my question is, which maintainer is going to accept it for
>> mainline? Is there anything i need to do?

I already applied it: http://lkml.kernel.org/r/20131209232904.GD4699@google.com

You don't need to do anything more.

> I'll create a branch for Bjorn to pull.  Or, if Bjorn wants to take it
> directly,
>
> Acked-by: Jason Cooper <jason@lakedaemon.net>
>
> thx,
>
> Jason.
