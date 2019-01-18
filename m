Return-Path: <SRS0=ljL/=P2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA1A8C43387
	for <linux-pci@archiver.kernel.org>; Fri, 18 Jan 2019 11:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A37CE2086D
	for <linux-pci@archiver.kernel.org>; Fri, 18 Jan 2019 11:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547810683;
	bh=PUisAjVa3cv5X1Xh6/0uP915h1Husuc43o0Ccl7AMXQ=;
	h=From:Date:Subject:To:Cc:List-ID:From;
	b=HiB/YKbLRhkCTQDhbZerpLeCAuGgq+qI5tG+XK5S4hpCi6dJevuRGGUS0XGYig6E6
	 l/xw4KKBP4qjXH6jcjnj5hDp6PuYBpvvJvk++wmyUxljIL1T/HzBhleTC+Qku8NWvT
	 gZgYKFIlTn6Chc4qjyIZn8zvRdyzL7ah3BfBvM88=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbfARLYh (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 18 Jan 2019 06:24:37 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44650 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbfARLYh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Jan 2019 06:24:37 -0500
Received: by mail-ot1-f68.google.com with SMTP id f18so14032150otl.11;
        Fri, 18 Jan 2019 03:24:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=rbRF+RcGW7kmODdnnEmQMjVFOTRo3Te5UWzYrvsUTX4=;
        b=Rhf/NATMbqsAMcilPhyf1aF6QY6Ivi9+FttShjOp8ERqbe0AOcIWrY1jYtIlujUGXm
         21JPgNCi6BC0ux5cRLJ4FeHdxey4S4wb94gdJuQY+GXnM4WpGrZqkZ6cXq1EEEqoysNn
         1M6crrtQL0bquNlp/Gphfn0U+vmfhr32+bMDsp9uVJM+F/XQytfe7+2zHnZC576VZGNT
         nl2dTcjwJsjydtAu+YkfQpRWi+V6D/JpEtG1jrWbOjxA0w8eKeqsFkeLjwXMpu27xzRE
         3keoxCN126CXF0Sly9wLesvywvwrzxOB0n7BrtvCd4AO+AB89Y2v4UU4XOgjB7HRgpDg
         pOKw==
X-Gm-Message-State: AJcUukcybuUt5rCdUlHi7YxFhVjtFHBMyFtHCL1f6QhTpMuvbBPVOj+m
        l8S4uhDtRdKLglmKfuZ1gVP9jggrz9F+JQ1DOAg=
X-Google-Smtp-Source: ALg8bN4gZduNZVppIjQrTuFafiC1SE9TWt9qzHWTQlYg6FB3zwVsojIkaFaRjo6NLY8xGuFYZ1TpY4RLlYMT2LoaCcM=
X-Received: by 2002:a9d:5f06:: with SMTP id f6mr11826020oti.258.1547810676653;
 Fri, 18 Jan 2019 03:24:36 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 18 Jan 2019 12:24:25 +0100
Message-ID: <CAJZ5v0jiK=zLP4cUsw=y9ea7PLHHgy=xshAsHFhTgyDJH+kOiQ@mail.gmail.com>
Subject: [GIT PULL] ACPI fixes for v5.0-rc3
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-5.0-rc3

with top-most commit 11ee2a3808aebbec73096551a716dea03d417fcb

 Merge branch 'acpi-pci'

on top of commit 1c7fc5cbc33980acd13d668f1c8f0313d6ae9fd8

 Linux 5.0-rc2

to receive ACPI fixes for 5.0-rc3.

These fix an ACPI initialization ordering issue introduced in
the 4.17 time frame and causing functional problems to appear on
multiple systems and fix some fallout of the recent change to
enable building kernels with ACPI support and without PCI.

Specifics:

 - Restore the ACPI initialization ordering changed implicitly by the
   module-level AML handling rework during the 4.17 development cycle
   that caused the EC address space handler based on information from
   ECDT to be set up before loading AML definition blocks, making it
   effectively not accessible by AML on some systems that don't work
   as expected any more (Rafael Wysocki).

 - Add direct dependencies on PCI to Kconfig in multiple places for
   code that depends on both ACPI and PCI, but the PCI dependency
   was implicitly satisfied by the ACPI dependency before, to prevent
   invalid configurations from being created, for example by
   randconfig (Sinan Kaya).

Thanks!


---------------

Rafael J. Wysocki (1):
      ACPI: EC: Look for ECDT EC after calling acpi_load_tables()

Sinan Kaya (8):
      ACPI / LPSS: Make PCI dependency explicit
      ata: pata_acpi: Make PCI dependency explicit
      vga-switcheroo: make PCI dependency explicit
      platform/x86: intel_ips: make PCI dependency explicit
      platform/x86: intel_pmc: Make PCI dependency explicit
      platform/x86: apple-gmux: Make PCI dependency explicit
      x86/intel/lpss: Make PCI dependency explicit
      drivers: thermal: int340x_thermal: Make PCI dependency explicit

---------------

 arch/x86/Kconfig                              |  2 +-
 drivers/acpi/Makefile                         |  3 ++-
 drivers/acpi/bus.c                            | 24 ++++++++++++------------
 drivers/acpi/internal.h                       |  4 ++++
 drivers/ata/Kconfig                           |  2 +-
 drivers/gpu/vga/Kconfig                       |  1 +
 drivers/platform/x86/Kconfig                  |  6 +++---
 drivers/thermal/intel/int340x_thermal/Kconfig |  2 +-
 8 files changed, 25 insertions(+), 19 deletions(-)
