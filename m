Return-Path: <SRS0=aMvC=SS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAC19C10F13
	for <linux-pci@archiver.kernel.org>; Tue, 16 Apr 2019 19:58:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CE7B21741
	for <linux-pci@archiver.kernel.org>; Tue, 16 Apr 2019 19:58:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729925AbfDPT6m (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 16 Apr 2019 15:58:42 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:50472 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728000AbfDPT6m (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Apr 2019 15:58:42 -0400
Received: from pd9ef12d2.dip0.t-ipconnect.de ([217.239.18.210] helo=nanos.glx-home)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hGUDs-0002wl-7d; Tue, 16 Apr 2019 21:58:28 +0200
Date:   Tue, 16 Apr 2019 21:58:27 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Wenwen Wang <wang6495@umn.edu>
cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] x86/PCI: fix a memory leak bug
In-Reply-To: <1555423298-6677-1-git-send-email-wang6495@umn.edu>
Message-ID: <alpine.DEB.2.21.1904162155430.1780@nanos.tec.linutronix.de>
References: <1555423298-6677-1-git-send-email-wang6495@umn.edu>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 16 Apr 2019, Wenwen Wang wrote:

> In pcibios_irq_init(), the PCI IRQ routing table 'pirq_table' is firstly
> found through pirq_find_routing_table(). If the table is not found and
> 'CONFIG_PCI_BIOS' is defined, the table is then allocated in
> pcibios_get_irq_routing_table() using kmalloc(). In the following
> execution, if the I/O APIC is used, this table is actually not used.
> However, in that case, the allocated table is not freed, which can lead to
> a memory leak bug.

s/which can lead to/which is/

There is no 'can'. It simply is a memory leak.

> To fix this issue, this patch frees the allocated table if it is not used.

To fix this issue, free the allocated table if it is not used.

'this patch' is completely redundant information and discouraged in
Documentation/process/....

Other than that:

Acked-by: Thomas Gleixner <tglx@linutronix.de>
