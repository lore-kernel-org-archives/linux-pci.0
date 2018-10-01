Return-Path: <SRS0=/qR3=MN=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CACC5C43143
	for <linux-pci@archiver.kernel.org>; Mon,  1 Oct 2018 06:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 903462084C
	for <linux-pci@archiver.kernel.org>; Mon,  1 Oct 2018 06:57:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="FM20/O8R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 903462084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728821AbeJANdS (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 1 Oct 2018 09:33:18 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:45687 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727339AbeJANdS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 Oct 2018 09:33:18 -0400
Received: by mail-qk1-f194.google.com with SMTP id m8-v6so2617427qka.12
        for <linux-pci@vger.kernel.org>; Sun, 30 Sep 2018 23:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6v+PEJgA6/RPmEXDPBzWHGWtq4n2ZgsG+QnnunA7HZc=;
        b=FM20/O8RjtW776/nXGLHaoynFROyQv35ozEixBYfF9g+Np0SslzYaWGSJLYuNiMTai
         v7ZS3GeSFgEMazJPxEj36ih5iEGmCXksDg9VtOLRKz2H9ni5sfBvfwW46nLnh90RQNcS
         ypQKMMb+Y8sLcBuS01u1lQRz0r7JB61zNH8tQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6v+PEJgA6/RPmEXDPBzWHGWtq4n2ZgsG+QnnunA7HZc=;
        b=qr0C1+aQdNLX/e/AIGSnsAHQC4Yw06Gdfv9MXoVjC4nphssiaD7lZ4OF/sdbaBQV9t
         KlGghBpQTwsij1I34jXbf+w8bS6UsBKpRreXiw0/HlNS2QLQ1ZmA85CByhMcCETeLP8f
         9RiLBv2VRWB4a22nYTiKmXuigp52V1nQreRW6Qg6ZXPnxEFPgj1U31wd2swDBxS2k7zU
         yHnvxa1ExbzWq6ChboSqJjqaIZaekysdrb6dsDcdeoev/Eb/sgXjNOFRzJLmuWP+nXpp
         jH0Ca3SUlTtn19io3b99YKoyVpRk49MNWMxI7I88egjJJe3td7ihvel9ov4Qn7lIKtIX
         xPDQ==
X-Gm-Message-State: ABuFfohFLwb25cv7QjvRuS6bpFYQbfY3dT+zYa9bcBbcLMNnjwKHh+9W
        +7c1PsrQaMXrl+olpl80ZtolVJ0dOueP5IyeHT+U+A==
X-Google-Smtp-Source: ACcGV62QkEfSqwMqBABNAkZVRFkiElKyKIZYRXnEnt+99EanCC2fh2M4rhD06tD017YjeP1n9KxvnYmVOTzKVugXfy0=
X-Received: by 2002:ae9:f106:: with SMTP id k6-v6mr2820678qkg.34.1538377022597;
 Sun, 30 Sep 2018 23:57:02 -0700 (PDT)
MIME-Version: 1.0
References: <1537935759-14754-1-git-send-email-suganath-prabu.subramani@broadcom.com>
 <1537935759-14754-2-git-send-email-suganath-prabu.subramani@broadcom.com>
 <20180926213241.GI28024@bhelgaas-glaptop.roam.corp.google.com>
 <20180927070327.wvl5glb4c7gtjoa3@wunner.de> <20180927184746.GM28024@bhelgaas-glaptop.roam.corp.google.com>
 <20180927190959.dio4qwti3i4accjm@wunner.de>
In-Reply-To: <20180927190959.dio4qwti3i4accjm@wunner.de>
From:   Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>
Date:   Mon, 1 Oct 2018 12:27:28 +0530
Message-ID: <CA+RiK64EdoSngTzDMUP4xXNcZQa6KfyucsRw42+DUo3s+JPmVQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/6] mpt3sas: Introduce mpt3sas_base_pci_device_is_available
To:     lukas@wunner.de
Cc:     helgaas@kernel.org, linux-scsi@vger.kernel.org,
        linux-pci@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Sathya Prakash <Sathya.Prakash@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        linux-kernel@vger.kernel.org, benh@kernel.crashing.org,
        ruscur@russell.cc, sbobroff@linux.ibm.com, oohall@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lucas and Bjorn,
Thanks for reviewing and providing useful comments.

On Fri, Sep 28, 2018 at 12:40 AM Lukas Wunner <lukas@wunner.de> wrote:
>
> On Thu, Sep 27, 2018 at 01:47:46PM -0500, Bjorn Helgaas wrote:
> >   mpt3sas_wait_for_commands_to_complete(...)
> >   {
> >     ...
> >  +  if (!mpt3sas_base_pci_device_is_available(ioc))
> >  +    return;
> >
> >     # In the definitive case, we returned above.  If we get here, we
> >     # think the device *might* be present.  The readl() inside
> >     # mpt3sas_base_get_iocstate() might fail (returning ~0 data).
> >     # It happens that (~0 & MPI2_IOC_STATE_MASK) != MPI2_IOC_STATE_OPERATIONAL
> >     # so we will return below if the device was removed after the
> >     # check above.
> >
> >     ioc_state = mpt3sas_base_get_iocstate(ioc, 0);
> >     if ((ioc_state & MPI2_IOC_STATE_MASK) != MPI2_IOC_STATE_OPERATIONAL)
> >       return;
> >     ...
> >
> >
> > I think this code is unreasonably complicated.  The multiple layers
> > and negations make it very difficult to figure out what's definitive.
>
> I agree there's room for improvement.
>
>
> > I'm not sure how mpt3sas benefits from adding
> > mpt3sas_base_pci_device_is_available() here, other than the fact that
> > it avoids an MMIO read to the device in most cases.  I think it would
> > be simpler and better to make mpt3sas_base_get_iocstate() smarter
> > about handling ~0 values from the readl().
>
> Avoiding an MMIO read when it's known to run into a Completion Timeout
> buys about 17 ms.  If the function is executed many times (I don't know
> if that's the case here, I'm referring to the general case), or if bailing
> out of it early avoids significant amounts of further I/O, then checking
> for disconnectedness makes sense.
>
> The 17 ms number is from this talk:
> https://www.youtube.com/watch?v=GJ6B0xzgvlM&t=832
>
> It's the typical Completion Timeout on an Intel chip, but it can be up to
> 50 ms in the default setting or up to 64 s if so configured in the Device
> Control 2 register (PCIe r4.0 sec 7.8.16).
>

This function is called only during controller reset, system shutdown
and driver unload operations.
For this case we can remove mpt3sas_base_pci_device_is_available() check,
since we can make the device removal from readl in
mpt3sas_base_get_iocstate() as you suggested.
But we need mpt3sas_base_pci_device_is_available() in other places
like while submitting the
IO/TMs to the HBA firmware etc where driver is not checking for the
IOC state (through readl() operation)
 to gracefully handle the HBA hot-unplug operation.

> Thanks,
>
> Lukas
