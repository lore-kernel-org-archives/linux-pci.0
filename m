Return-Path: <SRS0=jmuj=WK=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABDC6C32750
	for <linux-pci@archiver.kernel.org>; Wed, 14 Aug 2019 01:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ED4820844
	for <linux-pci@archiver.kernel.org>; Wed, 14 Aug 2019 01:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565744901;
	bh=35iNLY+3zML5gtouJ5dOsP2hrVe43AhtfEzM8qZJI/0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xu7LqtoyiIyzPYsuBWsPDAZ0q4sq0KZTliAVEKBowy4yEot748LWfQJIfFAsHNjvt
	 ctNubiyL3HZrPnqfMm1scVmcVPf4D2aHduDW0JqCExiqNS38fijaeMI3p+V+2eGLE5
	 YFkGOc5F7/TfnMg9ocOM9DTL0fZY3EG9EtH5sIjM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbfHNBIU (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 13 Aug 2019 21:08:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:57578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726383AbfHNBIU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 13 Aug 2019 21:08:20 -0400
Received: from localhost (unknown [104.133.9.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC65120665;
        Wed, 14 Aug 2019 01:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565744900;
        bh=35iNLY+3zML5gtouJ5dOsP2hrVe43AhtfEzM8qZJI/0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TV0lQX62Ih7wGdK1OvaGqqb/W6gup3czmHlObR1mhlVD7vvOmg/QIiXwp+sXMF8OM
         Bt1YnmJ8RpkUcKuXlugSt715ExPE/BED8n8mvoVr61b04uTbFcCDIjouA7QhT2le0x
         4WWIPvsiqRXQutONno9RyGZHY41rTx2MVqfGphGo=
Date:   Tue, 13 Aug 2019 20:08:19 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Keith Busch <keith.busch@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/5] PCI / PM: Check for error when reading Power State
Message-ID: <20190814010819.GA206171@google.com>
References: <20190805205214.194981-1-helgaas@kernel.org>
 <CAJZ5v0jFPU38zDugumJB0iq5d-LctcMCdygTrFU4=gYP3UJ+oA@mail.gmail.com>
 <20190809220116.GA221706@google.com>
 <27964051.NtteWoIlyA@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27964051.NtteWoIlyA@kreacher>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 14, 2019 at 12:59:26AM +0200, Rafael J. Wysocki wrote:
> On Saturday, August 10, 2019 12:01:16 AM CEST Bjorn Helgaas wrote:
> > On Mon, Aug 05, 2019 at 11:09:19PM +0200, Rafael J. Wysocki wrote:
> > > On Mon, Aug 5, 2019 at 10:52 PM Bjorn Helgaas <helgaas@kernel.org> wrote:

> > > > @@ -942,7 +942,7 @@ void pci_update_current_state(struct pci_dev *dev, pci_power_t state)
> > > >                 u16 pmcsr;
> > > >
> > > >                 pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
> > > > -               dev->current_state = (pmcsr & PCI_PM_CTRL_STATE_MASK);
> > > > +               dev->current_state = pci_power_state(pmcsr);
> > > 
> > > The if () branch above should cover the D3cold case, shouldn't it?
> > 
> > You mean the "if (platform_pci_get_power_state(dev) == PCI_D3cold)"
> > test?
> 
> Not exactly.
> 
> I mean "if (platform_pci_get_power_state(dev) == PCI_D3cold ||
> !pci_device_is_present(dev))".

I don't see what you mean.  The !pci_device_is_present(dev) test tells
us something about what the state of the device was at some time in
the past, but of course it doesn't say anything about whether reading
PCI_PM_CTRL will succeed, e.g.,

  # dev is present and in D0
  platform_pci_get_power_state(dev) == PCI_D3cold   # currently false
  !pci_device_is_present(dev)                       # currently false
  # dev is surprise hot-removed or put in D3cold
  pci_read_config_word(PCI_PM_CTRL, &pmcsr)
  # pmcsr == ~0 (error response)

(Maybe going to D3cold is impossible, but it's pretty hard to prove
that.  The hot-remove is definitely possible.)

> > platform_pci_get_power_state() returns PCI_UNKNOWN in some cases.
> > When that happens, might we not read PCI_PM_CTRL of a device in
> > D3cold?  I think this also has the same hotplug question as above.
> 
> Surprise hot-removal can take place at any time, in particular after setting
> current_state, so adding extra checks here doesn't prevent the value of
> it from becoming stale at least sometimes anyway.

Definitely.  The point is not to prevent current_state from becoming
stale, it's to prevent us from interpreting ~0 data (known to be
invalid) as though it were a valid register value.

Bjorn
