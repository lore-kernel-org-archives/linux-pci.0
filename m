Return-Path: <SRS0=Emu/=SZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EF49C282E1
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 16:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD2FD20643
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 16:38:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fI6JEaem"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729380AbfDWQiB (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 23 Apr 2019 12:38:01 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40479 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728889AbfDWQiA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Apr 2019 12:38:00 -0400
Received: by mail-pg1-f196.google.com with SMTP id d31so7880222pgl.7;
        Tue, 23 Apr 2019 09:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ibJmWHZz3X2WekAbnY9S5JjGiPv0VrFcXgtAoPvurw8=;
        b=fI6JEaemj1Ly5xYzLkNLX4ExOcGoVmFY4FHSe1692rivdVS04Rsh55ryDWBHjzpmqw
         NykbTYb5wKnwlEE3rW3/GrcACqYgouhEaAbtrR46jzIC4nmpg4NH650bf3UhlebGtX1Q
         D4QS3roDHhkjGoAIXBopyzxp8b3a75v8LVGBJUQtdwQzin1Pi4gER0mt0P00FVKTM4b3
         jyvkjT2JVRbILcvCQ3hv5kFP1ExpjD7hoTXXzoMDhhcccNIPOdytFSbZQ+7s8TPmZ/br
         041sFkqvGqGXKgFMatIvER0KWFrfZsK4gWyAJUS9xsgWmjAKX1FYo/RyogAuaNuuTShi
         u0FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ibJmWHZz3X2WekAbnY9S5JjGiPv0VrFcXgtAoPvurw8=;
        b=KJt1dTyFya3G7p4kGsQ/CN5McpULtR090TZCTtFolR47SnXtootF00gUiPQxUKx29z
         3UOc//IE2JjsqIUoaW3kVPOuxMzMfqZkwOCwX5aACXvLPK63Idn6jNQlMbw/GSDTk98b
         HxdoDDpYquCK1XQounEvYls6TMZtl9l+FPu2S0OfSN0KRmsXc/BOxmcptvZZNqNm6OaA
         bVRq+zo8ah8xQA577t+ChDwhSAPbmDH9plVbNYAv2uY+iYCZvljOkvE7b6H9+fQld6xU
         NfSjNI5aPisLls7Qiwh5dfnGngRnqVdvb9nh8sxAnSy4UFOQa+J2GBQ9+cvfUaCX+OtR
         LLuA==
X-Gm-Message-State: APjAAAVSR/UHbLjqT6PniPze3aefkNhOusSrRTgmU/pElrYmg8NJcoNo
        dMliekTvrSMGnyqBuq1ALFs=
X-Google-Smtp-Source: APXvYqzt9p/nQdh14eanLDHYnwwRmjTTgRQvPSE194CIBEflf+rS+yB29JSfBgYj8ywve9F9E/Hb6Q==
X-Received: by 2002:a63:c706:: with SMTP id n6mr25600945pgg.310.1556037478941;
        Tue, 23 Apr 2019 09:37:58 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id v1sm24364801pff.81.2019.04.23.09.37.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 09:37:58 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, rjw@rjwysocki.net,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        x86@kernel.org, fenghua.yu@intel.com,
        linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
        linux-gpio@vger.kernel.org, mchehab+samsung@kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v4 47/63] Documentation: x86: convert pat.txt to reST
Date:   Wed, 24 Apr 2019 00:29:16 +0800
Message-Id: <20190423162932.21428-48-changbin.du@gmail.com>
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
 Documentation/x86/index.rst |   1 +
 Documentation/x86/pat.rst   | 235 ++++++++++++++++++++++++++++++++++++
 Documentation/x86/pat.txt   | 230 -----------------------------------
 3 files changed, 236 insertions(+), 230 deletions(-)
 create mode 100644 Documentation/x86/pat.rst
 delete mode 100644 Documentation/x86/pat.txt

diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
index d805962a7238..e06b5c0ea883 100644
--- a/Documentation/x86/index.rst
+++ b/Documentation/x86/index.rst
@@ -17,3 +17,4 @@ Linux x86 Support
    zero-page
    tlb
    mtrr
+   pat
diff --git a/Documentation/x86/pat.rst b/Documentation/x86/pat.rst
new file mode 100644
index 000000000000..bf09cab2e0bf
--- /dev/null
+++ b/Documentation/x86/pat.rst
@@ -0,0 +1,235 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==========================
+PAT (Page Attribute Table)
+==========================
+
+x86 Page Attribute Table (PAT) allows for setting the memory attribute at the
+page level granularity. PAT is complementary to the MTRR settings which allows
+for setting of memory types over physical address ranges. However, PAT is
+more flexible than MTRR due to its capability to set attributes at page level
+and also due to the fact that there are no hardware limitations on number of
+such attribute settings allowed. Added flexibility comes with guidelines for
+not having memory type aliasing for the same physical memory with multiple
+virtual addresses.
+
+PAT allows for different types of memory attributes. The most commonly used
+ones that will be supported at this time are Write-back, Uncached,
+Write-combined, Write-through and Uncached Minus.
+
+
+PAT APIs
+========
+
+There are many different APIs in the kernel that allows setting of memory
+attributes at the page level. In order to avoid aliasing, these interfaces
+should be used thoughtfully. Below is a table of interfaces available,
+their intended usage and their memory attribute relationships. Internally,
+these APIs use a reserve_memtype()/free_memtype() interface on the physical
+address range to avoid any aliasing.
+::
+
+  -------------------------------------------------------------------
+  API                    |    RAM   |  ACPI,...  |  Reserved/Holes  |
+  -----------------------|----------|------------|------------------|
+                         |          |            |                  |
+  ioremap                |    --    |    UC-     |       UC-        |
+                         |          |            |                  |
+  ioremap_cache          |    --    |    WB      |       WB         |
+                         |          |            |                  |
+  ioremap_uc             |    --    |    UC      |       UC         |
+                         |          |            |                  |
+  ioremap_nocache        |    --    |    UC-     |       UC-        |
+                         |          |            |                  |
+  ioremap_wc             |    --    |    --      |       WC         |
+                         |          |            |                  |
+  ioremap_wt             |    --    |    --      |       WT         |
+                         |          |            |                  |
+  set_memory_uc          |    UC-   |    --      |       --         |
+  set_memory_wb          |          |            |                  |
+                         |          |            |                  |
+  set_memory_wc          |    WC    |    --      |       --         |
+  set_memory_wb          |          |            |                  |
+                         |          |            |                  |
+  set_memory_wt          |    WT    |    --      |       --         |
+  set_memory_wb          |          |            |                  |
+                         |          |            |                  |
+  pci sysfs resource     |    --    |    --      |       UC-        |
+                         |          |            |                  |
+  pci sysfs resource_wc  |    --    |    --      |       WC         |
+  is IORESOURCE_PREFETCH |          |            |                  |
+                         |          |            |                  |
+  pci proc               |    --    |    --      |       UC-        |
+  !PCIIOC_WRITE_COMBINE  |          |            |                  |
+                         |          |            |                  |
+  pci proc               |    --    |    --      |       WC         |
+  PCIIOC_WRITE_COMBINE   |          |            |                  |
+                         |          |            |                  |
+  /dev/mem               |    --    |  WB/WC/UC- |    WB/WC/UC-     |
+  read-write             |          |            |                  |
+                         |          |            |                  |
+  /dev/mem               |    --    |    UC-     |       UC-        |
+  mmap SYNC flag         |          |            |                  |
+                         |          |            |                  |
+  /dev/mem               |    --    |  WB/WC/UC- |    WB/WC/UC-     |
+  mmap !SYNC flag        |          |(from exist-|  (from exist-    |
+  and                    |          |  ing alias)|    ing alias)    |
+  any alias to this area |          |            |                  |
+                         |          |            |                  |
+  /dev/mem               |    --    |    WB      |       WB         |
+  mmap !SYNC flag        |          |            |                  |
+  no alias to this area  |          |            |                  |
+  and                    |          |            |                  |
+  MTRR says WB           |          |            |                  |
+                         |          |            |                  |
+  /dev/mem               |    --    |    --      |       UC-        |
+  mmap !SYNC flag        |          |            |                  |
+  no alias to this area  |          |            |                  |
+  and                    |          |            |                  |
+  MTRR says !WB          |          |            |                  |
+                         |          |            |                  |
+  -------------------------------------------------------------------
+
+Advanced APIs for drivers
+=========================
+
+A. Exporting pages to users with remap_pfn_range, io_remap_pfn_range,
+vmf_insert_pfn.
+
+Drivers wanting to export some pages to userspace do it by using mmap
+interface and a combination of:
+
+  1) pgprot_noncached()
+  2) io_remap_pfn_range() or remap_pfn_range() or vmf_insert_pfn()
+
+With PAT support, a new API pgprot_writecombine is being added. So, drivers can
+continue to use the above sequence, with either pgprot_noncached() or
+pgprot_writecombine() in step 1, followed by step 2.
+
+In addition, step 2 internally tracks the region as UC or WC in memtype
+list in order to ensure no conflicting mapping.
+
+Note that this set of APIs only works with IO (non RAM) regions. If driver
+wants to export a RAM region, it has to do set_memory_uc() or set_memory_wc()
+as step 0 above and also track the usage of those pages and use set_memory_wb()
+before the page is freed to free pool.
+
+MTRR effects on PAT / non-PAT systems
+=====================================
+
+The following table provides the effects of using write-combining MTRRs when
+using ioremap*() calls on x86 for both non-PAT and PAT systems. Ideally
+mtrr_add() usage will be phased out in favor of arch_phys_wc_add() which will
+be a no-op on PAT enabled systems. The region over which a arch_phys_wc_add()
+is made, should already have been ioremapped with WC attributes or PAT entries,
+this can be done by using ioremap_wc() / set_memory_wc().  Devices which
+combine areas of IO memory desired to remain uncacheable with areas where
+write-combining is desirable should consider use of ioremap_uc() followed by
+set_memory_wc() to white-list effective write-combined areas.  Such use is
+nevertheless discouraged as the effective memory type is considered
+implementation defined, yet this strategy can be used as last resort on devices
+with size-constrained regions where otherwise MTRR write-combining would
+otherwise not be effective.
+::
+
+  ----------------------------------------------------------------------
+  MTRR Non-PAT   PAT    Linux ioremap value        Effective memory type
+  ----------------------------------------------------------------------
+                                                    Non-PAT |  PAT
+       PAT
+       |PCD
+       ||PWT
+       |||
+  WC   000      WB      _PAGE_CACHE_MODE_WB            WC   |   WC
+  WC   001      WC      _PAGE_CACHE_MODE_WC            WC*  |   WC
+  WC   010      UC-     _PAGE_CACHE_MODE_UC_MINUS      WC*  |   UC
+  WC   011      UC      _PAGE_CACHE_MODE_UC            UC   |   UC
+  ----------------------------------------------------------------------
+
+(*) denotes implementation defined and is discouraged
+
+.. note:: -- in the above table mean "Not suggested usage for the API". Some
+  of the --'s are strictly enforced by the kernel. Some others are not really
+  enforced today, but may be enforced in future.
+
+For ioremap and pci access through /sys or /proc - The actual type returned
+can be more restrictive, in case of any existing aliasing for that address.
+For example: If there is an existing uncached mapping, a new ioremap_wc can
+return uncached mapping in place of write-combine requested.
+
+set_memory_[uc|wc|wt] and set_memory_wb should be used in pairs, where driver
+will first make a region uc, wc or wt and switch it back to wb after use.
+
+Over time writes to /proc/mtrr will be deprecated in favor of using PAT based
+interfaces. Users writing to /proc/mtrr are suggested to use above interfaces.
+
+Drivers should use ioremap_[uc|wc] to access PCI BARs with [uc|wc] access
+types.
+
+Drivers should use set_memory_[uc|wc|wt] to set access type for RAM ranges.
+
+
+PAT debugging
+=============
+
+With CONFIG_DEBUG_FS enabled, PAT memtype list can be examined by::
+
+  # mount -t debugfs debugfs /sys/kernel/debug
+  # cat /sys/kernel/debug/x86/pat_memtype_list
+  PAT memtype list:
+  uncached-minus @ 0x7fadf000-0x7fae0000
+  uncached-minus @ 0x7fb19000-0x7fb1a000
+  uncached-minus @ 0x7fb1a000-0x7fb1b000
+  uncached-minus @ 0x7fb1b000-0x7fb1c000
+  uncached-minus @ 0x7fb1c000-0x7fb1d000
+  uncached-minus @ 0x7fb1d000-0x7fb1e000
+  uncached-minus @ 0x7fb1e000-0x7fb25000
+  uncached-minus @ 0x7fb25000-0x7fb26000
+  uncached-minus @ 0x7fb26000-0x7fb27000
+  uncached-minus @ 0x7fb27000-0x7fb28000
+  uncached-minus @ 0x7fb28000-0x7fb2e000
+  uncached-minus @ 0x7fb2e000-0x7fb2f000
+  uncached-minus @ 0x7fb2f000-0x7fb30000
+  uncached-minus @ 0x7fb31000-0x7fb32000
+  uncached-minus @ 0x80000000-0x90000000
+
+This list shows physical address ranges and various PAT settings used to
+access those physical address ranges.
+
+Another, more verbose way of getting PAT related debug messages is with
+"debugpat" boot parameter. With this parameter, various debug messages are
+printed to dmesg log.
+
+PAT Initialization
+==================
+
+The following table describes how PAT is initialized under various
+configurations. The PAT MSR must be updated by Linux in order to support WC
+and WT attributes. Otherwise, the PAT MSR has the value programmed in it
+by the firmware. Note, Xen enables WC attribute in the PAT MSR for guests.
+::
+
+  MTRR PAT   Call Sequence               PAT State  PAT MSR
+  =========================================================
+  E    E     MTRR -> PAT init            Enabled    OS
+  E    D     MTRR -> PAT init            Disabled    -
+  D    E     MTRR -> PAT disable         Disabled   BIOS
+  D    D     MTRR -> PAT disable         Disabled    -
+  -    np/E  PAT  -> PAT disable         Disabled   BIOS
+  -    np/D  PAT  -> PAT disable         Disabled    -
+  E    !P/E  MTRR -> PAT init            Disabled   BIOS
+  D    !P/E  MTRR -> PAT disable         Disabled   BIOS
+  !M   !P/E  MTRR stub -> PAT disable    Disabled   BIOS
+
+  Legend
+  ------------------------------------------------
+  E         Feature enabled in CPU
+  D	   Feature disabled/unsupported in CPU
+  np	   "nopat" boot option specified
+  !P	   CONFIG_X86_PAT option unset
+  !M	   CONFIG_MTRR option unset
+  Enabled   PAT state set to enabled
+  Disabled  PAT state set to disabled
+  OS        PAT initializes PAT MSR with OS setting
+  BIOS      PAT keeps PAT MSR with BIOS setting
+
diff --git a/Documentation/x86/pat.txt b/Documentation/x86/pat.txt
deleted file mode 100644
index 481d8d8536ac..000000000000
--- a/Documentation/x86/pat.txt
+++ /dev/null
@@ -1,230 +0,0 @@
-
-PAT (Page Attribute Table)
-
-x86 Page Attribute Table (PAT) allows for setting the memory attribute at the
-page level granularity. PAT is complementary to the MTRR settings which allows
-for setting of memory types over physical address ranges. However, PAT is
-more flexible than MTRR due to its capability to set attributes at page level
-and also due to the fact that there are no hardware limitations on number of
-such attribute settings allowed. Added flexibility comes with guidelines for
-not having memory type aliasing for the same physical memory with multiple
-virtual addresses.
-
-PAT allows for different types of memory attributes. The most commonly used
-ones that will be supported at this time are Write-back, Uncached,
-Write-combined, Write-through and Uncached Minus.
-
-
-PAT APIs
---------
-
-There are many different APIs in the kernel that allows setting of memory
-attributes at the page level. In order to avoid aliasing, these interfaces
-should be used thoughtfully. Below is a table of interfaces available,
-their intended usage and their memory attribute relationships. Internally,
-these APIs use a reserve_memtype()/free_memtype() interface on the physical
-address range to avoid any aliasing.
-
-
--------------------------------------------------------------------
-API                    |    RAM   |  ACPI,...  |  Reserved/Holes  |
------------------------|----------|------------|------------------|
-                       |          |            |                  |
-ioremap                |    --    |    UC-     |       UC-        |
-                       |          |            |                  |
-ioremap_cache          |    --    |    WB      |       WB         |
-                       |          |            |                  |
-ioremap_uc             |    --    |    UC      |       UC         |
-                       |          |            |                  |
-ioremap_nocache        |    --    |    UC-     |       UC-        |
-                       |          |            |                  |
-ioremap_wc             |    --    |    --      |       WC         |
-                       |          |            |                  |
-ioremap_wt             |    --    |    --      |       WT         |
-                       |          |            |                  |
-set_memory_uc          |    UC-   |    --      |       --         |
- set_memory_wb         |          |            |                  |
-                       |          |            |                  |
-set_memory_wc          |    WC    |    --      |       --         |
- set_memory_wb         |          |            |                  |
-                       |          |            |                  |
-set_memory_wt          |    WT    |    --      |       --         |
- set_memory_wb         |          |            |                  |
-                       |          |            |                  |
-pci sysfs resource     |    --    |    --      |       UC-        |
-                       |          |            |                  |
-pci sysfs resource_wc  |    --    |    --      |       WC         |
- is IORESOURCE_PREFETCH|          |            |                  |
-                       |          |            |                  |
-pci proc               |    --    |    --      |       UC-        |
- !PCIIOC_WRITE_COMBINE |          |            |                  |
-                       |          |            |                  |
-pci proc               |    --    |    --      |       WC         |
- PCIIOC_WRITE_COMBINE  |          |            |                  |
-                       |          |            |                  |
-/dev/mem               |    --    |  WB/WC/UC- |    WB/WC/UC-     |
- read-write            |          |            |                  |
-                       |          |            |                  |
-/dev/mem               |    --    |    UC-     |       UC-        |
- mmap SYNC flag        |          |            |                  |
-                       |          |            |                  |
-/dev/mem               |    --    |  WB/WC/UC- |    WB/WC/UC-     |
- mmap !SYNC flag       |          |(from exist-|  (from exist-    |
- and                   |          |  ing alias)|    ing alias)    |
- any alias to this area|          |            |                  |
-                       |          |            |                  |
-/dev/mem               |    --    |    WB      |       WB         |
- mmap !SYNC flag       |          |            |                  |
- no alias to this area |          |            |                  |
- and                   |          |            |                  |
- MTRR says WB          |          |            |                  |
-                       |          |            |                  |
-/dev/mem               |    --    |    --      |       UC-        |
- mmap !SYNC flag       |          |            |                  |
- no alias to this area |          |            |                  |
- and                   |          |            |                  |
- MTRR says !WB         |          |            |                  |
-                       |          |            |                  |
--------------------------------------------------------------------
-
-Advanced APIs for drivers
--------------------------
-A. Exporting pages to users with remap_pfn_range, io_remap_pfn_range,
-vmf_insert_pfn
-
-Drivers wanting to export some pages to userspace do it by using mmap
-interface and a combination of
-1) pgprot_noncached()
-2) io_remap_pfn_range() or remap_pfn_range() or vmf_insert_pfn()
-
-With PAT support, a new API pgprot_writecombine is being added. So, drivers can
-continue to use the above sequence, with either pgprot_noncached() or
-pgprot_writecombine() in step 1, followed by step 2.
-
-In addition, step 2 internally tracks the region as UC or WC in memtype
-list in order to ensure no conflicting mapping.
-
-Note that this set of APIs only works with IO (non RAM) regions. If driver
-wants to export a RAM region, it has to do set_memory_uc() or set_memory_wc()
-as step 0 above and also track the usage of those pages and use set_memory_wb()
-before the page is freed to free pool.
-
-MTRR effects on PAT / non-PAT systems
--------------------------------------
-
-The following table provides the effects of using write-combining MTRRs when
-using ioremap*() calls on x86 for both non-PAT and PAT systems. Ideally
-mtrr_add() usage will be phased out in favor of arch_phys_wc_add() which will
-be a no-op on PAT enabled systems. The region over which a arch_phys_wc_add()
-is made, should already have been ioremapped with WC attributes or PAT entries,
-this can be done by using ioremap_wc() / set_memory_wc().  Devices which
-combine areas of IO memory desired to remain uncacheable with areas where
-write-combining is desirable should consider use of ioremap_uc() followed by
-set_memory_wc() to white-list effective write-combined areas.  Such use is
-nevertheless discouraged as the effective memory type is considered
-implementation defined, yet this strategy can be used as last resort on devices
-with size-constrained regions where otherwise MTRR write-combining would
-otherwise not be effective.
-
-----------------------------------------------------------------------
-MTRR Non-PAT   PAT    Linux ioremap value        Effective memory type
-----------------------------------------------------------------------
-                                                  Non-PAT |  PAT
-     PAT
-     |PCD
-     ||PWT
-     |||
-WC   000      WB      _PAGE_CACHE_MODE_WB            WC   |   WC
-WC   001      WC      _PAGE_CACHE_MODE_WC            WC*  |   WC
-WC   010      UC-     _PAGE_CACHE_MODE_UC_MINUS      WC*  |   UC
-WC   011      UC      _PAGE_CACHE_MODE_UC            UC   |   UC
-----------------------------------------------------------------------
-
-(*) denotes implementation defined and is discouraged
-
-Notes:
-
--- in the above table mean "Not suggested usage for the API". Some of the --'s
-are strictly enforced by the kernel. Some others are not really enforced
-today, but may be enforced in future.
-
-For ioremap and pci access through /sys or /proc - The actual type returned
-can be more restrictive, in case of any existing aliasing for that address.
-For example: If there is an existing uncached mapping, a new ioremap_wc can
-return uncached mapping in place of write-combine requested.
-
-set_memory_[uc|wc|wt] and set_memory_wb should be used in pairs, where driver
-will first make a region uc, wc or wt and switch it back to wb after use.
-
-Over time writes to /proc/mtrr will be deprecated in favor of using PAT based
-interfaces. Users writing to /proc/mtrr are suggested to use above interfaces.
-
-Drivers should use ioremap_[uc|wc] to access PCI BARs with [uc|wc] access
-types.
-
-Drivers should use set_memory_[uc|wc|wt] to set access type for RAM ranges.
-
-
-PAT debugging
--------------
-
-With CONFIG_DEBUG_FS enabled, PAT memtype list can be examined by
-
-# mount -t debugfs debugfs /sys/kernel/debug
-# cat /sys/kernel/debug/x86/pat_memtype_list
-PAT memtype list:
-uncached-minus @ 0x7fadf000-0x7fae0000
-uncached-minus @ 0x7fb19000-0x7fb1a000
-uncached-minus @ 0x7fb1a000-0x7fb1b000
-uncached-minus @ 0x7fb1b000-0x7fb1c000
-uncached-minus @ 0x7fb1c000-0x7fb1d000
-uncached-minus @ 0x7fb1d000-0x7fb1e000
-uncached-minus @ 0x7fb1e000-0x7fb25000
-uncached-minus @ 0x7fb25000-0x7fb26000
-uncached-minus @ 0x7fb26000-0x7fb27000
-uncached-minus @ 0x7fb27000-0x7fb28000
-uncached-minus @ 0x7fb28000-0x7fb2e000
-uncached-minus @ 0x7fb2e000-0x7fb2f000
-uncached-minus @ 0x7fb2f000-0x7fb30000
-uncached-minus @ 0x7fb31000-0x7fb32000
-uncached-minus @ 0x80000000-0x90000000
-
-This list shows physical address ranges and various PAT settings used to
-access those physical address ranges.
-
-Another, more verbose way of getting PAT related debug messages is with
-"debugpat" boot parameter. With this parameter, various debug messages are
-printed to dmesg log.
-
-PAT Initialization
-------------------
-
-The following table describes how PAT is initialized under various
-configurations. The PAT MSR must be updated by Linux in order to support WC
-and WT attributes. Otherwise, the PAT MSR has the value programmed in it
-by the firmware. Note, Xen enables WC attribute in the PAT MSR for guests.
-
- MTRR PAT   Call Sequence               PAT State  PAT MSR
- =========================================================
- E    E     MTRR -> PAT init            Enabled    OS
- E    D     MTRR -> PAT init            Disabled    -
- D    E     MTRR -> PAT disable         Disabled   BIOS
- D    D     MTRR -> PAT disable         Disabled    -
- -    np/E  PAT  -> PAT disable         Disabled   BIOS
- -    np/D  PAT  -> PAT disable         Disabled    -
- E    !P/E  MTRR -> PAT init            Disabled   BIOS
- D    !P/E  MTRR -> PAT disable         Disabled   BIOS
- !M   !P/E  MTRR stub -> PAT disable    Disabled   BIOS
-
- Legend
- ------------------------------------------------
- E         Feature enabled in CPU
- D	   Feature disabled/unsupported in CPU
- np	   "nopat" boot option specified
- !P	   CONFIG_X86_PAT option unset
- !M	   CONFIG_MTRR option unset
- Enabled   PAT state set to enabled
- Disabled  PAT state set to disabled
- OS        PAT initializes PAT MSR with OS setting
- BIOS      PAT keeps PAT MSR with BIOS setting
-
-- 
2.20.1

