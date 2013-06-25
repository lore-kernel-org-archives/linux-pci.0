Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oa0-f47.google.com ([209.85.219.47]:51415 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751424Ab3FYQUy (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 25 Jun 2013 12:20:54 -0400
Received: by mail-oa0-f47.google.com with SMTP id m1so13830065oag.34
        for <linux-pci@vger.kernel.org>; Tue, 25 Jun 2013 09:20:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20130625115552.7ebdad17@skate>
References: <1371660979-21588-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1371660979-21588-3-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130620185707.GA8888@mithrandir> <CAErSpo6Mm6kYZKN_n-fMRD2T1-F0sf9GStmOTA8tT0wVLedCgw@mail.gmail.com>
 <20130625115552.7ebdad17@skate>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 25 Jun 2013 10:20:33 -0600
Message-ID: <CAErSpo67ogc6R=vk+dt0Y6OFvwtLTL57tHx1u1zTkqY9g4N_1w@mail.gmail.com>
Subject: Re: [PATCHv3 02/11] pci: use weak functions for MSI arch-specific functions
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Thierry Reding <thierry.reding@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Russell King <linux@arm.linux.org.uk>,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	linux-arm <linux-arm-kernel@lists.infradead.org>,
	Maen Suleiman <maen@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Thierry Reding <thierry.reding@avionic-design.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jun 25, 2013 at 3:55 AM, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:
> Dear Bjorn Helgaas,
>
> On Mon, 24 Jun 2013 19:52:45 -0600, Bjorn Helgaas wrote:
>
>> I agree; the whole point of __weak is to provide a "default"
>> implementation, so I hope you can just remove any empty default_*()
>> functions and fold the others into the arch_*() functions directly.
>>
>> If there actually are callbacks from arch-specific strong functions
>> back to the stuff in the default_*() functions, that suggests that we
>> should refactor and rename that bit of functionality.
>
> There is one such case, as highlighted in the commit log of this patch:
>
> """
> This is needed because the x86 Xen implementation of
> teardown_msi_irqs() needs to do some work, and then call the default
> implementation of this hook.
> """
>
> Any suggestion on how to solve this particular case?

Nope.  Just leave it as-is for that case and consolidate what you can.

Bjorn
