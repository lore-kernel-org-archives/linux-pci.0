Return-Path: <SRS0=/dOL=PT=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03EDDC43387
	for <linux-pci@archiver.kernel.org>; Fri, 11 Jan 2019 10:22:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0EDB2146F
	for <linux-pci@archiver.kernel.org>; Fri, 11 Jan 2019 10:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547202172;
	bh=PG/GZyqPfjIhNBMJUTI5rw6jwpPQEx5pW77TEkiNFRo=;
	h=From:Date:Subject:To:Cc:List-ID:From;
	b=Q9FGlYMiFiEcorSYdCX3WkOJhtzIkvXsOEcWXdWfZ3RxCvRDKM1JVxXpdljD8bbYa
	 D/1gZWX35tAB/jF780dMkSAxmu6DRT/9BaMpApwBUU2FhZ5idsex/YX4S8HWe93MA1
	 dudXOQA9dzjYISQibbYifpP9kpt1BvgHUajPn1g0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730786AbfAKKWq (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 11 Jan 2019 05:22:46 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:34988 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbfAKKWq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Jan 2019 05:22:46 -0500
Received: by mail-oi1-f195.google.com with SMTP id v6so11798292oif.2;
        Fri, 11 Jan 2019 02:22:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=dj0OX87eiD5eXmDpyMWeS/s/LtaeLGorc2Nd49cmBBg=;
        b=VSg3wvPHAGtQqK3ZU1iqJTLqfpg7+uBloCBT/2bNbku5LqFRMjdv00rgRhyYTsmGvv
         a0fCFSi/DqZ3VOQwwbom1OZ4XZYOO5S2vf55u6w5NUB8az6PO3FEZ+yE7dbJyQ1uG+AU
         xwEoSyORe3KkvSoPmXDTJ77rzD/MHFSe68fjHDCrG6cknsdf4f8UfXJIiesEhOuAAddT
         g75UEtVOsbW2b+mvleCe5c0teDSKNA6iVfyvouWXSNxZQNCqwbHDUfZ+OCegNs3nijo+
         6a/WWpJUx1zE5UdZevm++O6P9nHLWT245Q0jVfjgVITh6tPyh9AHs7pl/GdRFwig2svM
         6w9Q==
X-Gm-Message-State: AJcUukcFVnKFIkHt00MtkDBngbb7NaOBmxRjs6kdn4pA0kuEuUTnCaM8
        JH9M0gZmGiCrxPIVcE/CMN96cajunT5OKDd0/DUEKxv5
X-Google-Smtp-Source: ALg8bN5UaXCzrzp0sDBPOySkzWLsi3xSm3RL1z8CyTi3z+ispuLQhun8YpiIKFMi6iZaoHUbb/d5CxQU86svdl2RMBg=
X-Received: by 2002:aca:195:: with SMTP id 143mr8284453oib.322.1547202164506;
 Fri, 11 Jan 2019 02:22:44 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 11 Jan 2019 11:22:33 +0100
Message-ID: <CAJZ5v0jRxHZJW5aW5NPLx2pcD1g5dhYzdyUw_PUTRekhOsqeyQ@mail.gmail.com>
Subject: [GIT PULL] ACPI fixes for v5.0-rc2
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-5.0-rc2

with top-most commit 65a4f3a1efda8e0cc2516301fc3ad64e3eca716c

 Merge branches 'acpi-pci', 'acpi-power' and 'acpi-misc'

on top of commit bfeffd155283772bbe78c6a05dec7c0128ee500c

 Linux 5.0-rc1

to receive ACPI fixes for 5.0-rc2.

This fix a build failure introduced recently, fix the xpower PMIC
ACPI driver, clean up the handling of duplicate entries in _PRx
power resource lists and fix addresses in NUMA-related messages on
32-bit with PAE.

Specifics:

 - Fix build failures with both CONFIG_NLS and CONFIG_PCI unset that
   can occur since ACPI can be built without PCI now (Sinan Kaya).

 - Clean up the handling of duplicate entries in power resource lists
   returned by _PRx evaluation to avoid triggering WARN_ON() on
   attempts to add duplicate symlinks in sysfs (Hans de Goede).

 - Fix issues with the TS current-source switching on systems using
   the xpower PMIC by avoiding to update unrelated bits in the TS
   pin-ctrl register and avoiding to unconditionally enable TS
   current-source on systems where it is not used (Hans de Goede).

 - Fix addresses in NUMA-related messages on 32-bit with PAE which
   can be truncated due to integer type conversions (Chao Fan).

Thanks!


---------------

Chao Fan (1):
      ACPI: NUMA: Use correct type for printing addresses on i386-PAE

Hans de Goede (2):
      ACPI: power: Skip duplicate power resource references in _PRx
      ACPI / PMIC: xpower: Fix TS-pin current-source handling

Sinan Kaya (1):
      ACPI: Fix build failure when CONFIG_NLS is set to 'n'

---------------

 drivers/acpi/Kconfig                  |  1 +
 drivers/acpi/numa.c                   |  6 ++---
 drivers/acpi/pmic/intel_pmic_xpower.c | 41 ++++++++++++++++++++++++++++-------
 drivers/acpi/power.c                  | 22 +++++++++++++++++++
 4 files changed, 59 insertions(+), 11 deletions(-)
