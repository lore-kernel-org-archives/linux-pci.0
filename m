Return-Path: <SRS0=Emu/=SZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC63BC10F03
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 16:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 841D520645
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 16:39:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p7Yjj+rO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729546AbfDWQis (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 23 Apr 2019 12:38:48 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45017 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729310AbfDWQir (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Apr 2019 12:38:47 -0400
Received: by mail-pf1-f195.google.com with SMTP id y13so7758716pfm.11;
        Tue, 23 Apr 2019 09:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ao1k2Uh8U/LRDASbEEQCfw1kgyOffPMSmdg/Hjoj9fg=;
        b=p7Yjj+rOXVZGFWvMUaVBew0BcKpKYzGxWGxAjoMNQchM4vBSSDw0vnGvsNPJirEyiL
         n5NbfqUb1RHTlUYN7aNfVAvu8HVoayJaH73W71SNPRGB/Ukv3tEKp86Znk7nmNGSilS4
         F3biF+V/vfvt89RhOGk8Idar006gMT+0lLhnKFZ7k/u7JZSpL1DEq1dJZBDCBCIhZ6iq
         DjPP+6C7E+6X6dFNPVS9v6dStjwduRZuU20qBMTH8spbk/5qo26idQmGBV62ntVPqL3m
         Hr4J7tzztWwD6M31l5RVMUwUH5QHCBiqaTgXuWs/7UcVgIfBkZwHS+g9U9ZB2k5VV5UI
         YXZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ao1k2Uh8U/LRDASbEEQCfw1kgyOffPMSmdg/Hjoj9fg=;
        b=cpL+YnYfYWa1rCzhDWvjfkFluhZ1akMjwD+ws6qaJ910qcZMQqwbhCSY7CzdmpaRqg
         wyZjlQdK5dQULgeUimR+Lpo/Wo0lyjDqkoRZtxcv+W7ajIZFx7owQ5relxaXNtXXS9y8
         Fi1YI+SH0vyBRLTKmmANstf5rw4s9xa5s1R5pJK2PS1pApHf3xSr9sw5nO6RM1nnzCye
         Sdv8P+Yc0TQh/aBDJvEpn3m1Zy0pmB50/ncuSHfqXcp5ziZf0s5K8gwVqAcNKtj/3fXW
         KJfLu3pPhec14LqnsHPGKSOpy0ZGR+pRtsIbrBixGksoF22aF6bQYB3i33YjCQGzHvcV
         Wheg==
X-Gm-Message-State: APjAAAXnM7zoYmrYpi0IrTKCwf8BTndT3uY94qL9WvB0GZjQwSpyMw2O
        H5nOqIuVHUTWL7UQXgsfWP8=
X-Google-Smtp-Source: APXvYqwQKECWplBd06QikSOEoBIjyKNxrFMfDtXDax+6IVYtQkG78RIWG7Sym4OfvZvjqbcyGWsdZg==
X-Received: by 2002:aa7:8ac8:: with SMTP id b8mr27568786pfd.234.1556037526611;
        Tue, 23 Apr 2019 09:38:46 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id v1sm24364801pff.81.2019.04.23.09.38.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 09:38:45 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, rjw@rjwysocki.net,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        x86@kernel.org, fenghua.yu@intel.com,
        linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
        linux-gpio@vger.kernel.org, mchehab+samsung@kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v4 56/63] Documentation: x86: convert i386/IO-APIC.txt to reST
Date:   Wed, 24 Apr 2019 00:29:25 +0800
Message-Id: <20190423162932.21428-57-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190423162932.21428-1-changbin.du@gmail.com>
References: <20190423162932.21428-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This converts the plain text documentation to reStructuredText format and
add it to Sphinx TOC tree. No essential content change.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 .../x86/i386/{IO-APIC.txt => IO-APIC.rst}     | 26 ++++++++++++-------
 Documentation/x86/i386/index.rst              | 10 +++++++
 Documentation/x86/index.rst                   |  1 +
 3 files changed, 27 insertions(+), 10 deletions(-)
 rename Documentation/x86/i386/{IO-APIC.txt => IO-APIC.rst} (93%)
 create mode 100644 Documentation/x86/i386/index.rst

diff --git a/Documentation/x86/i386/IO-APIC.txt b/Documentation/x86/i386/IO-APIC.rst
similarity index 93%
rename from Documentation/x86/i386/IO-APIC.txt
rename to Documentation/x86/i386/IO-APIC.rst
index 15f5baf7e1b6..aec98f742763 100644
--- a/Documentation/x86/i386/IO-APIC.txt
+++ b/Documentation/x86/i386/IO-APIC.rst
@@ -1,3 +1,11 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=======
+IO-APIC
+=======
+
+:Author: Ingo Molnar <mingo@kernel.org>
+
 Most (all) Intel-MP compliant SMP boards have the so-called 'IO-APIC',
 which is an enhanced interrupt controller. It enables us to route
 hardware interrupts to multiple CPUs, or to CPU groups. Without an
@@ -13,7 +21,7 @@ usually worked around by the kernel. If your MP-compliant SMP board does
 not boot Linux, then consult the linux-smp mailing list archives first.
 
 If your box boots fine with enabled IO-APIC IRQs, then your
-/proc/interrupts will look like this one:
+/proc/interrupts will look like this one::
 
    ---------------------------->
   hell:~> cat /proc/interrupts
@@ -37,14 +45,14 @@ none of those IRQ sources is performance-critical.
 In the unlikely case that your board does not create a working mp-table,
 you can use the pirq= boot parameter to 'hand-construct' IRQ entries. This
 is non-trivial though and cannot be automated. One sample /etc/lilo.conf
-entry:
+entry::
 
 	append="pirq=15,11,10"
 
 The actual numbers depend on your system, on your PCI cards and on their
 PCI slot position. Usually PCI slots are 'daisy chained' before they are
 connected to the PCI chipset IRQ routing facility (the incoming PIRQ1-4
-lines):
+lines)::
 
                ,-.        ,-.        ,-.        ,-.        ,-.
      PIRQ4 ----| |-.    ,-| |-.    ,-| |-.    ,-| |--------| |
@@ -56,7 +64,7 @@ lines):
      PIRQ1 ----| |-  `----| |-  `----| |-  `----| |--------| |
                `-'        `-'        `-'        `-'        `-'
 
-Every PCI card emits a PCI IRQ, which can be INTA, INTB, INTC or INTD:
+Every PCI card emits a PCI IRQ, which can be INTA, INTB, INTC or INTD::
 
                                ,-.
                          INTD--| |
@@ -78,19 +86,19 @@ to have non shared interrupts). Slot5 should be used for videocards, they
 do not use interrupts normally, thus they are not daisy chained either.
 
 so if you have your SCSI card (IRQ11) in Slot1, Tulip card (IRQ9) in
-Slot2, then you'll have to specify this pirq= line:
+Slot2, then you'll have to specify this pirq= line::
 
 	append="pirq=11,9"
 
 the following script tries to figure out such a default pirq= line from
-your PCI configuration:
+your PCI configuration::
 
 	echo -n pirq=; echo `scanpci | grep T_L | cut -c56-` | sed 's/ /,/g'
 
 note that this script won't work if you have skipped a few slots or if your
 board does not do default daisy-chaining. (or the IO-APIC has the PIRQ pins
 connected in some strange way). E.g. if in the above case you have your SCSI
-card (IRQ11) in Slot3, and have Slot1 empty:
+card (IRQ11) in Slot3, and have Slot1 empty::
 
 	append="pirq=0,9,11"
 
@@ -105,7 +113,7 @@ won't function properly (e.g. if it's inserted as a module).
 If you have 2 PCI buses, then you can use up to 8 pirq values, although such
 boards tend to have a good configuration.
 
-Be prepared that it might happen that you need some strange pirq line:
+Be prepared that it might happen that you need some strange pirq line::
 
 	append="pirq=0,0,0,0,0,0,9,11"
 
@@ -115,5 +123,3 @@ Good luck and mail to linux-smp@vger.kernel.org or
 linux-kernel@vger.kernel.org if you have any problems that are not covered
 by this document.
 
--- mingo
-
diff --git a/Documentation/x86/i386/index.rst b/Documentation/x86/i386/index.rst
new file mode 100644
index 000000000000..8747cf5bbd49
--- /dev/null
+++ b/Documentation/x86/i386/index.rst
@@ -0,0 +1,10 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+============
+i386 Support
+============
+
+.. toctree::
+   :maxdepth: 2
+
+   IO-APIC
diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
index 526f7a008b8e..19323c5b89ce 100644
--- a/Documentation/x86/index.rst
+++ b/Documentation/x86/index.rst
@@ -26,3 +26,4 @@ Linux x86 Support
    microcode
    resctrl_ui
    usb-legacy-support
+   i386/index
-- 
2.20.1

