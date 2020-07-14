Return-Path: <SRS0=Y43U=AZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23A0AC433DF
	for <linux-pci@archiver.kernel.org>; Tue, 14 Jul 2020 15:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3C192222E
	for <linux-pci@archiver.kernel.org>; Tue, 14 Jul 2020 15:40:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PLO92HE7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7z5SMSaA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgGNPkj (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 14 Jul 2020 11:40:39 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44552 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbgGNPkj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Jul 2020 11:40:39 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594741236;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0uPhzHq4qVcpZoidpzCvLlU0JqwbUaoesqtBDTqjKBY=;
        b=PLO92HE7/OrFI76NkdCtdM347N4vVgYqABAguWpWwl3ejCAfppCAw6s/d6DP5XXf0WzVb6
        SeSEQDr6PgoCnCaS99Nifzf/47LrGXLiZERsKr5snbRfajeGiZeVsEpt40DQ5spQboWxNK
        GMzKzOa7dMx0oo31q+yV6xqnwn0I8/oxykuL3Rljwu64J7m35qoE8wvN73kjyf2LikEGry
        D2yiGmdnOAm/XKPNbO09aEsp0bwT+KWYaUwtyo3Sl2q1gXIqS3ZtnUOOYnWvRVQXDLzuA8
        xYly8d8C4i6aOadk8L42Dn75iISFDsz0sRXM200vL4SG/uI76Ja11bj0/YvW8g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594741236;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0uPhzHq4qVcpZoidpzCvLlU0JqwbUaoesqtBDTqjKBY=;
        b=7z5SMSaAIrIxPEdOiIM2SJSSEWAY7dHrxXAmHBts6tGDnNJSlcALzBN+Yn+aC1cfBEodHU
        m3RhVFEPXLdlItBg==
To:     "Derrick\, Jonathan" <jonathan.derrick@intel.com>,
        "andriy.shevchenko\@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "helgaas\@kernel.org" <helgaas@kernel.org>
Cc:     "Kalakota\, SushmaX" <sushmax.kalakota@intel.com>,
        "lorenzo.pieralisi\@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-pci\@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI: vmd: Keep fwnode allocated through VMD irqdomain life
In-Reply-To: <225256cc0ef63a3e149bcac97999d06381c52830.camel@intel.com>
References: <20200630163332.GA3437879@bjorn-Precision-5520> <225256cc0ef63a3e149bcac97999d06381c52830.camel@intel.com>
Date:   Tue, 14 Jul 2020 17:40:36 +0200
Message-ID: <87lfjmumtn.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

"Derrick, Jonathan" <jonathan.derrick@intel.com> writes:
> On Tue, 2020-06-30 at 11:33 -0500, Bjorn Helgaas wrote:
> I see that struct irqchip_fwid contains the actual fwnode structure and
> when that is freed, it's causes the issue.
>
> I'm noticing in each caller of irq_domain_free_fwnode, we have the
> domain itself available. It seems like it should be up to the caller to
> deal with the fwnode pointer, but we could just do:

Why? The fwnode pointer handling is inconsistent for the various fwnode
types. We really don't want to go back to that state.

Thanks,

        tglx
