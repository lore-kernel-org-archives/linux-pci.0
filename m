Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Sun, 18 Mar 2018 07:52:27 -0500
From: Rob Herring <robh@kernel.org>
To: srinivas.kandagatla@linaro.org
Cc: bhelgaas@google.com, svarbanov@mm-sol.com,
        linux-pci@vger.kernel.org, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pcie: qcom: Add support to enable pcie refclk
Message-ID: <20180318031703.xt6fscof7ibslgrq@rob-hp-laptop>
References: <20180315144133.14031-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180315144133.14031-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Mar 15, 2018 at 02:41:33PM +0000, srinivas.kandagatla@linaro.org wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
> This patch adds support to enable 100MHz pcie refclk,
> On some boards like DB600c this clock is not enabled by default.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  Documentation/devicetree/bindings/pci/qcom,pcie.txt |  1 +
>  drivers/pci/dwc/pcie-qcom.c                         | 21 ++++++++++++++++++++-
>  2 files changed, 21 insertions(+), 1 deletion(-)

Reviewed-by: Rob Herring <robh@kernel.org>
