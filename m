Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:41079 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932110AbbDKHaf (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 11 Apr 2015 03:30:35 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
	by mailout.nyi.internal (Postfix) with ESMTP id 78C3F20808
	for <linux-pci@vger.kernel.org>; Sat, 11 Apr 2015 03:30:30 -0400 (EDT)
Date: Sat, 11 Apr 2015 09:30:31 +0200
From: Greg KH <greg@kroah.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Fam Zheng <famz@redhat.com>,
	linux-pci@vger.kernel.org, stable@vger.kernel.org,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH v6 01/10] PCI/MSI: Rename msi_set_enable(),
 msix_clear_and_set_ctrl()
Message-ID: <20150411073031.GA10481@kroah.com>
References: <20150410223533.20848.95316.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20150410225426.20848.45696.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150410225426.20848.45696.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Apr 10, 2015 at 05:54:26PM -0500, Bjorn Helgaas wrote:
> From: Michael S. Tsirkin <mst@redhat.com>
> 
> Rename msi_set_enable() to pci_msi_set_enable() and
> msix_clear_and_set_ctrl() to pci_msix_clear_and_set_ctrl().
> 
> No functional change.
> 
> [bhelgaas: changelog, split into separate patch]
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Reviewed-by: Fam Zheng <famz@redhat.com>
> CC: stable@vger.kernel.org
> ---
>  drivers/pci/msi.c |   28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)

How does this, and the other patch you marked for stable, relate to the
stable_kernel_rules.txt file that dictates what we can take for stable
patches?

confused,

greg k-h
