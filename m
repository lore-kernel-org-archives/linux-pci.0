Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:58600 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752900AbdKHWc0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Nov 2017 17:32:26 -0500
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Jeffy Chen <jeffy.chen@rock-chips.com>
Cc: linux-kernel@vger.kernel.org, bhelgaas@google.com,
        linux-pm@vger.kernel.org, tony@atomide.com,
        shawn.lin@rock-chips.com, briannorris@chromium.org,
        dianders@chromium.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>
Subject: Re: [RFC PATCH v10 6/7] PCI / PM: Move acpi wakeup code to pci core
Date: Wed, 08 Nov 2017 23:32:20 +0100
Message-ID: <1894178.xtK0vD2N4H@aspire.rjw.lan>
In-Reply-To: <20171027072612.26565-7-jeffy.chen@rock-chips.com>
References: <20171027072612.26565-1-jeffy.chen@rock-chips.com> <20171027072612.26565-7-jeffy.chen@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday, October 27, 2017 9:26:11 AM CET Jeffy Chen wrote:
> Move acpi wakeup code to pci core as pci_set_wakeup(), so that other
> platforms could reuse it.

What exactly do you want to reuse?

It looks like that's just several lines of code in acpi_pci_wakeup()
and acpi_pci_propagate_wakeup() which invoke ACPI-specific lower-level
functions, so IMO not worth it at all.

The structure for other platform code may be the same or similar, but
the details will almost certainly be different and I don't think that
having more callback pointers in pci_platform_pm_ops is necessarily better.

> Also add .setup_dev() / .setup_host_bridge() / .cleanup() platform pm
> ops's callbacks to setup and cleanup pci devices and host bridge for
> wakeup.

Why are they needed?

> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>

Thanks,
Rafael
