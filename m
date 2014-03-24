Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f181.google.com ([209.85.213.181]:33308 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750936AbaCXWHi (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 24 Mar 2014 18:07:38 -0400
Received: by mail-ig0-f181.google.com with SMTP id h18so85297igc.2
        for <linux-pci@vger.kernel.org>; Mon, 24 Mar 2014 15:07:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAA93t1rPE3yUh8nAGJDiqeGhixznZdhdyFwRoX_c1VWT3WEtvw@mail.gmail.com>
References: <1393286367-16482-1-git-send-email-yinghai@kernel.org>
	<CAErSpo4E3Kd6Vk94NQy3Nj-Hd9WFaphoXL-eCmsaQ4KvQ-fK6Q@mail.gmail.com>
	<CAE9FiQUvU=BqPXDHC+B=zC7ZGarimLDdvHsDbVL8t8qnZLJpzw@mail.gmail.com>
	<CAErSpo6vuzaKJ-qWKfwcY_MsDhSdG9NazaYzG3=tabJerUv6mw@mail.gmail.com>
	<CAE9FiQV3bM087uhWc5oH6j_7AJim0ECwTZKD05JSe2R5KmuCAQ@mail.gmail.com>
	<CAErSpo75LCpED6T48osUkGJ5CS7tUSEmdKye0wJZVOSb_OwnQQ@mail.gmail.com>
	<CAE9FiQX+hOUsLRrL8u_T7SPU4s3SKdUiXOHSwoswKZoBNqXGUw@mail.gmail.com>
	<CAE9FiQVN9R3DJWasRqNyzNK2vOpmnRZdbp0KjnPUeMtoJXoJiQ@mail.gmail.com>
	<CAA93t1oMD3bR_zKUK5_Hw+J_LeF3GTGBfR+JA=mV=L7z9X+y1Q@mail.gmail.com>
	<CAA93t1rPE3yUh8nAGJDiqeGhixznZdhdyFwRoX_c1VWT3WEtvw@mail.gmail.com>
Date: Mon, 24 Mar 2014 15:07:38 -0700
Message-ID: <CAE9FiQVgCjCAiRKiBMRmObkDPRkRkVBxsCJY=+apxojh6JmkTA@mail.gmail.com>
Subject: Re: [PATCH] pciehp: only wait command complete for really hotplug control
From: Yinghai Lu <yinghai@kernel.org>
To: Rajat Jain <rajatxjain@gmail.com>
Cc: Guenter Roeck <groeck@juniper.net>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Mar 24, 2014 at 2:54 PM, Rajat Jain <rajatxjain@gmail.com> wrote:
> Hello,
>
> I tested this today, and it works fine. Apparently It even solves the
> problem my systems were facing, thus I do not need my patch anymore!
> :-)

Great.

Please post the patch with your tested-by.

Thanks

Yinghai
