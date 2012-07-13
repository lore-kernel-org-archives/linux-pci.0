Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:62873 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932757Ab2GMSHU (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 13 Jul 2012 14:07:20 -0400
Received: by vcbf11 with SMTP id f11so2443020vcb.19
        for <linux-pci@vger.kernel.org>; Fri, 13 Jul 2012 11:07:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAErSpo4-wFVG0B9WOoxtsAmWuqn4oUGBQSqDRZUAYa2i-TuCWQ@mail.gmail.com>
References: <1340437325-29282-1-git-send-email-yinghai@kernel.org>
	<1340437325-29282-3-git-send-email-yinghai@kernel.org>
	<CAErSpo5K9EqAQSKA5_YdM2WThWddJr4XDbFHr84h_MPHvSqJmg@mail.gmail.com>
	<20120711162120.GA17988@google.com>
	<CAE9FiQUeJ3fyjamtxgx=_PeZC0Qdofx5ou8Gbg_ikSGTCbC06g@mail.gmail.com>
	<CAErSpo4nrhBg7SSknmtG=Ss+UGmUJthQ7EBuedNFdyV0PUQuxQ@mail.gmail.com>
	<CAE9FiQVbaYszsqq6WYENQu18a52m2fD9svtdFV2y4DeDnYWJcA@mail.gmail.com>
	<CAErSpo7f1hvQ2sg8TTu-d2dy1ST8xNEfR0odESihQtRh=KMi5A@mail.gmail.com>
	<CAE9FiQU3RbdnBssTT6tiGP9GjtyLHBbdaor2qF=26d8WLf72cw@mail.gmail.com>
	<CAErSpo6rEcu3gwScEDxJ7DXzeMpT4DBGgAyhNE9qpPo4wEMouw@mail.gmail.com>
	<CAE9FiQXTjEqLLGx=EzxoWNqKTPF+g4=PNMiiTLkdUyf0LX-JUg@mail.gmail.com>
	<CAErSpo4=W7kejZ9BsUeZfu5R0=R8tzq5+q96aOX+VbOsOY6CLw@mail.gmail.com>
	<CAE9FiQU1NkYr2jPFoRazYyniRK0TnjXsyLnALA8muaf3F04-pg@mail.gmail.com>
	<CAErSpo7LvGcKm2touq5OpbxPx0XyRbg2B+DMtVigcqqN9uPgcA@mail.gmail.com>
	<CAE9FiQXpMm1Mif=vhzP99NpO6iVPZbXVAPwwhEWdo=dEczspiw@mail.gmail.com>
	<CAErSpo4-wFVG0B9WOoxtsAmWuqn4oUGBQSqDRZUAYa2i-TuCWQ@mail.gmail.com>
Date: Fri, 13 Jul 2012 11:07:18 -0700
Message-ID: <CAE9FiQV_yUZ3oA8wQUcM=KTTQQG-AWRrevBWCZ52exe4yfCPsg@mail.gmail.com>
Subject: Re: [PATCH 2/5] pciehp: Don't enable presence notification while
 surprise removal is not supported.
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jul 13, 2012 at 8:30 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Thu, Jul 12, 2012 at 6:19 PM, Yinghai Lu <yinghai@kernel.org> wrote:
>
> The question is what to do when a new card appears and there's no
> attention button.  In general I think we should follow the SHPC flow
> and wait for some software equivalent of a button push, e.g., a sysfs
> poke.
>
> But if pciehp handles ExpressCards, that doesn't sound like the
> desired user experience -- if we insert an ExpressCard in a laptop,
> don't we expect it to just start working, without having to poke
> around in software?

ExpressCards does support surprise removal. so in current code, it
still get online
automatically.

Yinghai
