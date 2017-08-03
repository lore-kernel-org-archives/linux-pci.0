Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ns.mm-sol.com ([37.157.136.199]:34966 "EHLO extserv.mm-sol.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751058AbdHCMpE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 3 Aug 2017 08:45:04 -0400
Subject: Re: [PATCH 3/3] PCI: qcom: Allow post_init to fail
To: Bjorn Andersson <bjorn.andersson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20170716064203.3406-1-bjorn.andersson@linaro.org>
From: Stanimir Varbanov <svarbanov@mm-sol.com>
Message-ID: <df93be6a-eaf1-aebd-e5b2-855a32adb576@mm-sol.com>
Date: Thu, 3 Aug 2017 15:45:00 +0300
MIME-Version: 1.0
In-Reply-To: <20170716064203.3406-1-bjorn.andersson@linaro.org>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Bjorn, thanks for the patch!

On 07/16/2017 09:42 AM, Bjorn Andersson wrote:
> host_init should detect and propagate errors from post_init.
> 
> In addition, by acknowleding that post_init can fail we must disable the
> post_init resources in a step separate from the deinit, so that we don't
> try to disable the post_init resources a second time.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  drivers/pci/dwc/pcie-qcom.c | 20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)

The patch looks good to me,

Acked-by: Stanimir Varbanov <svarbanov@mm-sol.com>

regards,
Stan
