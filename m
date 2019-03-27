Return-Path: <SRS0=cd0N=R6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C517AC10F00
	for <linux-pci@archiver.kernel.org>; Wed, 27 Mar 2019 08:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82B7A206B8
	for <linux-pci@archiver.kernel.org>; Wed, 27 Mar 2019 08:39:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Rk6Bs+bZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725786AbfC0Ii7 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 27 Mar 2019 04:38:59 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40505 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbfC0Ii7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Mar 2019 04:38:59 -0400
Received: by mail-wm1-f67.google.com with SMTP id z24so12506560wmi.5
        for <linux-pci@vger.kernel.org>; Wed, 27 Mar 2019 01:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yWTdMO/u4KOiskJtQBGHbF6j2v2MoP1IZWeewOD5oUU=;
        b=Rk6Bs+bZmgRaisSLFc8nFs0apJ5prGC+gm0QebTOCIWTMT5G19UYvCHxxmrJhklIL6
         wio3/1fMTtIrwTjztKqOCMSduTaGYrowCiq3OjuR0Fyh2XlRi45Qja2oH/mYeOSgIfkg
         uAym3FIXdZU/f7zsxlTtOhPzHDyQbMXTtDsX0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yWTdMO/u4KOiskJtQBGHbF6j2v2MoP1IZWeewOD5oUU=;
        b=qfPODT9MNMFoPPnfb32YK0BRLYq1JWkSbVvPmEAy/lyh6CXKgtk0kkWFP0A98j7V3R
         bkSeIl0D5kKnFB5//Od9rnuduOLjHNBNVbEPKYWeKMJJY6nveHdYW9xuS0v7tARhQGFL
         cZzPBwhZru9obi/cSfrysZfyZS3uRqrjMfeu526XpO4Sds6ikzJX2xKA2OtduK6UBca8
         04dXkYiWHfKWwUQlO5GkW0D1RrEMV366uqxXRrY7clM2HTXOYInvTDLn0Tn+LIZJFrqx
         7Zx5XPawct2ddmsh5u+M0yFMv1IqiuYRmYChACnqvc7moOHHd5shdVZGpuHH0St/d22+
         fpmg==
X-Gm-Message-State: APjAAAVP+To7ju0OfnvHh+CWO1S0YrS61bce3KLGVuBT2mVhQgCc4eYd
        Hs3iFhSpBeWIbWBXAxqJIkWltM+AzH36vJxk63mqgg==
X-Google-Smtp-Source: APXvYqxgYtcGlMbOfnJs1AcQu4Zatx7WN4kazaWkSdamJCzsDnYtRT4xBdZOcS5qbufv9JEMtZXQZ3/Qv00/vMwEEWk=
X-Received: by 2002:a7b:cf2c:: with SMTP id m12mr7447073wmg.21.1553675937349;
 Wed, 27 Mar 2019 01:38:57 -0700 (PDT)
MIME-Version: 1.0
References: <1551415936-30174-1-git-send-email-srinath.mannam@broadcom.com>
In-Reply-To: <1551415936-30174-1-git-send-email-srinath.mannam@broadcom.com>
From:   Srinath Mannam <srinath.mannam@broadcom.com>
Date:   Wed, 27 Mar 2019 14:08:46 +0530
Message-ID: <CABe79T5M3FJQed018aGfRhS7eLBbtmoO33mFP=K+xHgavto64Q@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] Add IPROC PCIe new features
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lorenzo/Bjorn,

Could you please help to review this patch series when you have time?
I believe I have addressed all your review comments.

Thanks,
Srinath.

On Fri, Mar 1, 2019 at 10:22 AM Srinath Mannam
<srinath.mannam@broadcom.com> wrote:
>
> This patch set extends support of new IPROC PCIe host controller features
>  - Add CRS check using controller register status flags
>  - Add outbound window mapping configuration for 32-bit I/O region
>
> This patch set is based on Linux-5.0-rc2.
>
> Changes from v3:
>   - Addressed Lorenzo Pieralisi comments.
>
> Changes from v2:
>   - Based on Lorenzo Pieralisi comments, commit logs are expanded.
>
> Changes from v1:
>   - Addressed Bjorn Helgaas comments.
>   - Removed set order mode patch from patchset.
>
> Srinath Mannam (2):
>   PCI: iproc: Add CRS check in config read
>   PCI: iproc: Add outbound configuration for 32-bit I/O region
>
>  drivers/pci/controller/pcie-iproc.c | 44 +++++++++++++++++++++++++++++++++----
>  1 file changed, 40 insertions(+), 4 deletions(-)
>
> --
> 2.7.4
>
