Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EE52C388F9
	for <linux-pci@archiver.kernel.org>; Tue, 17 Nov 2020 01:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C7B22468B
	for <linux-pci@archiver.kernel.org>; Tue, 17 Nov 2020 01:07:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbgKQBHG (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 16 Nov 2020 20:07:06 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:35896 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbgKQBHF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Nov 2020 20:07:05 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kepSU-00Ds8n-El; Mon, 16 Nov 2020 18:06:58 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kepST-002qfT-AH; Mon, 16 Nov 2020 18:06:58 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Guilherme G. Piccoli" <gpiccoli@canonical.com>,
        Thomas Gleixner <tglx@linutronix.de>, lukas@wunner.de,
        linux-pci@vger.kernel.org, kernelfans@gmail.com,
        andi@firstfloor.org, hpa@zytor.com, bhe@redhat.com, x86@kernel.org,
        okaya@kernel.org, mingo@redhat.com, jay.vosburgh@canonical.com,
        dyoung@redhat.com, gavin.guo@canonical.com, bp@alien8.de,
        bhelgaas@google.com, Guowen Shan <gshan@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, kernel@gpiccoli.net,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        ddstreet@canonical.com, vgoyal@redhat.com
References: <20201117001907.GA1342260@bjorn-Precision-5520>
Date:   Mon, 16 Nov 2020 19:06:40 -0600
In-Reply-To: <20201117001907.GA1342260@bjorn-Precision-5520> (Bjorn Helgaas's
        message of "Mon, 16 Nov 2020 18:19:07 -0600")
Message-ID: <87h7poeqqn.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1kepST-002qfT-AH;;;mid=<87h7poeqqn.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX188ydrQYzwMz6XyNvsZC3ptsCeXvn1fyKU=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 1/3] x86/quirks: Scan all busses for early PCI quirks
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Bjorn Helgaas <helgaas@kernel.org> writes:

> I don't think passing the device information to the kdump kernel is
> really practical.  The kdump kernel would use it to do PCI config
> writes to disable MSIs before enabling IRQs, and it doesn't know how
> to access config space that early.

I don't think it is particularly practical either.  But in practice
on x86 it is either mmio writes or 0xcf8 style writes and we could
pass a magic table that would have all of that information.

> We could invent special "early config access" things, but that gets
> really complicated really fast.  Config access depends on ACPI MCFG
> tables, firmware interfaces, and in many cases, on the native host
> bridge drivers in drivers/pci/controllers/.

I do agree that the practical problem with passing information early
is that gets us into the weeds and creates code that we only care
about in the case of kexec-on-panic.  It is much better to make the
existing code more robust, so that we reduce our dependency on firmware
doing the right thing.

> I think we need to disable MSIs in the crashing kernel before the
> kexec.  It adds a little more code in the crash_kexec() path, but it
> seems like a worthwhile tradeoff.

Disabling MSIs in the b0rken kernel is not possible.

Walking the device tree or even a significant subset of it hugely
decreases the chances that we will run into something that is incorrect
in the known broken kernel.  I expect the code to do that would double
or triple the amount of code that must be executed in the known broken
kernel.  The last time something like that happened (switching from xchg
to ordinary locks) we had cases that stopped working.  Walking all of
the pci devices in the system is much more invasive.

That is not to downplay the problems of figuring out how to disable
things in early boot.

My two top candidates are poking the IOMMUs early to shut things off,
and figuring out if we can delay enabling interrupts until we have
initialized pci.

Poking at IOMMUs early should work for most systems with ``enterprise''
hardware.  Systems where people care about kdump the most.

Eric
