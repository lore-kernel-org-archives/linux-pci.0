Return-Path: <SRS0=fwBN=EG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98DA9C388F7
	for <linux-pci@archiver.kernel.org>; Sat, 31 Oct 2020 21:49:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B6DD20756
	for <linux-pci@archiver.kernel.org>; Sat, 31 Oct 2020 21:49:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vsliVRnt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ng5hsa/u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725880AbgJaVtR (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 31 Oct 2020 17:49:17 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50284 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbgJaVtR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 31 Oct 2020 17:49:17 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604180955;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qkyGG23d8Oju/T6dnuYTqANlxTDymnqLTSvkubtS9gg=;
        b=vsliVRntutM0GOE3hoVVmu/ViFK7VmgZQP2wNyCzCpGdrt0qNofOwIMEPXaJ8iQodzXlSk
        HEjRYOxuR3Bc8odVZRARR9iZng+XdMVQ09CbkALJBnfTGAVpGC/SW6BRY591pzGCoSCS6j
        XT8wZRRpGZRtFlWTr2roNQTditYoerX6nw0yjimKlqMwicO6Od1wxUxKeL+qsUtpCKybJ0
        ckRRqM6s7y5PbyYodgT4K9CxJFKft0VtbF/oXj1I07SVDdLwG5lNv+aoCpW0+oBhc976d6
        OpGPIXkyYsKi9E7in3lwwHurMXjvcVivPjnIXWQYSN3nHhiXatva6m7Gv31S8g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604180955;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qkyGG23d8Oju/T6dnuYTqANlxTDymnqLTSvkubtS9gg=;
        b=ng5hsa/ui4rhHNPKLXo4Fp1L0eC1dpYDz4IzhYF9wy/FkMRl6UZ8zDMPm11TZFcaoAbz4Q
        izrr+3daBzIRU/Dg==
To:     Frank Wunderlich <linux@fw-web.de>, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Marc Zyngier <maz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pci@vger.kernel.org, Ryder Lee <ryder.lee@mediatek.com>
Subject: Re: [PATCH] pci: mediatek: fix warning in msi.h
In-Reply-To: <20201031140330.83768-1-linux@fw-web.de>
References: <20201031140330.83768-1-linux@fw-web.de>
Date:   Sat, 31 Oct 2020 22:49:14 +0100
Message-ID: <878sbm9icl.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Frank,

On Sat, Oct 31 2020 at 15:03, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
>
> 5.10 shows these warnings on bootup while enabling pcie
> at least on bananapi-r2:
>
> [    6.161730] WARNING: CPU: 2 PID: 73 at include/linux/msi.h:213 pci_msi_setup_
> msi_irqs.constprop.0+0x78/0x80
> ....
> [    6.724607] WARNING: CPU: 2 PID: 73 at include/linux/msi.h:219 free_msi_irqs+
>
> fix this by selecting PCI_MSI_ARCH_FALLBACKS for MTK PCIe driver

That's not a fix. It's just supressing the warning.

PCI_MSI_ARCH_FALLBACKS is only valid for

  1) Architectures which implement the fallbacks

  2) Outdated PCI controller drivers on architectures without #1 which
     implement the deprecated msi_controller mechanism. That is handled
     in the weak arch fallback implementation.

The mediatek PCIE driver does not qualify for #2. It's purely irq domain
based.

So there is something else going wrong. The PCI device which tries to
allocate MSIs does not have an irq domain associated which makes it run
into that warning.

If you enable PCI_MSI_ARCH_FALLBACKS then the MSI allocation fails
silently. So it's just papering over the underlying problem.

So it needs to be figured out why the domain association is not there.

Thanks,

        tglx





