Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from muin.pair.com ([209.68.1.55]:53710 "EHLO muin.pair.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753065Ab3I3AFp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sun, 29 Sep 2013 20:05:45 -0400
Received: from mail-vc0-f175.google.com (mail-vc0-f175.google.com [209.85.220.175])
	by muin.pair.com (Postfix) with ESMTPSA id 671BC8FC12
	for <linux-pci@vger.kernel.org>; Sun, 29 Sep 2013 19:56:19 -0400 (EDT)
Received: by mail-vc0-f175.google.com with SMTP id ia10so3225337vcb.20
        for <linux-pci@vger.kernel.org>; Sun, 29 Sep 2013 16:56:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1379502122-20792-2-git-send-email-Minghuan.Lian@freescale.com>
References: <1379502122-20792-1-git-send-email-Minghuan.Lian@freescale.com>
	<1379502122-20792-2-git-send-email-Minghuan.Lian@freescale.com>
Date: Sun, 29 Sep 2013 18:56:18 -0500
Message-ID: <CAOZdJXUF3ibW5iuB-2p5bhPp-Uw9MVKzqZiDdukMfi4f1d3Phw@mail.gmail.com>
Subject: Re: [PATCH 2/2] pci: fsl: rework PCI driver compatible with Layerscape
From: Timur Tabi <timur@tabi.org>
To: Minghuan Lian <Minghuan.Lian@freescale.com>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	linux-pci@vger.kernel.org, Zang Roy-R61911 <r61911@freescale.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Scott Wood <scottwood@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Sep 18, 2013 at 6:02 AM, Minghuan Lian
<Minghuan.Lian@freescale.com> wrote:

> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 38f3b7e..6fd6348 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -690,6 +690,7 @@ config FSL_SOC
>
>  config FSL_PCI
>         bool
> +       select PCI_FSL if FSL_SOC_BOOKE || PPC_86xx

I think having two config options, one called FSL_PCI and the other
PCI_FSL, is very confusing.  Surely, you can pick better names than
that?
