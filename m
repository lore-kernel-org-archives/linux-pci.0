Return-Path: <SRS0=T4LS=ML=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30F89C43143
	for <linux-pci@archiver.kernel.org>; Sat, 29 Sep 2018 13:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D542020882
	for <linux-pci@archiver.kernel.org>; Sat, 29 Sep 2018 13:18:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D542020882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728077AbeI2TrY (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 29 Sep 2018 15:47:24 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42063 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728029AbeI2TrX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 29 Sep 2018 15:47:23 -0400
Received: by mail-ot1-f67.google.com with SMTP id h26-v6so8697115otl.9;
        Sat, 29 Sep 2018 06:18:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e2ZdzCMuwxxmZmPfkJD5u2P9Apa5Mq6LiwzMxfl7dc8=;
        b=IWVBILx1Yl0J9tlt7/keRQDxSH37Ba3XaCP0zrR6U8YgJKwMaQr7pdWep8FF4R6ulx
         98LPAU83+4ZG3Emvl6Jj47v60asEwRp8q8L9i5Bbs3r5uDdKcDE2qMyv+QkVqzWywEgs
         WTnCdfIu2FR6Uq7m6Nz58Agj8GurqjzD8yVbyrF81GyV8+FTqXQHVr7K74+ssCbLg5O6
         iF3fh5s6kgWH0tzWZLX8CUB7u/e/ssTJrYfkbM3htEDhYtLOGCvc38TYWDI1Kq4qUqB4
         Y1XdOIzYO7eefY62GHm7a1chZBJiJT/AH40c5i9YMOqjXy8xNVSP/QHWrXZC+ljdtY91
         3nKg==
X-Gm-Message-State: ABuFfoimg85DEI4CVk8PPdDGd6GMyTwaENXWsF+r8JrdOfvVcYFIWws/
        b20u3FEF9FZS7RqpLRiBWOLkBiKySj9kkIT8ric=
X-Google-Smtp-Source: ACcGV63Z00kmUxofNmnxr+FnW1CWrz3N5cyNCA1wvbqPsLNeV2rJJcMfky7xnuUk/AfPRjrkMojmqMD9tbJn6SpkWIU=
X-Received: by 2002:a9d:48f9:: with SMTP id a54-v6mr1875665otj.343.1538227136722;
 Sat, 29 Sep 2018 06:18:56 -0700 (PDT)
MIME-Version: 1.0
References: <20180928215054.28561-1-joe@perches.com> <20180928230616.GA150287@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20180928230616.GA150287@bhelgaas-glaptop.roam.corp.google.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sat, 29 Sep 2018 15:18:38 +0200
Message-ID: <CAJZ5v0hh899QjTTbzRK7oWqSH6GccV_H0weUUYJdVw8sQgyONQ@mail.gmail.com>
Subject: Re: Bad MAINTAINERS pattern in section 'ACPI'
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Joe Perches <joe@perches.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Keith Busch <keith.busch@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Sep 29, 2018 at 1:06 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> [+cc Tony, Borislav (ACPI APEI reviewers), linux-pci]
>
> On Fri, Sep 28, 2018 at 02:50:53PM -0700, Joe Perches wrote:
> > Please fix this defect appropriately.
> >
> > linux-next MAINTAINERS section:
> >
> >       308     ACPI
> >       309     M:      "Rafael J. Wysocki" <rjw@rjwysocki.net>
> >       310     M:      Len Brown <lenb@kernel.org>
> >       311     L:      linux-acpi@vger.kernel.org
> >       312     W:      https://01.org/linux-acpi
> >       313     Q:      https://patchwork.kernel.org/project/linux-acpi/list/
> >       314     T:      git git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
> >       315     B:      https://bugzilla.kernel.org
> >       316     S:      Supported
> >       317     F:      drivers/acpi/
> >       318     F:      drivers/pnp/pnpacpi/
> >       319     F:      include/linux/acpi.h
> >       320     F:      include/linux/fwnode.h
> >       321     F:      include/acpi/
> >       322     F:      Documentation/acpi/
> >       323     F:      Documentation/ABI/testing/sysfs-bus-acpi
> >       324     F:      Documentation/ABI/testing/configfs-acpi
> >       325     F:      drivers/pci/*acpi*
> >       326     F:      drivers/pci/*/*acpi*
> > -->   327     F:      drivers/pci/*/*/*acpi*
> >       328     F:      tools/power/acpi/
>
> My proposal to fix this:
>
> commit a99051c0d3c59fd259fd76a8bbd9837b76b509d9
> Author: Bjorn Helgaas <bhelgaas@google.com>
> Date:   Fri Sep 28 17:34:21 2018 -0500
>
>     MAINTAINERS: Remove obsolete drivers/pci pattern from ACPI section
>
>     Prior to 256a45937093 ("PCI/AER: Squash aerdrv_acpi.c into aerdrv.c"),
>     drivers/pci/pcie/aer/aerdrv_acpi.c contained code to parse the ACPI HEST
>     table.  That code now lives in drivers/pci/pcie/aer.c.
>
>     Remove the "F: drivers/pci/*/*/*acpi*" pattern because it matches nothing.
>
>     We could add a "F: drivers/pci/pcie/aer.c" pattern to the ACPI APEI
>     section, but that file sees a lot of changes, almost none of which are of
>     interest to the ACPI folks.
>
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 700408b7bc53..9babd8a0406b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -324,7 +324,6 @@ F:  Documentation/ABI/testing/sysfs-bus-acpi
>  F:     Documentation/ABI/testing/configfs-acpi
>  F:     drivers/pci/*acpi*
>  F:     drivers/pci/*/*acpi*
> -F:     drivers/pci/*/*/*acpi*
>  F:     tools/power/acpi/

Looks good to me.

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
