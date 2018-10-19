Return-Path: <SRS0=b7f5=M7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B565CECDE43
	for <linux-pci@archiver.kernel.org>; Fri, 19 Oct 2018 05:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76F8C21470
	for <linux-pci@archiver.kernel.org>; Fri, 19 Oct 2018 05:20:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mr0CWOGr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76F8C21470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbeJSNYs (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 19 Oct 2018 09:24:48 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:43885 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726924AbeJSNYr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 Oct 2018 09:24:47 -0400
Received: by mail-yw1-f66.google.com with SMTP id j75-v6so12736316ywj.10;
        Thu, 18 Oct 2018 22:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eYm3Z3uHgiS50jVdrs5Ht18bNBsSRmhH1uK5LNe0tkA=;
        b=mr0CWOGrSieqzo7EDBAnWFQmPimGw2LFO3O4a70+RHWUdQHA5rst/uPLllmNC0TyZJ
         NNCCs+GxFag9biL8EpaHO4CNPx+JZZEKPC7tF640UB9evsTXu7hMJupLo1tVoECV50Tx
         ZAj1g8rq7JtGlOm9kH9R52K0zem72Zw7AVZ/026U7j69korDpjD8G9RkL2Q4yfYNwBmI
         J6a3tPWWYsf0mM8HH8Lzew3ZrhQ/oxqtfPM9OTNCZv3q83D9qoRuY8iGzhhWfOThU9Xx
         JVmpx2pZwSqo7fTRxaSFJjRCOLQp6KP/cQ2fklaGJJ1NEqNEg+U0Ry9Gt93DcdEWQ/ev
         ftuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eYm3Z3uHgiS50jVdrs5Ht18bNBsSRmhH1uK5LNe0tkA=;
        b=tLWDoS7lgiltqxhHA8bXMAom0PpkBnkkJ/JF77xO9y2McAZXnLmjG8g/MLgyIt+aGA
         4CGkYkhvZbxXzhClQSg6Zgnngi12R0OBKCc7Y8LD/ef9Uf5poqdTaeHmrx9iDsQyZYCo
         Z7qESNNYJB4Fzin2UF7L7Ih6iD1OsY/fp6+hgeulmxMBLQD5oBmNigDBe6SihlU/WCG5
         J7Z56Doj+L29tioNqIgJNx54cK7bvvewKVE/N2sTBLIRYGNt8nhQqFFNNFd1Y8U8Lk74
         S53lvA+tvS+e8owF2papFdaUWoArHrjBY9fKpbSBNBHhJsOhkpOrF9+MEhEkJTywB/iI
         eKgQ==
X-Gm-Message-State: ABuFfohmaLtZWvhTb7emZH4gZo9ptrx7i8Gw4ejLZgLpyD95/iRpKq0i
        L2/w/tPINRoWkLIiOLqCAY4tGNXPIu+cHtuDGrQ=
X-Google-Smtp-Source: ACcGV62i1f69dyUv8xKhlAiMQGv4Be0cftCBzmn2YA82A11bbaP+7sJx3cVp4K+OkAiJUU/8We1JCF16QEsfLRSUn6M=
X-Received: by 2002:a81:ee0b:: with SMTP id l11-v6mr21372847ywm.422.1539926419608;
 Thu, 18 Oct 2018 22:20:19 -0700 (PDT)
MIME-Version: 1.0
References: <20181017080201.10866-1-hch@lst.de> <20181017080201.10866-5-hch@lst.de>
In-Reply-To: <20181017080201.10866-5-hch@lst.de>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Thu, 18 Oct 2018 22:19:51 -0700
Message-ID: <CAMo8BfKOqAKLPEXatPZQ4bCAAzQLx_vAHscmxDJPC9PGsoJqtA@mail.gmail.com>
Subject: Re: [PATCH 4/8] PCI: consolidate PCI config entry in drivers/pci
To:     Christoph Hellwig <hch@lst.de>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        mporter@kernel.crashing.org, alex.bou9@gmail.com,
        linux@dominikbrodowski.net,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        linux-pci@vger.kernel.org, linux-scsi@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Christoph,

On Wed, Oct 17, 2018 at 1:03 AM Christoph Hellwig <hch@lst.de> wrote:
> diff --git a/arch/xtensa/configs/iss_defconfig b/arch/xtensa/configs/iss_defconfig
> index 4bb5b76d9524..818849bb7736 100644
> --- a/arch/xtensa/configs/iss_defconfig
> +++ b/arch/xtensa/configs/iss_defconfig
> @@ -4,7 +4,7 @@ CONFIG_EXPERT=y
>  CONFIG_SYSCTL_SYSCALL=y
>  # CONFIG_IOSCHED_DEADLINE is not set
>  # CONFIG_IOSCHED_CFQ is not set
> -# CONFIG_PCI is not set
> +CONFIG_PCI=y

This change doesn't make sense as there's no PCI hardware in the Xtensa ISS.
Otherwise for the Xtensa part:
Acked-by: Max Filippov <jcmvbkbc@gmail.com>

-- 
Thanks.
-- Max
