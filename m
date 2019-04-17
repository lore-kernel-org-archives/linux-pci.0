Return-Path: <SRS0=SWM8=ST=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 836C1C10F12
	for <linux-pci@archiver.kernel.org>; Wed, 17 Apr 2019 05:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B3AC20674
	for <linux-pci@archiver.kernel.org>; Wed, 17 Apr 2019 05:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555480714;
	bh=FGzDg75IcPqb+pboIEH8WsNq3zUPeE1q5l6HdyGmHvg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Phg9h1Tho4HnrTWaKaMAWpBp0hdVG//q2JU0B3nXAqvoAKFelWCvHS/wi4XlQRrTb
	 2pzEv6yISbgibgYQsiUHsBmcJZnjvSSdSPHil/sYB585mw7DM69S+3KqdVsk46/ygI
	 xthAfoVEimc8/5x1SCCOmYrOUKRuJ5h4F7lLDkXk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729099AbfDQF6d (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 17 Apr 2019 01:58:33 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44124 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726273AbfDQF6d (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 Apr 2019 01:58:33 -0400
Received: by mail-wr1-f65.google.com with SMTP id w18so71159wrv.11;
        Tue, 16 Apr 2019 22:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ACtm8Eb0/4kspQ0EJJEAO4ZLa4UvATtz24+esrSLa6c=;
        b=T4Bvl8+44+Ik4fiUHE8YnaYn3EQQs1bh27yZB2AVujXlA032CUMWA55vD7vM6RPZlk
         DTGJrPg7SQV6a2xW4dtwgySp+9lv2XHzDugGovtBH4pCJ6eFOK4ht4SPRkuEBaeFGlDj
         94DyBtGbKob2tlS5mps8nfPG3qgJb4kuAqGJKGQ6bRCl3WK1o52O1zxXckUDO38me61H
         wtsyvB4St41C/LalU/72jTZ2fMMUPJ/n/9CmQhdLTkjO88h3p4C1mxRS/PCZ6WphqJDc
         SSluFvXO0FwposYLVt7qtkf61El/tPmkWoZ66ZJUQEYlett8oMWRs9YcvB8jmtJYX+KX
         +8Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ACtm8Eb0/4kspQ0EJJEAO4ZLa4UvATtz24+esrSLa6c=;
        b=XCDpTx64ULzpg323pHnC13xtLtIx5WEKb4cWcyy0gDzXSoJcLlKch11qy994sVPRTT
         6oxe3yjwey1+rCTE91+44xYPA2JJWBsuf4/tBtwXn3aI0sghgFpWm6KvLpUYMI7R6mqO
         tHdSw0cV84JDGlCvxCsr1Aiswbr4X8o1iV7lTX2uLLrD/W4+evBz8xLr54JL9aC2cTgn
         Vhc5W7lJcEkU3hQmLhOTlpeHoUl86p7sT1slTpiocc3jRQdpKyklfEIU/bhYpZ6RXOT4
         m9k3xENXOKxYaxuqbutej292KV5CfGD3/V1vxRXPR1f6ighso07nZxWL0KVJ9mxU6t/H
         cK7g==
X-Gm-Message-State: APjAAAUwQq3EfhcoOp3HBZFxi2GVgiy0vZdRwBVbkz7qmVSF9oY1vLQZ
        NyTeNDeDdczPbn9WUm2qEGg=
X-Google-Smtp-Source: APXvYqwcFTGq0d6tIEoP6/i15l2Bwr952RzDlZ7lOuCkX1JJcN97WBs95PUD0LnMdyFsX2K0KeA8AA==
X-Received: by 2002:adf:dbce:: with SMTP id e14mr56661500wrj.249.1555480711352;
        Tue, 16 Apr 2019 22:58:31 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id y133sm2330908wmd.2.2019.04.16.22.58.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Apr 2019 22:58:30 -0700 (PDT)
Date:   Wed, 17 Apr 2019 07:58:28 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Wenwen Wang <wang6495@umn.edu>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] x86/PCI: fix a memory leak bug
Message-ID: <20190417055828.GB95755@gmail.com>
References: <1555423298-6677-1-git-send-email-wang6495@umn.edu>
 <alpine.DEB.2.21.1904162155430.1780@nanos.tec.linutronix.de>
 <CAAa=b7eAtZ+dd1kfpOAoFr9unrFv--jkFXTXmtcs0=Q-pPErMg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAa=b7eAtZ+dd1kfpOAoFr9unrFv--jkFXTXmtcs0=Q-pPErMg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


* Wenwen Wang <wang6495@umn.edu> wrote:

> On Tue, Apr 16, 2019 at 3:33 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > On Tue, 16 Apr 2019, Wenwen Wang wrote:
> >
> > > In pcibios_irq_init(), the PCI IRQ routing table 'pirq_table' is firstly
> > > found through pirq_find_routing_table(). If the table is not found and
> > > 'CONFIG_PCI_BIOS' is defined, the table is then allocated in
> > > pcibios_get_irq_routing_table() using kmalloc(). In the following
> > > execution, if the I/O APIC is used, this table is actually not used.
> > > However, in that case, the allocated table is not freed, which can lead to
> > > a memory leak bug.
> >
> > s/which can lead to/which is/
> >
> > There is no 'can'. It simply is a memory leak.
> >
> > > To fix this issue, this patch frees the allocated table if it is not used.
> >
> > To fix this issue, free the allocated table if it is not used.
> >
> > 'this patch' is completely redundant information and discouraged in
> > Documentation/process/....
> >
> 
> Thanks for your suggestions, Thomas. I will revise the commit's message.
> 
> Wenwen
> 
> > Other than that:
> >
> > Acked-by: Thomas Gleixner <tglx@linutronix.de>

You didn't add Thomas's Acked-by to your commit ...

Thanks,

	Ingo
