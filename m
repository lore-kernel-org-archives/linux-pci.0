Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from Chamillionaire.breakpoint.cc ([80.244.247.6]:47050 "EHLO
	Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754356Ab2FCT0x (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 3 Jun 2012 15:26:53 -0400
From: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
To: linux-pci@vger.kernel.org
Cc: linux-kbuild@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Michal Marek <mmarek@suse.cz>
Subject: Annotate PCI fixups with __devinit instead of __init
Date: Sun,  3 Jun 2012 20:48:16 +0200
Message-Id: <1338749305-22558-1-git-send-email-sebastian@breakpoint.cc>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch series adds a section missmatch check to modpost which will
splat a warning if a PCI fixup routine (declared via
DECLARE_PCI_FIXUP_HEADER for instance) is defined in __init. Even if the
platform does not support hot-plug, one could remove the PCI bus during
run time (soft remove, now HW touching involved) and rediscover it again.
The rediscover process will call the PCI-fixups again.
This is patch #1. After posting it Bjorn ask for fixing the noisy warnings
and this is done by patch #2 to #9.


Sebastian
