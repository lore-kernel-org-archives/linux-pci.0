Return-Path: <SRS0=Emu/=SZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40494C282DD
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 16:30:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFDE221773
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 16:30:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nF2kWWmg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728559AbfDWQa2 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 23 Apr 2019 12:30:28 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45119 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727656AbfDWQa2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Apr 2019 12:30:28 -0400
Received: by mail-pf1-f193.google.com with SMTP id e24so7735774pfi.12;
        Tue, 23 Apr 2019 09:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I/yfkslijbz6X+PfhMOQ60KU+rUuQOYsv8mtPJKM4Ec=;
        b=nF2kWWmgSvqxLykgD5Lq5mhIV7xco31Yd9OY9R6Tq9PCYM4y02tdIXzggSrwWpDjir
         KnmfQBzJu3PRnNxfCeriUzPioRk5hOlqURn1c/UcYYmsKTGXhxLLQaGPb/Al24x7F+A6
         w/QuJ2KRFB6a2FMuksUWA9gbWb/kmVMED6Spj8YSUSgXscK+ZQTeOgCN1GimKqfqfbeq
         6f4pPszI03tHJh8GGts1WReKyWf8sjpKvpTSoj+c/zzmHPADxNehvimxww3I1RQ+FZQ5
         LI7ARKsaYZPdUZ9nq23jYKRpNCFtJMV8CYCKfzmLJp1C3vOUQ5M6+dkvXqVAM0PS4IkG
         KVlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I/yfkslijbz6X+PfhMOQ60KU+rUuQOYsv8mtPJKM4Ec=;
        b=YHoejuac+8TDIiTaaiAOdKDLmTEHEZewuZ9cp0t+g3JJluhKZ7c3btEH0HQohczfw6
         LyJgkaHi5rqtvbhmFVZCK7FnJtumWnUE5I/WfadK2EB7DPd2s4PiHIdipUTbc3dBa/MZ
         SEXEPYvs6Vqqy1OLC9PK2ubdQ25hM/+WTbfsK78wvzj58DpFwr7V9iLl096LAP9RtmKl
         FHtwByKsIuikDZq24NPO8uQzVrpGnjwkKSakSHJPilXif9bHIFIhHJH4O0hSXbRfUy0d
         QGlTjns2dxtWJ+Mpb3f3lVMuKiIa/Aq8srz0oRt/RXlhXq48xL/BbWjEdJAnnZmjj9NW
         t/5Q==
X-Gm-Message-State: APjAAAUnS9R21D6uB4GGc+pRPfGPf08TiMo90ZZxhU5DBqs5PV2H2kbe
        3rTNwt5o7DtTTNMDTmuJdSw=
X-Google-Smtp-Source: APXvYqwdtYoUvaxBkBDYqiuEehv2A51ZtOlOkeIaeEHJosX+jvWEZXL96I9tXZ4LgENqH4rTsqy8MA==
X-Received: by 2002:aa7:8ac8:: with SMTP id b8mr27522171pfd.234.1556037027111;
        Tue, 23 Apr 2019 09:30:27 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id v1sm24364801pff.81.2019.04.23.09.30.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 09:30:26 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, rjw@rjwysocki.net,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        x86@kernel.org, fenghua.yu@intel.com,
        linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
        linux-gpio@vger.kernel.org, mchehab+samsung@kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v4 00/63] Include linux ACPI/PCI/X86 docs into Sphinx TOC tree
Date:   Wed, 24 Apr 2019 00:28:29 +0800
Message-Id: <20190423162932.21428-1-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Corbet and All,
The kernel now uses Sphinx to generate intelligent and beautiful documentation
from reStructuredText files. I converted all of the Linux ACPI/PCI/X86 docs to
reST format in this serias.

In this version I combined ACPI and PCI docs, and added new x86 docs conversion.

The hieararchy of ACPI docs are based on Corbet's suggestion:
https://lkml.org/lkml/2019/4/3/1047
I did some adjustment according to the content and finally they are placed as:
Documentation/firmware-guide/acpi/
├── acpi-lid.rst
├── aml-debugger.rst
├── apei
│   ├── einj.rst
│   └── output_format.rst
├── debug.rst
├── dsd
│   ├── data-node-references.rst
│   └── graph.rst
├── DSD-properties-rules.rst
├── enumeration.rst
├── gpio-properties.rst
├── i2c-muxes.rst
├── lpit.rst
├── method-customizing.rst
├── method-tracing.rst
├── namespace.rst
├── osi.rst
└── video_extension.rst
Documentation/driver-api/acpi/
├── linuxized-acpica.rst
└── scan_handlers.rst
ocumentation/admin-guide/acpi/
├── cppc_sysfs.rst
├── dsdt-override.rst
├── initrd_table_override.rst
└── ssdt-overlays.rst

The PCI docs are all put into driver API guide.
The X86 docs are all put into Architecture-specific documentation.

For you to preview, please visit below url:
http://www.bytemem.com:8080/kernel-doc/index.html

Thank you!


Changbin Du (63):
  Documentation: add Linux ACPI to Sphinx TOC tree
  Documentation: ACPI: move namespace.txt to firmware-guide/acpi and
    convert to reST
  Documentation: ACPI: move enumeration.txt to firmware-guide/acpi and
    convert to reST
  Documentation: ACPI: move osi.txt to firmware-guide/acpi and convert
    to reST
  Documentation: ACPI: move linuxized-acpica.txt to driver-api/acpi and
    convert to  reST
  Documentation: ACPI: move scan_handlers.txt to driver-api/acpi and
    convert to reST
  Documentation: ACPI: move DSD-properties-rules.txt to
    firmware-guide/acpi and covert to reST
  Documentation: ACPI: move gpio-properties.txt to firmware-guide/acpi
    and convert to reST
  Documentation: ACPI: move method-customizing.txt to
    firmware-guide/acpi and convert to reST
  Documentation: ACPI: move initrd_table_override.txt to
    admin-guide/acpi and convert to reST
  Documentation: ACPI: move dsdt-override.txt to admin-guide/acpi and
    convert to reST
  Documentation: ACPI: move i2c-muxes.txt to firmware-guide/acpi and
    convert to reST
  Documentation: ACPI: move acpi-lid.txt to firmware-guide/acpi and
    convert to reST
  Documentation: ACPI: move dsd/graph.txt to firmware-guide/acpi and
    convert to reST
  Documentation: ACPI: move dsd/data-node-references.txt to
    firmware-guide/acpi and convert to reST
  Documentation: ACPI: move debug.txt to firmware-guide/acpi and convert
    to reST
  Documentation: ACPI: move method-tracing.txt to firmware-guide/acpi
    and convert to rsST
  Documentation: ACPI: move aml-debugger.txt to firmware-guide/acpi and
    convert to reST
  Documentation: ACPI: move apei/output_format.txt to
    firmware-guide/acpi and convert to reST
  Documentation: ACPI: move apei/einj.txt to firmware-guide/acpi and
    convert to reST
  Documentation: ACPI: move cppc_sysfs.txt to admin-guide/acpi and
    convert to reST
  Documentation: ACPI: move lpit.txt to firmware-guide/acpi and convert
    to reST
  Documentation: ACPI: move ssdt-overlays.txt to admin-guide/acpi and
    convert to reST
  Documentation: ACPI: move video_extension.txt to firmware-guide/acpi
    and convert to reST
  Documentation: add Linux PCI to Sphinx TOC tree
  Documentation: PCI: convert pci.txt to reST
  Documentation: PCI: convert PCIEBUS-HOWTO.txt to reST
  Documentation: PCI: convert pci-iov-howto.txt to reST
  Documentation: PCI: convert MSI-HOWTO.txt to reST
  Documentation: PCI: convert acpi-info.txt to reST
  Documentation: PCI: convert pci-error-recovery.txt to reST
  Documentation: PCI: convert pcieaer-howto.txt to reST
  Documentation: PCI: convert endpoint/pci-endpoint.txt to reST
  Documentation: PCI: convert endpoint/pci-endpoint-cfs.txt to reST
  Documentation: PCI: convert endpoint/pci-test-function.txt to reST
  Documentation: PCI: convert endpoint/pci-test-howto.txt to reST
  Documentation: add Linux x86 docs to Sphinx TOC tree
  Documentation: x86: convert boot.txt to reST
  Documentation: x86: convert topology.txt to reST
  Documentation: x86: convert exception-tables.txt to reST
  Documentation: x86: convert kernel-stacks to reST
  Documentation: x86: convert entry_64.txt to reST
  Documentation: x86: convert earlyprintk.txt to reST
  Documentation: x86: convert zero-page.txt to reST
  Documentation: x86: convert tlb.txt to reST
  Documentation: x86: convert mtrr.txt to reST
  Documentation: x86: convert pat.txt to reST
  Documentation: x86: convert protection-keys.txt to reST
  Documentation: x86: convert intel_mpx.txt to reST
  Documentation: x86: convert amd-memory-encryption.txt to reST
  Documentation: x86: convert pti.txt to reST
  Documentation: x86: convert microcode.txt to reST
  Documentation: x86: convert resctrl_ui.txt to reST
  Documentation: x86: convert orc-unwinder.txt to reST
  Documentation: x86: convert usb-legacy-support.txt to reST
  Documentation: x86: convert i386/IO-APIC.txt to reST
  Documentation: x86: convert x86_64/boot-options.txt to reST
  Documentation: x86: convert x86_64/uefi.txt to reST
  Documentation: x86: convert x86_64/mm.txt to reST
  Documentation: x86: convert x86_64/5level-paging.txt to reST
  Documentation: x86: convert x86_64/fake-numa-for-cpusets to reST
  Documentation: x86: convert x86_64/cpu-hotplug-spec to reST
  Documentation: x86: convert x86_64/machinecheck to reST

 .../PCI/{MSI-HOWTO.txt => MSI-HOWTO.rst}      |   83 +-
 .../{PCIEBUS-HOWTO.txt => PCIEBUS-HOWTO.rst}  |  140 +-
 .../PCI/{acpi-info.txt => acpi-info.rst}      |   11 +-
 Documentation/PCI/endpoint/index.rst          |   13 +
 ...-endpoint-cfs.txt => pci-endpoint-cfs.rst} |   99 +-
 .../{pci-endpoint.txt => pci-endpoint.rst}    |   95 +-
 ...est-function.txt => pci-test-function.rst} |   32 +-
 ...{pci-test-howto.txt => pci-test-howto.rst} |   81 +-
 Documentation/PCI/index.rst                   |   18 +
 ...or-recovery.txt => pci-error-recovery.rst} |  178 +--
 .../{pci-iov-howto.txt => pci-iov-howto.rst}  |  161 ++-
 Documentation/PCI/{pci.txt => pci.rst}        |  267 ++--
 .../{pcieaer-howto.txt => pcieaer-howto.rst}  |  110 +-
 Documentation/acpi/aml-debugger.txt           |   66 -
 Documentation/acpi/apei/output_format.txt     |  147 --
 Documentation/acpi/i2c-muxes.txt              |   58 -
 Documentation/acpi/initrd_table_override.txt  |  111 --
 Documentation/acpi/method-customizing.txt     |   73 -
 Documentation/acpi/method-tracing.txt         |  192 ---
 Documentation/acpi/ssdt-overlays.txt          |  172 ---
 .../acpi/cppc_sysfs.rst}                      |   71 +-
 .../acpi/dsdt-override.rst}                   |    8 +-
 Documentation/admin-guide/acpi/index.rst      |   14 +
 .../acpi/initrd_table_override.rst            |  120 ++
 .../admin-guide/acpi/ssdt-overlays.rst        |  180 +++
 Documentation/admin-guide/index.rst           |    1 +
 Documentation/driver-api/acpi/index.rst       |    9 +
 .../acpi/linuxized-acpica.rst}                |  115 +-
 .../acpi/scan_handlers.rst}                   |   24 +-
 Documentation/driver-api/index.rst            |    1 +
 .../acpi/DSD-properties-rules.rst}            |   21 +-
 .../acpi/acpi-lid.rst}                        |   48 +-
 .../firmware-guide/acpi/aml-debugger.rst      |   75 +
 .../acpi/apei/einj.rst}                       |   98 +-
 .../acpi/apei/output_format.rst               |  150 ++
 .../acpi/debug.rst}                           |   31 +-
 .../acpi/dsd/data-node-references.rst}        |   28 +-
 .../acpi/dsd/graph.rst}                       |  157 +--
 .../acpi/enumeration.rst}                     |  135 +-
 .../acpi/gpio-properties.rst}                 |   78 +-
 .../firmware-guide/acpi/i2c-muxes.rst         |   61 +
 Documentation/firmware-guide/acpi/index.rst   |   26 +
 .../lpit.txt => firmware-guide/acpi/lpit.rst} |   18 +-
 .../acpi/method-customizing.rst               |   82 ++
 .../firmware-guide/acpi/method-tracing.rst    |  225 +++
 .../acpi/namespace.rst}                       |  310 +++--
 .../osi.txt => firmware-guide/acpi/osi.rst}   |   15 +-
 .../acpi/video_extension.rst}                 |   63 +-
 Documentation/firmware-guide/index.rst        |   13 +
 Documentation/index.rst                       |   12 +
 ...cryption.txt => amd-memory-encryption.rst} |   13 +-
 Documentation/x86/boot.rst                    | 1205 +++++++++++++++++
 Documentation/x86/boot.txt                    | 1130 ----------------
 Documentation/x86/earlyprintk.rst             |  148 ++
 Documentation/x86/earlyprintk.txt             |  141 --
 .../x86/{entry_64.txt => entry_64.rst}        |   12 +-
 ...eption-tables.txt => exception-tables.rst} |  231 ++--
 .../x86/i386/{IO-APIC.txt => IO-APIC.rst}     |   26 +-
 Documentation/x86/i386/index.rst              |   10 +
 Documentation/x86/index.rst                   |   30 +
 .../x86/{intel_mpx.txt => intel_mpx.rst}      |  120 +-
 .../x86/{kernel-stacks => kernel-stacks.rst}  |   20 +-
 .../x86/{microcode.txt => microcode.rst}      |   62 +-
 Documentation/x86/mtrr.rst                    |  350 +++++
 Documentation/x86/mtrr.txt                    |  329 -----
 .../{orc-unwinder.txt => orc-unwinder.rst}    |   27 +-
 Documentation/x86/pat.rst                     |  235 ++++
 Documentation/x86/pat.txt                     |  230 ----
 ...rotection-keys.txt => protection-keys.rst} |   33 +-
 Documentation/x86/{pti.txt => pti.rst}        |   19 +-
 .../x86/{resctrl_ui.txt => resctrl_ui.rst}    |  913 +++++++------
 Documentation/x86/{tlb.txt => tlb.rst}        |   30 +-
 Documentation/x86/topology.rst                |  228 ++++
 Documentation/x86/topology.txt                |  217 ---
 ...acy-support.txt => usb-legacy-support.rst} |    8 +-
 .../{5level-paging.txt => 5level-paging.rst}  |   16 +-
 Documentation/x86/x86_64/boot-options.rst     |  327 +++++
 Documentation/x86/x86_64/boot-options.txt     |  278 ----
 ...{cpu-hotplug-spec => cpu-hotplug-spec.rst} |    5 +-
 ...-for-cpusets => fake-numa-for-cpusets.rst} |   18 +-
 Documentation/x86/x86_64/index.rst            |   16 +
 .../x86_64/{machinecheck => machinecheck.rst} |   11 +-
 Documentation/x86/x86_64/mm.rst               |  161 +++
 Documentation/x86/x86_64/mm.txt               |  153 ---
 .../x86/x86_64/{uefi.txt => uefi.rst}         |   30 +-
 Documentation/x86/zero-page.rst               |   47 +
 Documentation/x86/zero-page.txt               |   40 -
 MAINTAINERS                                   |    4 +-
 88 files changed, 6041 insertions(+), 5128 deletions(-)
 rename Documentation/PCI/{MSI-HOWTO.txt => MSI-HOWTO.rst} (88%)
 rename Documentation/PCI/{PCIEBUS-HOWTO.txt => PCIEBUS-HOWTO.rst} (70%)
 rename Documentation/PCI/{acpi-info.txt => acpi-info.rst} (97%)
 create mode 100644 Documentation/PCI/endpoint/index.rst
 rename Documentation/PCI/endpoint/{pci-endpoint-cfs.txt => pci-endpoint-cfs.rst} (64%)
 rename Documentation/PCI/endpoint/{pci-endpoint.txt => pci-endpoint.rst} (82%)
 rename Documentation/PCI/endpoint/{pci-test-function.txt => pci-test-function.rst} (84%)
 rename Documentation/PCI/endpoint/{pci-test-howto.txt => pci-test-howto.rst} (78%)
 create mode 100644 Documentation/PCI/index.rst
 rename Documentation/PCI/{pci-error-recovery.txt => pci-error-recovery.rst} (80%)
 rename Documentation/PCI/{pci-iov-howto.txt => pci-iov-howto.rst} (63%)
 rename Documentation/PCI/{pci.txt => pci.rst} (78%)
 rename Documentation/PCI/{pcieaer-howto.txt => pcieaer-howto.rst} (81%)
 delete mode 100644 Documentation/acpi/aml-debugger.txt
 delete mode 100644 Documentation/acpi/apei/output_format.txt
 delete mode 100644 Documentation/acpi/i2c-muxes.txt
 delete mode 100644 Documentation/acpi/initrd_table_override.txt
 delete mode 100644 Documentation/acpi/method-customizing.txt
 delete mode 100644 Documentation/acpi/method-tracing.txt
 delete mode 100644 Documentation/acpi/ssdt-overlays.txt
 rename Documentation/{acpi/cppc_sysfs.txt => admin-guide/acpi/cppc_sysfs.rst} (51%)
 rename Documentation/{acpi/dsdt-override.txt => admin-guide/acpi/dsdt-override.rst} (56%)
 create mode 100644 Documentation/admin-guide/acpi/index.rst
 create mode 100644 Documentation/admin-guide/acpi/initrd_table_override.rst
 create mode 100644 Documentation/admin-guide/acpi/ssdt-overlays.rst
 create mode 100644 Documentation/driver-api/acpi/index.rst
 rename Documentation/{acpi/linuxized-acpica.txt => driver-api/acpi/linuxized-acpica.rst} (78%)
 rename Documentation/{acpi/scan_handlers.txt => driver-api/acpi/scan_handlers.rst} (90%)
 rename Documentation/{acpi/DSD-properties-rules.txt => firmware-guide/acpi/DSD-properties-rules.rst} (88%)
 rename Documentation/{acpi/acpi-lid.txt => firmware-guide/acpi/acpi-lid.rst} (77%)
 create mode 100644 Documentation/firmware-guide/acpi/aml-debugger.rst
 rename Documentation/{acpi/apei/einj.txt => firmware-guide/acpi/apei/einj.rst} (67%)
 create mode 100644 Documentation/firmware-guide/acpi/apei/output_format.rst
 rename Documentation/{acpi/debug.txt => firmware-guide/acpi/debug.rst} (91%)
 rename Documentation/{acpi/dsd/data-node-references.txt => firmware-guide/acpi/dsd/data-node-references.rst} (79%)
 rename Documentation/{acpi/dsd/graph.txt => firmware-guide/acpi/dsd/graph.rst} (56%)
 rename Documentation/{acpi/enumeration.txt => firmware-guide/acpi/enumeration.rst} (87%)
 rename Documentation/{acpi/gpio-properties.txt => firmware-guide/acpi/gpio-properties.rst} (81%)
 create mode 100644 Documentation/firmware-guide/acpi/i2c-muxes.rst
 create mode 100644 Documentation/firmware-guide/acpi/index.rst
 rename Documentation/{acpi/lpit.txt => firmware-guide/acpi/lpit.rst} (68%)
 create mode 100644 Documentation/firmware-guide/acpi/method-customizing.rst
 create mode 100644 Documentation/firmware-guide/acpi/method-tracing.rst
 rename Documentation/{acpi/namespace.txt => firmware-guide/acpi/namespace.rst} (54%)
 rename Documentation/{acpi/osi.txt => firmware-guide/acpi/osi.rst} (97%)
 rename Documentation/{acpi/video_extension.txt => firmware-guide/acpi/video_extension.rst} (79%)
 create mode 100644 Documentation/firmware-guide/index.rst
 rename Documentation/x86/{amd-memory-encryption.txt => amd-memory-encryption.rst} (94%)
 create mode 100644 Documentation/x86/boot.rst
 delete mode 100644 Documentation/x86/boot.txt
 create mode 100644 Documentation/x86/earlyprintk.rst
 delete mode 100644 Documentation/x86/earlyprintk.txt
 rename Documentation/x86/{entry_64.txt => entry_64.rst} (95%)
 rename Documentation/x86/{exception-tables.txt => exception-tables.rst} (67%)
 rename Documentation/x86/i386/{IO-APIC.txt => IO-APIC.rst} (93%)
 create mode 100644 Documentation/x86/i386/index.rst
 create mode 100644 Documentation/x86/index.rst
 rename Documentation/x86/{intel_mpx.txt => intel_mpx.rst} (75%)
 rename Documentation/x86/{kernel-stacks => kernel-stacks.rst} (92%)
 rename Documentation/x86/{microcode.txt => microcode.rst} (81%)
 create mode 100644 Documentation/x86/mtrr.rst
 delete mode 100644 Documentation/x86/mtrr.txt
 rename Documentation/x86/{orc-unwinder.txt => orc-unwinder.rst} (93%)
 create mode 100644 Documentation/x86/pat.rst
 delete mode 100644 Documentation/x86/pat.txt
 rename Documentation/x86/{protection-keys.txt => protection-keys.rst} (83%)
 rename Documentation/x86/{pti.txt => pti.rst} (95%)
 rename Documentation/x86/{resctrl_ui.txt => resctrl_ui.rst} (68%)
 rename Documentation/x86/{tlb.txt => tlb.rst} (81%)
 create mode 100644 Documentation/x86/topology.rst
 delete mode 100644 Documentation/x86/topology.txt
 rename Documentation/x86/{usb-legacy-support.txt => usb-legacy-support.rst} (92%)
 rename Documentation/x86/x86_64/{5level-paging.txt => 5level-paging.rst} (91%)
 create mode 100644 Documentation/x86/x86_64/boot-options.rst
 delete mode 100644 Documentation/x86/x86_64/boot-options.txt
 rename Documentation/x86/x86_64/{cpu-hotplug-spec => cpu-hotplug-spec.rst} (88%)
 rename Documentation/x86/x86_64/{fake-numa-for-cpusets => fake-numa-for-cpusets.rst} (90%)
 create mode 100644 Documentation/x86/x86_64/index.rst
 rename Documentation/x86/x86_64/{machinecheck => machinecheck.rst} (92%)
 create mode 100644 Documentation/x86/x86_64/mm.rst
 delete mode 100644 Documentation/x86/x86_64/mm.txt
 rename Documentation/x86/x86_64/{uefi.txt => uefi.rst} (79%)
 create mode 100644 Documentation/x86/zero-page.rst
 delete mode 100644 Documentation/x86/zero-page.txt

-- 
2.20.1

