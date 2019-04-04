Return-Path: <SRS0=GqAx=SG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21A81C4360F
	for <linux-pci@archiver.kernel.org>; Thu,  4 Apr 2019 15:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E530220882
	for <linux-pci@archiver.kernel.org>; Thu,  4 Apr 2019 15:41:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mbuki-mvuki-org.20150623.gappssmtp.com header.i=@mbuki-mvuki-org.20150623.gappssmtp.com header.b="oq4kLXLk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728803AbfDDPln (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 4 Apr 2019 11:41:43 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46287 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbfDDPln (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 4 Apr 2019 11:41:43 -0400
Received: by mail-wr1-f66.google.com with SMTP id t17so4327833wrw.13
        for <linux-pci@vger.kernel.org>; Thu, 04 Apr 2019 08:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbuki-mvuki-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PSR7+ApwjHyFZeIVwbODK3Yvem8n9K72eRmimyFKNn4=;
        b=oq4kLXLkojfUI8oe7XQ9xj1Y3EQnLGayxfnxSetYe73B2FpK4En0zpT9JMScYXsbY6
         QY/sNUXWOUY8v5YQXACnSGR8zj3r2aghOe+LLCS8VxNQjBaZ9FanxxUCHbQRfkjJm4yi
         YY+MHeYFDaLdjLHkDu553NdCiQXHj4RlXxGOeW8Ikux0fnltudvq/19pzqc2mQoODL9d
         XmbUE4ztudW+U01fkCzlJEt4wAD/ocyl29ZsaGF6ZUQ1aE98ilPijleOPJDDxaYK36VQ
         aU3Vorr99zysWD0mNrOva8txrRyDOPaBUFVfKI2ktxiYPhI+lLdtb5+D3QfYHXoNvhDs
         PR9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PSR7+ApwjHyFZeIVwbODK3Yvem8n9K72eRmimyFKNn4=;
        b=gokvfzMKM1U7Cn+Hbq1e9yePeDKTHVOmO83Xv2YzgZXs5dn9pC09WMZA6QtjCnggzd
         DfF0elgTy/8uKb4kvB14PlZUGDO++Pys2hgaAprQgfi2XlRg85mHE/f4PQ0TqyQgNBEq
         Pjjyd+YW3X2g2ZoyiExlusNsNxbaHRARGVfv4O360iqZDLce0+31ypGMtjEUx+0WIeIg
         kPOcsNtKeNVVaSXK/JfFR9kwGzYSV6S4n6jistb7DYjFrPWdfgiRpYNfq85/l1cTK1Bw
         5iTI/t719Ri1FmVhRC3GlAKqThoGfzO9VLn6/z2UMxvdMIPjg4KsJMhi6dqRwrBFZB6b
         67Gw==
X-Gm-Message-State: APjAAAXBCgvN4RMLQQILXERz2weUEBitvlYGFurHAe7Y+j9YeLJ8x3Lv
        WiPWBbcGfVILEbsOMBQtfq7yA0MCCiRwfByBwCMU1g==
X-Google-Smtp-Source: APXvYqwRBK2a4IcepyBsbnqP5X5u3caVU/sWsRjs775lHY6PMkTMp1GH+Pm9QFp5nKgUr0B6TLKtsuakT8RwLMZo+WY=
X-Received: by 2002:adf:b3d4:: with SMTP id x20mr4589065wrd.284.1554392501124;
 Thu, 04 Apr 2019 08:41:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190401211353.GA7263@google.com> <Pine.LNX.4.44L0.1904021028110.1562-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1904021028110.1562-100000@iolanthe.rowland.org>
From:   Jesse Hathaway <jesse@mbuki-mvuki.org>
Date:   Thu, 4 Apr 2019 10:41:29 -0500
Message-ID: <CANSNSoXOmExO2RSp1gS8myUuiDpva4=0GeGpv+t8+X9p0u0H_w@mail.gmail.com>
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

On Tue, Apr 2, 2019 at 9:29 AM Alan Stern <stern@rowland.harvard.edu> wrote:
> Most likely the problem occurs somewhere inside
> quirk_usb_handoff_xhci().  Can Jesse add debugging statements to that
> routine in order to pin down exactly where the problem lies?

Alan,

I added debug statements to quirk_usb_early_handoff, quirk_usb_disable_ehci &
ehci_bios_handoff. The box hangs right before calling:

pci_write_config_byte(pdev, offset + 3, 1);

which is in ehci_bios_handoff:

[   10.698240] DEBUG: Passed quirk_usb_early_handoff 1300
[   10.704271] DEBUG: Passed quirk_usb_early_handoff 1308
[   10.710206] DEBUG: Passed quirk_usb_disable_ehci 939
[   10.715949] DEBUG: Passed quirk_usb_disable_ehci 945
[   10.721685] DEBUG: Passed quirk_usb_disable_ehci 950
[   10.727423] DEBUG: Passed quirk_usb_disable_ehci 958
[   10.733160] DEBUG: Passed quirk_usb_disable_ehci 964
[   10.738897] DEBUG: Passed quirk_usb_disable_ehci 968
[   10.744633] DEBUG: Passed ehci_bios_handoff 849
[   10.749884] DEBUG: Passed ehci_bios_handoff 884

I have attached the debug output, and my modified pci-quirks.c file
to the bug report, let me know what else I can do to help.
