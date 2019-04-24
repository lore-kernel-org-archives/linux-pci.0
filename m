Return-Path: <SRS0=9smm=S2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3898C10F11
	for <linux-pci@archiver.kernel.org>; Wed, 24 Apr 2019 15:46:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7309720878
	for <linux-pci@archiver.kernel.org>; Wed, 24 Apr 2019 15:46:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ODqw1SW1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731080AbfDXPqa (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 24 Apr 2019 11:46:30 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40238 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727327AbfDXPqa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Apr 2019 11:46:30 -0400
Received: by mail-pl1-f193.google.com with SMTP id b3so9491717plr.7;
        Wed, 24 Apr 2019 08:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Y0LsCVSrGvoNOIOBTy+0pPOtleaTZYJy2+61/AagOVw=;
        b=ODqw1SW1096t2F8vFyk3P59wHCbJ7qXOaM37DdDe05X6EwQoskcUPWaGbz/hs76P7U
         TUOFwLI/hsCU6afQjXPkZrTkYmmGaETeod6xT4ulHGWIorpiTGcQk2kmBGw9maDWahiT
         k+Y2en03bXv7vbD8TMOBwxPPgKe2qWwF4NfuJlm5XmLGDXXL2cwheDNOFD9dJ5pKl9jL
         z0FNIw0S4bDJzuc7RBZsgk3/25xY+Yt2Ztv/RZeLFIJ388Y2HSg7ikZUxZhu89RDq3lU
         4gjuaUFHN0zyIcVK9YDrbRRWTnIjVgh5dQnZAYsmIIKfqDnmKNcrPOntbOssobcZalcx
         idyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Y0LsCVSrGvoNOIOBTy+0pPOtleaTZYJy2+61/AagOVw=;
        b=XYZgGp2MIAnARnqBpRPkaLJtA5QkzHY6rtDgJVfjaQSjG8A3dLICx6PhGryDXTHH7d
         6TOkwQRuFSISlHo9MBfPpr+bcY9+brpWfLm7ejlUpuRtXDYikUGxhvswRsAR7Nl6q+o4
         VTUQDnEmtwojZnStj/kpTEq1eNlQGQ8ksYejZahZWdSH1q34wPs4OSIS8gNYosDy1RCM
         L2iKuPNxEmL2bkSHZzaV1PZ9MyrgXYOrUCyhFz8oaeC6KZsNpYp+h98iGwcs0FoAopiU
         vgzrN8eu4+MJBN8OUiJqgWdxuhmHmQfHGX7XtlIbCUZJTLqWbmHZ7+h+vf/JodKSVGIO
         a9fQ==
X-Gm-Message-State: APjAAAU7kqM/7Cye3kS+mQxgxkWb0Y+bh5c3lB+KnZz0W7P4EjDP2+I/
        daG01X9EuQCmibzBMq+i/V0=
X-Google-Smtp-Source: APXvYqx1LVJqHOnpDOTUG9ydbgXkCgWczr574IlkzKmuvt4hX8i46bC8skY8tJxknOZWxaizOzpQyQ==
X-Received: by 2002:a17:902:868e:: with SMTP id g14mr15575836plo.183.1556120789376;
        Wed, 24 Apr 2019 08:46:29 -0700 (PDT)
Received: from mail.google.com ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id d67sm7320974pfa.35.2019.04.24.08.46.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Apr 2019 08:46:28 -0700 (PDT)
Date:   Wed, 24 Apr 2019 23:46:18 +0800
From:   Changbin Du <changbin.du@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Changbin Du <changbin.du@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PCI <linux-pci@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        linux-gpio@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: Re: [PATCH v4 00/63] Include linux ACPI/PCI/X86 docs into Sphinx TOC
 tree
Message-ID: <20190424154617.kowr5aamjkeceltr@mail.google.com>
References: <20190423162932.21428-1-changbin.du@gmail.com>
 <CAJZ5v0jPyaGQcDfpW5b7A-_3bvkfL78MxFmPtjwCGZ4-=KwUwg@mail.gmail.com>
 <20190423173644.GA14616@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190423173644.GA14616@google.com>
User-Agent: NeoMutt/20180716
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 23, 2019 at 12:36:44PM -0500, Bjorn Helgaas wrote:
> On Tue, Apr 23, 2019 at 06:39:47PM +0200, Rafael J. Wysocki wrote:
> > On Tue, Apr 23, 2019 at 6:30 PM Changbin Du <changbin.du@gmail.com> wrote:
> > > Hi Corbet and All,
> > > The kernel now uses Sphinx to generate intelligent and beautiful
> > > documentation from reStructuredText files. I converted all of the Linux
> > > ACPI/PCI/X86 docs to reST format in this serias.
> > >
> > > In this version I combined ACPI and PCI docs, and added new x86 docs
> > > conversion.
> > 
> > I'm not sure if combining all three into one big patch series has been
> > a good idea, honestly.
> 
> Yeah, if you post this again, I would find it easier to deal with if
> linux-pci only got the PCI-related things.  63 patches is a little too
> much for one series.
>
sure, so I will resend them respectively.

> Bjorn

-- 
Cheers,
Changbin Du
