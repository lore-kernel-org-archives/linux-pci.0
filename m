Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:38028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750874AbdARW4K (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 18 Jan 2017 17:56:10 -0500
Date: Wed, 18 Jan 2017 16:53:32 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: How to improve PCI bug tracking?
Message-ID: <20170118225332.GA22960@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

I want to improve PCI bug tracking.  It feels like our bugs don't get
the attention they need, and I'm soliciting ideas for how to improve
this.

Current situation:

  - People often report bugs via email to linux-pci.  I think this
    is good because everybody can see it.

  - Even after an email report, I often request a bugzilla because
    (1) it helps keep things from being forgotten, (2) it's a
    convenient place to store bulky data, and (3) I like to have a
    bugzilla URL to include in the changelog of a patch that fixes the
    bug.

  - Sometimes people open a bugzilla directly.  I get email about
    these (along with one or two other people), but this is sort of a
    problem because linux-pci never sees it, sometimes I miss it, and
    things tend to languish.

  - Discussion on a bugzilla is only seen by people listed in the
    bugzilla, not on linux-pci.

I'm contemplating changing this so the bugzilla mail would also go to
linux-pci.

Any objections or alternate suggestions?

Bjorn
