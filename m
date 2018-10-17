Return-Path: <SRS0=Zwnb=M5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C06ECDE30
	for <linux-pci@archiver.kernel.org>; Wed, 17 Oct 2018 08:32:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 893F321523
	for <linux-pci@archiver.kernel.org>; Wed, 17 Oct 2018 08:32:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XqP4Gk52"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 893F321523
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbeJQQ1H (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 17 Oct 2018 12:27:07 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38223 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726967AbeJQQ1G (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 Oct 2018 12:27:06 -0400
Received: by mail-qt1-f196.google.com with SMTP id l9-v6so29024968qtf.5;
        Wed, 17 Oct 2018 01:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gnmOvwVBiwhbr4qv0Wcjz1gEzwBhaQoYwTvhnMhd4bY=;
        b=XqP4Gk52VAKImMyKwOb2O70F9s7eC+3G+J4qOOsauf4EFxt5OPOpqtaoq1yRpkn2Ea
         JtoEtVL5rQ289iz/GXD7HeuzU+cDZN9MaMJUSizwoaVS0rRqbuNHGzNbFVE6Rgi1l7Bc
         3ZB6/g7hs7CSRRb3cAEo3GWvZOaWMh4zAaGaght47DJe5jpZtzLF0l2u8/qo4RH7yMy/
         J9cAXnEdZfqqtsiACX5MriRWS1R/MXchsk+VTaF+45ytgfhcwesIWRhyFI4rUFGCHQQY
         OefBNGesldPZuX+3QmahQeT9E9OW2GYD/I3MT04G5JoZaSDi808c5VbQdf+MUsMlRDHD
         0Wlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gnmOvwVBiwhbr4qv0Wcjz1gEzwBhaQoYwTvhnMhd4bY=;
        b=pDCq3u+xpVOXg1be8jDlfoYWlZiZZryDjkN7mvCSSgbbFpeNidqz9/Ur9kDZEeXgQw
         lrrlYnSq+D+y4f3E9UX6Nml6ozifzlqR23J20sAFsqCWwRnFTDLtWodil889stUq2I0Y
         wOSQJvXGe/18csUcRWMmdio2XLIKhCceC+I9r+ABPAI3rUYNTyv5wVo0Q41XGLjPMJeH
         weW7vDN/h7dGDJ54vY/lo+fEtY/bYEmUkwwSpow40rI0LiMbgOmqE76JLZKp/7lUG0Wg
         BckX3rbP+t6KX2UFJPg8F1eTpE2297VjJ13KXEn+ysE6uUKuvj42K46p1+cjakEuS7gY
         LypA==
X-Gm-Message-State: ABuFfohfVq968TUSDOMVzkgBc8pdz93floHvb+WkeUchOIlgXRItbLfn
        y02fzUN1ksYLSnCnjoxy6nYefIX4kQNh+CMIOzM=
X-Google-Smtp-Source: ACcGV60ft8YlaFa+c+7OYch40bCCnIAR4z4vA7VZtL/C7k8ihRTPGbYQdpxAza/WrBtbCuarELNmyL+OF2Z/pMZvW80=
X-Received: by 2002:ac8:190e:: with SMTP id t14-v6mr22831024qtj.327.1539765150096;
 Wed, 17 Oct 2018 01:32:30 -0700 (PDT)
MIME-Version: 1.0
References: <1539755947-27014-1-git-send-email-suganath-prabu.subramani@broadcom.com>
 <1539755947-27014-3-git-send-email-suganath-prabu.subramani@broadcom.com>
In-Reply-To: <1539755947-27014-3-git-send-email-suganath-prabu.subramani@broadcom.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 17 Oct 2018 11:32:18 +0300
Message-ID: <CAHp75Ve=X9X6xG5FpuZrmRKfSpcLwFQYE_A8vhUzNn92KSoc4w@mail.gmail.com>
Subject: Re: [v5 2/4] mpt3sas: Fix Sync cache command failure during driver unload
To:     Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        ruscur@russell.cc, sbobroff@linux.ibm.com, oohall@gmail.com,
        Sathya Prakash <Sathya.Prakash@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 17, 2018 at 8:59 AM Suganath Prabu
<suganath-prabu.subramani@broadcom.com> wrote:
>
> This is to fix Sync cache and start stop command
>  failures with DID_NO_CONNECT during driver unload.
>
> 1) Release drives first from SML, then remove internally
> in driver.
> 2) And allow sync cache and Start stop commands to firmware,
> even when remove_host flag is set.

> +       if (ioc->hba_mpi_version_belonged == MPI2_VERSION) {
> +               if (ioc->remove_host)
> +                       return false;
> +
> +               return true;
> +       }
> +
> +       if (ioc->remove_host) {
> +
> +               switch (scmd->cmnd[0]) {
> +               case SYNCHRONIZE_CACHE:
> +               case START_STOP:
> +                       return true;
> +               default:
> +                       return false;
> +               }
> +       }
> +
> +       return true;

Wouldn't be the same as

if (!ioc->remove_host || ioc->hba_mpi_version_belonged == MPI2_VERSION)
   return !ioc->remove_host;

 switch (scmd->cmnd[0]) {
 case SYNCHRONIZE_CACHE:
 case START_STOP:
   return true;
 default:
   return false;
 }

?

-- 
With Best Regards,
Andy Shevchenko
