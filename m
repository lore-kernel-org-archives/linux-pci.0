Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:50435 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933083AbbKFRWL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 6 Nov 2015 12:22:11 -0500
Date: Fri, 6 Nov 2015 11:22:05 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: linux-pci@vger.kernel.org
Subject: Re: ECRC and Max Read Request Size
Message-ID: <20151106172205.GA1002@localhost>
References: <56310B34.6000102@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <56310B34.6000102@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Sinan,

On Wed, Oct 28, 2015 at 01:51:48PM -0400, Sinan Kaya wrote:
> I'm seeing two problems with the current PCI framework when it comes
> to end-to-end CRC (ECRC) and Max Read Request Size.
> 
> The problem with ECRC is that it blindly enables ECRC generation on
> devices without checking if it is supported by the entire bus with
> ECRC=on option.
> 
> ECRC check can be enabled on all devices but ECRC generation on the
> root complex and switches needs to be set only if all devices
> support ECRC checking.
> 
> I'm thinking of making changes in this area to cover this gap with
> ECRC=safe option.

Sometimes they can't be avoided, but I'm generally not in favor of
adding command line parameters because they require too much of our
users and they introduce code paths that are rarely exercised.

What specific ECRC problem are you seeing?  Do you have devices that
don't operate correctly with the current code?  Or do you want to add
some new functionality, e.g., to enable ECRC in cases where we don't
enable it today?

> The other problem I'm seeing is about the maximum read request size.
> If I choose the PCI bus performance mode, maximum read request size
> is being limited to the maximum payload size.
> 
> I'd like to add a new mode where I can have bigger read request size
> than the maximum payload size.

I've never been thrilled about the way Linux ties MRRS and MPS
together.  I don't think the spec envisioned MRRS being used to
control segment size on the link.  My impression is that the purpose
of MRRS is to limit the amount of time one device can dominate a link.

I am sympathetic to the idea of having MRRS larger than MPS.  The
question is how to accomplish that.  I'm not really happy with the
current set of "pcie_bus_tune_*" parameters, so I'd hesitate to add
yet another one.  They feel like they're basically workarounds for the
fact that Linux can't optimize MPS directly itself.

Can you give any more specifics of your MRRS/MPS situation?  I guess
you hope to improve bandwidth to some device by reducing the number of
read requests?  Do you have any quantitative estimate of what you can
gain?

Bjorn
