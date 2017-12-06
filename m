Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ot0-f195.google.com ([74.125.82.195]:38631 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752242AbdLFOrh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 Dec 2017 09:47:37 -0500
MIME-Version: 1.0
In-Reply-To: <616e1d18-df26-f868-ddb9-602621e9240f@codeaurora.org>
References: <20171206141751.757163-1-arnd@arndb.de> <616e1d18-df26-f868-ddb9-602621e9240f@codeaurora.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 6 Dec 2017 15:47:36 +0100
Message-ID: <CAK8P3a1rE1nD0SA_FJQSY4GRYCr5COcmR2V7RCzcRUy6iUGgXQ@mail.gmail.com>
Subject: Re: [PATCH] pci: provide pci_get_domain_bus_and_slot dummy helper
To: Sinan Kaya <okaya@codeaurora.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Matthew Minter <matt@masarand.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Dec 6, 2017 at 3:41 PM, Sinan Kaya <okaya@codeaurora.org> wrote:
> On 12/6/2017 9:17 AM, Arnd Bergmann wrote:
>
> I thought Bjorn merged a similar patch yesterday with subject
>
> "[PATCH -next] pci: add function stub for pci_get_domain_bus_and_slot()"

It was probably just a bit too late to make it into today's linux-next.

       Arnd
