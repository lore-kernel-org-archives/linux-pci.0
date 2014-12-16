Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:63455 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750840AbaLPJyp (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 16 Dec 2014 04:54:45 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Stanimir Varbanov <svarbanov@mm-sol.com>,
	Mark Rutland <mark.rutland@arm.com>,
	devicetree@vger.kernel.org, Russell King <linux@arm.linux.org.uk>,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kishon Vijay Abraham I <kishon@ti.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Rob Herring <robh+dt@kernel.org>,
	Kumar Gala <galak@codeaurora.org>,
	Grant Likely <grant.likely@linaro.org>
Subject: Re: [PATCH 4/5] PCI: qcom: Add Qualcomm PCIe controller driver
Date: Tue, 16 Dec 2014 10:54:29 +0100
Message-ID: <4673431.OTm9MABNvH@wuerfel>
In-Reply-To: <548FFEB0.9080604@mm-sol.com>
References: <1418404441-5518-1-git-send-email-svarbanov@mm-sol.com> <2577563.x0mEZJNVDQ@wuerfel> <548FFEB0.9080604@mm-sol.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday 16 December 2014 11:43:12 Stanimir Varbanov wrote:

> >> +static int __init qcom_pcie_probe(struct platform_device *pdev)
> >> +{
> > 
> > I think it's a bug to mark this function as __init. It breaks
> > deferred probing and detaching/reattaching the device trough sysfs.
> > 
> 
> My bad, I have tried to avoid mismatch section warnings came up from
> dw_pcie_host_init() which is annotated as __init. Do you think we need
> to remove __init from dw_pcie_host_init() declaration and fix the
> drivers accordingly?

Yes, that's probably best. Initially, it was ok because all front-ends
of the dw-pcie driver were using module_platform_probe(), but that
is not the case any more, so now at least keystone, layerscape and
spear13xx are broken, and I think it's safer to change dw_pcie_host_init
than to rely on everyone using module_platform_probe() correctly.

	Arnd
