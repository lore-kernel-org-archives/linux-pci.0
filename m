Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:47611 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752620AbcDSXx6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 19 Apr 2016 19:53:58 -0400
Date: Tue, 19 Apr 2016 18:53:54 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] PCI: Skylake PCH ACS quirks
Message-ID: <20160419235354.GF17863@localhost>
References: <20160331222828.20486.30979.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160331222828.20486.30979.stgit@gimli.home>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Mar 31, 2016 at 04:34:26PM -0600, Alex Williamson wrote:
> Intel Skylake systems attempted to implement ACS on the PCH root
> ports, but it came out a wee bit off.  As noted in the second patch
> and the datasheets from Intel, dwords were used for the ACS
> capability and control words, so we see the capabilities correctly
> but the control register is an extra 2 bytes offset.  With this
> quirk we can fix the kernel, unfortunately lspci will still show
> the wrong ACS control bits though.  Thanks,
> 
> Alex
> 
> ---
> 
> Alex Williamson (2):
>       PCI: Reverse standard ACS vs device specific ACS enabling
>       PCI: Quirk PCH root port ACS for Sunrise Point

Wow, hard to imagine how that got through validation.

Applied to pci/virtualization for v4.7, thanks, Alex!
