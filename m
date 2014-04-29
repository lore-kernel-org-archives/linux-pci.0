Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f174.google.com ([209.85.213.174]:43069 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752127AbaD2Xz1 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 29 Apr 2014 19:55:27 -0400
Received: by mail-ig0-f174.google.com with SMTP id h18so6809441igc.7
        for <linux-pci@vger.kernel.org>; Tue, 29 Apr 2014 16:55:27 -0700 (PDT)
Subject: [PATCH v2 0/2] x86/gart: message tidy-up
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: David Airlie <airlied@linux.ie>, x86@kernel.org,
	Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
Date: Tue, 29 Apr 2014 17:55:25 -0600
Message-ID: <20140429235015.11112.79459.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

v2 of the patch I posted at [1].  I split this into two:

  1) Add pr_fmt() and convert to pr_info(), etc.
  2) Use more PCI-like device IDs, print ranges in %pR style, make more
     consistent.

Still no functional change except to messages.  I'd be glad to move
arch/x86/kernel/aperture_64.c to arch/x86/pci if desired; I didn't here
because it looks like several other files could also be moved, and I don't
know how far to go.

Bjorn

[1] http://lkml.kernel.org/r/20140425171655.312.97511.stgit@bhelgaas-glaptop.roam.corp.google.com

---

Bjorn Helgaas (2):
      x86/gart: Replace printk() with pr_info()
      x86/gart: Tidy messages and add bridge device info


 arch/x86/kernel/aperture_64.c |   59 ++++++++++++++++++++++-------------------
 1 file changed, 31 insertions(+), 28 deletions(-)
