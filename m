Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:54951 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751665Ab3KOPM6 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 15 Nov 2013 10:12:58 -0500
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: Fix whitespace, capitalization, and spelling errors
Date: Fri, 15 Nov 2013 16:25:31 +0100
Message-ID: <10501061.Rz588Hzp2k@vostro.rjw.lan>
In-Reply-To: <20131114223602.GA9315@google.com>
References: <20131114223602.GA9315@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday, November 14, 2013 03:36:02 PM Bjorn Helgaas wrote:
> I posted an earlier version of this a while ago[1], but decided to wait
> until the v3.13 merge window to reduce conflicts.  Unless there's
> objection, I plan to ask Linus to pull this before v3.13-rc1.
> 
> It makes no functional changes at all; it's only spelling, capitalization,
> and whitespace fixes (space-before-tab, whitespace-at-end-of-line, etc.)
> 
> Bjorn
> 
> [1] http://lkml.kernel.org/r/20130925174215.GA26273@google.com
> 
> 
> 
> PCI: Fix whitespace, capitalization, and spelling errors
> 
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Fix whitespace, capitalization, and spelling errors.  No functional change.
> I know "busses" is not an error, but "buses" was more common, so I used it
> consistently.
> 
> Signed-off-by: Marta Rybczynska <rybczynska@gmail.com> (pci_reset_bridge_secondary_bus())
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
