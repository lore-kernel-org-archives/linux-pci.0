Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1721C2D0E4
	for <linux-pci@archiver.kernel.org>; Tue, 17 Nov 2020 22:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63BE0241A7
	for <linux-pci@archiver.kernel.org>; Tue, 17 Nov 2020 22:26:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbgKQWZv (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 17 Nov 2020 17:25:51 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:45876 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbgKQWZv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Nov 2020 17:25:51 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kf9Pz-00G68N-7Z; Tue, 17 Nov 2020 15:25:43 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1kf9Px-0004kB-P4; Tue, 17 Nov 2020 15:25:42 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "Guilherme G. Piccoli" <gpiccoli@canonical.com>, lukas@wunner.de,
        linux-pci@vger.kernel.org, kernelfans@gmail.com,
        andi@firstfloor.org, hpa@zytor.com, bhe@redhat.com, x86@kernel.org,
        okaya@kernel.org, mingo@redhat.com, jay.vosburgh@canonical.com,
        dyoung@redhat.com, gavin.guo@canonical.com, bp@alien8.de,
        bhelgaas@google.com, Guowen Shan <gshan@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, kernel@gpiccoli.net,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        ddstreet@canonical.com, vgoyal@redhat.com
References: <20201117001907.GA1342260@bjorn-Precision-5520>
        <87h7poeqqn.fsf@x220.int.ebiederm.org>
        <873618xqaa.fsf@nanos.tec.linutronix.de>
        <f0d35834054cc1ac77ac0e6b68e84d62de3c48f7.camel@infradead.org>
        <87wnyjwzeo.fsf@nanos.tec.linutronix.de>
Date:   Tue, 17 Nov 2020 16:25:23 -0600
In-Reply-To: <87wnyjwzeo.fsf@nanos.tec.linutronix.de> (Thomas Gleixner's
        message of "Tue, 17 Nov 2020 20:34:23 +0100")
Message-ID: <87blfv7h9o.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1kf9Px-0004kB-P4;;;mid=<87blfv7h9o.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+pLfFxcS2M3EcGaZoSonDznaIdpaF8R1I=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 1/3] x86/quirks: Scan all busses for early PCI quirks
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Thomas Gleixner <tglx@linutronix.de> writes:

> On Tue, Nov 17 2020 at 12:19, David Woodhouse wrote:
>> On Tue, 2020-11-17 at 10:53 +0100, Thomas Gleixner wrote:
>>> But that does not solve the problem either simply because then the IOMMU
>>> will catch the rogue MSIs and you get an interrupt storm on the IOMMU
>>> error interrupt.
>>
>> Not if you can tell the IOMMU to stop reporting those errors.
>>
>> We can easily do it per-device for DMA errors; not quite sure what
>> granularity we have for interrupts. Perhaps the Intel IOMMU only lets
>> you set the Fault Processing Disable bit per IRTE entry, and you still
>> get faults for Compatibility Format interrupts? Not sure about AMD...
>
> It looks like the fault (DMAR) and event (AMD) interrupts can be
> disabled in the IOMMU. That might help to bridge the gap until the PCI
> bus is scanned in full glory and the devices can be shut up for real.
>
> If we make this conditional for a crash dump kernel that might do the
> trick.
>
> Lot's of _might_ there :)

Worth testing.

Folks tracking this down is this enough of a hint for you to write a
patch and test?

Also worth checking how close irqpoll is to handling a case like this.
At least historically it did a pretty good job at shutting down problem
interrupts.

I really find it weird that an edge triggered irq was firing fast enough
to stop a system from booting.  Level triggered irqs do that if they are
acknolwedged without actually being handled.  I think edge triggered
irqs only fire when another event comes in, and it seems odd to get so
many actual events causing interrupts that the system soft locks
up.  Is my memory of that situation confused?

I recommend making these facilities general debug facilities so that
they can be used for cases other than crash dump.  The crash dump kernel
would always enable them because it can assume that the hardware is
very likely in a wonky state.

Eric

