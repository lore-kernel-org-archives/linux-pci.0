Return-Path: <SRS0=e3W/=SH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA16BC282CE
	for <linux-pci@archiver.kernel.org>; Fri,  5 Apr 2019 21:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A76DE21726
	for <linux-pci@archiver.kernel.org>; Fri,  5 Apr 2019 21:34:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mbuki-mvuki-org.20150623.gappssmtp.com header.i=@mbuki-mvuki-org.20150623.gappssmtp.com header.b="O2iDRTx2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbfDEVe4 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 5 Apr 2019 17:34:56 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47]:44923 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbfDEVe4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 5 Apr 2019 17:34:56 -0400
Received: by mail-wr1-f47.google.com with SMTP id y7so9544703wrn.11
        for <linux-pci@vger.kernel.org>; Fri, 05 Apr 2019 14:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbuki-mvuki-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NyvK4CkZko+1ZyXXLKPTfOXhwHWsjBk4NGNi5kyz4ww=;
        b=O2iDRTx2YqKVdqsXf/hpIVGmWx1FL0Mnjf0ZmwXLxDgXD/BvYDgJHorj3Y0ZQatMfV
         G+xz5D8lmKF7hn6cywb0gThedPnuxLwaMybU1zzFjzuKk8LF4S65ly7tNOkOBC3jJVzA
         xChQink66guhFbwqQ9aNIahLCmszemWpHhI0Qo+MllBz6jbRLCVVGBEyBv9ftZn6KUx4
         6iY9Oz6ByjLF/lo3VWjXosUPW9onHbJwwYtxWaEcIRdSMSUrZIc8qIFsWCUn9CnX5tLF
         owR8n7VIgyXT1vS6zTAETU5HCXKQnUmw3OivIve/QX4iNL02UsVCU5kzKGqGimRlc8Tc
         0IPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NyvK4CkZko+1ZyXXLKPTfOXhwHWsjBk4NGNi5kyz4ww=;
        b=eWDidbMnVK0OjNlZM57vuFs9AYUl7OMlFLbfiX3VV+tY0tc8NXqOpNWoRUcloRHJgc
         oj2U9Vw1L+dirLW8ls+g6jUej+sK4yCSPRHuYYQetl6LF5HxH6gMJsFcQhWY4CSy83+s
         Q4s07LU+xMI7OQ4jJbdlPABHoDDfJQk4Q7U9lbfCFJcHgxuF6TodzPc6/OKoKoJgh6lq
         8TIa5M+8psYsIZPZRUtIukN+JujHhgStPOnNyF1zPngp6u1S0GPEqFPEBM+5gin7+nHK
         HQL6wvqOS55mcO8vIolE1fGQcNXr7MAHT81sVOcpFM/MpIeXISC1Cwt3mnce6gZRYeN5
         n2uQ==
X-Gm-Message-State: APjAAAV1uT1XjQXmrbeFXtipTSKZT1UfEnZdxm4dVIxqABVoFajQF0xt
        9VYc3FUvG0Yf9sUqKFyoFkUY2d6N71ZIYm6qolWJEg==
X-Google-Smtp-Source: APXvYqwIenadDP1gIaPT2VZVsLHbl3lT+ta3Izq3owqgDG2GVGUa7Xa4HO41346PpP8r/aNSGNy+A+8yhYNt091Up/w=
X-Received: by 2002:a5d:6406:: with SMTP id z6mr10523988wru.266.1554499637318;
 Fri, 05 Apr 2019 14:27:17 -0700 (PDT)
MIME-Version: 1.0
References: <CANSNSoWL-2hP6j+nQwjr26vUmvyJ_Y1c9CrJ4bHnuqYCXhecdg@mail.gmail.com>
 <Pine.LNX.4.44L0.1904041509280.1288-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1904041509280.1288-100000@iolanthe.rowland.org>
From:   Jesse Hathaway <jesse@mbuki-mvuki.org>
Date:   Fri, 5 Apr 2019 16:27:06 -0500
Message-ID: <CANSNSoVGLEkRE5DPyVhPVdsCbu44SOu0Tpf7smWjPUn_qwRHHA@mail.gmail.com>
Subject: Re: Regression causes a hang on boot with a Comtrol PCI card
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 4, 2019 at 2:14 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> Okay.  You could try skipping that pci_write_config_byte() call.  The
> following loop would probably time out, and you might find that the
> code crashes later on.
>
> You could also try setting try_handoff to 0 near the start of the
> routine.  Your system plus the Comtrol PCI card could have the same
> sort of bug as reported in Bugzilla #77021.

I tried both of those options and the output was similar, here is the output
with try_handoff set to 0. In both cases the box then hangs on initializing
pstore. Excuse my ignorance on understanding how having the Comtrol
card present would effect the USB handoff, but would there be any
value in trying to boot this box via UEFI, rather than via the BIOS? Does
UEFI handle the handoff differently?

[   11.391514] DEBUG: Passed quirk_usb_disable_ehci 945
[   11.397250] DEBUG: Passed quirk_usb_disable_ehci 950
[   11.402988] DEBUG: Passed quirk_usb_disable_ehci 958
[   11.408724] DEBUG: Passed quirk_usb_disable_ehci 964
[   11.414461] DEBUG: Passed quirk_usb_disable_ehci 968
[   11.420197] DEBUG: Passed ehci_bios_handoff 849
[   11.425448] DEBUG: Passed ehci_bios_handoff 889
[   11.430699] DEBUG: Passed ehci_bios_handoff 902
[   11.435952] DEBUG: Passed ehci_bios_handoff 918
[   11.441203] DEBUG: Passed ehci_bios_handoff 926
[   11.446455] DEBUG: Passed quirk_usb_disable_ehci 981
[   11.452292] DEBUG: Passed quirk_usb_disable_ehci 1009
[   11.458180] pci 0000:00:1d.0: quirk_usb_early_handoff+0x0/0x865
took 82350 usecs
[   11.466568] pci 0000:01:00.0: calling  quirk_e100_interrupt+0x0/0x1a0 @ 1
[   11.474249] pci 0000:01:00.0: quirk_e100_interrupt+0x0/0x1a0 took 0 usecs
[   11.481931] pci 0000:01:00.1: calling  quirk_e100_interrupt+0x0/0x1a0 @ 1
[   11.489612] pci 0000:01:00.1: quirk_e100_interrupt+0x0/0x1a0 took 0 usecs
[   11.497296] pci 0000:03:00.0: calling  quirk_blacklist_vpd+0x0/0x30 @ 1
[   11.504783] pci 0000:03:00.0: [Firmware Bug]: disabling VPD access
(can't determine size of non-standard VPD format)
[   11.516663] pci 0000:03:00.0: quirk_blacklist_vpd+0x0/0x30 took 11600 usecs
[   11.524538] pci 0000:07:00.0: calling  quirk_e100_interrupt+0x0/0x1a0 @ 1
[   11.532219] pci 0000:07:00.0: quirk_e100_interrupt+0x0/0x1a0 took 0 usecs
[   11.539901] pci 0000:07:00.1: calling  quirk_e100_interrupt+0x0/0x1a0 @ 1
[   11.547582] pci 0000:07:00.1: quirk_e100_interrupt+0x0/0x1a0 took 0 usecs
[   11.555374] pci 0000:0b:00.0: calling  pci_fixup_video+0x0/0x110 @ 1
[   11.562797] pci 0000:0b:00.0: Video device with shadowed ROM at
[mem 0x000c0000-0x000dffff]
[   11.572248] pci 0000:0b:00.0: pci_fixup_video+0x0/0x110 took 9453 usecs
[   11.579991] Unpacking initramfs...
[   11.923856] Freeing initrd memory: 22636K
[   11.950050] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[   11.957345] software IO TLB: mapped [mem 0x76289000-0x7a289000] (64MB)
[   11.967721] Initialise system trusted keyrings
[   11.972908] workingset: timestamp_bits=40 max_order=27 bucket_order=0
[   11.981517] zbud: loaded
[   12.138528] Key type asymmetric registered
[   12.143201] Asymmetric key parser 'x509' registered
[   12.148754] Block layer SCSI generic (bsg) driver version 0.4
loaded (major 247)
[   12.157245] io scheduler mq-deadline registered
[   12.163318] pcieport 0000:00:01.0: Signaling PME with IRQ 25
[   12.169926] pcieport 0000:00:02.0: Signaling PME with IRQ 26
[   12.176519] pcieport 0000:00:03.0: Signaling PME with IRQ 27
[   12.183109] pcieport 0000:00:03.2: Signaling PME with IRQ 28
[   12.189678] pcieport 0000:00:1c.0: Signaling PME with IRQ 29
[   12.196248] pcieport 0000:00:1c.4: Signaling PME with IRQ 30
[   12.202833] pcieport 0000:00:1c.7: Signaling PME with IRQ 31
[   12.212006] pcieport 0000:80:01.0: Signaling PME with IRQ 33
[   12.218609] pcieport 0000:80:03.0: Signaling PME with IRQ 34
[   12.225404] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[   12.238133] ERST: Error Record Serialization Table (ERST) support
is initialized.
[   12.246614] pstore: Registered erst as persistent store backend
