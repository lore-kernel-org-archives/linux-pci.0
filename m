Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oa0-f42.google.com ([209.85.219.42]:32781 "EHLO
	mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756496Ab3GYVKY (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 25 Jul 2013 17:10:24 -0400
Received: by mail-oa0-f42.google.com with SMTP id j6so5707534oag.15
        for <linux-pci@vger.kernel.org>; Thu, 25 Jul 2013 14:10:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20130524165947.GA2487@pyxis.br.cox.net>
References: <20130524165947.GA2487@pyxis.br.cox.net>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 25 Jul 2013 15:10:03 -0600
Message-ID: <CAErSpo4MkK-dYc1vqLombm01gVyBj2poKSMSD5f3VdzsuSj7QA@mail.gmail.com>
Subject: Re: Patch: Increase maximum bus memory window size (for Xeon Phi)
To: Bryce Lelbach <blelbach@cct.lsu.edu>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, May 24, 2013 at 10:59 AM, Bryce Lelbach <blelbach@cct.lsu.edu> wrote:
> The attached patch affects pbus_size_mem() in drivers/pci/setup-bus.c. The patch
> increases the maximum memory window size for a PCI bus from 2 Gb to 2^63 Gb.
>
> This change is necessary to support Intel Xeon Phi co-processors. These co-processors
> are PCIe devices used for high-performance computing applications. The device requires
> an 8Gb memory window to function (the co-processor has 8Gb of onboard memory).
>
> This patch is a modified version of a patch from Intel's MPSS framework
> (specifically, from the "KNC_gold_update_1-2.1.4982-15-rhel-6.3" package), which
> will apply to a 3.7.8 kernel (I am about to try it on a 3.8 kernel). To the best
> of my knowledge, newer RHEL kernels are shipped with this patch.

This needs a Signed-off-by before it can be applied (see
Documentation/SubmittingPatches for details about what this means).

Also, there's some confusion about this being in RHEL.  I take it that
it is not actually in RHEL, but perhaps in an Intel-supplied update
that is commonly applied on top of RHEL?

IIRC, a very similar patch was posted last year.  It'd be nice to dig
that up and credit that author as well.

It's more convenient for me to receive patches as plain-text email
(not attachments), also as described in SubmittingPatches.  I *can*
deal with attachments, but it's a hassle and I tend to keep putting
them off ;)

Bjorn
