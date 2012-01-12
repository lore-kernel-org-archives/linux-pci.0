Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ee0-f74.google.com ([74.125.83.74]:63308 "EHLO
	mail-ee0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750970Ab2ALPBh (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 12 Jan 2012 10:01:37 -0500
Received: by eekd41 with SMTP id d41so68710eek.1
        for <linux-pci@vger.kernel.org>; Thu, 12 Jan 2012 07:01:36 -0800 (PST)
Subject: [PATCH] fix amd_get_mmconfig_range link error
To: Linus Torvalds <torvalds@linux-foundation.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>,
	Eric Dumazet <eric.dumazet@gmail.com>,
	linux-kernel@vger.kernel.org
Date: Thu, 12 Jan 2012 08:01:34 -0700
Message-ID: <20120112145935.12223.39035.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This fixes a link error in current upstream when:

    CONFIG_PCI=y
    # CONFIG_AMD_NB not set

 LD      .tmp_vmlinux1
 arch/x86/pci/built-in.o: In function `early_fill_mp_bus_info':
 /opt/src/linux/arch/x86/pci/amd_bus.c:189: undefined reference to
 `amd_get_mmconfig_range'
 make: *** [.tmp_vmlinux1] Error 1

---

Bjorn Helgaas (1):
      x86/PCI: build amd_bus.o only when CONFIG_AMD_NB=y


 arch/x86/pci/Makefile |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

-- 
Bjorn
