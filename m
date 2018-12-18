Return-Path: <SRS0=EJXn=O3=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA803C43387
	for <linux-pci@archiver.kernel.org>; Tue, 18 Dec 2018 01:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B18952145D
	for <linux-pci@archiver.kernel.org>; Tue, 18 Dec 2018 01:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545098248;
	bh=iTEuxmTmWB0AAAB918o1so12K6vF8+GBSSsw6p/IlQ8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=wiXM0jY5MFEqQeu8kCBbcEFT/Hev1ey1HAcbkd7e9XTEN5BYJbOX9l4Sn5zOJEHd4
	 ClcbzS7kce1DHbu89QRWLXRlLhtqBSl3Fq1MuFGCHsoscyjzBMI1mfDGsX9b+5V7mt
	 7QVHs0C8cVb/JANywZsBPa6nfzDbg8Du5jirqzhc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbeLRB52 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 17 Dec 2018 20:57:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:47990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726285AbeLRB51 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 17 Dec 2018 20:57:27 -0500
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 143BA21841;
        Tue, 18 Dec 2018 01:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545098247;
        bh=iTEuxmTmWB0AAAB918o1so12K6vF8+GBSSsw6p/IlQ8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nJaNRrAfxDIwikXESGUJbxFERzESP3z/L6GEHoYTjY3BnoIP770DIVK8ywXOA1/sp
         TBn6EobyyOltBmITtZZEZz7uwXc7ui0Bfg7KFih4u8Ntfwlu5aItpNfrRBjo5Ar6BR
         /JOIDJWxmwrosNBfdMszZUF7xypBoKh20JQP6rrU=
Received: by mail-ot1-f44.google.com with SMTP id u16so14171109otk.8;
        Mon, 17 Dec 2018 17:57:27 -0800 (PST)
X-Gm-Message-State: AA+aEWaWywgc17yb3HsU5nJnU0FMH3NcOtKlPQj2ur6QRtqg0rbIfIx9
        kAej8iwBH/Xar7SSjj8jteL6VMNhm/N6FjC9G9k=
X-Google-Smtp-Source: AFSGD/XZm1uU94yTE3AYVkGbePZqGCZbBVMp4lHOHaLra0EQ42rMESzNWXyOkPhJLWk3e+eD5VeXOVmzS7pvkF9go/8=
X-Received: by 2002:a9d:22a:: with SMTP id 39mr11592742otb.354.1545098246420;
 Mon, 17 Dec 2018 17:57:26 -0800 (PST)
MIME-Version: 1.0
References: <20181215010247.26101-1-okaya@kernel.org> <20181215010247.26101-4-okaya@kernel.org>
 <20181217170056.GA20499@gmail.com>
In-Reply-To: <20181217170056.GA20499@gmail.com>
From:   Sinan Kaya <Okaya@kernel.org>
Date:   Tue, 18 Dec 2018 02:57:14 +0100
X-Gmail-Original-Message-ID: <CAK9iUCN0UWRm94qiFop0Tv=i8-uZnpBkMZkXMTz-jDBke45MZw@mail.gmail.com>
Message-ID: <CAK9iUCN0UWRm94qiFop0Tv=i8-uZnpBkMZkXMTz-jDBke45MZw@mail.gmail.com>
Subject: Re: [PATCH v10 3/6] PCI/ACPI: Allow ACPI to be built without
 CONFIG_PCI set
To:     Ingo Molnar <mingo@kernel.org>
Cc:     linux-acpi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Robert Moore <robert.moore@intel.com>,
        Erik Schmauss <erik.schmauss@intel.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Otavio Pontes <otavio.pontes@intel.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Dec 17, 2018 at 6:01 PM Ingo Molnar <mingo@kernel.org> wrote:
&gt;
&gt;
&gt; * Sinan Kaya <okaya@kernel.org> wrote:
&gt;
&gt; &gt; We are compiling PCI code today for systems with ACPI and no PCI
&gt; &gt; device present. Remove the useless code and reduce the tight
&gt; &gt; dependency.
&gt; &gt;
&gt; &gt; Signed-off-by: Sinan Kaya <okaya@kernel.org>
&gt; &gt; Acked-by: Bjorn Helgaas <bhelgaas@google.com> # PCI parts
&gt;
&gt; If this is targeted for the ACPI tree:
&gt;

Thanks, yes. Plan is to take it through ACPI tree.

> Acked-by: Ingo Molnar <mingo@kernel.org>
>
> Thanks,
>
>         Ingo
