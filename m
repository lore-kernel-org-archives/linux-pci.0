Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:60068 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750735AbcECFeS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 3 May 2016 01:34:18 -0400
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Yongji Xie <xyjxie@linux.vnet.ibm.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"aik@ozlabs.ru" <aik@ozlabs.ru>,
	"benh@kernel.crashing.org" <benh@kernel.crashing.org>,
	"paulus@samba.org" <paulus@samba.org>,
	"mpe@ellerman.id.au" <mpe@ellerman.id.au>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"warrier@linux.vnet.ibm.com" <warrier@linux.vnet.ibm.com>,
	"zhong@linux.vnet.ibm.com" <zhong@linux.vnet.ibm.com>,
	"nikunj@linux.vnet.ibm.com" <nikunj@linux.vnet.ibm.com>,
	"eric.auger@linaro.org" <eric.auger@linaro.org>,
	"will.deacon@arm.com" <will.deacon@arm.com>,
	"gwshan@linux.vnet.ibm.com" <gwshan@linux.vnet.ibm.com>,
	"David.Laight@ACULAB.COM" <David.Laight@ACULAB.COM>,
	"alistair@popple.id.au" <alistair@popple.id.au>,
	"ruscur@russell.cc" <ruscur@russell.cc>
Subject: RE: [PATCH 5/5] vfio-pci: Allow to mmap MSI-X table if interrupt
 remapping is supported
Date: Tue, 3 May 2016 05:34:14 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D15F842512@SHSMSX101.ccr.corp.intel.com>
References: <1461761010-5452-1-git-send-email-xyjxie@linux.vnet.ibm.com>
 <1461761010-5452-6-git-send-email-xyjxie@linux.vnet.ibm.com>
In-Reply-To: <1461761010-5452-6-git-send-email-xyjxie@linux.vnet.ibm.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> From: Yongji Xie
> Sent: Wednesday, April 27, 2016 8:43 PM
> 
> This patch enables mmapping MSI-X tables if hardware supports
> interrupt remapping which can ensure that a given pci device
> can only shoot the MSIs assigned for it.
> 
> With MSI-X table mmapped, we also need to expose the
> read/write interface which will be used to access MSI-X table.
> 
> Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>

A curious question here. Does "allow to mmap MSI-X" essentially
mean that KVM guest can directly read/write physical MSI-X
structure then?

Thanks
Kevin
