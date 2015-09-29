Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from 8bytes.org ([81.169.241.247]:53735 "EHLO theia.8bytes.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756058AbbI2Mkc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 29 Sep 2015 08:40:32 -0400
Date: Tue, 29 Sep 2015 14:40:30 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Cc: iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	Sebastian Ott <sebott@linux.vnet.ibm.com>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH] iommu/s390: add iommu api for s390 pci devices
Message-ID: <20150929124030.GI3036@8bytes.org>
References: <1440682383-27688-1-git-send-email-gerald.schaefer@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1440682383-27688-1-git-send-email-gerald.schaefer@de.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Gerald,

thanks for your patch. It looks pretty good and addresses my previous
review comments. I have a few questions, first one is how this
operates with DMA-API on s390. Is there a seperate DMA-API
implementation besides the IOMMU-API one for PCI devices?

My other question is inline:

On Thu, Aug 27, 2015 at 03:33:03PM +0200, Gerald Schaefer wrote:
> +struct s390_domain_device {
> +	struct list_head	list;
> +	struct zpci_dev		*zdev;
> +};

Instead of using your own struct here, have you considered using the
struct iommu_group instead? The struct devices contains a pointer to an
iommu_group and the struct itself contains pointers to the domain it is
currently bound to.


Regards,

	Joerg

