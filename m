Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oa0-f41.google.com ([209.85.219.41]:42499 "EHLO
	mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751922AbaASUaw (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 19 Jan 2014 15:30:52 -0500
Received: by mail-oa0-f41.google.com with SMTP id j17so835377oag.0
        for <linux-pci@vger.kernel.org>; Sun, 19 Jan 2014 12:30:52 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAAO_jA0C1mCS1oEOwmCffh6E6YB-Wj9pDtiYgwGj=_-6-a57VA@mail.gmail.com>
References: <CAAO_jA0qv5sx34OwULq-bHsgruRBmmYkWp90Hh+586AEkmJ41Q@mail.gmail.com>
	<CAAO_jA0C1mCS1oEOwmCffh6E6YB-Wj9pDtiYgwGj=_-6-a57VA@mail.gmail.com>
Date: Sun, 19 Jan 2014 12:30:51 -0800
Message-ID: <CAP6odjhLd4onStRtnG_x77eX5NvvCsV1jy9b=iTwtCtSo=5OKQ@mail.gmail.com>
Subject: Re: Regarding API's
From: Grant Grundler <grantgrundler@gmail.com>
To: Tarun Bharani <tarun374374@gmail.com>
Cc: linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Jan 18, 2014 at 10:24 PM, Tarun Bharani <tarun374374@gmail.com> wrote:
> Respected Sir,
>
> Please help us suggesting API or Macro that will scan all the
>     struct pci_driver { } objects and provide detail of the
>     struct pci_dev { } objects managed by the struct pci_driver { }

Hi Tarun,
Look for pci.txt in Documentation/ directory - that should answer your
question. If not, someone from pci mailing list (cc) can.

cheers,
grant

>
>
> --
> **Best Regards**
> **Tarun Bharani**
