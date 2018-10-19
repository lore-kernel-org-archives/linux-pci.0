Return-Path: <SRS0=b7f5=M7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1443ECDE43
	for <linux-pci@archiver.kernel.org>; Fri, 19 Oct 2018 05:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B11B21470
	for <linux-pci@archiver.kernel.org>; Fri, 19 Oct 2018 05:07:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="1JTGbee2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B11B21470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbeJSNML (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 19 Oct 2018 09:12:11 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:61395 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726942AbeJSNML (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 Oct 2018 09:12:11 -0400
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id w9J57fTS026021;
        Fri, 19 Oct 2018 14:07:41 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com w9J57fTS026021
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1539925662;
        bh=mYjXID3VQmfIEufK9cARuqSnPYUqryDcSZUlpJZAewA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=1JTGbee2r9AFN486BefMRz+x/MnvhV782D5VOFcoLzFR25CTcHR80+3mm3JDRkCVY
         voUk5wfnlP2AHBX8/ksMEsrO82fOFpQh8Xt/3ATIox7X5C42WwK8Qw5H74XbFDiOFO
         iP71hw/QkMrPNLCs71S8JySOqbsNhxkG/V34wEH8pw/miIPOUnOZdWY4yg8+Og9pqA
         C5yp2T7BXiiTOOZNfKEjkgjDAJQNW3CEdLH00x6on3LdN7JGEzWlkpZneYvvFOQ35S
         B+5KF7EiHwXrgeZ3LUtukmSe2etI+MKICK56+U4Yo2d3ujJPG2XB2iL89NuL8N9Pnj
         r6KvV12Ubwxrg==
X-Nifty-SrcIP: [209.85.217.54]
Received: by mail-vs1-f54.google.com with SMTP id i10so24520711vsm.13;
        Thu, 18 Oct 2018 22:07:41 -0700 (PDT)
X-Gm-Message-State: ABuFfohJZwtVE5evqJlF5rKjjTo4aoJZEf5fJTkmcrRkt7e0vCV/LhAf
        2dqtQSBECpaLs2Ct3qrZEbOmT8Z1gje5qo+22go=
X-Google-Smtp-Source: ACcGV60+ZPcmOytHtgLIeEc9t4tMNXp0dYDWA083Ni5ycAjI7Cy45BYFIxfylO9JQUtZhKE4X5jSt+ZyOSVmOoUm1Dk=
X-Received: by 2002:a67:3793:: with SMTP id j19mr13514804vsi.215.1539925660531;
 Thu, 18 Oct 2018 22:07:40 -0700 (PDT)
MIME-Version: 1.0
References: <20181017080201.10866-1-hch@lst.de> <20181017080201.10866-5-hch@lst.de>
In-Reply-To: <20181017080201.10866-5-hch@lst.de>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 19 Oct 2018 14:07:04 +0900
X-Gmail-Original-Message-ID: <CAK7LNASJaRrut2neRa92CudohW4A-2=GHMzgEpOzT97VdGuhng@mail.gmail.com>
Message-ID: <CAK7LNASJaRrut2neRa92CudohW4A-2=GHMzgEpOzT97VdGuhng@mail.gmail.com>
Subject: Re: [PATCH 4/8] PCI: consolidate PCI config entry in drivers/pci
To:     Christoph Hellwig <hch@lst.de>, linux-pci@vger.kernel.org
Cc:     mporter@kernel.crashing.org, Alex Bounine <alex.bou9@gmail.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 17, 2018 at 5:04 PM Christoph Hellwig <hch@lst.de> wrote:
>
> There is no good reason to duplicate the PCI menu in every architecture.
> Instead provide a selectable HAS_PCI symbol that indicates availability

HAS_PCI -> HAVE_PCI


> of PCI support and the handle the rest in drivers/pci.
>
> Note that for powerpc we now select HAVE_PCI globally instead of the
> convoluted mess of conditional or or non-conditional support per board,
> similar to what we do e.g. on x86.  For alpha PCI is selected for the
> non-jensen configs as it was the default before, and a lot of code does
> not compile without PCI enabled.  On other architectures with limited
> PCI support that wasn't as complicated I've left the selection as-is.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Thomas Gleixner <tglx@linutronix.de>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>



Just in case, could you double-check these?
PCI_ENDPOINT
PCI_ENDPOINT_CONFIGFS
PCI_EPF_TEST


Previously, architecture without "source drivers/pci/Kconfig"
could not enable PCI_ENDPOINT.

Now, any architecture can enable it
regardless of its actual PCI availability
because PCI_ENDPOINT is only guarded by HAS_DMA.


We could add 'depends on HAVE_PCI' or something
to guard it to avoid changing the logic.


config PCI_ENDPOINT
        bool "PCI Endpoint Support"
        depends on HAVE_PCI     # Is this correct ??
        depends on HAS_DMA


or better to have 'depends on PCI' ?


PCI ML is also CC'ed, so comments are appreciated.



-- 
Best Regards
Masahiro Yamada
