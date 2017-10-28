Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-io0-f196.google.com ([209.85.223.196]:53287 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751465AbdJ1UjK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 28 Oct 2017 16:39:10 -0400
Received: by mail-io0-f196.google.com with SMTP id 189so19447401iow.10
        for <linux-pci@vger.kernel.org>; Sat, 28 Oct 2017 13:39:10 -0700 (PDT)
Date: Sat, 28 Oct 2017 13:39:06 -0700
From: Brian Norris <briannorris@chromium.org>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: Jeffy Chen <jeffy.chen@rock-chips.com>,
        linux-kernel@vger.kernel.org, bhelgaas@google.com,
        linux-pm@vger.kernel.org, tony@atomide.com,
        shawn.lin@rock-chips.com, rjw@rjwysocki.net, dianders@chromium.org,
        linux-pci@vger.kernel.org
Subject: Re: [RFC PATCH v8 7/7] PCI / PM: Add support for the PCIe WAKE#
 signal for OF
Message-ID: <20171028203905.GA122526@google.com>
References: <20171026132840.20946-1-jeffy.chen@rock-chips.com>
 <20171026132840.20946-8-jeffy.chen@rock-chips.com>
 <334be327-543f-d379-83de-ce84799fa49a@codeaurora.org>
 <20171028000400.GE105121@google.com>
 <9460e098-a797-296a-1d03-0d19512457c2@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9460e098-a797-296a-1d03-0d19512457c2@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Oct 28, 2017 at 02:01:46PM -0400, Sinan Kaya wrote:
> I was looking for some code that can be used between OF and ACPI rather than
> duplicating the code in two different places just to extract some information
> from the platform firmware. 
> 
> My initial look at your code suggested it to be very generic except the IRQ
> read function. 
> 
> I was expecting that the kernel's PCI Wake handling to be common whether the IRQ
> information is coming from DT/ACPI.

I'm not an ACPI expert, but from reading the existing ACPI code handling
this wakeup configuration...they're not really that similar. Whereas for
device tree firmware there's not much magic to it -- the OS is really
just configuring a standard interrupt with wakeup capability -- ACPI
layers this all behind its GPE (General Purpose Event) abstraction,
which doesn't act like a typical interrupt. You manage GPE handlers with
a completely different set of APIs.

Anyway, Rafael seemed to have some of his own opinions (didn't like the
current approach it seems), so maybe we're all completely off track
here.

Regards,
Brian
