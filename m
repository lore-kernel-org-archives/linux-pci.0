Return-Path: <linux-kernel-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Jeffy Chen <jeffy.chen@rock-chips.com>
Cc: linux-kernel@vger.kernel.org, bhelgaas@google.com,
        linux-pm@vger.kernel.org, tony@atomide.com,
        shawn.lin@rock-chips.com, briannorris@chromium.org,
        dianders@chromium.org, linux-pci@vger.kernel.org
Subject: Re: [RFC PATCH v10 5/7] PCI: Make pci_platform_pm_ops's callbacks optional
Date: Wed, 08 Nov 2017 23:27:55 +0100
Message-ID: <7753323.U3pdzOgHt3@aspire.rjw.lan>
In-Reply-To: <20171027072612.26565-6-jeffy.chen@rock-chips.com>
References: <20171027072612.26565-1-jeffy.chen@rock-chips.com> <20171027072612.26565-6-jeffy.chen@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday, October 27, 2017 9:26:10 AM CET Jeffy Chen wrote:
> Allow platforms not to provide some of the pci_platform_pm_ops's
> callbacks.

So?

What exactly is wrong with having empty ops in there?

Is it really better to have everyone do extra checks every time an op is
invoked even when all of the ops are present?

> Also change the return value from -ENOSYS to -ENODEV for:
> warning: drivers/pci/pci.c,594: ENOSYS means 'invalid syscall nr' and nothing else

Moving stuff around and changing it at the same time is a bad idea.

Change it in one patch and move it around in another one and you'll be less
likely to make a mistake.  Moreover, reviewing it will be easier too, IMO.

Thanks,
Rafael
