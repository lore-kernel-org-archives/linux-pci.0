Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:45286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932982AbcJGQUk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Oct 2016 12:20:40 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id 414202034B
        for <linux-pci@vger.kernel.org>; Fri,  7 Oct 2016 16:20:39 +0000 (UTC)
Received: from localhost (unknown [69.55.156.165])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1612B2022D
        for <linux-pci@vger.kernel.org>; Fri,  7 Oct 2016 16:20:38 +0000 (UTC)
Date: Fri, 7 Oct 2016 11:20:36 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Subject: PCI host driver cleanups
Message-ID: <20161007162036.GA22287@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

I have a whole mess of mostly trivial cleanups to the PCI host drivers.
My goal is to remove some redundancy and unnecessary code, make them
more consistent and readable, and expose more common patterns.  I did
find a couple bugs in the process, but apart from those, my intent is
that none of these actually change any behavior.

I just tagged and asked Linus to pull my "next" branch, and my hope is
to merge all these cleanups into "next" and ask Linus to pull them
before -rc1, so we can get all the churn out of the way before the
next development cycle.

I'll post all of these to linux-pci, but to try to avoid spamming
everybody, I'll only send them directly to you if you're listed as a
maintainer.

Here's an overview of what the changes are:

  - Use driver name, e.g., "armada8k", instead of "pcie" for pointers
    to the device-specific struct.  "pcie" suggests something generic,
    and I think using the driver name gives a hint that this is
    device-specific information.

  - Pass around the device-specific struct internally, instead of the
    DesignWare-generic struct.  We can always derive one from the
    other, so this is somewhat arbitrary.  My rule of thumb was "use
    the generic struct where we *can't* use the internal one, e.g.,
    for interfaces called by the DesignWare code, and use the internal
    struct everywhere else."

  - Add accessors, i.e., wrappers for "readl(armada8k->base + offset)",
    to reduce repetition and expose similarities between drivers.

  - Restructure some interfaces to take the device-specific struct
    instead of a register address (mostly keystone).  This means that
    code can use register accessors instead of readl()/writel().

  - Rename accessors, e.g., from dra7xx_pcie_readl() to dra7xx_readl(),
    for brevity and consistency across drivers.

  - Export dw_pcie_readl_rc() and dw_pcie_pcie_writel_rc() and use
    them in the drivers instead of having the drivers access
    pp->dbi_base directly.
    
    My assumption is that most or all of the registers at dbi_base are
    DesignWare-generic and should be defined in pcie-designware.h.  I
    see a couple instances of duplication, e.g., PCIE_PHY_DEBUG_R0
    (artpec6 and imx6) and DEBUG0 (keystone).  But I'm not really sure
    about this, and I haven't tried to unify these yet.

  - Swap order of *_writel() arguments to be "dev, pos, val", same as
    pci_write_config_word().  I know "writel" takes "val, pos", so
    this is somewhat arbitrary.  Mainly I want them all to be the
    same.

  - Reorder device-specific structs to put generic info, e.g., the
    shared DesignWare pcie_port struct, at the top.  Also add comments
    about what DT property things come from.  We have quite a variety
    of names for the same things.

  - Add local "dev" pointers to reduce repetition of things like
    "&pdev->dev".

  - Remove platform drvdata when it's not used, i.e., if a driver
    calls platform_set_drvdata() but not platform_get_drvdata(), I
    assume there's no point in doing the set_drvdata().

  - Remove redundant pointers.  In several cases, the device-specific
    structs had copies of the DesignWare-generic dbi_base pointer.

  - Remove pointers to register blocks at constant offsets from other
    blocks.  I moved that offset to the register #define so we could
    use a single base pointer.

  - Remove unused #defines, particularly in spear13xx.  I know there's
    some value in these as documentation, but they also contribute a
    bit of clutter and possibility for transcription errors when
    copying them from the spec.  I could be persuaded to change this,
    especially if it's common information that could be moved to a
    common header, e.g., pcie-designware.h.

Bjorn
