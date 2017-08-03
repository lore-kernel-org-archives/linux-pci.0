Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:51278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751754AbdHCXIB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 3 Aug 2017 19:08:01 -0400
Date: Thu, 3 Aug 2017 18:07:58 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Varadarajan Narayanan <varada@codeaurora.org>, bhelgaas@google.com,
        robh+dt@kernel.org, mark.rutland@arm.com, svarbanov@mm-sol.com,
        sboyd@codeaurora.org, vivek.gautam@codeaurora.org,
        fengguang.wu@intel.com, weiyongjun1@huawei.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v6 0/7] Add support for IPQ8074 PCIe phy and controller
Message-ID: <20170803230758.GS20308@bhelgaas-glaptop.roam.corp.google.com>
References: <1501482857-14100-1-git-send-email-varada@codeaurora.org>
 <4cce58c3-3fec-db2d-8c97-28beb0e3b3ab@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4cce58c3-3fec-db2d-8c97-28beb0e3b3ab@ti.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 02, 2017 at 10:38:21AM +0530, Kishon Vijay Abraham I wrote:
> Hi,
> 
> On Monday 31 July 2017 12:04 PM, Varadarajan Narayanan wrote:
> > v6:
> >   Added 'Reviewed-by: Vivek Gautam <vivek.gautam@codeaurora.org>' and fixed
> >   white space issues as mentioned by Vivek.
> > 	phy: qcom-qmp: Fix phy pipe clock name
> > 	dt-bindings: phy: qmp: Add support for QMP phy in IPQ8074
> 
> merged the 1st four patches (phy patches) of the series to linux-phy -next.

Heh :)  Ignore my nitpicks on them then!
