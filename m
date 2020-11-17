Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 174BEC2D0E4
	for <linux-pci@archiver.kernel.org>; Tue, 17 Nov 2020 09:54:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A85A22168B
	for <linux-pci@archiver.kernel.org>; Tue, 17 Nov 2020 09:54:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zSRv/+sh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nZwJf4bF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727661AbgKQJxw (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 17 Nov 2020 04:53:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727656AbgKQJxv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Nov 2020 04:53:51 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6765C0613CF;
        Tue, 17 Nov 2020 01:53:51 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605606830;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=w88X9FArUN9Ckqzryj/SEcOf2eejeb528XBdbye6pQE=;
        b=zSRv/+sh88Dr/9rk83MdKS6DgvvEHpDnOQI56HgqewdzAknFs2efNxcR65h4YMsxaGcpK7
        gH3ikqXPE9y85lFTK/k080y7gE9CGp1EH4LTE/imwJuLN7ZV9I43/iinHvcjMbdI6SaVS1
        2a+cB3WfHEkM6T3A1lvCqVLgt3mCSVRZUAntkbkq+oGyXzA45k3JOA0uPfBuBSBkFAkV3Z
        GGxS3A2FKc5sslgWbRqR0tI+AZDV2Ad8D3gBEOZ+glgJyGHYdo0iqwEVMx7qp9zW2RAoQC
        EIHKhV+/iUGMOdEtZZxR6UJyfI0PW53BpC+LpJXa1I4GLgm3n8qZF1ewD8ix3Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605606830;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=w88X9FArUN9Ckqzryj/SEcOf2eejeb528XBdbye6pQE=;
        b=nZwJf4bFj/fTcUvLbJX3tMEZeH04pRYlzZCgpjdvmfWziaeYnqbVXpXy88KSEJnqy8Ny0W
        ugc7/yMp0qHYPzAw==
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Guilherme G. Piccoli" <gpiccoli@canonical.com>, lukas@wunner.de,
        linux-pci@vger.kernel.org, kernelfans@gmail.com,
        andi@firstfloor.org, hpa@zytor.com, bhe@redhat.com, x86@kernel.org,
        okaya@kernel.org, mingo@redhat.com, jay.vosburgh@canonical.com,
        dyoung@redhat.com, gavin.guo@canonical.com, bp@alien8.de,
        bhelgaas@google.com, Guowen Shan <gshan@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, kernel@gpiccoli.net,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        ddstreet@canonical.com, vgoyal@redhat.com
Subject: Re: [PATCH 1/3] x86/quirks: Scan all busses for early PCI quirks
In-Reply-To: <87h7poeqqn.fsf@x220.int.ebiederm.org>
References: <20201117001907.GA1342260@bjorn-Precision-5520> <87h7poeqqn.fsf@x220.int.ebiederm.org>
Date:   Tue, 17 Nov 2020 10:53:49 +0100
Message-ID: <873618xqaa.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 16 2020 at 19:06, Eric W. Biederman wrote:
> Bjorn Helgaas <helgaas@kernel.org> writes:
> My two top candidates are poking the IOMMUs early to shut things off,
> and figuring out if we can delay enabling interrupts until we have
> initialized pci.

Keeping interrupts disabled post PCI initialization would be nice, but
that requires feeding the whole init machinery through a shredder and
collecting the bits and pieces.

> Poking at IOMMUs early should work for most systems with ``enterprise''
> hardware.  Systems where people care about kdump the most.

The IOMMU IRQ remapping part _is_ initialized early and _before_
interrupts are enabled.

But that does not solve the problem either simply because then the IOMMU
will catch the rogue MSIs and you get an interrupt storm on the IOMMU
error interrupt.

This one is not going to be turned off because the IOMMU error interrupt
handler will handle each of them and tell the core code that everything
is under control.

As I explained several times now, the only way to shut this up reliably
is at the source. Curing the symptom is almost never a good solution.

Thanks,

        tglx
