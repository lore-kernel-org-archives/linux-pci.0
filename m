Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:40683 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751176AbbCKXMg (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 11 Mar 2015 19:12:36 -0400
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: rientjes@google.com, bhelgaas@google.com, mingo@redhat.com,
	tglx@linutronix.de, hpa@zytor.com, pure.logic@nexus-software.ie,
	jgross@suse.com, luto@amacapital.net, andy.shevchenko@gmail.com,
	thomas.petazzoni@free-electrons.com, JBeulich@suse.com, bp@suse.de
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	x86@kernel.org, "Luis R. Rodriguez" <mcgrof@suse.com>
Subject: [PATCH v1 0/2] x86: simplify UP APIC conditions
Date: Wed, 11 Mar 2015 16:10:20 -0700
Message-Id: <1426115422-1823-1-git-send-email-mcgrof@do-not-panic.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@suse.com>

There is no need for UP APIC Kconfig entries given x86 is not
in a state of flux for 32-bit and the options really don't
have major impact on kernel size or performance. Things can
also be expressed very clearly in a more simplified way, doing
that also removes all the UP APIC kconfig clutter.

Luis R. Rodriguez (2):
  x86: kconfig: remove X86_UP_IOAPIC
  x86: kconfig: remove X86_UP_APIC

 arch/x86/Kconfig    | 30 ++----------------------------
 drivers/pci/Kconfig |  2 ++
 2 files changed, 4 insertions(+), 28 deletions(-)

-- 
2.3.2.209.gd67f9d5.dirty

