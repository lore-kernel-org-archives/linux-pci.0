Return-Path: <SRS0=N/Da=QW=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB4FC10F0D
	for <linux-pci@archiver.kernel.org>; Fri, 15 Feb 2019 09:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A1EA222A1
	for <linux-pci@archiver.kernel.org>; Fri, 15 Feb 2019 09:36:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732309AbfBOJg4 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 15 Feb 2019 04:36:56 -0500
Received: from mga06.intel.com ([134.134.136.31]:25769 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728989AbfBOJg4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 15 Feb 2019 04:36:56 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Feb 2019 01:36:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,372,1544515200"; 
   d="scan'208";a="126710299"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by orsmga003.jf.intel.com with SMTP; 15 Feb 2019 01:36:52 -0800
Received: by lahna (sSMTP sendmail emulation); Fri, 15 Feb 2019 11:36:49 +0200
Date:   Fri, 15 Feb 2019 11:36:49 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Lukas Wunner <lukas@wunner.de>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Keith Busch <keith.busch@intel.com>,
        Oza Pawandeep <poza@codeaurora.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] PCI: pciehp: Disable Data Link Layer State
 Changed event on suspend
Message-ID: <20190215093649.GJ2322@lahna.fi.intel.com>
References: <20190131170746.7604-1-mika.westerberg@linux.intel.com>
 <20190131170746.7604-3-mika.westerberg@linux.intel.com>
 <20190214212129.GN96272@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190214212129.GN96272@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Feb 14, 2019 at 03:23:38PM -0600, Bjorn Helgaas wrote:
> On Thu, Jan 31, 2019 at 08:07:46PM +0300, Mika Westerberg wrote:
> > Commit 0e157e528604 ("PCI/PME: Implement runtime PM callbacks") tried to
> > solve an issue where the hierarchy immediately wakes up when it is
> > transitioned into D3cold. However, it turns out to prevent PME
> > propagation on some systems that do not support D3cold.
> > 
> > I looked more closely what might cause the immediate wakeup. It happens
> > when the ACPI power resource of the root port is turned off. The AML
> > code associated with the _OFF() method of the ACPI power resource
> > executes PCIe L2/3 ready transition and waits for it to complete. Right
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
> > The L2/3 ready sequence is described in PCIe r4.0 spec sections 5.2 and
> > 5.3.3 but unfortunately they do not state what happens if DLLSCE is
> > enabled during the sequence.
> 
> The hotplug (and, I guess, the DLLSCE interrupt) and PME interrupts
> are the same INTx wire or MSI vector.  But I guess we know the
> interrupt here must really be a PME because pcie_pme_irq() reads
> PCI_EXP_RTSTA_PME and does nothing unless it is set.
> 
> > Disabling Data Link Layer State Changed event (DLLSCE) seems to prevent
> > the issue and still allows the downstream hotplug port to notice when a
> > device is plugged/unplugged.
> 
> Interesting that Hot-Plug Interrupt Enable by itself doesn't seem to
> gate the DLLSCE notification.  Sec 6.7.3.4 says Hot-Plug Interrupt
> Enable is a master enable/disable bit for "all hot-plug events".  It's
> not completely explicit about what "all hot-plug events" includes, but
> DLLSCE is definitely included in the list in sec 6.7.3.

Indeed the spec is quite vague at places and leaves too much for the
imagination of the reader.

Sec 6.7.3.4 says:

  Software enables a hot-plug event to generate a wakeup event by
  enabling software notification of the event as described in Section
  6.7.3.1. Note that in order for software to disable interrupt
  generation while keeping wakeup generation enabled, the Hot-Plug
  Interrupt Enable bit must be cleared. For form factors that support
  wake generation, a wakeup event must be generated if all
  three of the following conditions occur:
  * The status register for an enabled event transitions from Clearnot
    set to Set
  * The Port is in device state D1, D2, or D3 Hot , and
  * The PME_En bit in the Port’s Power Management Control/Status register is Set

Which to me means that PMEs are generated based on which events are
enabled regardless whether Hot-Plug Interrupt is enabled or not.

> I don't think the bugzilla from Heiner below is actually related to
> *this* patch.  Heiner's system doesn't have the topology above.
> 
> If you have a report for a system where the immediate wakeup happens,
> i.e., something with the topology above, I'd be interested in
> including that report here.  Ideally it would have complete lspci
> info.  I'm just wondering if this is actually a defect in the switch.

I filed a new bugzilla about this here:

  https://bugzilla.kernel.org/show_bug.cgi?id=202593

Let me know if I should re-send with the link corrected.
