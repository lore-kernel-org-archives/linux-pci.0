Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:46383 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752030Ab2CGX1v convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 7 Mar 2012 18:27:51 -0500
Received: by lahj13 with SMTP id j13so7891797lah.19
        for <linux-pci@vger.kernel.org>; Wed, 07 Mar 2012 15:27:50 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20120307223432.25669.51388.stgit@bhelgaas.mtv.corp.google.com>
References: <20120307222436.25669.52282.stgit@bhelgaas.mtv.corp.google.com> <20120307223432.25669.51388.stgit@bhelgaas.mtv.corp.google.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 7 Mar 2012 16:27:30 -0700
Message-ID: <CAErSpo5Z10UrstkGLhCrEQm_vrMA0a7TNk=D256FixrG_V6n6w@mail.gmail.com>
Subject: Re: [PATCH v3 29/34] sparc/PCI: get rid of device resource fixups
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: linux-arch@vger.kernel.org, linux-pci@vger.kernel.org,
	sparclinux@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Mar 7, 2012 at 3:34 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> Tell the PCI core about host bridge address translation so it can take
> care of bus-to-resource conversion for us.
>
> Previously, when enumerating PCI devices from the OF device tree, sparc
> used pci_resource_adjust() to perform this address fixup for P2P bridge
> windows in the following places:
>
>    pci_cfg_fake_ranges()
>    apb_fake_ranges()
>    of_scan_pci_bridge()
>
> This patch replaces pci_resource_adjust() with the generic
> pcibios_bus_to_resource() and the appropriate pci_add_resource_offset()
> use to tell the PCI core about host bridge apertures and offsets.
>
> Resources of non-P2P bridge devices are set in pci_parse_of_addrs() and,
> as far as I can see, never converted to CPU addresses.

I'm concerned about this -- the fact that we seem to do bus-to-CPU
conversions on P2P bridge windows, but not on endpoint BARs.

Is it really the case that the OF device tree has bus addresses for
P2P windows but CPU addresses for other BARs?  That would be
surprising to me.  Or did I miss a conversion somewhere?

Help :)  Any sparc experts want to enlighten me?

Bjorn
