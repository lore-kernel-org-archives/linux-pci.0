Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C794C433EF
	for <linux-pci@archiver.kernel.org>; Thu, 31 Mar 2022 07:11:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231827AbiCaHM6 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 31 Mar 2022 03:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231804AbiCaHM1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 31 Mar 2022 03:12:27 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EEC545BD11;
        Thu, 31 Mar 2022 00:10:35 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 5475292009C; Thu, 31 Mar 2022 09:10:35 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 4DFB792009B;
        Thu, 31 Mar 2022 08:10:35 +0100 (BST)
Date:   Thu, 31 Mar 2022 08:10:35 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Nikolai Zhubr <zhubr.2@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
cc:     Arnd Bergmann <arnd@kernel.org>, x86@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RESEND][PATCH v2 0/2] x86/PCI: SiS PIRQ router updates
Message-ID: <alpine.DEB.2.21.2203301608140.22465@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

 This series was dropped from x86/irq due to a bug in a follow-up patch,
so resending verbatim after re-verification.

 Nikolai has observed the trigger mode not being fixed up once it has been 
incorrectly set by the BIOS for PCI devices, causing all kinds of usual 
issues.  As it turns out we don't have a PIRQ router defined for the 
SiS85C497 southbridge, which Nikolai's system uses, and which is different 
from the SiS85C503 southbridge we have support for.

 As we use the generic `sis' infix (capitalised or not) for the SiS85C503 
southbridge I have prepared this small patch series to first make the 
existing SiS program entities use a more specific `sis503' infix, and then
provide a suitable PIRQ router for the SiS85C497 device.

 See individual change descriptions for further details.

 Please apply.

  Maciej
