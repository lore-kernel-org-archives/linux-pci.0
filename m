Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DC23C2D0E4
	for <linux-pci@archiver.kernel.org>; Sun, 15 Nov 2020 14:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC95222273
	for <linux-pci@archiver.kernel.org>; Sun, 15 Nov 2020 14:32:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbgKOOcP (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 15 Nov 2020 09:32:15 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:37462 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbgKOOcP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 15 Nov 2020 09:32:15 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1keIeg-009fU2-79; Sun, 15 Nov 2020 07:05:22 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1keIef-0003D4-7f; Sun, 15 Nov 2020 07:05:21 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Guilherme G. Piccoli" <gpiccoli@canonical.com>,
        linux-pci@vger.kernel.org, kexec@lists.infradead.org,
        x86@kernel.org, linux-kernel@vger.kernel.org, bhelgaas@google.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, andi@firstfloor.org,
        lukas@wunner.de, okaya@kernel.org, kernelfans@gmail.com,
        ddstreet@canonical.com, gavin.guo@canonical.com,
        jay.vosburgh@canonical.com, kernel@gpiccoli.net,
        shan.gavin@linux.alibaba.com,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
References: <20201114212215.GA1194074@bjorn-Precision-5520>
Date:   Sun, 15 Nov 2020 08:05:05 -0600
In-Reply-To: <20201114212215.GA1194074@bjorn-Precision-5520> (Bjorn Helgaas's
        message of "Sat, 14 Nov 2020 15:22:15 -0600")
Message-ID: <87v9e6n2b2.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1keIef-0003D4-7f;;;mid=<87v9e6n2b2.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+YuU7K8slUpoLdruiB0niDW9O6RxUm9go=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 1/3] x86/quirks: Scan all busses for early PCI quirks
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Bjorn Helgaas <helgaas@kernel.org> writes:

> [+cc Rafael for question about ACPI method for PCI host bridge reset]
>
> On Sat, Nov 14, 2020 at 09:58:08PM +0100, Thomas Gleixner wrote:
>> On Sat, Nov 14 2020 at 14:39, Bjorn Helgaas wrote:
>> > On Sat, Nov 14, 2020 at 12:40:10AM +0100, Thomas Gleixner wrote:
>> >> On Sat, Nov 14 2020 at 00:31, Thomas Gleixner wrote:
>> >> > On Fri, Nov 13 2020 at 10:46, Bjorn Helgaas wrote:
>> >> >> pci_device_shutdown() still clears the Bus Master Enable bit if we're
>> >> >> doing a kexec and the device is in D0-D3hot, which should also disable
>> >> >> MSI/MSI-X.  Why doesn't this solve the problem?  Is this because the
>> >> >> device causing the storm was in PCI_UNKNOWN state?
>> >> >
>> >> > That's indeed a really good question.
>> >> 
>> >> So we do that on kexec, but is that true when starting a kdump kernel
>> >> from a kernel crash? I doubt it.
>> >
>> > Ah, right, I bet that's it, thanks.  The kdump path is basically this:
>> >
>> >   crash_kexec
>> >     machine_kexec
>> >
>> > while the usual kexec path is:
>> >
>> >   kernel_kexec
>> >     kernel_restart_prepare
>> >       device_shutdown
>> >         while (!list_empty(&devices_kset->list))
>> >           dev->bus->shutdown
>> >             pci_device_shutdown            # pci_bus_type.shutdown
>> >     machine_kexec
>> >
>> > So maybe we need to explore doing some or all of device_shutdown() in
>> > the crash_kexec() path as well as in the kernel_kexec() path.
>> 
>> The problem is that if the machine crashed anything you try to attempt
>> before starting the crash kernel is reducing the chance that the crash
>> kernel actually starts.
>
> Right.
>
>> Is there something at the root bridge level which allows to tell the
>> underlying busses to shut up, reset or go into a defined state? That
>> might avoid chasing lists which might be already unreliable.
>
> Maybe we need some kind of crash_device_shutdown() that does the
> minimal thing to protect the kdump kernel from devices.

The kdump kernel does not use any memory the original kernel uses.
Which should be a minimal and fairly robust level of protection
until the device drivers can be loaded and get ahold of things.

> The programming model for conventional PCI host bridges and PCIe Root
> Complexes is device-specific since they're outside the PCI domain.
> There probably *are* ways to do those things, but you would need a
> native host bridge driver or something like an ACPI method.  I'm not
> aware of an ACPI way to do this, but I added Rafael in case he is.
>
> A crash_device_shutdown() could do something at the host bridge level
> if that's possible, or reset/disable bus mastering/disable MSI/etc on
> individual PCI devices if necessary.

Unless I am confused DMA'ing to memory that is not already in use
is completely broken wether or not you are using the kdump kernel.

Eric
