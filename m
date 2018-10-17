Return-Path: <SRS0=Zwnb=M5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB46AECDE30
	for <linux-pci@archiver.kernel.org>; Wed, 17 Oct 2018 08:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 908382151D
	for <linux-pci@archiver.kernel.org>; Wed, 17 Oct 2018 08:17:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BK2xOmXI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 908382151D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbeJQQM0 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 17 Oct 2018 12:12:26 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:34117 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727008AbeJQQM0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 Oct 2018 12:12:26 -0400
Received: by mail-qk1-f195.google.com with SMTP id p6-v6so15960502qkg.1;
        Wed, 17 Oct 2018 01:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eq/Q4iqmrqnB+n1tF28+AEQk6nyh68BnrOd2wA/vhH4=;
        b=BK2xOmXIBYE7U0osl2Eud36DzY1FuLiv8DY5LnaQPD5tVVD40HO4JcigJ5kwMTgaaf
         1LoS2P4bRX+JWa96s1yx8Eu5PAzFC0bj+novmpvYWqJzwvzwqKON5/APRtRdJVpof6bW
         NtECLPPabL0rYrNNjt12M23hOOh556f/eKM0pHqhox0bcp/YcWyCb87CyvJfKFmD7NgH
         /wSz2swtlvq2RWnCaJYh49SA8QbAcYrrqMYxsiD+NeJutDw8eKSfag0Ie7nIf4GChTQh
         F+3dnAJ/p1UDT+I6f4lZmvkjXAA/NnaDxm3iBDowS9qVIuq/BDuOZxmekGJRePUS49qK
         5zJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eq/Q4iqmrqnB+n1tF28+AEQk6nyh68BnrOd2wA/vhH4=;
        b=b0/T8UASVaIRuUoK9xL5qZL2RSo56MPsshTyRGeXYt5IYi0RRlNYmRpGsDuuOZzRhR
         R9loy8nxftQjRkCMJCaMKI0KGTee0puITUuSPZnBtpbhxgcylXnTqLbsUHbR8r0U4RKu
         y6tu6YJdujlVuBom4xmewKzdHWXGD3JwMAxvJgwIsTFme2LxjfntS8OV8nK8DkhQE+Uk
         6TaYP7einrV16KqG9yEKC76PXkt47rrd8LyX0+wEsGApIviukkkAvH0FEChMtDwfzeOX
         Sd4dZhHkVZFRtqtD5I3Zbu7Is2hnA8RCaEOafP3q4cWJykpFkbRjrU41U5eZyk6vTbXx
         kFtA==
X-Gm-Message-State: ABuFfoiyEBoWFFC0Vj4+vuSsCzyoVXfCqer1Gwof3QvScZGmSPfYQtMF
        edLiC5Wy9WzIPP+tlf9a7eZOLYSP6Q/JyWEo9kZLiUIWcvA=
X-Google-Smtp-Source: ACcGV60+Y3174/LPFRxc9MQjDSdxUysyzJJObLKXKIlljHOJadk7K9W14zX164scsy4Eghx2cZ+lSNV5NxKzYN0246E=
X-Received: by 2002:a37:4787:: with SMTP id u129-v6mr24070614qka.301.1539764273079;
 Wed, 17 Oct 2018 01:17:53 -0700 (PDT)
MIME-Version: 1.0
References: <1539755947-27014-1-git-send-email-suganath-prabu.subramani@broadcom.com>
 <1539755947-27014-2-git-send-email-suganath-prabu.subramani@broadcom.com>
In-Reply-To: <1539755947-27014-2-git-send-email-suganath-prabu.subramani@broadcom.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 17 Oct 2018 11:17:41 +0300
Message-ID: <CAHp75Veh=CkhD67jb+Qjps-UqtcCBUsA8bWco6kqppm0Q+tcvg@mail.gmail.com>
Subject: Re: [v5 1/4] mpt3sas: Separate out mpt3sas_wait_for_ioc_to_operational
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
> No functional changes. This section of code
>  "wait for IOC to be operational" is used in many places
>  across the driver, and hence moved this code in to
>  a function "mpt3sas_wait_for_ioc_to_operational()"

> +       ioc_state = mpt3sas_base_get_iocstate(ioc, 1);
> +       while (ioc_state != MPI2_IOC_STATE_OPERATIONAL) {
> +

Do we need this blank line?

> +               if (wait_state_count++ == timeout) {
> +                       ioc_err(ioc, "%s: failed due to ioc not operational\n",
> +                               __func__);
> +                       return -EFAULT;
> +               }
> +               ssleep(1);
> +               ioc_state = mpt3sas_base_get_iocstate(ioc, 1);
> +               ioc_info(ioc, "%s: waiting for operational state(count=%d)\n",
> +                        __func__, wait_state_count);
> +       }

I understand this is part of existing code, but can you consider to
modify it to something like

do {
    ioc_state = mpt3sas_base_get_iocstate(ioc, 1);
    if (ioc_state == MPI2_IOC_STATE_OPERATIONAL)
      break;
    ioc_info(ioc, "%s: waiting for operational state(count=%d)\n",
__func__, ++wait_state_count);
while (timeout--);
if (!timeout) {
    ioc_err(ioc, "%s: failed due to ioc not operational\n", __func__);
    return -EFAULT;
}
Less lines, more understandable in my view.

> +       rc = mpt3sas_wait_for_ioc_to_operational(ioc,
> +                                       IOC_OPERATIONAL_WAIT_COUNT);

This can be one line (yes, I aware that is 82 characters, but it
improves readability from my p.o.v.).

> +       rc = mpt3sas_wait_for_ioc_to_operational(ioc,
> +                                       IOC_OPERATIONAL_WAIT_COUNT);

Ditto.

>         u16 smid;
> -       u32 ioc_state;
>         Mpi2ConfigRequest_t *config_request;
>         int r;
>         u8 retry_count, issue_host_reset = 0;
> -       u16 wait_state_count;
> +

Usually we don't split definition block.

>         struct config_request mem;
>         u32 ioc_status = UINT_MAX;

> +       ret = mpt3sas_wait_for_ioc_to_operational(ioc,
> +                                       IOC_OPERATIONAL_WAIT_COUNT);

One line?

> +       rc = mpt3sas_wait_for_ioc_to_operational(ioc,
> +                                       IOC_OPERATIONAL_WAIT_COUNT);

Ditto.

> +       rc = mpt3sas_wait_for_ioc_to_operational(ioc,
> +                                       IOC_OPERATIONAL_WAIT_COUNT);

Ditto.

> +       rc = mpt3sas_wait_for_ioc_to_operational(ioc,
> +                                       IOC_OPERATIONAL_WAIT_COUNT);

Ditto.

-- 
With Best Regards,
Andy Shevchenko
