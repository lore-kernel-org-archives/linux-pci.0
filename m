Return-Path: <SRS0=cv1o=P5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82F28C282DB
	for <linux-pci@archiver.kernel.org>; Mon, 21 Jan 2019 10:22:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D58F2089F
	for <linux-pci@archiver.kernel.org>; Mon, 21 Jan 2019 10:22:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbfAUKWW (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 21 Jan 2019 05:22:22 -0500
Received: from mga12.intel.com ([192.55.52.136]:40733 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725908AbfAUKWW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 21 Jan 2019 05:22:22 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jan 2019 02:22:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,502,1539673200"; 
   d="scan'208";a="111449670"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by orsmga008.jf.intel.com with SMTP; 21 Jan 2019 02:22:17 -0800
Received: by lahna (sSMTP sendmail emulation); Mon, 21 Jan 2019 12:22:17 +0200
Date:   Mon, 21 Jan 2019 12:22:17 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Lukas Wunner <lukas@wunner.de>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Keith Busch <keith.busch@intel.com>,
        Oza Pawandeep <poza@codeaurora.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI: pciehp: Disable Data Link Layer State Changed
 event on suspend
Message-ID: <20190121102217.GM14577@lahna.fi.intel.com>
References: <20190107143959.75267-1-mika.westerberg@linux.intel.com>
 <20190107143959.75267-3-mika.westerberg@linux.intel.com>
 <20190115002410.GF33971@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190115002410.GF33971@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

Sorry for the delay - I was on a business trip.

On Mon, Jan 14, 2019 at 06:24:10PM -0600, Bjorn Helgaas wrote:
> On Mon, Jan 07, 2019 at 05:39:59PM +0300, Mika Westerberg wrote:
> > Commit 0e157e528604 ("PCI/PME: Implement runtime PM callbacks") tried to
> > solve an issue where the hierarchy immediately wakes up when it is
> > transitioned into D3cold. It turns out preventing PME propagation in
> > some PCIe hierarchies not supporting D3cold.
> 
> I can't quite parse this last sentence.  Is it missing a word?

No, but I'm not native speaker :)

> > I looked more closely what might cause the immediate wakeup. It happens
> > when the ACPI power resource of the root port is turned off. The AML
> > code associated with the _OFF() method of the ACPI power resource
> > executes PCIe L2/3 ready transition and waits it to complete.
> 
> waits *for* it ...


OK.

> > Right
> > after the L2/3 ready transition is started the root port receives PME
> > from the downstream port.
> > 
> > The simplest hierarchy where this happens looks like this:
> > 
> >   00:1d.0 PCIe Root port
> >     ^
> >     |
> >     v
> >     05:00.0 PCIe switch #1 upstream port
> >       06:01.0 PCIe switch #1 downstream hotplug port
> >         ^
> >         |
> >         v
> >         08:00.0 Pcie switch #2 upstream port
> > 
> > It seems that the PCIe link between the two switches, before
> > PME_Turn_Off/PME_TO_Ack is complete for the whole hierarchy, goes
> > inactive and triggers PME towards the root port bringing it back to D0.
> > Disabling Data Link Layer State Changed event (DLLSCE) prevents the
> > issue and still allows the downstream hotplug port to notice when a
> > device is plugged/unplugged.
> 
> I don't understand the "link goes inactive and triggers PME" part.  Is
> that prescribed by the spec, or is this implementation-specific
> behavior, or even a bug?

It is not directly described in the spec (unfortunately). In general
they leave a lot for the reader to interpret instead of explaining how
the thing is supposed to be programmed in different situations :(

This is the behavior I see when the hierarchy goes into D3cold. I don't
have any equipment that would let me see what exactly happens there. The
above is my guess of what happens.

> Are there spec references that would be useful here?  PCIe r4.0, sec
> 5.2 seems like one starting point.  5.3.1.4.2?  5.3.3.2.1 and
> following sections seem like they should be very relevant, but I
> haven't studied it in detail.

Sure, I can add those references to the changelog.

> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=202103
> > Fixes: 0e157e528604 ("PCI/PME: Implement runtime PM callbacks")
> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > ---
> >  drivers/pci/hotplug/pciehp_hpc.c | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
> > index cd9eae650aa5..6fdaa8d48ebe 100644
> > --- a/drivers/pci/hotplug/pciehp_hpc.c
> > +++ b/drivers/pci/hotplug/pciehp_hpc.c
> > @@ -736,12 +736,18 @@ void pcie_clear_hotplug_events(struct controller *ctrl)
> >  
> >  void pcie_enable_interrupt(struct controller *ctrl)
> >  {
> > -	pcie_write_cmd(ctrl, PCI_EXP_SLTCTL_HPIE, PCI_EXP_SLTCTL_HPIE);
> > +	u16 mask;
> > +
> > +	mask = PCI_EXP_SLTCTL_HPIE | PCI_EXP_SLTCTL_DLLSCE;
> > +	pcie_write_cmd(ctrl, mask, mask);
> >  }
> >  
> >  void pcie_disable_interrupt(struct controller *ctrl)
> >  {
> > -	pcie_write_cmd(ctrl, 0, PCI_EXP_SLTCTL_HPIE);
> > +	u16 mask;
> > +
> 
> I think some sort of comment here would be useful.  It's pretty hard
> for the casual reader to figure out what things need to be masked.

Sure, I'll add a comment.

> > +	mask = PCI_EXP_SLTCTL_HPIE | PCI_EXP_SLTCTL_DLLSCE;
> > +	pcie_write_cmd(ctrl, 0, mask);
> >  }
> >  
> >  /*
> > -- 
> > 2.19.2
> > 
