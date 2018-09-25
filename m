Return-Path: <SRS0=zVIF=MH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCF96C43382
	for <linux-pci@archiver.kernel.org>; Tue, 25 Sep 2018 08:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CEF020C0A
	for <linux-pci@archiver.kernel.org>; Tue, 25 Sep 2018 08:39:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZcSzGZD6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CEF020C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbeIYOpb (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 25 Sep 2018 10:45:31 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39613 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbeIYOpb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Sep 2018 10:45:31 -0400
Received: by mail-qt1-f193.google.com with SMTP id c25-v6so6725267qtp.6;
        Tue, 25 Sep 2018 01:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BelKNSi0l3fbLonYOHp8fcK7rfEzVkV8EmqacmRU/T8=;
        b=ZcSzGZD6csPliVRitRI0v5hdIhHO7w2XAoFgnVnz3A8StMAk0zuE/VpLE527dKevft
         yCosLzKRultAWeKYT5agL+Zdp9InASKgqSGW0z1k+Dkfg9tV0MvWRBCzxpMsIOaqFj9e
         C6EETDefvPGn/ZP6N8VKSqdfoW8vMZM3KW2Ktu0XxwxKvzvdWD72OZRsFNpQu59v1K9I
         zs/JZmH2n/0DkxOnh7DOfYpPo4Oz667890nsSVZMXBquIEcv1Dprpi9BTHOmZznGV/Y/
         FWK5IyVCGa6SnTAo9CIZTCBc08huTK76dNRvXeZ9XlVNcz57sI/MEa6MJ9VPedM4WKqD
         MZTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BelKNSi0l3fbLonYOHp8fcK7rfEzVkV8EmqacmRU/T8=;
        b=tIJcmD/ubMvX9IkzpESSZ5W3wlfu18gmGpAvKsLNcyZP1lHbHaEJCwASr1UrcGOyBU
         vVOB58eaa1RHxJEAXZBlpBowIyUF1xswmdTtDAWwdKM4dT0PYA0eLpSwrwyVoC9JFEos
         T900p7SIGJO7sdyQXFzCEFMxYvQG1VzatwCxYzmmiWPcTc0+bQa/TBkJAF5dsjPHGIgu
         hdDBwO6eCC8YlEk3hzJwC5lXbeBNVqks0VofUdwtRdQb5jRJcfy+tOsti/S+zXca/QFA
         +sQd0kqkHHPvjnrg/eehtsHsRIWskJ4OxsdlIGAOGwd2eflRfcmOZ1lZE5gI8vLyirab
         K28g==
X-Gm-Message-State: ABuFfogjBH4Y7EswX5EvyTDox0Nne1p6RbdoORJCqwBDveRtbx4JXxIl
        sSdMLNJ/o/G3Xq4yGjyTq9uzDUkli+zVvf32nLA=
X-Google-Smtp-Source: ACcGV60mM/HSBvay9CIX2s42/Qk8EyJWbhtLwh2S2+m9L2RQykHexrtiqc5FdhzJVK+ETyLVuPQiAVhlupv+0IOyG98=
X-Received: by 2002:a0c:aa06:: with SMTP id d6-v6mr6679qvb.26.1537864743448;
 Tue, 25 Sep 2018 01:39:03 -0700 (PDT)
MIME-Version: 1.0
References: <1537770916-16337-1-git-send-email-suganath-prabu.subramani@broadcom.com>
In-Reply-To: <1537770916-16337-1-git-send-email-suganath-prabu.subramani@broadcom.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 25 Sep 2018 11:38:52 +0300
Message-ID: <CAHp75VfTERPx-pYaTxp-_mPcSw5-E+5kj3C+3ebYiWt9WvwEvw@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] mpt3sas: Hot-Plug Surprise removal support on IOC.
To:     Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>,
        Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org
Cc:     linux-scsi <linux-scsi@vger.kernel.org>,
        Sathya Prakash <Sathya.Prakash@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 24, 2018 at 9:36 AM Suganath Prabu S
<suganath-prabu.subramani@broadcom.com> wrote:
>
> Posting below set of patches to support PCIe Hot Plug surprise removal,
> and few defect fixes.
>
> This is NOT the normal PCIe Hot Plug support, whereby the user informs the
> OS that a hot removal is desired, the OS does an orderly shutdown of the
> driver on the device, special hot plug circuitry removes power from the
> PCIe slot, then the user can remove the device and replace it
> (where orderly bring-up of the device is done).
>
> With a true surprise removal (just removing HBA from a slot)
> there is a possibility to get all kinds of PCIe transaction errors,
> Below patches addresses those issues and remove HBA without bringing
> the system down.
>
> For surprise removal detection, driver does a PCI
> read of IOC's vendor field in IOC's PCI configuration space.
> If the read value is 0xFFFFFFFF this indicates that the device
> might have hot removed and the device will be removed from driver.
>

AFAIR Lukas asked you to Cc new versions to Linux PCI mailing list
and, if I'm not mistaken, to him.

> V1 changes:
> In Patch 0001 - unlock mutex, if active reset is in progress.
>
> V2 changes:
> Replaced mpt3sas_base_pci_device_is_unplugged with
> pci_device_is_present.
>
> V3 Change Set:
> Simplified function "mpt3sas_base_pci_device_is_available" and
> made inline
>
> Suganath Prabu S (6):
>   mpt3sas: Introduce      mpt3sas_base_pci_device_is_available
>   mpt3sas: Separate out      mpt3sas_wait_for_ioc_to_operational
>   mpt3sas: Introdude  _scsih_get_shost_and_ioc.
>   mpt3sas: Fix Sync cache command failure during driver      unload.
>   mpt3sas: Fix driver modifying NVRAM/persistent data.
>   mpt3sas: Bump driver version to 27.100.00.00.
>
>  drivers/scsi/mpt3sas/mpt3sas_base.c      | 135 +++++++++++++++-------
>  drivers/scsi/mpt3sas/mpt3sas_base.h      |  11 +-
>  drivers/scsi/mpt3sas/mpt3sas_config.c    |  32 +-----
>  drivers/scsi/mpt3sas/mpt3sas_ctl.c       |  26 +----
>  drivers/scsi/mpt3sas/mpt3sas_scsih.c     | 189 +++++++++++++++++++++++++++----
>  drivers/scsi/mpt3sas/mpt3sas_transport.c |  82 +++-----------
>  6 files changed, 298 insertions(+), 177 deletions(-)
>
> --
> 1.8.3.1
>


-- 
With Best Regards,
Andy Shevchenko
