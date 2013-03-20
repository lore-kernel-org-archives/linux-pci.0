Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:33666 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754032Ab3CTFkJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 20 Mar 2013 01:40:09 -0400
Message-ID: <1363757987.18880.31.camel@pasglop>
Subject: Re: [PATCHv2 3/3] ppc64: implemented pcibios_get_speed_cap_mask
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Lucas Kannebley Tavares <lucaskt@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	dri-devel@lists.freedesktop.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	David Airlie <airlied@linux.ie>,
	Brian King <brking@linux.vnet.ibm.com>,
	Thadeu Cascardo <cascardo@linux.vnet.ibm.com>,
	Alex Deucher <alexander.deucher@amd.com>
Date: Wed, 20 Mar 2013 06:39:47 +0100
In-Reply-To: <1363757079-23550-4-git-send-email-lucaskt@linux.vnet.ibm.com>
References: <1363757079-23550-1-git-send-email-lucaskt@linux.vnet.ibm.com>
	 <1363757079-23550-4-git-send-email-lucaskt@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 2013-03-20 at 02:24 -0300, Lucas Kannebley Tavares wrote:
> Implementation of a architecture-specific pcibios_get_speed_cap_mask.
> This implementation detects bus capabilities based on OF
> ibm,pcie-link-speed-stats property.

The problem with your approach is that it's not a runtime detection...

If the pseries machine is compiled into the kernel binary, it will
override pcibios_get_speed_cap_mask() using the device-tree, regardless
of whether the machine is currently booted on a pseries machine or not.

This wouldn't be a big problem if the pseries
pcibios_get_speed_cap_mask() was capable of doing a fallback to the
generic one if the device-tree property is absent but that isn't the
case.

I think what you need to do is:

  - Make it so the generic one can be called by the override. This can
look a bit tricky but it's better that way. One way to do it is to have
the actual implementation be in a __pci_* variant called by the weak
pcibios_* variant

  - Move the powerpc on to arch/powerpc/kernel/pci-common.c and make
it call a ppc_md.pcibios_get_speed_cap_mask(). If the hook is absent
(NULL), make it call the generic one

  - pseries can then populate the hook in ppc_md. with its custom
variant.

Cheers,
Ben.


