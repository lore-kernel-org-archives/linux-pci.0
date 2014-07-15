Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qg0-f52.google.com ([209.85.192.52]:65156 "EHLO
	mail-qg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753458AbaGOXJn (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 15 Jul 2014 19:09:43 -0400
Received: by mail-qg0-f52.google.com with SMTP id f51so77657qge.39
        for <linux-pci@vger.kernel.org>; Tue, 15 Jul 2014 16:09:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20140715225503.22578.32174.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20140715225503.22578.32174.stgit@bhelgaas-glaptop.roam.corp.google.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 15 Jul 2014 17:09:22 -0600
Message-ID: <CAErSpo4nVjnu_fmFa1M5eZmu+fFfb=xcyd2meHYZ=JkAs2qzuw@mail.gmail.com>
Subject: Re: [PATCH 0/2] Fix GPL v2 license string typos
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Simon Horman <horms@verge.net.au>,
	Will Deacon <will.deacon@arm.com>
Cc: Thierry Reding <treding@nvidia.com>,
	linux-arm <linux-arm-kernel@lists.infradead.org>,
	"linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jul 15, 2014 at 4:56 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> Thierry posted similar patches for tegra and mvebu.  These change the rest
> of the occurrences in drivers/pci from:
>
>   -MODULE_LICENSE("GPLv2");
>   +MODULE_LICENSE("GPL v2");

I should have done the research earlier, but the relevant code that
checks these strings is license_is_gpl_compatible().  That looks for
"GPL v2" but not "GPLv2".

> ---
>
> Bjorn Helgaas (2):
>       PCI: generic: Fix GPL v2 license string typo
>       PCI: rcar: Fix GPL v2 license string typo
>
>
>  drivers/pci/host/pci-host-generic.c |    2 +-
>  drivers/pci/host/pcie-rcar.c        |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
