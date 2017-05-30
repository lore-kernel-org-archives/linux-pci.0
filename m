Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:42496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751015AbdE3U6z (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 30 May 2017 16:58:55 -0400
Date: Tue, 30 May 2017 15:58:53 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ashok Raj <ashok.raj@intel.com>
Cc: Jean-Phillipe Brucker <jean-philippe.brucker@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Joerg Roedel <joro@8bytes.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        David Woodhouse <dwmw2@infradead.org>,
        iommu@lists.linux-foundation.org
Subject: Re: [PATCH 0/2] Save and restore pci properties to support FLR
Message-ID: <20170530205853.GB14896@bhelgaas-glaptop.roam.corp.google.com>
References: <1496161549-167468-1-git-send-email-ashok.raj@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1496161549-167468-1-git-send-email-ashok.raj@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, May 30, 2017 at 09:25:47AM -0700, Ashok Raj wrote:
> Resending Jean's patch so it can be included earlier than his large
> SVM commits. Original patch https://patchwork.kernel.org/patch/9593891
> was ack'ed by Bjorn. Let's commit these separately since we need
> functionality earlier.
> 
> Resending this series as requested by Jean.
> 
> CQ Tang (1):
>   PCI: Save properties required to handle FLR for replay purposes.
> 
> Jean-Philippe Brucker (1):
>   PCI: Cache PRI and PASID bits in pci_dev
> 
>  drivers/pci/ats.c       | 88 ++++++++++++++++++++++++++++++++++++++++---------
>  drivers/pci/pci.c       |  3 ++
>  include/linux/pci-ats.h | 10 ++++++
>  include/linux/pci.h     |  8 +++++
>  4 files changed, 94 insertions(+), 15 deletions(-)

Applied to pci/virtualization for v4.13.  See response to 2/2 for minor
changes I made there.
