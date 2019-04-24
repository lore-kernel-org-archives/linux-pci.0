Return-Path: <SRS0=9smm=S2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4492EC10F11
	for <linux-pci@archiver.kernel.org>; Wed, 24 Apr 2019 16:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F39D6218B0
	for <linux-pci@archiver.kernel.org>; Wed, 24 Apr 2019 16:33:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KyX0wpWg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731672AbfDXQdl (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 24 Apr 2019 12:33:41 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33439 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730794AbfDXQdk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Apr 2019 12:33:40 -0400
Received: by mail-pf1-f196.google.com with SMTP id h5so9588429pfo.0;
        Wed, 24 Apr 2019 09:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EpxqYT7wciSenKfeU0lmEAJRB6rmerWPGABXSsTD67w=;
        b=KyX0wpWg65wYoFUwCF+P0oatuciLbjwH7f42SsGWsAcFtilsLffB//SHd2XOSewIcu
         mDszDn9VoaN0cOl7CXkPUUFgrV76NyCEgighSWD6aFI61Ulq4zzPhneg6gY8fEy+WFAs
         eodeHiqtMgrqUb2Z9smPUSKCxifbhO1ZuTWMZhxPvE9SzhkBj3n9Uga50nj1eFbWq5nG
         2s3/6YZ18b3YqXqsL/mEIiKqnhu+/GsspMMOIRC8gnUdDq8gGlNNmSbokfdlFJ9SJP7p
         LDVmBFgKfrMvuIwryqIjCeGUTV1DGA3WpQ2jvlnPeUoFtgtPmOdBCUrTPtPSMwIE/zTy
         h+wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EpxqYT7wciSenKfeU0lmEAJRB6rmerWPGABXSsTD67w=;
        b=AMn6FqjeZsTNH/C57t24Yc1mcuPoRfIskNC/5Gvm7E/DGATpjI4tXOhbFj1GraH5db
         BgsvJKMWzw/AaeTnRg8D6umIIaEDV4q7EPSMWs53/1x1K5wvwp+MoUIIgz+cJC9/kFN9
         b6LCxrQ1Pd8SHteoC8f5X9xGk/amIn9agp547GfADsc63ws04V2R+CoaTt/NCWO+UcBi
         kSmLciHpa/FZUPBYHQ+zQR8ZJTgziMZVaDe/QlJD8zg1GAdsWhDY4Cr3b3b/et4+st9b
         +UL3XmnaeaS9065wDeEMlBsnVivvszUEcI00mcv2+un6Rl7oZ7BqSU7/O/wzE67ZKf+A
         4V5w==
X-Gm-Message-State: APjAAAXH6Elt4v+kNx+YgkIQZbDv+rn0hRevjSKcqr7vBnzkcPM/QadQ
        volOPtMiHlNn3/wOHZVitDk=
X-Google-Smtp-Source: APXvYqwUJ75HKkQcvVkM3hB21BPKyW+V3p5o+fnEnZSrzAMd3/IvY/55EGS89wYpE0mu0rh+FVTlxw==
X-Received: by 2002:a65:648f:: with SMTP id e15mr31788910pgv.414.1556123619539;
        Wed, 24 Apr 2019 09:33:39 -0700 (PDT)
Received: from mail.google.com ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id q128sm32292731pga.60.2019.04.24.09.33.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Apr 2019 09:33:38 -0700 (PDT)
Date:   Thu, 25 Apr 2019 00:33:29 +0800
From:   Changbin Du <changbin.du@gmail.com>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Changbin Du <changbin.du@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Bjorn Helgaas <bhelgaas@google.com>, rjw@rjwysocki.net,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        x86@kernel.org, fenghua.yu@intel.com,
        linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: Re: [PATCH v4 10/63] Documentation: ACPI: move
 initrd_table_override.txt to admin-guide/acpi and convert to reST
Message-ID: <20190424163328.e3ux6opmr47d5ixg@mail.google.com>
References: <20190423162932.21428-1-changbin.du@gmail.com>
 <20190423162932.21428-11-changbin.du@gmail.com>
 <20190423180734.67c6f470@coco.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190423180734.67c6f470@coco.lan>
User-Agent: NeoMutt/20180716
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 23, 2019 at 06:07:34PM -0300, Mauro Carvalho Chehab wrote:
> Em Wed, 24 Apr 2019 00:28:39 +0800
> Changbin Du <changbin.du@gmail.com> escreveu:
> 
> > This converts the plain text documentation to reStructuredText format and
> > add it to Sphinx TOC tree. No essential content change.
> > 
> > Signed-off-by: Changbin Du <changbin.du@gmail.com>
> > ---
> >  Documentation/acpi/initrd_table_override.txt  | 111 ----------------
> >  Documentation/admin-guide/acpi/index.rst      |   1 +
> >  .../acpi/initrd_table_override.rst            | 120 ++++++++++++++++++
> >  3 files changed, 121 insertions(+), 111 deletions(-)
> >  delete mode 100644 Documentation/acpi/initrd_table_override.txt
> >  create mode 100644 Documentation/admin-guide/acpi/initrd_table_override.rst
> > 
> > diff --git a/Documentation/acpi/initrd_table_override.txt b/Documentation/acpi/initrd_table_override.txt
> > deleted file mode 100644
> > index 30437a6db373..000000000000
> > --- a/Documentation/acpi/initrd_table_override.txt
> > +++ /dev/null
> > @@ -1,111 +0,0 @@
> > -Upgrading ACPI tables via initrd
> > -================================
> > -
> > -1) Introduction (What is this about)
> > -2) What is this for
> > -3) How does it work
> > -4) References (Where to retrieve userspace tools)
> > -
> > -1) What is this about
> > ----------------------
> > -
> > -If the ACPI_TABLE_UPGRADE compile option is true, it is possible to
> > -upgrade the ACPI execution environment that is defined by the ACPI tables
> > -via upgrading the ACPI tables provided by the BIOS with an instrumented,
> > -modified, more recent version one, or installing brand new ACPI tables.
> > -
> > -When building initrd with kernel in a single image, option
> > -ACPI_TABLE_OVERRIDE_VIA_BUILTIN_INITRD should also be true for this
> > -feature to work.
> > -
> > -For a full list of ACPI tables that can be upgraded/installed, take a look
> > -at the char *table_sigs[MAX_ACPI_SIGNATURE]; definition in
> > -drivers/acpi/tables.c.
> > -All ACPI tables iasl (Intel's ACPI compiler and disassembler) knows should
> > -be overridable, except:
> > -   - ACPI_SIG_RSDP (has a signature of 6 bytes)
> > -   - ACPI_SIG_FACS (does not have an ordinary ACPI table header)
> > -Both could get implemented as well.
> > -
> > -
> > -2) What is this for
> > --------------------
> > -
> > -Complain to your platform/BIOS vendor if you find a bug which is so severe
> > -that a workaround is not accepted in the Linux kernel. And this facility
> > -allows you to upgrade the buggy tables before your platform/BIOS vendor
> > -releases an upgraded BIOS binary.
> > -
> > -This facility can be used by platform/BIOS vendors to provide a Linux
> > -compatible environment without modifying the underlying platform firmware.
> > -
> > -This facility also provides a powerful feature to easily debug and test
> > -ACPI BIOS table compatibility with the Linux kernel by modifying old
> > -platform provided ACPI tables or inserting new ACPI tables.
> > -
> > -It can and should be enabled in any kernel because there is no functional
> > -change with not instrumented initrds.
> > -
> > -
> > -3) How does it work
> > --------------------
> > -
> > -# Extract the machine's ACPI tables:
> > -cd /tmp
> > -acpidump >acpidump
> > -acpixtract -a acpidump
> > -# Disassemble, modify and recompile them:
> > -iasl -d *.dat
> > -# For example add this statement into a _PRT (PCI Routing Table) function
> > -# of the DSDT:
> > -Store("HELLO WORLD", debug)
> > -# And increase the OEM Revision. For example, before modification:
> > -DefinitionBlock ("DSDT.aml", "DSDT", 2, "INTEL ", "TEMPLATE", 0x00000000)
> > -# After modification:
> > -DefinitionBlock ("DSDT.aml", "DSDT", 2, "INTEL ", "TEMPLATE", 0x00000001)
> > -iasl -sa dsdt.dsl
> > -# Add the raw ACPI tables to an uncompressed cpio archive.
> > -# They must be put into a /kernel/firmware/acpi directory inside the cpio
> > -# archive. Note that if the table put here matches a platform table
> > -# (similar Table Signature, and similar OEMID, and similar OEM Table ID)
> > -# with a more recent OEM Revision, the platform table will be upgraded by
> > -# this table. If the table put here doesn't match a platform table
> > -# (dissimilar Table Signature, or dissimilar OEMID, or dissimilar OEM Table
> > -# ID), this table will be appended.
> > -mkdir -p kernel/firmware/acpi
> > -cp dsdt.aml kernel/firmware/acpi
> > -# A maximum of "NR_ACPI_INITRD_TABLES (64)" tables are currently allowed
> > -# (see osl.c):
> > -iasl -sa facp.dsl
> > -iasl -sa ssdt1.dsl
> > -cp facp.aml kernel/firmware/acpi
> > -cp ssdt1.aml kernel/firmware/acpi
> > -# The uncompressed cpio archive must be the first. Other, typically
> > -# compressed cpio archives, must be concatenated on top of the uncompressed
> > -# one. Following command creates the uncompressed cpio archive and
> > -# concatenates the original initrd on top:
> > -find kernel | cpio -H newc --create > /boot/instrumented_initrd
> > -cat /boot/initrd >>/boot/instrumented_initrd
> > -# reboot with increased acpi debug level, e.g. boot params:
> > -acpi.debug_level=0x2 acpi.debug_layer=0xFFFFFFFF
> > -# and check your syslog:
> > -[    1.268089] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
> > -[    1.272091] [ACPI Debug]  String [0x0B] "HELLO WORLD"
> > -
> > -iasl is able to disassemble and recompile quite a lot different,
> > -also static ACPI tables.
> > -
> > -
> > -4) Where to retrieve userspace tools
> > -------------------------------------
> > -
> > -iasl and acpixtract are part of Intel's ACPICA project:
> > -http://acpica.org/
> > -and should be packaged by distributions (for example in the acpica package
> > -on SUSE).
> > -
> > -acpidump can be found in Len Browns pmtools:
> > -ftp://kernel.org/pub/linux/kernel/people/lenb/acpi/utils/pmtools/acpidump
> > -This tool is also part of the acpica package on SUSE.
> > -Alternatively, used ACPI tables can be retrieved via sysfs in latest kernels:
> > -/sys/firmware/acpi/tables
> > diff --git a/Documentation/admin-guide/acpi/index.rst b/Documentation/admin-guide/acpi/index.rst
> > index 3e041206089d..09e4e81e4fb7 100644
> > --- a/Documentation/admin-guide/acpi/index.rst
> > +++ b/Documentation/admin-guide/acpi/index.rst
> > @@ -8,3 +8,4 @@ the Linux ACPI support.
> >  .. toctree::
> >     :maxdepth: 1
> >  
> > +   initrd_table_override
> > diff --git a/Documentation/admin-guide/acpi/initrd_table_override.rst b/Documentation/admin-guide/acpi/initrd_table_override.rst
> > new file mode 100644
> > index 000000000000..0787b2b91ded
> > --- /dev/null
> > +++ b/Documentation/admin-guide/acpi/initrd_table_override.rst
> > @@ -0,0 +1,120 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> > +================================
> > +Upgrading ACPI tables via initrd
> > +================================
> > +
> > +1) Introduction (What is this about)
> > +2) What is this for
> > +3) How does it work
> > +4) References (Where to retrieve userspace tools)
> 
> Hmm... I did the same on my conversion, but IMO, the best would be to
> hide (or remove, if ACPI maintainers agree) the contents, as this may
> conflict with the body as people may add new stuff and forget to
> update it.
> 
> So, if ACPI maintainers insist on keeping it, I would code this as:
> 
> .. Contents
> 
>    1) Introduction (What is this about)
>    2) What is this for
>    3) How does it work
>    4) References (Where to retrieve userspace tools)
> 
> as this will make this invisible on html/pdf/epub output.
>
I just removed it. If anyone wants it back, please comment. Thanks.

> Anyway, with or without the above change:
> 
> Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> 
> > +
> > +1) What is this about
> > +=====================
> > +
> > +If the ACPI_TABLE_UPGRADE compile option is true, it is possible to
> > +upgrade the ACPI execution environment that is defined by the ACPI tables
> > +via upgrading the ACPI tables provided by the BIOS with an instrumented,
> > +modified, more recent version one, or installing brand new ACPI tables.
> > +
> > +When building initrd with kernel in a single image, option
> > +ACPI_TABLE_OVERRIDE_VIA_BUILTIN_INITRD should also be true for this
> > +feature to work.
> > +
> > +For a full list of ACPI tables that can be upgraded/installed, take a look
> > +at the char `*table_sigs[MAX_ACPI_SIGNATURE];` definition in
> > +drivers/acpi/tables.c.
> > +
> > +All ACPI tables iasl (Intel's ACPI compiler and disassembler) knows should
> > +be overridable, except:
> > +
> > +  - ACPI_SIG_RSDP (has a signature of 6 bytes)
> > +  - ACPI_SIG_FACS (does not have an ordinary ACPI table header)
> > +
> > +Both could get implemented as well.
> > +
> > +
> > +2) What is this for
> > +===================
> > +
> > +Complain to your platform/BIOS vendor if you find a bug which is so severe
> > +that a workaround is not accepted in the Linux kernel. And this facility
> > +allows you to upgrade the buggy tables before your platform/BIOS vendor
> > +releases an upgraded BIOS binary.
> > +
> > +This facility can be used by platform/BIOS vendors to provide a Linux
> > +compatible environment without modifying the underlying platform firmware.
> > +
> > +This facility also provides a powerful feature to easily debug and test
> > +ACPI BIOS table compatibility with the Linux kernel by modifying old
> > +platform provided ACPI tables or inserting new ACPI tables.
> > +
> > +It can and should be enabled in any kernel because there is no functional
> > +change with not instrumented initrds.
> > +
> > +
> > +3) How does it work
> > +===================
> > +::
> > +
> > +  # Extract the machine's ACPI tables:
> > +  cd /tmp
> > +  acpidump >acpidump
> > +  acpixtract -a acpidump
> > +  # Disassemble, modify and recompile them:
> > +  iasl -d *.dat
> > +  # For example add this statement into a _PRT (PCI Routing Table) function
> > +  # of the DSDT:
> > +  Store("HELLO WORLD", debug)
> > +  # And increase the OEM Revision. For example, before modification:
> > +  DefinitionBlock ("DSDT.aml", "DSDT", 2, "INTEL ", "TEMPLATE", 0x00000000)
> > +  # After modification:
> > +  DefinitionBlock ("DSDT.aml", "DSDT", 2, "INTEL ", "TEMPLATE", 0x00000001)
> > +  iasl -sa dsdt.dsl
> > +  # Add the raw ACPI tables to an uncompressed cpio archive.
> > +  # They must be put into a /kernel/firmware/acpi directory inside the cpio
> > +  # archive. Note that if the table put here matches a platform table
> > +  # (similar Table Signature, and similar OEMID, and similar OEM Table ID)
> > +  # with a more recent OEM Revision, the platform table will be upgraded by
> > +  # this table. If the table put here doesn't match a platform table
> > +  # (dissimilar Table Signature, or dissimilar OEMID, or dissimilar OEM Table
> > +  # ID), this table will be appended.
> > +  mkdir -p kernel/firmware/acpi
> > +  cp dsdt.aml kernel/firmware/acpi
> > +  # A maximum of "NR_ACPI_INITRD_TABLES (64)" tables are currently allowed
> > +  # (see osl.c):
> > +  iasl -sa facp.dsl
> > +  iasl -sa ssdt1.dsl
> > +  cp facp.aml kernel/firmware/acpi
> > +  cp ssdt1.aml kernel/firmware/acpi
> > +  # The uncompressed cpio archive must be the first. Other, typically
> > +  # compressed cpio archives, must be concatenated on top of the uncompressed
> > +  # one. Following command creates the uncompressed cpio archive and
> > +  # concatenates the original initrd on top:
> > +  find kernel | cpio -H newc --create > /boot/instrumented_initrd
> > +  cat /boot/initrd >>/boot/instrumented_initrd
> > +  # reboot with increased acpi debug level, e.g. boot params:
> > +  acpi.debug_level=0x2 acpi.debug_layer=0xFFFFFFFF
> > +  # and check your syslog:
> > +  [    1.268089] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
> > +  [    1.272091] [ACPI Debug]  String [0x0B] "HELLO WORLD"
> > +
> > +iasl is able to disassemble and recompile quite a lot different,
> > +also static ACPI tables.
> > +
> > +
> > +4) Where to retrieve userspace tools
> > +====================================
> > +
> > +iasl and acpixtract are part of Intel's ACPICA project:
> > +http://acpica.org/
> > +
> > +and should be packaged by distributions (for example in the acpica package
> > +on SUSE).
> > +
> > +acpidump can be found in Len Browns pmtools:
> > +ftp://kernel.org/pub/linux/kernel/people/lenb/acpi/utils/pmtools/acpidump
> > +
> > +This tool is also part of the acpica package on SUSE.
> > +Alternatively, used ACPI tables can be retrieved via sysfs in latest kernels:
> > +/sys/firmware/acpi/tables
> 
> 
> 
> Thanks,
> Mauro

-- 
Cheers,
Changbin Du
