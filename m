Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:57562 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726546AbeIKOIZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 11 Sep 2018 10:08:25 -0400
Date: Tue, 11 Sep 2018 12:09:57 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Len Brown <lenb@kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Keith Busch <keith.busch@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Mario.Limonciello@dell.com,
        Anthony Wong <anthony.wong@canonical.com>,
        "D . J . Bernstein" <djb@cr.yp.to>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH 01/10] PCI: Do not skip power managed bridges in
 pci_enable_wake()
Message-ID: <20180911090957.GT14465@lahna.fi.intel.com>
References: <20180906155020.51700-1-mika.westerberg@linux.intel.com>
 <20180906155020.51700-2-mika.westerberg@linux.intel.com>
 <6060673.ioIVnQPhoN@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6060673.ioIVnQPhoN@aspire.rjw.lan>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Sep 11, 2018 at 10:47:55AM +0200, Rafael J. Wysocki wrote:
> > @@ -2134,9 +2134,11 @@ static int __pci_enable_wake(struct pci_dev *dev, pci_power_t state, bool enable
> >  
> >  	/*
> >  	 * Bridges can only signal wakeup on behalf of subordinate devices,
> > -	 * but that is set up elsewhere, so skip them.
> > +	 * but that is set up elsewhere, so skip them. With the exception
> > +	 * of bridges that we power manage. These can signal wake for
> > +	 * example on a hotplug event.
> >  	 */
> 
> I would change the comment even more, to something like:
> 
> "Bridges that are not power-manageable directly only signal wakeup on behalf
> of subordinate devices which is set up elsewhere, so skip them.  However,
> bridges that are power-manageable may signal wakeup for themselves (for example,
> on a hotplug event) and they need to be covered here."

OK, I'll update the comment accordingly.
