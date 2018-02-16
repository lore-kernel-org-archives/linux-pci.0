Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ns.mm-sol.com ([37.157.136.199]:43859 "EHLO extserv.mm-sol.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1033893AbeBPOMN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 16 Feb 2018 09:12:13 -0500
Subject: Re: [PATCH v2] PCI: qcom: use regulator bulk api for apq8064 supplies
To: srinivas.kandagatla@linaro.org, stanimir.varbanov@linaro.org,
        linux-pci@vger.kernel.org, bhelgaas@google.com
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org
References: <20180215132637.5673-1-srinivas.kandagatla@linaro.org>
From: Stanimir Varbanov <svarbanov@mm-sol.com>
Message-ID: <9a1d3bba-6777-ff90-4af5-9a4e6a73b3c7@mm-sol.com>
Date: Fri, 16 Feb 2018 16:12:06 +0200
MIME-Version: 1.0
In-Reply-To: <20180215132637.5673-1-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Thanks for the patch!

On 02/15/2018 03:26 PM, srinivas.kandagatla@linaro.org wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
> This patch converts existing regulators to use regulator bulk apis,
> to make it consistent with msm8996 changes also cut down some redundant code.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
> Changes since v1:
> 	updated index correctly and use ARRAY_SIZE
> 
>  drivers/pci/dwc/pcie-qcom.c | 52 +++++++++++++--------------------------------
>  1 file changed, 15 insertions(+), 37 deletions(-)
> 

Acked-by: Stanimir Varbanov <svarbanov@mm-sol.com>

-- 
regards,
Stan
