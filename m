Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qk0-f170.google.com ([209.85.220.170]:36833 "EHLO
        mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965344AbeBMS3X (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Feb 2018 13:29:23 -0500
MIME-Version: 1.0
In-Reply-To: <20180213165948.GA14035@embeddedor.com>
References: <20180213165948.GA14035@embeddedor.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 13 Feb 2018 20:29:21 +0200
Message-ID: <CAHp75VfdDUooc=zy2rk8ep0PdsEsD1TGbaD9nm8DBB1NmYYTTw@mail.gmail.com>
Subject: Re: [PATCH] PCI/ASPM: Use 64-bit arithmetic instead of 32-bit
To: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Feb 13, 2018 at 6:59 PM, Gustavo A. R. Silva
<garsilva@embeddedor.com> wrote:
> Add suffix ULL to constant 1000 in order to give the compiler complete
> information about the proper arithmetic to use. Notice that this
> constant is used in a context that expects an expression of type
> u64 (64 bits, unsigned).
>
> The expression threshold_us * 1000 is currently being evaluated
> using 32-bit arithmetic.

> -       u64 threshold_ns = threshold_us * 1000;
> +       u64 threshold_ns = threshold_us * 1000ULL;

Shouldn't be other way around, i.e.

(u64)threshold_us ?

But still the question. have you checked all callers? Does it even makes sense?

-- 
With Best Regards,
Andy Shevchenko
