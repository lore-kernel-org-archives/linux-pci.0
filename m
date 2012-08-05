Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from minas.ics.muni.cz ([147.251.4.40]:39053 "EHLO minas.ics.muni.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752373Ab2HEIFR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sun, 5 Aug 2012 04:05:17 -0400
Date: Sun, 5 Aug 2012 10:05:00 +0200
From: Lukas Hejtmanek <xhejtman@ics.muni.cz>
To: Konrad Wilk <konrad.wilk@oracle.com>
Cc: yinghai@kernel.org, linux-pci@vger.kernel.org, roland@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: mellanox mlx4_core and SR-IOV
Message-ID: <20120805080500.GH25979@ics.muni.cz>
References: <9f903175-4080-4016-b9f8-83e8615c110e@default>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
In-Reply-To: <9f903175-4080-4016-b9f8-83e8615c110e@default>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

On Fri, Aug 03, 2012 at 06:49:59AM -0700, Konrad Wilk wrote:
> This looks like you are using PV PCI passthrough? If so, did you
> remember to use 'iommu=soft' to enable the Xen-SWIOTLB in your guest?
> And are you booting with more than 4GB? Or is less than 3GB (so that you have
> a nice gap in E820).

good catch. I forgot to pass swiotl=force for DomU in Xen. So now, it seems
that mlx4_core works, mlx4_en (ethernet part) works as well. Unfortunately,
the IB part does not. IB layer complains that SR-IOV is currently unsupported
(kernel 3.5.0). So no luck here so far. 

There is OFED stack directly from Mellanox, that seems to support SR-IOV even
for IB layer, but they have buildable sources only for RHEL/SLES kernels
(2.6.32) and even correcting the sources to get it compile with 3.5.0 does not
make things work. The driver complains about interrupts not working in Dom0 or
even without Xen hypervisor at all.

The only good point is, that I managed to convice Supermicro (board
manufacturer), that enabling SR-IOV in BIOS leads to BIOS lockup, they
confirmed it and maybe they provide BIOS upgrade.

Thanks all.

-- 
Luká¹ Hejtmánek
