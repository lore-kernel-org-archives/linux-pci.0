Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:53918 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751748AbdLGAR6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 6 Dec 2017 19:17:58 -0500
Date: Wed, 6 Dec 2017 16:17:54 -0800
From: Tony Lindgren <tony@atomide.com>
To: Brian Norris <briannorris@chromium.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        linux-kernel@vger.kernel.org, bhelgaas@google.com,
        linux-pm@vger.kernel.org, shawn.lin@rock-chips.com,
        dianders@chromium.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>
Subject: Re: [RFC PATCH v10 6/7] PCI / PM: Move acpi wakeup code to pci core
Message-ID: <20171207001754.GB28152@atomide.com>
References: <20171027072612.26565-1-jeffy.chen@rock-chips.com>
 <1894178.xtK0vD2N4H@aspire.rjw.lan>
 <20171114025109.GA43048@google.com>
 <1882670.s3LR2t44nD@aspire.rjw.lan>
 <20171206193421.GA143886@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171206193421.GA143886@google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

* Brian Norris <briannorris@chromium.org> [171206 19:36]:
> By the way, it seems pretty ambiguous how we want to handle things like
> (a) multiple devices sharing the same WAKE#
> (b) systems where a slot is swappable
> 
> For (a), the main problem is that if we have to repeat the interrupt
> definition in multiple devices, then we have to deal with something like
> IRQF_SHARED. That can be done, but it makes it much harder to use the
> dedicated wakeirq helpers.

This will get messy, let's not go there :) That is unless the hardware
really has a single interrupt wired to multiple devices. And in that
case almost certainly a custom interrupt handler is needed.

Regards,

Tony
