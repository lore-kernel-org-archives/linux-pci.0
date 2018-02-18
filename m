Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ot0-f196.google.com ([74.125.82.196]:46845 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750961AbeBRXHq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 18 Feb 2018 18:07:46 -0500
Date: Sun, 18 Feb 2018 17:07:44 -0600
From: Rob Herring <robh@kernel.org>
To: srinivas.kandagatla@linaro.org
Cc: stanimir.varbanov@linaro.org, svarbanov@mm-sol.com,
        linux-pci@vger.kernel.org, bhelgaas@google.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3] PCI: qcom: add missing supplies required for msm8996
Message-ID: <20180218230744.hdl4ctug5utif6j5@rob-hp-laptop>
References: <20180215132248.5572-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180215132248.5572-1-srinivas.kandagatla@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Feb 15, 2018 at 01:22:48PM +0000, srinivas.kandagatla@linaro.org wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
> This patch adds supplies that are required for msm8996. vdda
> is analog supply that go in to controller, and vddpe_3v3 is
> supply to PCIe endpoint.
> 
> Without these supplies PCIe endpoints which require power supplies are
> not enumerated at all, as there is no one to power it up.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
> changes since v2:
> 	Add back empty line suggested by Stan
> 	use ARRAY_SIZE
> 
>  .../devicetree/bindings/pci/qcom,pcie.txt          |  4 ++++
>  drivers/pci/dwc/pcie-qcom.c                        | 23 +++++++++++++++++++++-
>  2 files changed, 26 insertions(+), 1 deletion(-)

Reviewed-by: Rob Herring <robh@kernel.org>
