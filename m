Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:45209 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932695AbcHJC6Z (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 9 Aug 2016 22:58:25 -0400
Message-ID: <57AA984E.8040308@intel.com>
Date: Wed, 10 Aug 2016 10:58:22 +0800
From: "Yong, Jonathan" <jonathan.yong@intel.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: linux-pci@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
	Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/3] PCI: Add Precision Time Measurement (PTM) support
References: <20160613185945.12503.32760.stgit@bhelgaas-glaptop2.roam.corp.google.com> <20160613190534.12503.18923.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20160613190534.12503.18923.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 06/14/2016 03:05, Bjorn Helgaas wrote:
> From: Jonathan Yong <jonathan.yong@intel.com>
> 
> Add Precision Time Measurement (PTM) support (see PCIe r3.1, sec 6.22).
> 
> Enable PTM on PTM Root devices and switch ports.  This does not enable PTM
> on endpoints.
> 
> There currently are no PTM-capable devices on the market, but it is
> expected to be supported by the Intel Apollo Lake platform.
> 
> [bhelgaas: complete rework]
> Signed-off-by: Jonathan Yong <jonathan.yong@intel.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Hi,

Any updates on the PTM changes?


