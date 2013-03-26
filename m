Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oa0-f51.google.com ([209.85.219.51]:58686 "EHLO
	mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752392Ab3CZWfy (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 26 Mar 2013 18:35:54 -0400
Received: by mail-oa0-f51.google.com with SMTP id g12so4828879oah.38
        for <linux-pci@vger.kernel.org>; Tue, 26 Mar 2013 15:35:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <515213CF.7000804@gentoo.org>
References: <515213CF.7000804@gentoo.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 26 Mar 2013 16:35:33 -0600
Message-ID: <CAErSpo5wG8FUyomySdze56-e9Jr+3DevoCGGAnhLM8vpOBvQ5w@mail.gmail.com>
Subject: Re: lspci -k is broken with depmod from kmod since it doesn't
 generate modules.pcimap anymore
To: Samuli Suominen <ssuominen@gentoo.org>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Lucas De Marchi <lucas.demarchi@profusion.mobi>,
	Kay Sievers <kay@vrfy.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Mar 26, 2013 at 3:31 PM, Samuli Suominen <ssuominen@gentoo.org> wrote:
> The depmod from kmod no longer generates file modules.pcimap, and lspci -k
> relies on that as noted at:
>
> https://bugs.gentoo.org/show_bug.cgi?id=462982
>
> null pciutils-3.1.10 # grep -r modules.*map *
> ls-kernel.c:      sprintf(name, "/lib/modules/%s/modules.pcimap",
> uts.release);
> lspci.c:char *opt_pcimap;                       /* Override path to Linux
> modules.pcimap */
> lspci.c:"-p <file>\tLook up kernel modules in a given file instead of
> default modules.pcimap\n"
> lspci.man:.RI /lib/modules/ kernel_version /modules.pcimap.

I don't think this is a kernel problem, and I don't know where to
point you.  Maybe Lucas or Kay will know?
