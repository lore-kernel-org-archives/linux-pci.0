Return-Path: <SRS0=iymf=OS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D5EEC07E85
	for <linux-pci@archiver.kernel.org>; Sun,  9 Dec 2018 06:20:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 108022086E
	for <linux-pci@archiver.kernel.org>; Sun,  9 Dec 2018 06:20:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EA4GR6tP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 108022086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbeLIGUh (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 9 Dec 2018 01:20:37 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33432 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbeLIGUh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 9 Dec 2018 01:20:37 -0500
Received: by mail-qt1-f194.google.com with SMTP id l11so9064226qtp.0;
        Sat, 08 Dec 2018 22:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BBrT9x6lbdBqPLHun+vpeIcsLQMplwfhFjYdmho9/OQ=;
        b=EA4GR6tPLbW+R8JXjRBfWqgagkPEC8jNehxDV7rb0n9Cwt15LcXUqVvEkRV1bCBClH
         EQfXfmeFcFAgXREkz7QP7QCbEBUwoJIOjT3oBjeizHUsx+WTlZnRwgrdFZVUMEQC6g6y
         EbsXFmsSXJG/as30FZf5m5aORYskuEQetN5w8lp35Y3DNrPttIt+O3aQIL3UbTfDIDao
         uwT8E69jAknunyZONgq9gihJH8X7hKSqy6sW6Z6Q6G8R0RPRA3MT4fCZ6J4nRu8XZW3s
         LXFYPu1DHrsYkYrRYBSi6539OhZwlPoyMK4OV+7dATNKt4oXh2yTvOwy1tgrxpkjbDXL
         zwFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BBrT9x6lbdBqPLHun+vpeIcsLQMplwfhFjYdmho9/OQ=;
        b=jfHMVeKkUTyK5TZW13j+3m8s1iEKX5bmshkcXZ7y+foPQGYn73/5waufWftYtuj75Z
         PEjwF/j8EkLRfMlGdSY18vu2/7I7OJZ/fkBPTQmqU6h+8J/c2bMD146m6SGek2mSePwC
         HMnstf+wudva4g/szTAaL7RqsKl78v8Myat1aSUNCDgp5PeTFs6ZvJUR9uhhXCSBKF2D
         vPGgIuBu5eCuptWODOirUGS87QLMx7X0mtnOM0bwG6zB2nvV7/GQE/gfnF+vX8l7x4OB
         /kmIZkkDCWiuzghtUA6PhqkPtCCvgvXxcr3zQaUvaG/FKL7B1hiDCKa3k83HKdIbtLT6
         dJMw==
X-Gm-Message-State: AA+aEWYooKs3FtpBE/fAv+MqKEMmDqbVSTasIAHVqalxmwH5hPy59hx4
        HHI0cIRBMFfB44j6ulojGazhDA37ikHA7aeX/Bo=
X-Google-Smtp-Source: AFSGD/X+pIVMr0+2/bN/k/hvZWLgL5SyOdc9OGtqatl5CW/kCK53QxMG3ens+2jmvE2/j13DWBdGyKNmawQGSU7D/3Q=
X-Received: by 2002:ac8:6151:: with SMTP id d17mr7672088qtm.194.1544336436035;
 Sat, 08 Dec 2018 22:20:36 -0800 (PST)
MIME-Version: 1.0
References: <20181208214644.5374-1-okaya@kernel.org> <20181208214644.5374-3-okaya@kernel.org>
In-Reply-To: <20181208214644.5374-3-okaya@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 9 Dec 2018 08:20:24 +0200
Message-ID: <CAHp75VeCSPv81Bf2zjgFfD1YW2B6Z0YdhJsGR+Hvrf54mvdOPA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] PCI/ACPI: allow ACPI to be built without PCI support
To:     okaya@kernel.org
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Robert Moore <robert.moore@intel.com>,
        "Schmauss, Erik" <erik.schmauss@intel.com>,
        Jan Kiszka <jan.kiszka@siemens.com>, otavio.pontes@intel.com,
        Christian Koenig <christian.koenig@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org, devel@acpica.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Dec 8, 2018 at 11:46 PM Sinan Kaya <okaya@kernel.org> wrote:
>
> We are compiling PCI code today for systems with ACPI and no PCI
> device present. Remove the useless code and reduce the tight
> dependency.

> +#ifdef CONFIG_PCI
>  struct pci_dev *acpi_get_pci_dev(acpi_handle);
> +#else
> +static inline struct pci_dev *acpi_get_pci_dev(acpi_handle hndl)

Can you spell handle fully?

> +{
> +       return NULL;
> +}
> +#endif

-- 
With Best Regards,
Andy Shevchenko
