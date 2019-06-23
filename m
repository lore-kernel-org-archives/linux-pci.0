Return-Path: <SRS0=rw/4=UW=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CC1FC43613
	for <linux-pci@archiver.kernel.org>; Sun, 23 Jun 2019 00:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FDBB2086A
	for <linux-pci@archiver.kernel.org>; Sun, 23 Jun 2019 00:30:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726350AbfFWAat (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 22 Jun 2019 20:30:49 -0400
Received: from gate.crashing.org ([63.228.1.57]:57041 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725844AbfFWAat (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 22 Jun 2019 20:30:49 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x5N0Uhb0003550;
        Sat, 22 Jun 2019 19:30:44 -0500
Message-ID: <5f3dcc3a8dafad188e3adb8ee9cf347bebdee7f6.camel@kernel.crashing.org>
Subject: Archs using generic PCI controller drivers vs. resource policy
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-arch@vger.kernel.org
Date:   Sun, 23 Jun 2019 10:30:42 +1000
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi !

As part of my cleanup and consolidation of the PCI resource assignment
policies, I need to clarify something.

At the moment, unless PCI_PROBE_ONLY is set, a number of
platforms/archs expect Linux to reassign everything rather than honor
what has setup, then (re)assign what's left or broken. This is mostly
the case of embedded platforms. Things like x86 and desktop/server
powerpc will generally honor the firmware setup.

One problem is that this policy decision tend to be sprinkled in some
of the controller drivers themselves in drivers/pci/controller (or the
pci_host_probe helper).

This is wrong. I want to move it to the architecture (initially,
eventually it should be platform driven, but the default will start
with architecture specific to avoid changing the existing behaviours
while consolidating the code).

To do that right, I want to understand which archs can potentially use
the code in drivers/pci/controller today so I can change those archs to
explicitely set the default to "reassign everything" (and take the
policy out of the drivers themselves).

So far I've counted arm, arm64 (DT, not ACPI) and nios2. Any other ?

The remaining archs fall into two categories:

 - Those who have their own existing PCI management code and don't
use the generic controller drivers. I'm handling these already.

 - Those who don't seem to have anything to do with PCI (yet ?) or that
I've missed. Those will default to the x86 model (honor FW setup unless
it has conflicts or is broken, and (re)assign what's left) unless
explicitly changed.

Cheers,
Ben.


