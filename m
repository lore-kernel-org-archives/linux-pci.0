Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from charlotte.tuxdriver.com ([70.61.120.58]:58451 "EHLO
	smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752139AbaCaK4e (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 31 Mar 2014 06:56:34 -0400
Date: Mon, 31 Mar 2014 06:56:19 -0400
From: Neil Horman <nhorman@tuxdriver.com>
To: Jean Delvare <jdelvare@suse.de>
Cc: Joerg Roedel <joro@8bytes.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci <linux-pci@vger.kernel.org>
Subject: Re: Interrupt remapping quirk tainting the kernel
Message-ID: <20140331105619.GA8050@hmsreliant.think-freely.org>
References: <1396253868.23070.94.camel@chaos.site>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1396253868.23070.94.camel@chaos.site>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Mar 31, 2014 at 10:17:48AM +0200, Jean Delvare wrote:
> Hi Neil and all,
> 
> I have (once again) a question about this commit:
> 
> From: Neil Horman <nhorman@tuxdriver.com>
> Date: Tue, 16 Apr 2013 20:38:32 +0000
> Subject: iommu/vt-d: add quirk for broken interrupt remapping on 55XX chipsets
> Git-commit: 03bbcb2e7e292838bb0244f5a7816d194c911d62
> 
> When interrupt remapping is disabled by this quirk, the kernel gets
> tainted. What is the rationale for doing that?
> 
> The user can boot with intremap=off. That will also disable interrupt
> remapping, as the quirk does, but not taint the kernel. If this is
> considered OK then I fail to see why the quirk should behave differently
> and taint the kernel.
> 
> Thanks,
The quirk is intented to flag to the user the fact that BIOS has not followed
the recommended procedure that was laied out in the intel published errata
sheet.  Arguably you could say that we should still taint the kernel in the
event that intremap=off is still specified, but it seems pragmatic not to do so,
as the use of that option suggsts the administrator has asserted a workaround to
the problem that is identical to the fix (in the event that the BIOS vendor has
not released an update).

Thanks
Neil

> -- 
> Jean Delvare
> SUSE L3 Support
> 
> 
