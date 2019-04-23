Return-Path: <SRS0=Emu/=SZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DACEC10F03
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 17:36:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 311C8214AE
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 17:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556041012;
	bh=0ywx4lbgLqdcOUJmTJLQ1S0sd6blYojEzZMGaehyCq4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hlnLaTMZs3LAtkvpXFb2asDRPi/JOvoZluo+BRWOodzSnConNvOwrvnYnT7+YEjhg
	 7SuenJk8eH5ArEBSX7ji4WGBTvXmXGcaTl2wj/5ApTtIz6y6feCvOPtqULpteM6ykO
	 OfHactqrFV5j6ciAtdAgNSS+ighs/SSIpYN9HD7c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729363AbfDWRgq (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 23 Apr 2019 13:36:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:32872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728526AbfDWRgp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 23 Apr 2019 13:36:45 -0400
Received: from localhost (odyssey.drury.edu [64.22.249.253])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02F66206BA;
        Tue, 23 Apr 2019 17:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556041005;
        bh=0ywx4lbgLqdcOUJmTJLQ1S0sd6blYojEzZMGaehyCq4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RFKifikufVAAEiYElOfFEZNBmaOX2AaURO7CJBO43uVnIm7SiUToincr0CoU5SipS
         eq2M2g/oAiDcLtIuc216jiwUzJebwpsyrWM9ejkKSSdRE8ZRTqbu9nljumpqsQwuQ6
         IfP1DjparUtNRl4DWKZkRDEo/m77cCe09UE43KGY=
Date:   Tue, 23 Apr 2019 12:36:44 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Changbin Du <changbin.du@gmail.com>,
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
Message-ID: <20190423173644.GA14616@google.com>
References: <20190423162932.21428-1-changbin.du@gmail.com>
 <CAJZ5v0jPyaGQcDfpW5b7A-_3bvkfL78MxFmPtjwCGZ4-=KwUwg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jPyaGQcDfpW5b7A-_3bvkfL78MxFmPtjwCGZ4-=KwUwg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 23, 2019 at 06:39:47PM +0200, Rafael J. Wysocki wrote:
> On Tue, Apr 23, 2019 at 6:30 PM Changbin Du <changbin.du@gmail.com> wrote:
> > Hi Corbet and All,
> > The kernel now uses Sphinx to generate intelligent and beautiful
> > documentation from reStructuredText files. I converted all of the Linux
> > ACPI/PCI/X86 docs to reST format in this serias.
> >
> > In this version I combined ACPI and PCI docs, and added new x86 docs
> > conversion.
> 
> I'm not sure if combining all three into one big patch series has been
> a good idea, honestly.

Yeah, if you post this again, I would find it easier to deal with if
linux-pci only got the PCI-related things.  63 patches is a little too
much for one series.

Bjorn
