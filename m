Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f181.google.com ([209.85.213.181]:57730 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751274AbaCTDOX (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 19 Mar 2014 23:14:23 -0400
Received: by mail-ig0-f181.google.com with SMTP id h18so869325igc.2
        for <linux-pci@vger.kernel.org>; Wed, 19 Mar 2014 20:14:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAErSpo75LCpED6T48osUkGJ5CS7tUSEmdKye0wJZVOSb_OwnQQ@mail.gmail.com>
References: <1393286367-16482-1-git-send-email-yinghai@kernel.org>
	<CAErSpo4E3Kd6Vk94NQy3Nj-Hd9WFaphoXL-eCmsaQ4KvQ-fK6Q@mail.gmail.com>
	<CAE9FiQUvU=BqPXDHC+B=zC7ZGarimLDdvHsDbVL8t8qnZLJpzw@mail.gmail.com>
	<CAErSpo6vuzaKJ-qWKfwcY_MsDhSdG9NazaYzG3=tabJerUv6mw@mail.gmail.com>
	<CAE9FiQV3bM087uhWc5oH6j_7AJim0ECwTZKD05JSe2R5KmuCAQ@mail.gmail.com>
	<CAErSpo75LCpED6T48osUkGJ5CS7tUSEmdKye0wJZVOSb_OwnQQ@mail.gmail.com>
Date: Wed, 19 Mar 2014 20:14:22 -0700
Message-ID: <CAE9FiQWWFpv_280F8gYvyH=oiw1Mcu-Dhv=d74QqaAzg80snUA@mail.gmail.com>
Subject: Re: [PATCH] pciehp: only wait command complete for really hotplug control
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Rajat Jain <rajatxjain@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Mar 19, 2014 at 3:01 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:

> In any case, it needs to be clear why we expect CC for some bits but not others.

Others bits should be chipset internal set right away.
The 4 bits will need chipset to talk to external controller to do the
work, that take some time.

Thanks

Yinghai
