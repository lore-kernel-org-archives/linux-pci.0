Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f177.google.com ([209.85.214.177]:51013 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751761Ab3GIQbF (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 9 Jul 2013 12:31:05 -0400
Received: by mail-ob0-f177.google.com with SMTP id ta17so7156016obb.36
        for <linux-pci@vger.kernel.org>; Tue, 09 Jul 2013 09:31:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20130709160132.7f5e7a8e@skate>
References: <1372686136-1370-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1372686136-1370-6-git-send-email-thomas.petazzoni@free-electrons.com>
 <CAL_Jsq+h=y5SNo4qO5-5u_w8rW++9MKDZK8rASNjhtVcjh-iyQ@mail.gmail.com> <20130709160132.7f5e7a8e@skate>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 9 Jul 2013 10:30:42 -0600
Message-ID: <CAErSpo6cnHbE3RSu8HFn09SY66tOZZG95JEvKFmzHieXYV0NYg@mail.gmail.com>
Subject: Re: [PATCHv4 05/11] of: pci: add registry of MSI chips
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Rob Herring <robherring2@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Russell King <linux@arm.linux.org.uk>,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	Maen Suleiman <maen@marvell.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jul 9, 2013 at 8:01 AM, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:
> On Tue, 9 Jul 2013 08:43:36 -0500, Rob Herring wrote:
>> > +{
>> > +       struct msi_chip *c;
>> > +       list_for_each_entry(c, &msi_chip_list, list) {
>>
>> Need the safe variant here?
>
> As suggested by Bjorn, I've changed this function to grab the
> msi_chip_mutex while traversing the list.

The "safe" list functions don't do any mutual exclusion.  The only
safety they provide is that we won't go in the weeds if the body of
the loop deletes the current list entry.  This loop doesn't delete
entries, so we don't need the safe variant.

Bjorn
