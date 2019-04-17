Return-Path: <SRS0=SWM8=ST=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7784DC282DA
	for <linux-pci@archiver.kernel.org>; Wed, 17 Apr 2019 14:11:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42A1E206BA
	for <linux-pci@archiver.kernel.org>; Wed, 17 Apr 2019 14:11:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="bHbDZZKb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729395AbfDQOLd (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 17 Apr 2019 10:11:33 -0400
Received: from mta-p1.oit.umn.edu ([134.84.196.201]:39900 "EHLO
        mta-p1.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728335AbfDQOLd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 Apr 2019 10:11:33 -0400
Received: from localhost (localhost [127.0.0.1])
        by mta-p1.oit.umn.edu (Postfix) with ESMTP id 63A2D5D9;
        Wed, 17 Apr 2019 14:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=umn.edu; h=
        content-type:content-type:subject:subject:message-id:date:date
        :from:from:in-reply-to:references:mime-version:received:received
        :received; s=20160920; t=1555510291; x=1557324692; bh=VINQTYcmYl
        PJVi7GnyF7i/H+KZBnevrjSbV8ruaLGtU=; b=bHbDZZKbAZkEEuVeeHjJG8qoSK
        BV5LVxoTkxQ58VtnjWczYr4j1AS80hkq9rP4bBtlBSYVQNVVE3d28RSpiFSscnE2
        JptPZE1yH5CeEWKbTo0wWs24/i1fsuY/iKuZOXpqa/HTuRm1OnpT+tEI1NjS4k3j
        h2wYTn1krpoMCQJGQGFkZGMyI2jkLmn/48V5tC3wTK6dwOL2+PzAw4wd10l3peOS
        CYDmNlcEvcZLUfCEVV0TbkRPXnCIphf8fwrFkVXjrLHv0NCFphWKskZI+MJzPrEr
        hDhv9SZF/Gc1gNyfw85PGF5DY/5l2RYXDB436sxVESc8F5O9/Rp1Ho+9Op5Q==
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p1.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p1.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id zk4tC_K_YH_t; Wed, 17 Apr 2019 09:11:31 -0500 (CDT)
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
        (using TLSv1 with cipher AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wang6495)
        by mta-p1.oit.umn.edu (Postfix) with ESMTPSA id 2F4587D;
        Wed, 17 Apr 2019 09:11:31 -0500 (CDT)
Received: by mail-io1-f49.google.com with SMTP id p16so20704266iod.2;
        Wed, 17 Apr 2019 07:11:31 -0700 (PDT)
X-Gm-Message-State: APjAAAWks2WMOTflab2gbrXI4l9PpcHjWsI+7TBCuTO9H7IoxTOHnYH5
        qSoQTrA/qQ3XLXQpKTcfUzEwYhC9m2k+tz8FWQY=
X-Google-Smtp-Source: APXvYqxyKnf0nGbBbPfR0nNBlpKYKHXALPEKI3+F0dvKLI2DZPVMan1p8TdgUbnIZbX/P4w5ZXxRtLIeJkkX7iNQpbI=
X-Received: by 2002:a6b:ca87:: with SMTP id a129mr57926289iog.187.1555510290910;
 Wed, 17 Apr 2019 07:11:30 -0700 (PDT)
MIME-Version: 1.0
References: <1555423298-6677-1-git-send-email-wang6495@umn.edu>
 <alpine.DEB.2.21.1904162155430.1780@nanos.tec.linutronix.de>
 <CAAa=b7eAtZ+dd1kfpOAoFr9unrFv--jkFXTXmtcs0=Q-pPErMg@mail.gmail.com> <20190417055828.GB95755@gmail.com>
In-Reply-To: <20190417055828.GB95755@gmail.com>
From:   Wenwen Wang <wang6495@umn.edu>
Date:   Wed, 17 Apr 2019 09:10:55 -0500
X-Gmail-Original-Message-ID: <CAAa=b7e5gNfoMciFRMBaD=ZX+JF1iJfOKP6LyHNAr0fCE1KCrQ@mail.gmail.com>
Message-ID: <CAAa=b7e5gNfoMciFRMBaD=ZX+JF1iJfOKP6LyHNAr0fCE1KCrQ@mail.gmail.com>
Subject: Re: [PATCH v2] x86/PCI: fix a memory leak bug
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
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

On Wed, Apr 17, 2019 at 12:58 AM Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Wenwen Wang <wang6495@umn.edu> wrote:
>
> > On Tue, Apr 16, 2019 at 3:33 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> > >
> > > On Tue, 16 Apr 2019, Wenwen Wang wrote:
> > >
> > > > In pcibios_irq_init(), the PCI IRQ routing table 'pirq_table' is firstly
> > > > found through pirq_find_routing_table(). If the table is not found and
> > > > 'CONFIG_PCI_BIOS' is defined, the table is then allocated in
> > > > pcibios_get_irq_routing_table() using kmalloc(). In the following
> > > > execution, if the I/O APIC is used, this table is actually not used.
> > > > However, in that case, the allocated table is not freed, which can lead to
> > > > a memory leak bug.
> > >
> > > s/which can lead to/which is/
> > >
> > > There is no 'can'. It simply is a memory leak.
> > >
> > > > To fix this issue, this patch frees the allocated table if it is not used.
> > >
> > > To fix this issue, free the allocated table if it is not used.
> > >
> > > 'this patch' is completely redundant information and discouraged in
> > > Documentation/process/....
> > >
> >
> > Thanks for your suggestions, Thomas. I will revise the commit's message.
> >
> > Wenwen
> >
> > > Other than that:
> > >
> > > Acked-by: Thomas Gleixner <tglx@linutronix.de>
>
> You didn't add Thomas's Acked-by to your commit ...
>

I will add it and resubmit the patch.

Thanks,
Wenwen
