Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:37564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730259AbeHNRGV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 14 Aug 2018 13:06:21 -0400
Date: Tue, 14 Aug 2018 09:18:57 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Myron Stowe <myron.stowe@redhat.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
        keith.busch@intel.com, jdmason@kudzu.us, okaya@kernel.org
Subject: Re: [PATCH 0/2] Augment device matching its upstream Root Port's MPS
 logic
Message-ID: <20180814141857.GO113140@bhelgaas-glaptop.roam.corp.google.com>
References: <20180813181931.105655.22182.stgit@tak.stowe>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180813181931.105655.22182.stgit@tak.stowe>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 13, 2018 at 12:19:31PM -0600, Myron Stowe wrote:
> In commit 27d868b5e6cf ("PCI: Set MPS to match upstream bridge") Keith made
> sure every device's MPS setting matched its upstream bridge, making it more
> likely that a hot-added devices would work in a system with an optimized MPS
> configuration.
> 
> This series augments Keith's approach to include tuning down a Root Port's
> MPS setting in the case where a hot-added device is not capable of matching
> it (see: [1]).
> 
> Testing by Dongdong exposed a bug with the logic including Virtual Functions
> (VFs).  VFs should not be included so a pre-cursor patch, 1/2, was added to
> cover such.
> 
> [1] https://bugzilla.kernel.org/show_bug.cgi?id=200527
> 
> Myron Stowe (2):
>       PCI: Skip MPS logic for Virtual Functions (VFs)
>       PCI: Match Root Port's MPS to endpoint's MPSS as necessary
> 
> 
>  drivers/pci/probe.c |   16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)

Applied to pci/enumeration for v4.19, thanks!
