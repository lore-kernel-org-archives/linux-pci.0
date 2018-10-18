Return-Path: <SRS0=PAID=M6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1EBDC67863
	for <linux-pci@archiver.kernel.org>; Thu, 18 Oct 2018 20:08:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E21321476
	for <linux-pci@archiver.kernel.org>; Thu, 18 Oct 2018 20:08:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bgPuvpPp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E21321476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725735AbeJSELJ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 19 Oct 2018 00:11:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:33084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725139AbeJSELJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 19 Oct 2018 00:11:09 -0400
Received: from [10.80.45.152] (unknown [71.69.156.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4417208E4;
        Thu, 18 Oct 2018 20:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539893312;
        bh=mB0r5vgTcOZ7+q+Vi2oi4y/lRd99XGe/aq9c8jdZxPU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=bgPuvpPp9C5uBGwi/tq8XRSILiKUFs/lamBED2oiHkkWOMH4p4qIXbhJ3bNW0W2H7
         jMKrYSkiEREq+Q9R8l7bP5f1TOelLaz+o97TMiRnDN6xWnjlplCETWDE182A4A2Ibt
         ma58+a7h0ryvWoty/lbnVJEuk1gk3DAGUXn4YFas=
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
From:   Sinan Kaya <okaya@kernel.org>
Message-ID: <6fd4e2d2-c0ac-b26d-9a14-0379b4421679@kernel.org>
Date:   Thu, 18 Oct 2018 16:08:27 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181018183721.27467-3-gpiccoli@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/18/2018 2:37 PM, Guilherme G. Piccoli wrote:
> We observed a kdump failure in x86 that was narrowed down to MSI irq
> storm coming from a PCI network device. The bug manifests as a lack of
> progress in the boot process of kdump kernel, and a flood of kernel
> messages like:
> 
> [...]
> [ 342.265294] do_IRQ: 0.155 No irq handler for vector
> [ 342.266916] do_IRQ: 0.155 No irq handler for vector
> [ 347.258422] do_IRQ: 14053260 callbacks suppressed
> [...]

These kind of issues are usually fixed by fixing the network driver's
shutdown routine to ensure that MSI interrupts are cleared there.
