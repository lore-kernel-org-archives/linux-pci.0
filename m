Return-Path: <SRS0=Emu/=SZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AED5C10F03
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 16:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F708217D9
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 16:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556037616;
	bh=+K32CEJySJHRZYnsViCh90blV19hUxk8RW9cAv6Ulo0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=tm+I7Vw2URnmy7ZMyvEFufWpSdblsTa9ZzewpyRy0QAu2tIuPJAF3Xlv78iiNnzJT
	 r+U4AkaKF7ALk2Z0B/rednQ/JWr+rpO4HyI8yyI/nBYSAhb2h+YuOARPjqdkXJV3vj
	 VtFltpaNSlbX+SGaLpYTrKZKUP0TTOkbPo3lwaSo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729201AbfDWQkB (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 23 Apr 2019 12:40:01 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:39832 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728796AbfDWQj7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Apr 2019 12:39:59 -0400
Received: by mail-oi1-f193.google.com with SMTP id n187so11823680oih.6;
        Tue, 23 Apr 2019 09:39:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+K32CEJySJHRZYnsViCh90blV19hUxk8RW9cAv6Ulo0=;
        b=PpESjBfBkvPeeeAAgmKZJgOWZQrwFZQgIa9sRMcTyb8Ni5fw6dW2eFCLlOZO771Av5
         mPNx3v39nB1CO9vocxCHhCmJpe+My7lT1gKn4+hdrakbCzTjh/Kybcu1DgMfx80rjeu2
         YRuXXXGgUsdSj/OiNC6Y5Ub6KsXrY/LSkv1W2tN4VbdCktTi4S7lfqU2/f/WsNqBOlUR
         2PNvl2zGxonWkKYzCJfAiEW5nAQHZaL2WtZw57a2vB1nS4exPDjPEAl9+DrgCp0QpKNO
         y79oHuXiazC30yrVEvnwJbS9jfk0I9s0IVN1y8Q6Q2H9REXd2yjpRvX030QjbpaZWyWq
         unVA==
X-Gm-Message-State: APjAAAXGkntkadhqyxsfWint7c4gKYaDuK861cKENVj9M6Ht9OFA2v0/
        ceWkGradgJ73r16b96LbNBWdvKCbqgLjAUTvqcw=
X-Google-Smtp-Source: APXvYqyjp5DtSCtDUG+rmnZI31mrPN2qE3z63KQ1nAPWx58ynDjdfFmvDo+BMIXoWwqZdvHAAtJAYKpmM6dQRHFO+xE=
X-Received: by 2002:aca:ab06:: with SMTP id u6mr2199750oie.68.1556037598459;
 Tue, 23 Apr 2019 09:39:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190423162932.21428-1-changbin.du@gmail.com>
In-Reply-To: <20190423162932.21428-1-changbin.du@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 23 Apr 2019 18:39:47 +0200
Message-ID: <CAJZ5v0jPyaGQcDfpW5b7A-_3bvkfL78MxFmPtjwCGZ4-=KwUwg@mail.gmail.com>
Subject: Re: [PATCH v4 00/63] Include linux ACPI/PCI/X86 docs into Sphinx TOC tree
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PCI <linux-pci@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        linux-gpio@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 23, 2019 at 6:30 PM Changbin Du <changbin.du@gmail.com> wrote:
>
> Hi Corbet and All,
> The kernel now uses Sphinx to generate intelligent and beautiful documentation
> from reStructuredText files. I converted all of the Linux ACPI/PCI/X86 docs to
> reST format in this serias.
>
> In this version I combined ACPI and PCI docs, and added new x86 docs conversion.

I'm not sure if combining all three into one big patch series has been
a good idea, honestly.

It would have been easier to review and handle otherwise.

For one, I'd like to handle the ACPI part of it myself if Jon doesn't mind that.

Thanks,
Rafael
