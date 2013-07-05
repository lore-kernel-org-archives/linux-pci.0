Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:41853 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751670Ab3GEXFZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 5 Jul 2013 19:05:25 -0400
Message-ID: <1373065511.4446.11.camel@pasglop>
Subject: Re: [PATCH 1/8] PCI: Add pcibios_stop_dev()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Date: Sat, 06 Jul 2013 09:05:11 +1000
In-Reply-To: <CAErSpo52hic4nb-RtTT+e1nhXFeuWUJWajEzMy3j6wzWHVaG4A@mail.gmail.com>
References: <1372993054-25730-1-git-send-email-shangw@linux.vnet.ibm.com>
	 <1372993054-25730-2-git-send-email-shangw@linux.vnet.ibm.com>
	 <CAErSpo7QGD99HM1fEcvGi-9h3HX6C8nu1mzJHnMMUKWTNO0vnw@mail.gmail.com>
	 <1373063807.4446.10.camel@pasglop>
	 <CAErSpo52hic4nb-RtTT+e1nhXFeuWUJWajEzMy3j6wzWHVaG4A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, 2013-07-05 at 16:49 -0600, Bjorn Helgaas wrote:
> I know we have paths where we save config space, do a reset, and
> restore config space.  I don't like those because some quirks aren't
> applied and I don't believe restoring config space is sufficient to
> make the device safe to use.  There could be internal state that we
> aren't restoring.  It's also possible that a firmware update means the
> device is different than it was before the reset, e.g., BARs could be
> different types or sizes.

True. Ok, I'll stick to the actual hotplug path then, you make
good points.

Cheers,
Ben.


