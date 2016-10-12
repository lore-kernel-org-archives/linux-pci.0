Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:60950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932125AbcJLQG7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Oct 2016 12:06:59 -0400
Date: Wed, 12 Oct 2016 11:06:54 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Stanimir Varbanov <svarbanov@mm-sol.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 0/4] PCI: qcom: Cleanups
Message-ID: <20161012160654.GS4308@localhost>
References: <20161012135859.30144.30808.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161012135859.30144.30808.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Oct 12, 2016 at 08:59:54AM -0500, Bjorn Helgaas wrote:
>   - Remove platform drvdata because it appears unused (we called
>     platform_set_drvdata() but not platform_get_drvdata()).
> 
>   - Remove redundant struct members.
> 
> Nothing here should change the behavior of the driver.
> 
> Changes from v1:
>   I dropped the following patch because it was a lot of churn for
>   questionable benefit:
>     PCI: qcom: Name private struct pointer "qcom" consistently
> 
> ---
> 
> Bjorn Helgaas (4):
>       PCI: qcom: Remove unused platform data
>       PCI: qcom: Remove redundant struct qcom_pcie.dbi
>       PCI: qcom: Remove redundant struct qcom_pcie.dev
>       PCI: qcom: Reorder struct qcom_pcie
> 
> 
>  drivers/pci/host/pcie-qcom.c |   30 ++++++++++++------------------
>  1 file changed, 12 insertions(+), 18 deletions(-)

I applied these to pci/host-qcom for v4.9.  I hope to ask Linus to
pull them tomorrow, so if you see any issues, let me know soon.
