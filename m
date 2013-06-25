Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:58666 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751136Ab3FYQyz (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 25 Jun 2013 12:54:55 -0400
Received: by mail-oa0-f46.google.com with SMTP id h1so13771353oag.33
        for <linux-pci@vger.kernel.org>; Tue, 25 Jun 2013 09:54:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20130625184419.2bc14a71@skate>
References: <1371660979-21588-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1371660979-21588-3-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130620185707.GA8888@mithrandir> <CAErSpo6Mm6kYZKN_n-fMRD2T1-F0sf9GStmOTA8tT0wVLedCgw@mail.gmail.com>
 <20130625115552.7ebdad17@skate> <CAErSpo67ogc6R=vk+dt0Y6OFvwtLTL57tHx1u1zTkqY9g4N_1w@mail.gmail.com>
 <20130625184419.2bc14a71@skate>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 25 Jun 2013 10:54:34 -0600
Message-ID: <CAErSpo7HWkYkcGbpGe8ty=+NHh_BnnFvAVvwWb4s-prcKWo=eA@mail.gmail.com>
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

On Tue, Jun 25, 2013 at 10:44 AM, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:
> Dear Bjorn Helgaas,
>
> On Tue, 25 Jun 2013 10:20:33 -0600, Bjorn Helgaas wrote:
>
>> > Any suggestion on how to solve this particular case?
>>
>> Nope.  Just leave it as-is for that case and consolidate what you can.
>
> So I keep the weak arch_*() function and the strong default_*() for
> this particular hook, and for all the other hooks, I only keep a weak
> arch_*() function. Is this what you suggest for now?

Yep, that sounds good.

Bjorn
