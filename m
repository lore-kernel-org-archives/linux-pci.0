Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f171.google.com ([209.85.213.171]:34260 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750737AbaCSSSs (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 19 Mar 2014 14:18:48 -0400
Received: by mail-ig0-f171.google.com with SMTP id hl1so12494542igb.4
        for <linux-pci@vger.kernel.org>; Wed, 19 Mar 2014 11:18:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAErSpo6vuzaKJ-qWKfwcY_MsDhSdG9NazaYzG3=tabJerUv6mw@mail.gmail.com>
References: <1393286367-16482-1-git-send-email-yinghai@kernel.org>
	<CAErSpo4E3Kd6Vk94NQy3Nj-Hd9WFaphoXL-eCmsaQ4KvQ-fK6Q@mail.gmail.com>
	<CAE9FiQUvU=BqPXDHC+B=zC7ZGarimLDdvHsDbVL8t8qnZLJpzw@mail.gmail.com>
	<CAErSpo6vuzaKJ-qWKfwcY_MsDhSdG9NazaYzG3=tabJerUv6mw@mail.gmail.com>
Date: Wed, 19 Mar 2014 11:18:47 -0700
Message-ID: <CAE9FiQV3bM087uhWc5oH6j_7AJim0ECwTZKD05JSe2R5KmuCAQ@mail.gmail.com>
Subject: Re: [PATCH] pciehp: only wait command complete for really hotplug control
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Rajat Jain <rajatxjain@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Feb 25, 2014 at 9:45 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Mon, Feb 24, 2014 at 6:55 PM, Yinghai Lu <yinghai@kernel.org> wrote:
>
> It's quite likely that I'm mistaken, and this is not a silicon
> problem, especially since two vendors apparently did it the same way.
> But I'd like to see the explanation from Intel about how this complies
> with the spec.  I provided a spec reference for why I think we should
> wait for a command completed event.  The next step would be for you or
> Intel to respond with "here's the section in the spec that you missed,
> and it says the OS should not wait for an event unless it is changing
> the EIC, PCC, PIC, or AIC bits."

Hi, Bjorn,

Intel admits that it is silicon problem.
CC will be set iff EIC || PCC || PIC || AIC is set.

so please me know if you want
1. just use the patch in current form. it will do that for ...
2. or modify the patch to check vendor to set flag for every controller, and use
that to decide if need to wait CC.

BTW, other OS does not check CC for other than the four bits.

Thanks

Yinghai
