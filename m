Return-Path: <SRS0=PAID=M6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9F0CC67863
	for <linux-pci@archiver.kernel.org>; Thu, 18 Oct 2018 20:30:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DDEF21480
	for <linux-pci@archiver.kernel.org>; Thu, 18 Oct 2018 20:30:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="U35eCchs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DDEF21480
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbeJSEdJ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 19 Oct 2018 00:33:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:39364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725738AbeJSEdJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 19 Oct 2018 00:33:09 -0400
Received: from [10.80.45.152] (unknown [71.69.156.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EAB102145D;
        Thu, 18 Oct 2018 20:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539894626;
        bh=ru6OX5LR/9642YeLpzLwhx/DB0bSIvUmX/c1D9h1UUI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=U35eCchslzRc9dg8uSaQL71VT3olPvRfG0ude3wEpwMS2HlQcW3ykUHTt+aEpKt4g
         +28N5oP9NtenU9AcXEUiUMXwcftmvjKoo1Eh9gV4C+cSz9YhXDob6WiIQDNwBuyY1m
         Y8Bsr6YlMuZoWa4dJBwHU0A0uzwpk8cjj5DSlFMg=
Subject: Re: [PATCH 3/3] x86/quirks: Add parameter to clear MSIs early on boot
To:     "Guilherme G. Piccoli" <gpiccoli@canonical.com>,
        linux-pci@vger.kernel.org, kexec@lists.infradead.org,
        x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, bhelgaas@google.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        andi@firstfloor.org, lukas@wunner.de, billy.olsen@canonical.com,
        cascardo@canonical.com, ddstreet@canonical.com,
        fabiomirmar@canonical.com, gavin.guo@canonical.com,
        jay.vosburgh@canonical.com, kernel@gpiccoli.net, mfo@canonical.com,
        shan.gavin@linux.alibaba.com
References: <20181018183721.27467-1-gpiccoli@canonical.com>
 <20181018183721.27467-3-gpiccoli@canonical.com>
 <6fd4e2d2-c0ac-b26d-9a14-0379b4421679@kernel.org>
 <12d6175b-7f09-872a-61c4-700e905579c7@canonical.com>
From:   Sinan Kaya <okaya@kernel.org>
Message-ID: <50d84d48-eebf-ed91-8148-be727f76883f@kernel.org>
Date:   Thu, 18 Oct 2018 16:30:22 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <12d6175b-7f09-872a-61c4-700e905579c7@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/18/2018 4:13 PM, Guilherme G. Piccoli wrote:
>> These kind of issues are usually fixed by fixing the network driver's
>> shutdown routine to ensure that MSI interrupts are cleared there.
> 
> Sinan, I'm not sure shutdown handlers for drivers are called in panic
> kexec (I remember of an old experiment I did, loading a kernel
> with "kexec -p" didn't trigger the handlers).

AFAIK, all shutdown (not remove) routines are called before launching the next
kernel even in crash scenario. It is not safe to start the new kernel while
hardware is doing a DMA to the system memory and triggering interrupts.

Shutdown routine in PCI core used to disable MSI/MSI-x on behalf of all
endpoints but it was later decided that this is the responsibility of the
endpoint driver.

commit fda78d7a0ead144f4b2cdb582dcba47911f4952c
Author: Prarit Bhargava <prarit@redhat.com>
Date:   Thu Jan 26 14:07:47 2017 -0500

     PCI/MSI: Stop disabling MSI/MSI-X in pci_device_shutdown()

     The pci_bus_type .shutdown method, pci_device_shutdown(), is called from
     device_shutdown() in the kernel restart and shutdown paths.

     Previously, pci_device_shutdown() called pci_msi_shutdown() and
     pci_msix_shutdown().  This disables MSI and MSI-X, which causes the device
     to fall back to raising interrupts via INTx.  But the driver is still bound
     to the device, it doesn't know about this change, and it likely doesn't
     have an INTx handler, so these INTx interrupts cause "nobody cared"
     warnings like this:

       irq 16: nobody cared (try booting with the "irqpoll" option)
       CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.8.2-1.el7_UNSUPPORTED.x86_64 #1
       Hardware name: Hewlett-Packard HP Z820 Workstation/158B, BIOS J63 v03.90 06/
       ...

     The MSI disabling code was added by d52877c7b1af ("pci/irq: let
     pci_device_shutdown to call pci_msi_shutdown v2") because a driver left MSI
     enabled and kdump failed because the kexeced kernel wasn't prepared to
     receive the MSI interrupts.

    Subsequent commits 1851617cd2da ("PCI/MSI: Disable MSI at enumeration even
     if kernel doesn't support MSI") and  e80e7edc55ba ("PCI/MSI: Initialize MSI
     capability for all architectures") changed the kexeced kernel to disable
     all MSIs itself so it no longer depends on the crashed kernel to clean up
     after itself.

     Stop disabling MSI/MSI-X in pci_device_shutdown().  This resolves the
     "nobody cared" unhandled IRQ issue above.  It also allows PCI serial
     devices, which may rely on the MSI interrupts, to continue outputting
     messages during reboot/shutdown.

     [bhelgaas: changelog, drop pci_msi_shutdown() and pci_msix_shutdown() calls
     altogether]
     Fixes: https://bugzilla.kernel.org/show_bug.cgi?id=187351
     Signed-off-by: Prarit Bhargava <prarit@redhat.com>
     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
     CC: Alex Williamson <alex.williamson@redhat.com>
     CC: David Arcari <darcari@redhat.com>
     CC: Myron Stowe <mstowe@redhat.com>
     CC: Lukas Wunner <lukas@wunner.de>
     CC: Keith Busch <keith.busch@intel.com>
     CC: Mika Westerberg <mika.westerberg@linux.intel.com>



> 
> But this case is even worse, because the NICs were in PCI passthrough
> mode, using vfio. So, they were completely unaware of what happened
> in the host kernel.
> 
> Also, this is spec compliant - system reset events should guarantee the
> bits are cleared (although kexec is not exactly a system reset, it's
> similar)

