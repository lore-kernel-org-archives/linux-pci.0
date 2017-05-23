Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:48924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753027AbdEWUHV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 23 May 2017 16:07:21 -0400
Date: Tue, 23 May 2017 15:07:19 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: John Crispin <john@phrozen.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] PCI: qcom: Add support for IPQ4019 PCIe controller
Message-ID: <20170523200719.GG7241@bhelgaas-glaptop.roam.corp.google.com>
References: <20170505152524.29337-1-john@phrozen.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170505152524.29337-1-john@phrozen.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Stanimir?

On Fri, May 05, 2017 at 05:25:24PM +0200, John Crispin wrote:
> Add support for the IPQ4019 PCIe controller. IPQ4019 supports Gen
> 1/2, one lane, one PCIe root complex with support for MSI and legacy
> interrupts, and it conforms to PCI Express Base 2.1 specification.
> 
> The core init is the sames as for the MSM8996, however the clocks and
> reset lines differ.
> 
> Signed-off-by: John Crispin <john@phrozen.org>
> ---
>  .../devicetree/bindings/pci/qcom,pcie.txt          |  20 +-
>  drivers/pci/host/pcie-qcom.c                       | 304 +++++++++++++++++++++

pcie-qcom.c was recently moved to drivers/pci/dwc, but I was able to
apply this by hand pretty easily.  But I would like Stanimir's ack
first.

Bjorn
