Return-Path: <SRS0=Zwnb=M5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1938EECDE32
	for <linux-pci@archiver.kernel.org>; Wed, 17 Oct 2018 08:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D284B21527
	for <linux-pci@archiver.kernel.org>; Wed, 17 Oct 2018 08:24:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ojTZ2pH2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D284B21527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbeJQQTW (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 17 Oct 2018 12:19:22 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:46001 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727108AbeJQQTW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 Oct 2018 12:19:22 -0400
Received: by mail-qk1-f195.google.com with SMTP id m8-v6so15928843qka.12;
        Wed, 17 Oct 2018 01:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k6zpMeUD1hnXIQt6SveV+FJcEsuK99MaJDdjRb4CZFI=;
        b=ojTZ2pH2ML6I9yaJH65ijm4k+R4pW3L4+GlEvCchmAaO6CD1mfNL8W/eLB7nMY9eEb
         kVj1dwCSjpBvvdKGxG86PXQxG1RIK8kRkQ/KSjucEghcKKzbv0m6zhV3sVovXPsewuab
         0NyLU/99WcdKZL1iKjLp3g5IF4xSMQuYcCW3qrlmOjlTOM1XWX3ghxrwYtGCsU2CpHCK
         vTY7ulmAQQwKTAWYVWpS2Vph98m6wqbo0ZVl90u9tZbsDBF8zt/7AA28iS2jHI357CJC
         oWgcKNJPYWsUqIAPx5rGWDl9Y0Cy5hcr+FLL+CLDAB8HJKuJg/POVz2fm/13PEyssfJe
         Gvsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k6zpMeUD1hnXIQt6SveV+FJcEsuK99MaJDdjRb4CZFI=;
        b=eZbKYu584baat1dTaAmWqgrcWH5Rb5635yotkQ7kZRhZ1ENxujtJuA9z7p/Qqu+2Ij
         6e8TP7fYcrb500hA6Fo76/FGEDxh/QkQaDYAqLH1d2EuH/izOcEI2eSKpYjOkb2pC2sy
         Lzk+WA9GfOS5L00ZSuW2EgCc8GpbwPztMq+9w1cDUftrOI5kOdqbeOukVIAALDoN1Ocf
         NgrXG2fYCrN69qqKqNEz4ebYf1nYlcsfCJILH3UnolsufrzejsT4YE22Cev0bBob2184
         5jc7oCnxwZBHfvPOagUPf8/CGqKVbY6rWZcoiVN9MZ/Siv0nivr5fTxx4TiqUMzw9Mzu
         bB9Q==
X-Gm-Message-State: ABuFfoiMyYx7GXZFs1FUHo5Tn7G5x1PKF2J7Dsp67Uwj4reEaxSrKqIp
        xppVEaygrCAJIq9msn3iGPKWD1JUCPRMG2BDHN0=
X-Google-Smtp-Source: ACcGV61qWcSCEriwUm9LeaQHANruZTbvWLCVFsB0oVHpgQOCppHPBlmwfo+sK5ZYfclrLpAbpDy5KRSBinNiUDQg8Fs=
X-Received: by 2002:ae9:c307:: with SMTP id n7-v6mr23577475qkg.70.1539764687865;
 Wed, 17 Oct 2018 01:24:47 -0700 (PDT)
MIME-Version: 1.0
References: <1539755947-27014-1-git-send-email-suganath-prabu.subramani@broadcom.com>
 <1539755947-27014-4-git-send-email-suganath-prabu.subramani@broadcom.com>
In-Reply-To: <1539755947-27014-4-git-send-email-suganath-prabu.subramani@broadcom.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 17 Oct 2018 11:24:36 +0300
Message-ID: <CAHp75Vf2HMj-DBU7TPEM2=g=XdzksnMgCvzCU6BQa9W8XJmPKQ@mail.gmail.com>
Subject: Re: [v5 3/4] mpt3sas:Fix driver modifying persistent data.
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
> * If EEDPTagMode field in manufacturing page11 is set,
> unset it. This is needed to fix a hardware bug
> in SAS3/SAS2 cards, So, skipping EEDPTagMode changes
> in Manufacturing page11 for SAS35 controllers.
>
> * Fix driver modifying NVRAM/persistent data in
> Manufacturing page11 along with current copy. Driver should
> change only current copy of Manufacturing page11.

> -       if (ioc->manu_pg11.EEDPTagMode == 0) {
> +       if ((!ioc->is_gen35_ioc) && (ioc->manu_pg11.EEDPTagMode == 0)) {

No need to have parens.

-- 
With Best Regards,
Andy Shevchenko
