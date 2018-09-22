Return-Path: <SRS0=8Jd2=ME=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93477ECE560
	for <linux-pci@archiver.kernel.org>; Sat, 22 Sep 2018 15:01:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18ACA21522
	for <linux-pci@archiver.kernel.org>; Sat, 22 Sep 2018 15:01:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AJhJ07z/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18ACA21522
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728476AbeIVUzO (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 22 Sep 2018 16:55:14 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45901 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbeIVUzO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 22 Sep 2018 16:55:14 -0400
Received: by mail-pl1-f194.google.com with SMTP id j8-v6so7222896pll.12;
        Sat, 22 Sep 2018 08:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Q3id+dt8Is+EFT/gsq4oqHyQakZe5Ls9zBtdwdBwRkQ=;
        b=AJhJ07z/8C6qOLtVSzQDqJbZF940IMxV1REWhoKYCGrgHjbmjdNWNaOF7AsNpJNEkM
         kcxQY6/FqQoH0lndxvTmNpH/q8In2zxwuK3bAk3DBAHiM6/yWEfwzFRSM/y9YOe1f19z
         8rdotw57kkogBYH0et2goZgAF5ppYziUEysmjsZWS+FB559XZzVGfMhbx2x7ZYa1OJ6n
         5PplJUI1uNx3uScX7EMLfpI+VQE9QgG9mMCGDGc6XgVp+HwcSjSZyqrG5xxo3TgGlI0o
         fgwbFAm/N8ihac0aI/+CDdfOSr+FYGTRyTM1oigdMoDJDS1WHF1sPrgU9smoln9PeS1H
         fVVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Q3id+dt8Is+EFT/gsq4oqHyQakZe5Ls9zBtdwdBwRkQ=;
        b=RNUsbINS0IfJ3D862DkLRlXACnntu//zYWJ6BBjD/TdB9Zv3c8uCstih3UKxvYpbMg
         QBGzQ7aOeEt6E9h5XpsLUabsSFJdKTaKZOTAtc1ug40Sm6A7ckZZq3sXIoImmWmL19bc
         z0yMe5Qz19eGXOZ9aek9UOPZxLDqBAMdvJovkEFqFeANDYqvqtqidaYXyW1A0f2dF8AC
         I4o47pvUQqeLgsFPSjjhtn6P8rvkbJON/NvBAN6LMy8ob1o7MDvAv2AJEPbAAy7tfcpv
         Ed6ZExLPmottNnSRzo/+QeXKGZiC6vK3lYtf+somNKphMv5o1P+RbT23elelX+mVUGJR
         NgSA==
X-Gm-Message-State: ABuFfoh1Cnu1drhntW4WjcKEzmVN9IpVEGzdG3dPWOAfWizxncgTNbaO
        hiuTw8ahY9AeVhZHv7QTUVc=
X-Google-Smtp-Source: ACcGV61iSQLzt7/T1syoXEEun0/ZlB3VV52L1gXeG3hn7BqXhvbkBvHpUuNCD52u4tQhqkKG+qbs4Q==
X-Received: by 2002:a17:902:e85:: with SMTP id 5-v6mr2911020plx.73.1537628481859;
        Sat, 22 Sep 2018 08:01:21 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id o10-v6sm63437397pfk.76.2018.09.22.08.01.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Sep 2018 08:01:20 -0700 (PDT)
Date:   Sat, 22 Sep 2018 08:01:19 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Christoph Hellwig <hch@lst.de>
Cc:     iommu@lists.linux-foundation.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 4/4] dma-mapping: clear dev->dma_ops in
 arch_teardown_dma_ops
Message-ID: <20180922150119.GA14761@roeck-us.net>
References: <20180827084711.23407-1-hch@lst.de>
 <20180827084711.23407-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180827084711.23407-5-hch@lst.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On Mon, Aug 27, 2018 at 10:47:11AM +0200, Christoph Hellwig wrote:
> There is no reason to leave the per-device dma_ops around when
> deconfiguring a device, so move this code from arm64 into the
> common code.
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>

This patch causes various ppc images to crash in -next due to NULL
DMA ops in dma_alloc_attrs().

Looking into the code, the macio driver tries to instantiate on
the 0000:f0:0d.0 PCI address (the driver maps to all Apple PCI IDs)
and fails. This results in a call to arch_teardown_dma_ops(). Later,
the same device pointer is used to instantiate ohci-pci, which
crashes in probe because the dma_ops pointer has been cleared.

I don't claim to fully understand the code, but to me it looks like
the pci device is allocated and waiting for a driver to attach to.
See arch/powerpc/kernel/pci_of_scan.c:of_create_pci_dev().
If attaching a driver (here: macio) fails, the same device pointer
is then reused for the next matching driver until a match is found
and the device is successfully instantiated. Of course this fails
quite badly if the device pointer has been scrubbed after the first
failure.

I don't know if this is generic PCI behavior or ppc specific.
I am copying pci and ppc maintainers for additional input.

Either case, reverting the patch fixes the problem.

Guenter

---
ohci-pci 0000:f0:0d.0: OHCI PCI host controller
ohci-pci 0000:f0:0d.0: new USB bus registered, assigned bus number 1
------------[ cut here ]------------
kernel BUG at ./include/linux/dma-mapping.h:516!
Oops: Exception in kernel mode, sig: 5 [#1]
BE PREEMPT SMP NR_CPUS=4 NUMA PowerMac
Modules linked in:
CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W
4.19.0-rc4-next-20180921-dirty #1
NIP:  c00000000086b824 LR: c00000000086b5dc CTR: c00000000086dd70
REGS: c00000003d30f0b0 TRAP: 0700   Tainted: G        W
(4.19.0-rc4-next-20180921-dirty)
MSR:  800000000002b032 <SF,EE,FP,ME,IR,DR,RI>  CR: 28008842  XER: 00000000
IRQMASK: 0 
GPR00: c00000000086b5dc c00000003d30f330 c000000001199900 c00000003d3ce898 
GPR04: c00000000115b798 c00000003d8c3a48 0000000000000000 0000000000000000 
GPR08: 0000000000000000 ffffffffffffff00 0000000000000000 0000000000000020 
GPR12: 0000000024008442 c000000001299000 c00000000000f720 0000000000000000 
GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
GPR20: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
GPR24: 0000000000000000 c0000000010452e8 c000000001045420 0000000000000080 
GPR28: 000000000000001c c000000001045408 c00000003d3ce898 c00000003d8c3a30 
NIP [c00000000086b824] .ohci_init+0x564/0x570
LR [c00000000086b5dc] .ohci_init+0x31c/0x570
Call Trace:
[c00000003d30f330] [c00000000086b5dc] .ohci_init+0x31c/0x570 (unreliable)
[c00000003d30f3c0] [c00000000086de58] .ohci_pci_reset+0xa8/0xb0
[c00000003d30f440] [c0000000008335ec] .usb_add_hcd+0x35c/0x9b0
[c00000003d30f510] [c00000000084ea90] .usb_hcd_pci_probe+0x320/0x510
[c00000003d30f5c0] [c0000000006c7df8] .local_pci_probe+0x68/0x140
[c00000003d30f660] [c0000000006c92a4] .pci_device_probe+0x144/0x210
[c00000003d30f710] [c00000000074cd48] .really_probe+0x2a8/0x3c0
[c00000003d30f7b0] [c00000000074d100] .driver_probe_device+0x80/0x170
[c00000003d30f840] [c00000000074d33c] .__driver_attach+0x14c/0x150
[c00000003d30f8d0] [c000000000749c6c] .bus_for_each_dev+0xac/0x100
[c00000003d30f970] [c00000000074c334] .driver_attach+0x34/0x50
[c00000003d30f9f0] [c00000000074b9b8] .bus_add_driver+0x178/0x2f0
[c00000003d30fa90] [c00000000074e560] .driver_register+0x90/0x1a0
[c00000003d30fb10] [c0000000006c707c] .__pci_register_driver+0x6c/0x90
[c00000003d30fba0] [c000000000f39f14] .ohci_pci_init+0x90/0xac
[c00000003d30fc10] [c00000000000f380] .do_one_initcall+0x70/0x2d0
[c00000003d30fce0] [c000000000edfca4] .kernel_init_freeable+0x3b8/0x4b0
[c00000003d30fdb0] [c00000000000f744] .kernel_init+0x24/0x160
[c00000003d30fe30] [c00000000000b7a4] .ret_from_kernel_thread+0x58/0x74

---
# bad: [46c163a036b41a29b0ec3c475bf97515d755ff41] Add linux-next specific files for 20180921
# good: [7876320f88802b22d4e2daf7eb027dd14175a0f8] Linux 4.19-rc4
git bisect start 'HEAD' 'v4.19-rc4'
# bad: [03b5533c4d89cc558063a98fa4201a5d2b4eb1f7] Merge remote-tracking branch 'crypto/master'
git bisect bad 03b5533c4d89cc558063a98fa4201a5d2b4eb1f7
# bad: [62c54071a46255d59e26e95528b80bf432796cb4] Merge remote-tracking branch 'v9fs/9p-next'
git bisect bad 62c54071a46255d59e26e95528b80bf432796cb4
# bad: [1eee72bfcf0977daca74e9f902956adbb4f38847] Merge remote-tracking branch 'realtek/for-next'
git bisect bad 1eee72bfcf0977daca74e9f902956adbb4f38847
# good: [30d3220045f49c707bbeec1d35423bd60488c433] Merge remote-tracking branch 'scsi-fixes/fixes'
git bisect good 30d3220045f49c707bbeec1d35423bd60488c433
# bad: [a31a9772a2aa569dc279468da4be555b737e51f8] Merge remote-tracking branch 'at91/at91-next'
git bisect bad a31a9772a2aa569dc279468da4be555b737e51f8
# bad: [3f52a0ad91857e78a5feed28327eafa11c44412c] Merge remote-tracking branch 'arm-soc/for-next'
git bisect bad 3f52a0ad91857e78a5feed28327eafa11c44412c
# good: [92c76bf9685778b2b7e5d6b4c93d74d9ef5d54a7] Merge remote-tracking branch 'leaks/leaks-next'
git bisect good 92c76bf9685778b2b7e5d6b4c93d74d9ef5d54a7
# good: [4e7afff85160ffaa236785591126cf52e11f077c] Merge branch 'fixes' into for-next
git bisect good 4e7afff85160ffaa236785591126cf52e11f077c
# bad: [5748e1b35ba28368515d850e8087929a3a65e055] MIPS: don't select DMA_MAYBE_COHERENT from DMA_PERDEV_COHERENT
git bisect bad 5748e1b35ba28368515d850e8087929a3a65e055
# good: [ccf640f4c9988653ef884672381b03b9be247bec] dma-mapping: remove dma_configure
git bisect good ccf640f4c9988653ef884672381b03b9be247bec
# bad: [46053c73685411915d3de50c5a0045beef32806b] dma-mapping: clear dev->dma_ops in arch_teardown_dma_ops
git bisect bad 46053c73685411915d3de50c5a0045beef32806b
# good: [dc3c05504d38849f77149cb962caeaedd1efa127] dma-mapping: remove dma_deconfigure
git bisect good dc3c05504d38849f77149cb962caeaedd1efa127
# first bad commit: [46053c73685411915d3de50c5a0045beef32806b] dma-mapping: clear dev->dma_ops in arch_teardown_dma_ops
