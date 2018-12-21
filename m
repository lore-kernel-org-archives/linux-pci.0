Return-Path: <SRS0=Xdj1=O6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02006C43612
	for <linux-pci@archiver.kernel.org>; Fri, 21 Dec 2018 11:08:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE9BC21908
	for <linux-pci@archiver.kernel.org>; Fri, 21 Dec 2018 11:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545390504;
	bh=2gXkGWWVGzp13OtV8HE8xXJntHT/Dbe/Tjm/NypnbKA=;
	h=From:Date:Subject:To:Cc:List-ID:From;
	b=ZdpZ/dLbcTVddYNmjLXpASfBed1qlKt950bzdZIo3SnnO3k6Q4gQH8Q95xF3mic8z
	 EKrfBdmS77KqiOuN/3jcYzuqyrQCBAYtJRT/tZUmg+7uXxaBOcL6MjxFx3HIc+YIv6
	 cOXE0diuhsUn+vML93TsDONltWoyUx+44q4mXKZs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732711AbeLULIX (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 21 Dec 2018 06:08:23 -0500
Received: from mail-oi1-f170.google.com ([209.85.167.170]:45973 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732142AbeLULIX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Dec 2018 06:08:23 -0500
Received: by mail-oi1-f170.google.com with SMTP id y1so4440448oie.12;
        Fri, 21 Dec 2018 03:08:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Tsved48N0aJ3hdWSy+DlrDmTxz4AWNNf8Ntrzppx5mA=;
        b=ZF+KHnVJMbaFNvOV63ZBLPa3MxH7FAaHl7dliDlrZdTlARCZaS1Lz1mAANdD5Oer9B
         CbzFh+rwAAqsAUBalFxja1PSckPeCSbmcRQnIyXituzf5dYjErEgwB1uVuKeW+VW6ZUS
         SmoMvqhq04r4y6bVvZP6ZBiCITIF4UNbcLyxXnmwq9m+os0cKOwj/v6ZTQCiaClQyBte
         zXrIDU4BFUUSCRvcSv2YreCUB+lOr2ASC1kIuOd9t6l/Mr/0I3JHv9fMt38SP+cjxxML
         AuGkYcDqeHvXMxBQ3UKoa7Gj7A2CcpJdgtkz2/yhF3KjCaAUCNntN2FqCqgDCybqslgF
         5I7g==
X-Gm-Message-State: AA+aEWYnkNKEUW5RI7KdMtlFIQnm8stORoQkSLdKz/IwkPVdoP4dhnX8
        cFI9/LIiVEhAErSA2AHu+ybPxg16N+True9xr9I8i70K
X-Google-Smtp-Source: AFSGD/V1VxwTlcBoQIuCAA55UXrvflmj7OZ0CURDVNbmcf8va6FrtQpHzkMw9eY/fjERLp4Sf9IGAwnM0zrMcO8yhuc=
X-Received: by 2002:aca:b642:: with SMTP id g63mr1009867oif.195.1545390502162;
 Fri, 21 Dec 2018 03:08:22 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 21 Dec 2018 12:08:11 +0100
Message-ID: <CAJZ5v0iskAJZADqKOncZ01wAD4CysUwUwqtTB-3kAu8umMfGBQ@mail.gmail.com>
Subject: [GIT PULL] ACPI updates for v4.21-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Linus,

This goes early due to the upcoming holidays period.

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-4.21-rc1

with top-most commit 3eb85368460d942005ba305829e279d0fe4767e0

 Merge branch 'acpi-pci'

on top of commit 7566ec393f4161572ba6f11ad5171fd5d59b0fbd

 Linux 4.20-rc7

to receive ACPI updates for 4.21-rc1.

These update the ACPICA code in the kernel to the 20181213 upstream
revision, make it possible to build the ACPI subsystem without PCI
support, and a new OEM _OSI string, add a new device support to the
ACPI driver for AMD SoCs and fix PM handling in the ACPI driver for
Intel SoCs, fix the SPCR table handling and do some assorted fixes
and cleanups.

Specifics:

 - Update the ACPICA code in the kernel to the 20181213 upstream
   revision including:
   * New Windows _OSI strings (Bob Moore, Jung-uk Kim).
   * Buffers-to-string conversions update (Bob Moore).
   * Removal of support for expressions in package elements (Bob
     Moore).
   * New option to display method/object evaluation in debug output
     (Bob Moore).
   * Compiler improvements (Bob Moore, Erik Schmauss).
   * Minor debugger fix (Erik Schmauss).
   * Disassembler improvement (Erik Schmauss).
   * Assorted cleanups (Bob Moore, Colin Ian King, Erik Schmauss).

 - Add support for a new OEM _OSI string to indicate special handling
   of secondary graphics adapters on some systems (Alex Hung).

 - Make it possible to build the ACPI subystem without PCI support
   (Sinan Kaya).

 - Make the SPCR table handling regard baud rate 0 in accordance with
   the specification of it and make the DSDT override code support
   DSDT code names generated by recent ACPICA (Andy Shevchenko, Wang
   Dongsheng, Nathan Chancellor).

 - Add clock frequency for Hisilicon Hip08 SPI controller to the ACPI
   driver for AMD SoCs (APD) (Jay Fang).

 - Fix the PM handling during device init in the ACPI driver for
   Intel SoCs (LPSS) (Hans de Goede).

 - Avoid double panic()s by clearing the APEI GHES block_status
   before panic() (Lenny Szubowicz).

 - Clean up a function invocation in the ACPI core and get rid of
   some code duplication by using the DEFINE_SHOW_ATTRIBUTE macro
   in the APEI support code (Alexey Dobriyan, Yangtao Li).

Thanks!


---------------

Alex Hung (1):
      ACPI / OSI: Add OEM _OSI string to enable dGPU direct output

Alexey Dobriyan (1):
      ACPI: fix acpi_find_child_device() invocation in acpi_preset_companion()

Andy Shevchenko (1):
      ACPI: SPCR: Consider baud rate 0 as preconfigured state

Bob Moore (8):
      ACPICA: iASL: Enhance error detection
      ACPICA: Update version to 20181031
      ACPICA: Add "Windows 2018" string in the _OSI support
      ACPICA: add comments, no functional change
      ACPICA: Update buffer-to-string conversions
      ACPICA: Expressions in package elements are not supported
      ACPICA: Debug output: Add option to display method/object evaluation
      ACPICA: Update version to 20181213

Colin Ian King (1):
      ACPICA: Use %d for signed int print formatting instead of %u

Erik Schmauss (5):
      ACPICA: Debugger: refactor to fix unused variable warning
      ACPICA: iASL: adding definition and disassembly for TPM2 revision 3
      ACPICA: Remove defines that use deprecated flag
      ACPICA: disassembler: disassemble OEMx tables as AML
      ACPICA: change coding style to match ACPICA, no functional change

Hans de Goede (1):
      ACPI / LPSS: Ignore acpi_device_fix_up_power() return value

Jay Fang (1):
      ACPI / APD: Add clock frequency for Hisilicon Hip08 SPI controller

Jung-uk Kim (1):
      ACPICA: Add "Windows 2018.2" string in the _OSI support

Lenny Szubowicz (1):
      ACPI/APEI: Clear GHES block_status before panic()

Nathan Chancellor (1):
      ACPI / tables: Add an ifdef around amlcode and dsdt_amlcode

Sinan Kaya (7):
      ACPI: Move PCI reset to a separate function
      ACPI: Allow CONFIG_PCI to be unset for reboot
      ACPICA: Remove PCI bits from ACPICA when CONFIG_PCI is unset
      PCI/ACPI: Allow ACPI to be built without CONFIG_PCI set
      arm64: select ACPI PCI code only when both features are enabled
      ACPI/IORT: Stub out ACS functions when CONFIG_PCI is not set
      ACPI: Make PCI slot detection driver depend on PCI

Wang Dongsheng (1):
      ACPI / tables: add DSDT AmlCode new declaration name support

Yangtao Li (1):
      ACPI, APEI, EINJ: Change to use DEFINE_SHOW_ATTRIBUTE macro

---------------

 arch/arm64/Kconfig                       |   4 +-
 arch/x86/include/asm/pci_x86.h           |   7 ++
 drivers/acpi/Kconfig                     |   5 +-
 drivers/acpi/Makefile                    |   2 +-
 drivers/acpi/acpi_apd.c                  |   6 ++
 drivers/acpi/acpi_lpss.c                 |   7 +-
 drivers/acpi/acpica/Makefile             |   2 +-
 drivers/acpi/acpica/acglobal.h           |   4 --
 drivers/acpi/acpica/achware.h            |   9 +++
 drivers/acpi/acpica/acnamesp.h           |   1 +
 drivers/acpi/acpica/acstruct.h           |   5 +-
 drivers/acpi/acpica/dbxface.c            | 118 +++++++++++++++++++------------
 drivers/acpi/acpica/dsmethod.c           |  14 ++++
 drivers/acpi/acpica/dsobject.c           |  11 ---
 drivers/acpi/acpica/dspkginit.c          |  26 +++++++
 drivers/acpi/acpica/dsutils.c            |   2 -
 drivers/acpi/acpica/dswload.c            |   6 +-
 drivers/acpi/acpica/dswload2.c           |  15 ++--
 drivers/acpi/acpica/dswstate.c           |   2 +-
 drivers/acpi/acpica/evhandler.c          |   8 +--
 drivers/acpi/acpica/exconvrt.c           |  49 +++++++++----
 drivers/acpi/acpica/excreate.c           |   2 -
 drivers/acpi/acpica/exoparg2.c           |   6 +-
 drivers/acpi/acpica/exregion.c           |   4 ++
 drivers/acpi/acpica/exserial.c           |   6 +-
 drivers/acpi/acpica/exutils.c            |   3 -
 drivers/acpi/acpica/nsaccess.c           |  23 +++++-
 drivers/acpi/acpica/nseval.c             |  13 ++++
 drivers/acpi/acpica/nsload.c             |   2 -
 drivers/acpi/acpica/nsparse.c            |  12 ++++
 drivers/acpi/acpica/psloop.c             |  10 ++-
 drivers/acpi/acpica/psobject.c           |   3 +-
 drivers/acpi/acpica/psparse.c            |  15 ++++
 drivers/acpi/acpica/psxface.c            |   6 ++
 drivers/acpi/acpica/utglobal.c           |   3 -
 drivers/acpi/acpica/utmisc.c             |   3 +-
 drivers/acpi/acpica/utosi.c              |   2 +
 drivers/acpi/apei/einj.c                 |  12 +---
 drivers/acpi/apei/ghes.c                 |   2 +
 drivers/acpi/arm64/iort.c                |  20 ++++--
 drivers/acpi/internal.h                  |   5 ++
 drivers/acpi/osi.c                       |   7 ++
 drivers/acpi/osl.c                       |   2 +
 drivers/acpi/reboot.c                    |  40 +++++++----
 drivers/acpi/spcr.c                      |  11 +++
 drivers/acpi/tables.c                    |  12 +++-
 drivers/pci/Makefile                     |   2 +-
 include/acpi/acoutput.h                  |   6 +-
 include/acpi/acpi_drivers.h              |   7 ++
 include/acpi/acpixf.h                    |   2 +-
 include/acpi/actbl.h                     |   1 +
 include/acpi/actbl3.h                    |  23 ++++++
 include/acpi/actypes.h                   |   6 ++
 include/acpi/platform/aclinux.h          |   4 ++
 include/linux/acpi.h                     |   9 ++-
 include/linux/pci.h                      |   4 ++
 tools/power/acpi/tools/acpidump/apmain.c |   2 +-
 57 files changed, 424 insertions(+), 169 deletions(-)
