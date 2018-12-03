Return-Path: <SRS0=SeHV=OM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D3CC04EB9
	for <linux-pci@archiver.kernel.org>; Mon,  3 Dec 2018 08:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 564152145D
	for <linux-pci@archiver.kernel.org>; Mon,  3 Dec 2018 08:19:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tRq8BZUO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 564152145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725858AbeLCITt (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 3 Dec 2018 03:19:49 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53751 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbeLCITt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 Dec 2018 03:19:49 -0500
Received: by mail-wm1-f65.google.com with SMTP id y1so4686406wmi.3
        for <linux-pci@vger.kernel.org>; Mon, 03 Dec 2018 00:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kIZVzQ0j9pWi/lbfSos6PkXInSWuPBCZGTaWJwLOhlo=;
        b=tRq8BZUOo+WnxP+iFBkPjBdsvAetKNjZpcXIxHY9kXnMEbFdojpQgDJm72yoDxUbPx
         vvoEIA6T/HCp1R+1zMVCKSThVguwatv6vHkJPKSSYNnzyqWWEGgto+yLUtzXbSFxiY5Z
         v9cIIh8rV7auODigGrTVciSqsl6Zacw8XBbYy1v1VFyAiKqolSENmynBznyAi8PP7hQh
         WmPru0nGup1hJkXsfiiRvKcwklT/xC9H7uZjy/oDRn3iEzOdny7r5QRviJM/c8fkoujc
         emTVdPGl1ySkawRR9a/SPxySRQUyDIIvQL7G4pUsKdjAkzaUTL5f5o5Cvk3cfzK8r1SH
         A02g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=kIZVzQ0j9pWi/lbfSos6PkXInSWuPBCZGTaWJwLOhlo=;
        b=OfQp47/uaKP3+EMN5DdwkEP+J4p1y0Snysve/MgRf2or+8VEHWK0C7WIeAdWT4SFX1
         dGDg6oqPBeW1986/ZFplJC6X2S3O1u3sCYu94v69yPYXmFgXi3Ls3j1W0H3UvgLt9V9O
         4o1C1QjfAriRTDey5hrYMpvZPWToscUiaQiowy9vUUO+0Bl9fN14xMe9yivKrLwD0dUI
         nbtEVcfFNLYk7jse9BcugjFl+0D35nBPt2+b5fIpD2WqJ9Wh7gKxjX+3ZzVwLSpv+jFD
         QOM652XaE9g19yqXofcmQv7C4YO+qhx2XU1Ub57kNu+bRSIXRxWTdS+Mtx1IeI2OIlKe
         XSyw==
X-Gm-Message-State: AA+aEWYmCxKWpyeQMcW3r+8tyznH+k0HtrAdE45X67jKqDAjM0v66DTf
        C1nTjTF5/kGaKtOyifs7QOE=
X-Google-Smtp-Source: AFSGD/WtDWBhPZpyL8tFVCAXw6X7+lFAX8ey6kqynezOIxf62TNW+DxZf6CVOLfhXkpMuCucAkhO8A==
X-Received: by 2002:a1c:44d6:: with SMTP id r205mr7597919wma.50.1543825185540;
        Mon, 03 Dec 2018 00:19:45 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id e142sm18280462wmf.46.2018.12.03.00.19.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Dec 2018 00:19:44 -0800 (PST)
Date:   Mon, 3 Dec 2018 09:19:42 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Sinan Kaya <okaya@kernel.org>
Cc:     linux-pci@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Robert Moore <robert.moore@intel.com>,
        Lv Zheng <lv.zheng@intel.com>
Subject: Re: [PATCH v1 2/2] PCI/ACPI: alloc ACPI to be built without PCI
 support
Message-ID: <20181203081942.GA2516@gmail.com>
References: <20181201204137.1786-1-okaya@kernel.org>
 <20181201204137.1786-2-okaya@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181201204137.1786-2-okaya@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


* Sinan Kaya <okaya@kernel.org> wrote:

> We are compiling PCI code today for systems with ACPI and no PCI
> device present. Remove the useless code and reduce the tight
> dependency.
> 
> Signed-off-by: Sinan Kaya <okaya@kernel.org>
> ---
>  arch/x86/include/asm/pci_x86.h | 5 +++++
>  drivers/acpi/Kconfig           | 1 -
>  drivers/acpi/Makefile          | 2 +-
>  drivers/acpi/internal.h        | 5 +++++
>  drivers/pci/Makefile           | 2 +-
>  include/acpi/acpi_drivers.h    | 5 +++++
>  include/linux/acpi.h           | 6 ++++++
>  include/linux/pci.h            | 4 ++++
>  8 files changed, 27 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/include/asm/pci_x86.h b/arch/x86/include/asm/pci_x86.h
> index 959d618dbb17..940cf12e7d05 100644
> --- a/arch/x86/include/asm/pci_x86.h
> +++ b/arch/x86/include/asm/pci_x86.h
> @@ -121,7 +121,12 @@ extern void __init dmi_check_pciprobe(void);
>  extern void __init dmi_check_skip_isa_align(void);
>  
>  /* some common used subsys_initcalls */
> +#ifdef CONFIG_PCI
>  extern int __init pci_acpi_init(void);
> +#else
> +static inline int  __init pci_acpi_init(void)
> +{ return -EINVAL; }
> +#endif

No objections to removing the dependency, but that's nowhere near
standard kernel style. ;-)

(There are similar problems elsewhere in the patch as well, please fix 
all of them.)

Thanks,

	Ingo
