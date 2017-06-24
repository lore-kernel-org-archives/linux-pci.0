Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35692 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754621AbdFXCBz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Jun 2017 22:01:55 -0400
Received: by mail-pf0-f195.google.com with SMTP id s66so9728543pfs.2
        for <linux-pci@vger.kernel.org>; Fri, 23 Jun 2017 19:01:55 -0700 (PDT)
From: Palmer Dabbelt <palmer@dabbelt.com>
To: linux-pci@vger.kernel.org
To: linux-kernel@vger.kernel.org
To: bhelgaas@google.com
To: hch@infradead.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-snps-arc@lists.infradead.org
Cc: linux-cris-kernel@axis.com
Cc: linux-ia64@vger.kernel.org
Cc: linux-s390@vger.kernel.org
Cc: linux-sh@vger.kernel.org
Cc: sparclinux@vger.kernel.org
Subject: pci: Add generic pcibios_{fixup_bus,align_resource}
Date: Fri, 23 Jun 2017 18:50:41 -0700
Message-Id: <20170624015044.16746-1-palmer@dabbelt.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

While upstreaming the RISC-V port, it was pointed out that multiple
architectures have copied the mostly empty versions of at least one of these
functions.  This defines weakly bound versions of the common functions and
removes the now obselete functions from other ports.

This has been split out from the RISC-V submission so we can decouple all these
generic changes from our port review process.  There's some discussion on an
earlier version of the patch here

  https://lkml.org/lkml/2017/6/6/998

but I'm afraid a lot of this is really out of my wheelhouse (and I'm pretty
slammed trying to get the RISC-V port in better shape), so I'm afraid I'm not
going to be able to perform the full cleanup suggested.
