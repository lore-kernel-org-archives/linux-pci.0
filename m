Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f175.google.com ([209.85.213.175]:38514 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932306AbaGIPdO (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 9 Jul 2014 11:33:14 -0400
Received: by mail-ig0-f175.google.com with SMTP id h3so1998150igd.8
        for <linux-pci@vger.kernel.org>; Wed, 09 Jul 2014 08:33:13 -0700 (PDT)
Received: from localhost ([172.16.48.225])
        by mx.google.com with ESMTPSA id v6sm16322477igz.21.2014.07.09.08.33.12
        for <linux-pci@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 09 Jul 2014 08:33:13 -0700 (PDT)
Subject: [PATCH 0/3] Minor resource assignment cleanups
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 09 Jul 2014 09:33:12 -0600
Message-ID: <20140709153252.1004.86246.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

These are minor, mostly cosmetic changes, although they do make
a few changes to the messages printed by resource assignment.  I'm
planning these for v3.17.

---

Bjorn Helgaas (3):
      PCI: Cleanup control flow
      PCI: Return conventional error values from pci_revert_fw_address()
      PCI: Tidy resource assignment messages


 drivers/pci/setup-res.c |   69 ++++++++++++++++++++---------------------------
 1 file changed, 30 insertions(+), 39 deletions(-)
