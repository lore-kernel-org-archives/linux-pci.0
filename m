Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60155 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752111Ab2DZMYP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 26 Apr 2012 08:24:15 -0400
Message-ID: <4F993E69.1010309@redhat.com>
Date: Thu, 26 Apr 2012 08:24:09 -0400
From: Prarit Bhargava <prarit@redhat.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: linux-pci@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>,
	Matthew Wilcox <matthew.wilcox@linux.intel.com>,
	Don Dutile <ddutile@redhat.com>,
	Myron Stowe <mstowe@redhat.com>,
	James Paradis <james.paradis@stratus.com>
Subject: Re: [PATCH v1] PCI: work around Stratus ftServer broken PCIe hierarchy
References: <20120425233632.12292.32916.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20120425233632.12292.32916.stgit@bhelgaas.mtv.corp.google.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 04/25/2012 07:36 PM, Bjorn Helgaas wrote:
> A PCIe downstream port is a P2P bridge.  Its secondary interface is
> a link that should lead only to device 0 (unless ARI is enabled)[1], so
> we don't probe for non-zero device numbers.
> 
> Some Stratus ftServer systems have a PCIe downstream port (02:00.0) that
> leads to both an upstream port (03:00.0) and a downstream port (03:01.0),
> and 03:01.0 has important devices below it:
> 
>   [0000:02]-+-00.0-[0000:03]--+-00.0
>                               \-01.0-[0000:xx]--+-[USB]
>                                                 \-[NIC]
> 
> Previously, we didn't enumerate device 03:01.0, so USB and the network
> didn't work.  This patch adds a DMI quirk to scan all device numbers,
> not just 0, below a downstream port.
> 
> Based on a patch by Prarit Bhargava.
> 
> [1] PCIe spec r3.0, sec 7.3.1
> 
> CC: Myron Stowe <mstowe@redhat.com>
> CC: Don Dutile <ddutile@redhat.com>
> CC: James Paradis <jim.paradis@stratus.com>

Nuts.  This is my fault.  I'm so used to calling him "Jim" that I screwed up his
email address.  It should be james.paradis@stratus.com .

Jim, can you retest with this updated version of the patch so we can confirm it
works?

http://marc.info/?l=linux-pci&m=133539711207345&w=2

Thanks,

P.
