Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:52112 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754513AbaEGH7o (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 7 May 2014 03:59:44 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-doc@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Joerg Roedel <joro@8bytes.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	linux-kernel@vger.kernel.org,
	James Bottomley <jbottomley@parallels.com>,
	linux-pci@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH v2 5/5] iommu/exynos: Remove unnecessary "&" from function pointers
Date: Wed, 07 May 2014 09:59:12 +0200
Message-ID: <4487941.CzcQKkqQhp@wuerfel>
In-Reply-To: <20140506224846.17968.21521.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20140506223250.17968.27054.stgit@bhelgaas-glaptop.roam.corp.google.com> <20140506224846.17968.21521.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday 06 May 2014 16:48:46 Bjorn Helgaas wrote:
> Remove the unnecessary "&" from the function pointers in exynos_iommu_ops.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
