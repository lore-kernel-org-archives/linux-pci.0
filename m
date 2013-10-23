Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175]:48323 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754343Ab3JWDYC (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 22 Oct 2013 23:24:02 -0400
Received: by mail-ie0-f175.google.com with SMTP id aq17so360839iec.6
        for <linux-pci@vger.kernel.org>; Tue, 22 Oct 2013 20:24:01 -0700 (PDT)
Subject: [PATCH 0/2] Remove pcibios_last_bus stuff
To: David Howells <dhowells@redhat.com>,
	Koichi Yasutake <yasutake.koichi@jp.panasonic.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-am33-list@redhat.com,
	linux-kernel@vger.kernel.org
Date: Tue, 22 Oct 2013 21:23:59 -0600
Message-ID: <20131023032140.12410.43295.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

pcibios_last_bus is an x86 thing that has gotten copied into mn10300
and FR-V.  On mn10300, it is clearly useless because it is set but
never tested.

On FR-V, I suspect it is also useless, but it is possible that people
boot with "pci=lastbus=<X>".  Please speak up if you think it should
be kept for FR-V.

---

Bjorn Helgaas (2):
      frv/PCI: Remove pcibios_last_bus
      mn10300/PCI: Remove useless pcibios_last_bus


 arch/frv/mb93090-mb00/pci-frv.h         |    1 -
 arch/frv/mb93090-mb00/pci-vdk.c         |   36 -------------------------------
 arch/mn10300/unit-asb2305/pci-asb2305.h |    1 -
 arch/mn10300/unit-asb2305/pci.c         |    5 ----
 4 files changed, 43 deletions(-)
