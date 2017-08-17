Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ns.mm-sol.com ([37.157.136.199]:54896 "EHLO extserv.mm-sol.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752772AbdHQLqn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 17 Aug 2017 07:46:43 -0400
Subject: Re: [PATCH v8 1/3] PCI: dwc: qcom: Use block IP version for
 operations
To: Varadarajan Narayanan <varada@codeaurora.org>, bhelgaas@google.com,
        robh+dt@kernel.org, mark.rutland@arm.com, kishon@ti.com,
        sboyd@codeaurora.org, vivek.gautam@codeaurora.org,
        fengguang.wu@intel.com, weiyongjun1@huawei.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <1502968858-28090-1-git-send-email-varada@codeaurora.org>
 <1502968858-28090-2-git-send-email-varada@codeaurora.org>
From: Stanimir Varbanov <svarbanov@mm-sol.com>
Message-ID: <acd26a12-bcd8-5b51-fe51-748d7ba33489@mm-sol.com>
Date: Thu, 17 Aug 2017 14:46:41 +0300
MIME-Version: 1.0
In-Reply-To: <1502968858-28090-2-git-send-email-varada@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Varada,

On 08/17/2017 02:20 PM, Varadarajan Narayanan wrote:
> Presently, when support for a new SoC is added, the driver ops
> structures and functions are versioned with plain 1, 2, 3 etc.
> Instead use the block IP version number.
> 
> Signed-off-by: Varadarajan Narayanan <varada@codeaurora.org>
> ---
>  drivers/pci/dwc/pcie-qcom.c | 132 +++++++++++++++++++++++---------------------
>  1 file changed, 68 insertions(+), 64 deletions(-)

The patch cannot be applied on todays linux-next so you have to rebase
the patches on top of Bjorn's pci.git tree.

Otherwise you have my:

Acked-by: Stanimir Varbanov <svarbanov@mm-sol.com>

regards,
Stan
