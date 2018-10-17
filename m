Return-Path: <SRS0=Zwnb=M5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 972A4ECDE30
	for <linux-pci@archiver.kernel.org>; Wed, 17 Oct 2018 08:31:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 691E821526
	for <linux-pci@archiver.kernel.org>; Wed, 17 Oct 2018 08:31:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 691E821526
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbeJQQZi (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 17 Oct 2018 12:25:38 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:36612 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726994AbeJQQZh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 Oct 2018 12:25:37 -0400
Received: by mail-vs1-f68.google.com with SMTP id c205so20238224vsd.3;
        Wed, 17 Oct 2018 01:31:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nbgd8scfCvhY6jmG199ZNUqhpVDts12fW1AAxoxPxmI=;
        b=LWouU6AlAJbs0Rns0leAhpE4XwlYxQW9C0zvb2hdVNIzp9M+uIYwOkuL09D9vtJimJ
         U2mkwUOPmlKSXyKVRw0LOKlKa5xAIhSW3m5YZRaKWYihAqY3USmQAkCq+uYw+kis4s8Y
         uNqe7KU/aul5Mhbnxe83pnOUPkM8hdixqwFQSG58WCtrDzKVbyDjI2ZdQmNDTTHyS0d1
         lTo9otyOfQ5KjUB+AV8sy2lXEPN56sfbS68D5kzi/oHcUDHSMpzQ0DpVBAZmVEhNXiJk
         3OTEtSt+J8OmRYa/ZLtU8XdmzwypLsT057LHRof8EVuLYB1PeE7uZVXKAHlhJxAAUpfE
         YnWA==
X-Gm-Message-State: ABuFfoj4FK7KIWAVNtSXiHOTpOaaR9gd4pMe6wuV7lpM2ZwZQAakcbCj
        r022eNf/PW5uVxcAzzSrMGLp9LYf8RkcAlLd39g=
X-Google-Smtp-Source: ACcGV6273LL+JTUOtmfdqAmVO+8UCsjrLVNOvZEMtmS9Vt2WV6JXoIZjMmugHwndwVBvraDokh3c/RzyRUPLyAWwMIc=
X-Received: by 2002:a67:843:: with SMTP id 64mr10052717vsi.166.1539765061626;
 Wed, 17 Oct 2018 01:31:01 -0700 (PDT)
MIME-Version: 1.0
References: <20181017080201.10866-1-hch@lst.de>
In-Reply-To: <20181017080201.10866-1-hch@lst.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 17 Oct 2018 10:30:49 +0200
Message-ID: <CAMuHMdWMtxxu8iivcnT=uWTMHsp=iSq_QzXqDWQut5OHwTU8Sg@mail.gmail.com>
Subject: Re: move bus (PCI, PCMCIA, EISA, rapdio) config to drivers/ v2
To:     Christoph Hellwig <hch@lst.de>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Matt Porter <mporter@kernel.crashing.org>,
        Alex Bounine <alex.bou9@gmail.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        scsi <linux-scsi@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Christoph,

On Wed, Oct 17, 2018 at 10:03 AM Christoph Hellwig <hch@lst.de> wrote:
> currently every architecture that wants to provide on of the common
> periphal busses needs to add some boilerplate code and include the
> right Kconfig files.   This series instead just selects the presence
> (when needed) and then handles everything in the bus-specific
> Kconfig file under drivers/.
>
> Changes since v1:
>  - rename all HAS_* Kconfig symbols to HAVE_*
>  - drop the CONFIG_PCI_QSPAN option entirely
>  - drop duplicate select from powerpc
>  - restore missing selection of PCI_MSI for riscv
>  - update x86 and riscv defconfigs to include PCI
>  - actually inclue drivers/eisa/Kconfig
>  - adjust some captilizations

Thanks for the update!

Please use "git format-patch -v<N> --cover" to prepare patch series
for sending with git-send-email.

  "-v<N>" to prefix all patches with version number <N>,
  "--cover" to have a "[PATCH 0/<M>]" prefix in the cover letter.

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
