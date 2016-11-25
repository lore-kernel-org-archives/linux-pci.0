Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from dehamd003.servertools24.de ([31.47.254.18]:53436 "EHLO
        dehamd003.servertools24.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753027AbcKYI4M (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Nov 2016 03:56:12 -0500
Subject: Re: Multiple problems with the Linux kernel on an AMD desktop
To: =?UTF-8?Q?Rog=c3=a9rio_Brito?= <rbrito@ime.usp.br>
References: <20161124233957.k2twr352kna6ukd2@ime.usp.br>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
From: Clemens Ladisch <clemens@ladisch.de>
Message-ID: <5e4a6800-251f-23e7-11f5-9993280fe8d5@ladisch.de>
Date: Fri, 25 Nov 2016 09:47:40 +0100
MIME-Version: 1.0
In-Reply-To: <20161124233957.k2twr352kna6ukd2@ime.usp.br>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Rogério Brito wrote:
> * I have never been able to boot this computer of mine without the option
>   irqpoll---otherwise, I get the nobody cared message.

The "nobody cared" message indicates that there were too many interrupts
that no driver felt responsible for, so the kernel has disabled that
interrupt vector.  The irqpoll option is a workaround to get the devices
on that interrupt vector to work, but it's not perfect.

It's possible that most of your problems are caused by the irqpoll option.

What IRQ is the problematic one (see the "nobody cared" message)?  What
devices are connected to it (see /proc/interrupts)?  Does the problem go
away when you prevent the corresponding driver(s) from loading?


Regards,
Clemens
