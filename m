Return-Path: <SRS0=aMvC=SS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B9F6C10F13
	for <linux-pci@archiver.kernel.org>; Tue, 16 Apr 2019 21:30:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45C332075B
	for <linux-pci@archiver.kernel.org>; Tue, 16 Apr 2019 21:30:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="J76nAIpK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727136AbfDPVaa (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 16 Apr 2019 17:30:30 -0400
Received: from mta-p3.oit.umn.edu ([134.84.196.203]:49070 "EHLO
        mta-p3.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbfDPVaa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Apr 2019 17:30:30 -0400
Received: from localhost (localhost [127.0.0.1])
        by mta-p3.oit.umn.edu (Postfix) with ESMTP id C8522712;
        Tue, 16 Apr 2019 21:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=umn.edu; h=
        content-type:content-type:subject:subject:message-id:date:date
        :from:from:in-reply-to:references:mime-version:received:received
        :received; s=20160920; t=1555450228; x=1557264629; bh=SejhEAdsy0
        bjqdzzcUyFRadn51Pa9bkvFtRS16XL79Q=; b=J76nAIpKpewq74JpuDHhvVJxpy
        brTijYCMMqPYaKt8wMP1c3BRQpYhpgwoSqK+Cwwz1N0muZeqsjfVGtuYsIYH66E1
        8uOt/EXw2qpQgniQUwqcKM2OFj9fJTRg23ELwzOa/SsBjSOEQ7IillAN6ZqbLyqS
        iJu679fHPxJ+8KdtrzL8ww5H2VpXUxt1d07r5SRrpYo/D3dC1ghdEwjgyVmhb6MG
        1etqJbSydMxKlG2vSbU1W3FwEGusuGZ9xd7VzPp1SzZ/9dPLX7VpXdBkDulogq+a
        PDEmRNGQd0M6D+hZcMkyyBATaZd8C/bKeamFG5GNG4brv4x65dujZPRG1GTQ==
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p3.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p3.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id MaX3WBuGIlUy; Tue, 16 Apr 2019 16:30:28 -0500 (CDT)
Received: from mail-it1-f182.google.com (mail-it1-f182.google.com [209.85.166.182])
        (using TLSv1 with cipher AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wang6495)
        by mta-p3.oit.umn.edu (Postfix) with ESMTPSA id 9973C6EA;
        Tue, 16 Apr 2019 16:30:28 -0500 (CDT)
Received: by mail-it1-f182.google.com with SMTP id q14so1219478itk.0;
        Tue, 16 Apr 2019 14:30:28 -0700 (PDT)
X-Gm-Message-State: APjAAAW9bfuRhenEsITYD0WSOioh1Y3weKy1IASFaqj1L6ATPwIfr0R/
        NpRDHSQ7Rw/uZ3Duc3xRvH1HpXR69ei2otzIROA=
X-Google-Smtp-Source: APXvYqzZcZ0v3Zfkxa58QIKDsDcENIb48YmS+BIyLvXSnNscYH24PtSJjbMAqZ/NgefgVhzfv40RCt0Z1K1zSBg0ZaQ=
X-Received: by 2002:a24:6b92:: with SMTP id v140mr27663327itc.161.1555450228421;
 Tue, 16 Apr 2019 14:30:28 -0700 (PDT)
MIME-Version: 1.0
References: <1555423298-6677-1-git-send-email-wang6495@umn.edu> <alpine.DEB.2.21.1904162155430.1780@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1904162155430.1780@nanos.tec.linutronix.de>
From:   Wenwen Wang <wang6495@umn.edu>
Date:   Tue, 16 Apr 2019 16:29:52 -0500
X-Gmail-Original-Message-ID: <CAAa=b7eAtZ+dd1kfpOAoFr9unrFv--jkFXTXmtcs0=Q-pPErMg@mail.gmail.com>
Message-ID: <CAAa=b7eAtZ+dd1kfpOAoFr9unrFv--jkFXTXmtcs0=Q-pPErMg@mail.gmail.com>
Subject: Re: [PATCH v2] x86/PCI: fix a memory leak bug
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>, Wenwen Wang <wang6495@umn.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 16, 2019 at 3:33 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Tue, 16 Apr 2019, Wenwen Wang wrote:
>
> > In pcibios_irq_init(), the PCI IRQ routing table 'pirq_table' is firstly
> > found through pirq_find_routing_table(). If the table is not found and
> > 'CONFIG_PCI_BIOS' is defined, the table is then allocated in
> > pcibios_get_irq_routing_table() using kmalloc(). In the following
> > execution, if the I/O APIC is used, this table is actually not used.
> > However, in that case, the allocated table is not freed, which can lead to
> > a memory leak bug.
>
> s/which can lead to/which is/
>
> There is no 'can'. It simply is a memory leak.
>
> > To fix this issue, this patch frees the allocated table if it is not used.
>
> To fix this issue, free the allocated table if it is not used.
>
> 'this patch' is completely redundant information and discouraged in
> Documentation/process/....
>

Thanks for your suggestions, Thomas. I will revise the commit's message.

Wenwen

> Other than that:
>
> Acked-by: Thomas Gleixner <tglx@linutronix.de>
