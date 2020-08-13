Return-Path: <SRS0=UuFS=BX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50CDFC433DF
	for <linux-pci@archiver.kernel.org>; Thu, 13 Aug 2020 20:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 246CA20838
	for <linux-pci@archiver.kernel.org>; Thu, 13 Aug 2020 20:45:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Cu9+tn5a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbgHMUpk (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 13 Aug 2020 16:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726486AbgHMUpk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Aug 2020 16:45:40 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4478BC061383
        for <linux-pci@vger.kernel.org>; Thu, 13 Aug 2020 13:45:40 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id a24so6282039oia.6
        for <linux-pci@vger.kernel.org>; Thu, 13 Aug 2020 13:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yNNvJ2SAFqRHuwD/G5e2MKagg8MdQRQYf4wQID5n0pg=;
        b=Cu9+tn5aum9zaW1fAqSiCYXZz7Roh6QpQEQdIlm7uDBjzwg3hK0OunMqgVXwtd7Gib
         HmVG2zlVW8Mk65Dq500nyZ+vt8qbK7/uFaYCUctcCPRG/zCXGAPHpfnbErQ3e+ocrGDk
         J+PqoMu2Gd3MALvuTtrrXv8BNRxK72O9y4TN6Es70Tehszoqty0GTCAF995mgl8iykDy
         khue7Mu+1xAveulr4De3yXRACZ+AxGrkb2rrVxXj1EACjQC6AP4HEIE6/UXtVw2ynJWp
         epFwA3FJdqjeUmJyhTp2PwchWqz4AmVBE1RmF8s7tgGtVCqN1cHKWIpcBNZogFTGPFMT
         2eJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yNNvJ2SAFqRHuwD/G5e2MKagg8MdQRQYf4wQID5n0pg=;
        b=IjfMc6Kh/2UgBambAcywrPRu+B8HY+epLIkGEuor1Q9xNqvy4e3v8vEJmRbfYCkSBL
         fhGU1j3QhaUF5VMMey/nBHU+W7SVZTdkeuodJHfvVYZArx56Pc7dE4if/HwfF8/czk0q
         hAhS5LsqcXcmG/ll6DlPuy0EXs1xmzBaeUEsfi7J7pmpvG9xF45oH4jjhMdJV+ZfIAO1
         2d6jPLZPCVYBxlmBJCMSqBqRiO52maaJQGMcLMeji9eoRCJ+kWPtNkUd2PQM0ONI7hdF
         +o+Q4r6rXyAZK0rdNSx6hfz9ca9ekv3JvhhlDPhtU/lVaA4dppvE8WDKPr5xcQy6UO10
         pi6g==
X-Gm-Message-State: AOAM531G5Sksc4TmABpd9Aa5z0iFyIN8gx6tcgqIDX0hQ2YbHOxgy5Ag
        No7UNMt7h65eQQTAWJT+hBezWZ7ojIdjX8NiJLg+/w==
X-Google-Smtp-Source: ABdhPJxa2pZkSh2yo0esw2HFcUnCvXzYVTmf+2PaUJHQQCc72sYyhZ3qFrEI1V3lQKUF0CmdQ7SyViWcSK3s7H1ndxg=
X-Received: by 2002:aca:3081:: with SMTP id w123mr4688524oiw.132.1597351539327;
 Thu, 13 Aug 2020 13:45:39 -0700 (PDT)
MIME-Version: 1.0
References: <20952e3e-6b06-11e4-aff7-07dfbdc5ee18@infradead.org>
In-Reply-To: <20952e3e-6b06-11e4-aff7-07dfbdc5ee18@infradead.org>
From:   Jesse Barnes <jsbarnes@google.com>
Date:   Thu, 13 Aug 2020 13:45:28 -0700
Message-ID: <CAJmaN=k+-KEyC3fvpMOVz6B6UZyQOuXEBkX6PKxqTUw64cCZ=w@mail.gmail.com>
Subject: Re: [PATCH] x86/pci: fix intel_mid_pci.c build error when ACPI is not enabled
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 13, 2020 at 12:58 PM Randy Dunlap <rdunlap@infradead.org> wrote=
:
>
> From: Randy Dunlap <rdunlap@infradead.org>
>
> Fix build error when CONFIG_ACPI is not set/enabled by adding
> the header file <asm/acpi.h> which contains a stub for the function
> in the build error.
>
> ../arch/x86/pci/intel_mid_pci.c: In function =E2=80=98intel_mid_pci_init=
=E2=80=99:
> ../arch/x86/pci/intel_mid_pci.c:303:2: error: implicit declaration of fun=
ction =E2=80=98acpi_noirq_set=E2=80=99; did you mean =E2=80=98acpi_irq_get=
=E2=80=99? [-Werror=3Dimplicit-function-declaration]
>   acpi_noirq_set();
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Len Brown <lenb@kernel.org>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Jesse Barnes <jsbarnes@google.com>
> Cc: Arjan van de Ven <arjan@linux.intel.com>
> Cc: linux-pci@vger.kernel.org
> ---
> Found in linux-next, but applies to/exists in mainline also.
>
> Alternative.1: X86_INTEL_MID depends on ACPI
> Alternative.2: drop X86_INTEL_MID support
>
>  arch/x86/pci/intel_mid_pci.c |    1 +
>  1 file changed, 1 insertion(+)
>
> --- linux-next-20200813.orig/arch/x86/pci/intel_mid_pci.c
> +++ linux-next-20200813/arch/x86/pci/intel_mid_pci.c
> @@ -33,6 +33,7 @@
>  #include <asm/hw_irq.h>
>  #include <asm/io_apic.h>
>  #include <asm/intel-mid.h>
> +#include <asm/acpi.h>
>
>  #define PCIE_CAP_OFFSET        0x100

Reviewed-by: Jesse Barnes <jsbarnes@google.com>

Thanks Randy. Another option is to remove the MID support entirely.

Jesse
