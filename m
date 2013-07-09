Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:35378 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751452Ab3GIWwT (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 9 Jul 2013 18:52:19 -0400
Received: by mail-wi0-f179.google.com with SMTP id hj3so5675294wib.12
        for <linux-pci@vger.kernel.org>; Tue, 09 Jul 2013 15:52:18 -0700 (PDT)
Message-ID: <51DC941E.60007@gmail.com>
Date: Tue, 09 Jul 2013 17:52:14 -0500
From: Rob Herring <robherring2@gmail.com>
MIME-Version: 1.0
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
CC: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
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
Subject: Re: [PATCHv4 05/11] of: pci: add registry of MSI chips
References: <1372686136-1370-1-git-send-email-thomas.petazzoni@free-electrons.com> <1372686136-1370-6-git-send-email-thomas.petazzoni@free-electrons.com> <CAL_Jsq+h=y5SNo4qO5-5u_w8rW++9MKDZK8rASNjhtVcjh-iyQ@mail.gmail.com> <20130709160132.7f5e7a8e@skate>
In-Reply-To: <20130709160132.7f5e7a8e@skate>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 07/09/2013 09:01 AM, Thomas Petazzoni wrote:
> Rob,
> 
> On Tue, 9 Jul 2013 08:43:36 -0500, Rob Herring wrote:
> 
>>> +int of_msi_chip_add(struct msi_chip *chip)
>>
>> Perhaps of_pci_msi_chip_add instead.
> 
> Sure, makes sense.
> 
>>> +{
>>> +       struct msi_chip *c;
>>> +       list_for_each_entry(c, &msi_chip_list, list) {
>>
>> Need the safe variant here?
> 
> As suggested by Bjorn, I've changed this function to grab the
> msi_chip_mutex while traversing the list.
> 
> Does your e-mail implies that the general approach seems ok? If so,
> I'll resend an updated v5 version taking into account the comments
> that I have received on this v4.

Yes. Since it is only trivial comments, you can add my ack.

Acked-by: Rob Herring <rob.herring@calxeda.com>

Rob

> 
> Thanks!
> 
> Thomas
> 

