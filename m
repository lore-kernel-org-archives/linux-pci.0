Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:43812 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751005AbaBRRyf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 18 Feb 2014 12:54:35 -0500
Date: Tue, 18 Feb 2014 10:54:32 -0700 (MST)
From: Keith Busch <keith.busch@intel.com>
To: Alexander Gordeev <agordeev@redhat.com>
cc: Keith Busch <keith.busch@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Matthew Wilcox <willy@linux.intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	linux-nvme@lists.infradead.org,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v3 6/9] nvme: Use pci_enable_msi_range() and
 pci_enable_msix_range()
In-Reply-To: <20140120084046.GB19068@dhcp-26-207.brq.redhat.com>
Message-ID: <alpine.LRH.2.03.1402181044560.4656@AMR>
References: <cover.1389904166.git.agordeev@redhat.com> <1c441f670f33375b6c41e074baf6e84e6c7bb0c2.1389904166.git.agordeev@redhat.com> <CAErSpo4g_xm4vZWZDgyjtJu+z5ARSerQLrtJ6W_peXv4bKwcgg@mail.gmail.com> <alpine.LRH.2.03.1401171419370.25844@AMR>
 <20140120083835.GA19068@dhcp-26-207.brq.redhat.com> <20140120084046.GB19068@dhcp-26-207.brq.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, 20 Jan 2014, Alexander Gordeev wrote:
> As result deprecation of MSI-X/MSI enablement functions
> pci_enable_msix() and pci_enable_msi_block() all drivers
> using these two interfaces need to be updated to use the
> new pci_enable_msi_range() and pci_enable_msix_range()
> interfaces.
>
> Signed-off-by: Alexander Gordeev <agordeev@redhat.com>

Reviewed-by: Keith Busch <keith.busch@intel.com>
