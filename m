Return-Path: <SRS0=Emu/=SZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38255C10F03
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 21:09:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0094D21773
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 21:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556053741;
	bh=bpyhZQzIS9gnxZ/DB7mVWTg0gt5r9peVpzytTsQPOEw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=CMRq1I5JubvjXyjARAcqGq19rNPnDV2k9q6qmwikSpdHNZYurw7X714zX4UZtPDaa
	 w+30RNVO/1mFhX3pvoYgwOYlEHptRqgmnD9lf308nz7NefPK4bjxfKy0xx6lLD8jVy
	 hmPDnHlop1MmNsgxlaD0+IQMV/kBh512bxv58hps=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbfDWVIz (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 23 Apr 2019 17:08:55 -0400
Received: from casper.infradead.org ([85.118.1.10]:38522 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfDWVIy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Apr 2019 17:08:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=vdJiYFNKoKyfpKh/sHwLi3OzHq3/SpHY3SiZoXQLSOo=; b=G6a4jleNomlkvu7eTiW0NpqxiO
        /ZBQDd1qzueVFNl1v/y5qc3zaNQ5vXizByhEQ6+sCOgk72t47SG/fLY9Ib9Lr1Wb98rzVR5YTr4Cy
        R+skOlk62aIQx2b8XLYg2CeyupDYpZEWXed/v0XfHS3Id5+jQ1u2bKqWeQUaw1In6VRIkQucDThx1
        X7SDQYApTQ+eLciLf3PyQdPPD/RaOsP4KMcvBCjLigmGI0p2zNJMciAlKvIfhvh5IJMVtEuEZjpgj
        TkUTto5qgswEezqaIPG+Sox6o6td747KLECfJ64HPWFEVB0rlzdqwZaSYbzK4E/zEj8aiTDZUWXGU
        m3+KaGNg==;
Received: from 177.17.136.231.dynamic.adsl.gvt.net.br ([177.17.136.231] helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hJ2ep-0003j0-BE; Tue, 23 Apr 2019 21:08:51 +0000
Date:   Tue, 23 Apr 2019 18:08:45 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Bjorn Helgaas <bhelgaas@google.com>, rjw@rjwysocki.net,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        x86@kernel.org, fenghua.yu@intel.com,
        linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: Re: [PATCH v4 11/63] Documentation: ACPI: move dsdt-override.txt to
 admin-guide/acpi and convert to reST
Message-ID: <20190423180845.603542d5@coco.lan>
In-Reply-To: <20190423162932.21428-12-changbin.du@gmail.com>
References: <20190423162932.21428-1-changbin.du@gmail.com>
        <20190423162932.21428-12-changbin.du@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Em Wed, 24 Apr 2019 00:28:40 +0800
Changbin Du <changbin.du@gmail.com> escreveu:

> This converts the plain text documentation to reStructuredText format and
> add it to Sphinx TOC tree. No essential content change.
> 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>

Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

> ---
>  .../acpi/dsdt-override.rst}                               | 8 +++++++-
>  Documentation/admin-guide/acpi/index.rst                  | 1 +
>  2 files changed, 8 insertions(+), 1 deletion(-)
>  rename Documentation/{acpi/dsdt-override.txt => admin-guide/acpi/dsdt-override.rst} (56%)
> 
> diff --git a/Documentation/acpi/dsdt-override.txt b/Documentation/admin-guide/acpi/dsdt-override.rst
> similarity index 56%
> rename from Documentation/acpi/dsdt-override.txt
> rename to Documentation/admin-guide/acpi/dsdt-override.rst
> index 784841caa6e6..50bd7f194bf4 100644
> --- a/Documentation/acpi/dsdt-override.txt
> +++ b/Documentation/admin-guide/acpi/dsdt-override.rst
> @@ -1,6 +1,12 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +===============
> +Overriding DSDT
> +===============
> +
>  Linux supports a method of overriding the BIOS DSDT:
>  
> -CONFIG_ACPI_CUSTOM_DSDT builds the image into the kernel.
> +CONFIG_ACPI_CUSTOM_DSDT - builds the image into the kernel.
>  
>  When to use this method is described in detail on the
>  Linux/ACPI home page:
> diff --git a/Documentation/admin-guide/acpi/index.rst b/Documentation/admin-guide/acpi/index.rst
> index 09e4e81e4fb7..d68e9914c5ff 100644
> --- a/Documentation/admin-guide/acpi/index.rst
> +++ b/Documentation/admin-guide/acpi/index.rst
> @@ -9,3 +9,4 @@ the Linux ACPI support.
>     :maxdepth: 1
>  
>     initrd_table_override
> +   dsdt-override



Thanks,
Mauro
