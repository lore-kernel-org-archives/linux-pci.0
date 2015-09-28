Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yk0-f178.google.com ([209.85.160.178]:36444 "EHLO
	mail-yk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751044AbbI1Wmk (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 28 Sep 2015 18:42:40 -0400
Received: by ykdt18 with SMTP id t18so196736544ykd.3
        for <linux-pci@vger.kernel.org>; Mon, 28 Sep 2015 15:42:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150928220854.GA16110@localhost>
References: <20150928220854.GA16110@localhost>
From: Rob Herring <robh@kernel.org>
Date: Mon, 28 Sep 2015 17:42:20 -0500
Message-ID: <CAL_JsqL_O2qqESs69spQCPuDfKG5g8_GZkhiYFo-+U8ttxnJng@mail.gmail.com>
Subject: Re: pci_generic_config_write32() access size problem
To: Bjorn Helgaas <helgaas@kernel.org>,
	Russell King <linux@arm.linux.org.uk>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Sep 28, 2015 at 5:08 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> Hi Rob,
>
> Russell pointed out a problem with 1f94a94f67e1 ("PCI: Add generic config
> accessors").  pci_generic_config_write32() does a read/modify/write if the
> size is less than 32 bits, so I think we have problem if this is used with
> 8- or 16-bit registers that contain RW1C bits.  Any thoughts on how we can
> fix this?

My series didn't change access sizes unless I made a made a mistake
somewhere, so the problem should have existed before.

Is it known addresses we need to deal with? We could do special case
handling of certain addresses to mask out RW1C bits. This could be in
the generic functions or in wrappers around the generic functions.
There's already some similar examples of special address handling
IIRC.

Rob
