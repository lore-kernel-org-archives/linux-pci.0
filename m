Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:52704 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751927AbbJCOgd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sat, 3 Oct 2015 10:36:33 -0400
Date: Sat, 3 Oct 2015 09:36:30 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Christian Melki <christian.melki@t2data.com>
Cc: linux-pci@vger.kernel.org,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Joerg Roedel <joro@8bytes.org>,
	iommu@lists.linux-foundation.org
Subject: Re: Fwd: SWIOTLB on 32-bit PAE.
Message-ID: <20151003143630.GB17684@localhost>
References: <560E9007.1000604@t2data.com>
 <560E92A0.9030707@t2data.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <560E92A0.9030707@t2data.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Konrad, Joerg, iommu list]

On Fri, Oct 02, 2015 at 04:20:16PM +0200, Christian Melki wrote:
> I discovered a strange error on my machine. 32-bit PAE 4.2.0 without
> IOMMU code (yeah, I know).
> When writing to an ext4 filesystem on a USB disk my kernel would hang
> and not return control to userspace. It would spew kernel messages to
> syslog as fast as it could without giving userspace any time, ie "hang"
> as far as a user sees it. The device itself is ok and the filesystem is
> clean.
> I get messages like this, millions of them.
> 
> Oct  2 14:33:06 voodoochild kernel: [  223.287447] nommu_map_sg:
> overflow 25dcac000+1024 of device mask ffffffff
> Oct  2 14:33:06 voodoochild kernel: [  223.287448] nommu_map_sg:
> overflow 25dcac000+1024 of device mask ffffffff
> Oct  2 14:33:06 voodoochild kernel: [  223.287449] nommu_map_sg:
> overflow 25dcac000+1024 of device mask ffffffff
> 
> I disovered that SWIOTLB was not on. It is only provided for 64-bit
> machines where it is default. On 32-bit SWIOTLB seems disabled
> unless you are running with some IOMMU/AGPGART code.
> 
> But what about 32-bit PAE? Would that not qualify for SWIOTLB without IOMMU?
> 
> I am a novice in this area. Maybe this is a Kconfig "bug" for us
> that like to hang ourselves with CONFIG_* rope? :) I'd like to think
> that SWIOTLB should be default for 32-bit PAE too?
> 
> Best regards,
> Christian
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
