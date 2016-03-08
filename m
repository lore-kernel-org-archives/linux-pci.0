Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:33215 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751207AbcCHSFg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 8 Mar 2016 13:05:36 -0500
Date: Tue, 8 Mar 2016 10:05:20 -0800
From: Andi Kleen <ak@linux.intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Jayachandran Chandrashekaran Nair
	<jayachandran.chandrashekaran@broadcom.com>,
	Rob Herring <robh@kernel.org>, x86@kernel.org,
	linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v1 0/3] PCI: Avoid touching non-compliant BARs
Message-ID: <20160308180520.GN23621@tassilo.jf.intel.com>
References: <20160226155334.9113.77645.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20160308175020.GD19869@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160308175020.GD19869@localhost>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> I applied the first two patches, with Andi's Tested-by, to
> pci/resource for v4.6.
> 
> Per Jayachandran, the Broadcom patch turned out not to be necessary,
> so I dropped that one.

Thanks. Can the patches please also be marked Cc: stable
for earlier kernels.

-Andi
