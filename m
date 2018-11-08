Return-Path: <SRS0=XjPq=NT=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB358C43441
	for <linux-pci@archiver.kernel.org>; Thu,  8 Nov 2018 23:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CE4C20857
	for <linux-pci@archiver.kernel.org>; Thu,  8 Nov 2018 23:52:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YxHFqStF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CE4C20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbeKIJaN (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 9 Nov 2018 04:30:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:57896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727016AbeKIJaN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 9 Nov 2018 04:30:13 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD8842081D;
        Thu,  8 Nov 2018 23:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541721136;
        bh=iu1hEBq/tdh/y4hDFiCPj3F9Nj6QHnloJHPE9YySEUs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YxHFqStFhXwsFEnPCD0Huu+LTTDwldYucDqIrugJWvyMta44y6ZV7dAwDAYhu82Rd
         si024UAay2ACIo3oM1+J/xrhPn0AOrGpLuOJUFL6FbpYQEAR8mR5sp9Ef4jUM2i0c4
         OynnG3087TDC/SxEH3UEjrjFp50vR2x3hr6BCJ0A=
Date:   Thu, 8 Nov 2018 17:52:14 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Add x86 early-quirks.c file pattern to PCI
 subsystem
Message-ID: <20181108235214.GI41183@google.com>
References: <154041923937.26247.17083948926896599419.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <154041923937.26247.17083948926896599419.stgit@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 24, 2018 at 05:13:59PM -0500, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> arch/x86/kernel/early-quirks.c contains special PCI quirks that need to
> run even before the usual DECLARE_PCI_FIXUP_EARLY() quirks.  These have
> typically been merged by the x86 maintainers, which is fine, but PCI folks
> should at least see what's happening, so add a file pattern to the PCI
> subsystem entry.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

I applied this with Ingo's ack to pci/misc for v4.20.

> ---
>  MAINTAINERS |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4ece30f15777..63cb7f3dbbb4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11249,6 +11249,7 @@ F:	include/uapi/linux/pci*
>  F:	lib/pci*
>  F:	arch/x86/pci/
>  F:	arch/x86/kernel/quirks.c
> +F:	arch/x86/kernel/early-quirks.c
>  
>  PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS
>  M:	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> 
