Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:36040 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031243Ab3HIVzt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 9 Aug 2013 17:55:49 -0400
Message-ID: <1376085258.32100.40.camel@pasglop>
Subject: Re: [PATCHv8 04/10] of: pci: add registry of MSI chips
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jason Cooper <jason@lakedaemon.net>
Cc: Thierry Reding <thierry.reding@gmail.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Russell King <linux@arm.linux.org.uk>,
	Maen Suleiman <maen@marvell.com>, linux-pci@vger.kernel.org,
	Rob Herring <rob.herring@calxeda.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-arm-kernel@lists.infradead.org
Date: Sat, 10 Aug 2013 07:54:18 +1000
In-Reply-To: <20130809142724.GD25111@titan.lakedaemon.net>
References: <1376000268-18397-1-git-send-email-thomas.petazzoni@free-electrons.com>
	 <1376000268-18397-5-git-send-email-thomas.petazzoni@free-electrons.com>
	 <1376027346.32100.8.camel@pasglop>
	 <20130809134427.GC25111@titan.lakedaemon.net> <20130809141806.GA15973@ulmo>
	 <20130809142724.GD25111@titan.lakedaemon.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, 2013-08-09 at 10:27 -0400, Jason Cooper wrote:
> 
> You're correct, I sent this a little too hastily.  I thought Ben knew
> something I didn't (see above), but the error was only where you
> indicated.  I'm revising my fix to just append the semi-colon after
> the
> NULL.

I messed up in my reply, I was talking about the one after the NULL.

Cheers,
Ben.


