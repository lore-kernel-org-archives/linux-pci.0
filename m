Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:37161 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757198Ab3KZPui convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 26 Nov 2013 10:50:38 -0500
Received: by mail-ie0-f177.google.com with SMTP id tp5so9192532ieb.8
        for <linux-pci@vger.kernel.org>; Tue, 26 Nov 2013 07:50:37 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <cfeb9976fbb74028b600c9f86fcdd9ad@BLUPR05MB118.namprd05.prod.outlook.com>
References: <528D4739.80700@fold.natur.cuni.cz> <CAErSpo7LcyL+K5rg+aNaaNzLXKyxvfAgeOPidb_3LqU3B2LXzA@mail.gmail.com>
 <01b89ce965ed454fb9f0e0cf52ba622e@BLUPR05MB118.namprd05.prod.outlook.com>
 <20131125194044.GA9710@google.com> <5293F3FB.6000401@fold.natur.cuni.cz>
 <20131126031317.GA6258@google.com> <cfeb9976fbb74028b600c9f86fcdd9ad@BLUPR05MB118.namprd05.prod.outlook.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 26 Nov 2013 08:50:17 -0700
Message-ID: <CAErSpo41KYXbgz5q=U9gfDD_tZNp9qFr0LGqMvnem2rQTLTL1g@mail.gmail.com>
Subject: Re: pciehp LinkState
To: Rajat Jain <rajatjain@juniper.net>
Cc: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Rajat Jain <rajatjain.linux@gmail.com>,
	Guenter Roeck <groeck@juniper.net>
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Nov 25, 2013 at 10:53 PM, Rajat Jain <rajatjain@juniper.net> wrote:

> Bjorn: Actually this threads brings up an good point. Is "DLL State changed" bit in "Slot Status" ALWAYS updated without regard to whether the Link state notifications were enabled or not?

That's the way I read it.  I assume you're referring to the "DLL State
Changed Enable" bit in Slot Control.  I don't see anything in the spec
about "DLL State Changed" depending on that.

> Looks like it. If yes, I'll take this as an input to make a 1 line change to my patch:
>
> Currently in my patch, the pciehp_use_link_events=1 is used to only enable link state change notifications, but in case pcie_isr() finds "DLL changed" bit set in "Slot status", it processes the link state change. I'll make the single line change to pcie_isr() to process the event only if pciehp_use_link_events=1. Let me know if this sounds alright.

If we can avoid it, I'd prefer not to add the "pciehp_use_link_events"
module parameter.  What would break if we just *always* used link
events?

Bjorn
