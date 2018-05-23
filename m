Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 23 May 2018 19:06:19 +0530
From: Vinod <vkoul@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: svarbanov@mm-sol.com, lorenzo.pieralisi@arm.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org
Subject: Re: [PATCH v2] PCI: qcom: add runtime pm support to pcie_port
Message-ID: <20180523133619.GL20991@vkoul-mobl>
References: <20180523104425.6650-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180523104425.6650-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 23-05-18, 11:44, Srinivas Kandagatla wrote:
> This patch is required when the pcie controller sits on a bus with
> its own power domain and clocks which are controlled via a bus driver
> like simple pm bus. As these bus driver have runtime pm enabled, it makes
> sense to update the usage counter so that the runtime pm does not suspend
> the clks or power domain associated with the bus driver.

FWIW:

Reviewed-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
