Return-Path: <SRS0=Emu/=SZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F84C282DD
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 20:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6E9C21850
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 20:18:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mbuki-mvuki-org.20150623.gappssmtp.com header.i=@mbuki-mvuki-org.20150623.gappssmtp.com header.b="Gr2YwS3q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbfDWUSx (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 23 Apr 2019 16:18:53 -0400
Received: from mail-wm1-f52.google.com ([209.85.128.52]:53700 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbfDWUSx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Apr 2019 16:18:53 -0400
Received: by mail-wm1-f52.google.com with SMTP id q16so1654179wmj.3
        for <linux-pci@vger.kernel.org>; Tue, 23 Apr 2019 13:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbuki-mvuki-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ASdjcawRrrgqD5NQTFWWrPiiL1LVNSOCmnViIVcvQ6Y=;
        b=Gr2YwS3qU7+5fjpkMPPgO5j7LWl8WnaQDSn+E87hOzPVDtV7IJFviPAHW4Nwsmpl9E
         zNpD+1L95k15UwdQmn64KWeDIpMPHU1kIda0298HbUTMCmYFL9aE6kgR5bXePIJ4jMfw
         /BfGBzbGhz3vxGcTWiQera/+BY3vR805TiVK4oGa2pswGKlOjUYoMmpO6fYNLmYSy1HG
         hVSKjM6DLe+XUzOiFuAIMYbAzW0vdPpgjsAwDve03WdaUk2NjAVUg72k1YZDZMFgE9fa
         5ATsXw8pTKCxvgl/DQFaiO4O1GSdectA6/Hb1wmH+DLEvUu56E50do6dHudL9+CEGB9a
         wF8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ASdjcawRrrgqD5NQTFWWrPiiL1LVNSOCmnViIVcvQ6Y=;
        b=ptLDRoaLWA2eP8uHmw2CmTWw1hicnzgWt9o2Uu1MtxSX943+ni4hVxQCmhuaEGYoIp
         MAtbJgiQjsKILqlclSDfqezvruQFcxsaMO8B94ZAf4SA6mWYsf6atNqT4Ol7Qjg824nU
         ppeSkeempDyJMWyvkihUcoF1/GGvP+jfEZ9mhspBfUKAO7zsYR1FP++dWV/Wgs1n4zpN
         MEvhne49Gu5HFAztdsylC6YrxtlQXHVnWoKhZB3oNo6lyKXnzDynSjNOugRmDFB7vULo
         rE+m9bRmmgTTz388S5VhecmRs4D4oGRacMetsPq0xpsFvOQBP78qB69dd4fYdNeLZUQS
         pOgA==
X-Gm-Message-State: APjAAAWIe/KWBfSBGkl0xmY4OeMKz+xNCo3Cj9e7z+d29JhVVivDNpww
        BIrVJCqkrbXHHmnhPjGhs5exzED+VtTO4obBXIG3DQ==
X-Google-Smtp-Source: APXvYqz0c74W3/SXXAurawT7D62mo7DC7HpYucHH34+Gj20/qv8EnEvmc2KbfzlCiAGiiZUZopMUy698V0IClWXvKn0=
X-Received: by 2002:a1c:96d5:: with SMTP id y204mr3682109wmd.22.1556050731126;
 Tue, 23 Apr 2019 13:18:51 -0700 (PDT)
MIME-Version: 1.0
References: <CANSNSoVpnK6fyfFct7cLNRJAvdLWh0ac=isnPOkOAp4LV+WoSw@mail.gmail.com>
 <Pine.LNX.4.44L0.1904161054060.1605-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1904161054060.1605-100000@iolanthe.rowland.org>
From:   Jesse Hathaway <jesse@mbuki-mvuki.org>
Date:   Tue, 23 Apr 2019 15:18:40 -0500
Message-ID: <CANSNSoXHZf6kb2W1yJ81HztSkc-3BAjxghL6NchTLLyv362mQw@mail.gmail.com>
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

On Tue, Apr 16, 2019 at 10:00 AM Alan Stern <stern@rowland.harvard.edu> wrote:
> Whatever the source of the problem, I don't think you're going to find
> it by looking at the USB code.  Perhaps the early initialization of the
> functions that _are_ present on the Comtrol card somehow messes up
> other parts of the system.

Thanks for all you help Alan,

I think at this point my Linux kernel debugging knowledge has run
aground. I would
love to crack this nut, but I doubt that will be possible with my
current knowledge base.
For now I am going to run the patched kernel even if I don't
understand precisely why
they prevent the box from hanging on boot when the Comtrol card is present.
