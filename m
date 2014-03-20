Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f177.google.com ([209.85.213.177]:54709 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750917AbaCTDQE (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 19 Mar 2014 23:16:04 -0400
Received: by mail-ig0-f177.google.com with SMTP id ur14so872425igb.4
        for <linux-pci@vger.kernel.org>; Wed, 19 Mar 2014 20:16:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAErSpo75LCpED6T48osUkGJ5CS7tUSEmdKye0wJZVOSb_OwnQQ@mail.gmail.com>
References: <1393286367-16482-1-git-send-email-yinghai@kernel.org>
	<CAErSpo4E3Kd6Vk94NQy3Nj-Hd9WFaphoXL-eCmsaQ4KvQ-fK6Q@mail.gmail.com>
	<CAE9FiQUvU=BqPXDHC+B=zC7ZGarimLDdvHsDbVL8t8qnZLJpzw@mail.gmail.com>
	<CAErSpo6vuzaKJ-qWKfwcY_MsDhSdG9NazaYzG3=tabJerUv6mw@mail.gmail.com>
	<CAE9FiQV3bM087uhWc5oH6j_7AJim0ECwTZKD05JSe2R5KmuCAQ@mail.gmail.com>
	<CAErSpo75LCpED6T48osUkGJ5CS7tUSEmdKye0wJZVOSb_OwnQQ@mail.gmail.com>
Date: Wed, 19 Mar 2014 20:16:02 -0700
Message-ID: <CAE9FiQX+hOUsLRrL8u_T7SPU4s3SKdUiXOHSwoswKZoBNqXGUw@mail.gmail.com>
Subject: Re: [PATCH] pciehp: only wait command complete for really hotplug control
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Rajat Jain <rajatxjain@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Mar 19, 2014 at 3:01 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Wed, Mar 19, 2014 at 12:18 PM, Yinghai Lu <yinghai@kernel.org> wrote:
>
> I think the current pciehp design is a bit broken.  Today we perform
> commands very synchronously:
>
>     pcie_write_cmd() {
>         write Slot Control
>         if (Command Complete supported) {
>             wait for Command Complete
>         }
>     }
>
> The typical driver pattern would be more asynchronous, like this:
>
>     pcie_write_cmd() {
>         read Slot Status
>         if (!Command Completed) {
>             wait for Command Complete
>         }
>         write Slot Control
>     }
>
> With the asynchronous pattern, we would probably never wait at all
> unless we performed two commands in immediate succession.  I wouldn't
> be surprised if doing this asynchronously would effectively cover up
> these hardware differences.

I like this idea. Will give it a try.

Thanks

Yinghai
