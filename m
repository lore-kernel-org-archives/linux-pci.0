Return-Path: <SRS0=Hm5h=NQ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FCD7C0044C
	for <linux-pci@archiver.kernel.org>; Mon,  5 Nov 2018 21:38:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CF3420827
	for <linux-pci@archiver.kernel.org>; Mon,  5 Nov 2018 21:38:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CF3420827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387580AbeKFHAO (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 6 Nov 2018 02:00:14 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:36105 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387441AbeKFHAO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Nov 2018 02:00:14 -0500
Received: from p5492fe24.dip0.t-ipconnect.de ([84.146.254.36] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gJmZm-0005vk-FD; Mon, 05 Nov 2018 22:38:26 +0100
Date:   Mon, 5 Nov 2018 22:38:25 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Zubin Mithra <zsm@chromium.org>
cc:     mingo@redhat.com, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
        groeck@chromium.org, Kees Cook <keescook@chromium.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] x86/pci: Annotate 'pci_root_ops' with __ro_after_init
In-Reply-To: <20181105201735.72026-1-zsm@chromium.org>
Message-ID: <alpine.DEB.2.21.1811052232020.1659@nanos.tec.linutronix.de>
References: <20181105201735.72026-1-zsm@chromium.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 5 Nov 2018, Zubin Mithra wrote:

Cc+: Bjorn

> When CONFIG_X86_INTEL_MID is set pci_root_ops is written to inside
> intel_mid_pci_init(which is marked __init) and not modified after. This
> makes pci_root_ops a suitable candidate for annotating as
> __ro_after_init.

This is confusing. What about CONFIG_X86_INTEL_MID=n?

What you want to say is:

 pci_root_ops is only modified from intel_mid_pci_init() which is a init
 function, so it can be made __ro_after_init.

or something like this. Hmm?

Other than the nitpick above:

      Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

> Signed-off-by: Zubin Mithra <zsm@chromium.org>
> ---
>  arch/x86/pci/common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
> index d4ec117c1142..204ee80cfa63 100644
> --- a/arch/x86/pci/common.c
> +++ b/arch/x86/pci/common.c
> @@ -67,7 +67,7 @@ static int pci_write(struct pci_bus *bus, unsigned int devfn, int where, int siz
>  				  devfn, where, size, value);
>  }
>  
> -struct pci_ops pci_root_ops = {
> +struct pci_ops pci_root_ops __ro_after_init = {
>  	.read = pci_read,
>  	.write = pci_write,
>  };
> -- 
> 2.19.1.930.g4563a0d9d0-goog
> 
> 
