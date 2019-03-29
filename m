Return-Path: <SRS0=8ruR=SA=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39A24C43381
	for <linux-pci@archiver.kernel.org>; Fri, 29 Mar 2019 16:38:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11603217F5
	for <linux-pci@archiver.kernel.org>; Fri, 29 Mar 2019 16:38:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729671AbfC2QiN (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 29 Mar 2019 12:38:13 -0400
Received: from foss.arm.com ([217.140.101.70]:35532 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729046AbfC2QiN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 29 Mar 2019 12:38:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1A7F915BF;
        Fri, 29 Mar 2019 09:38:13 -0700 (PDT)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2A4623F68F;
        Fri, 29 Mar 2019 09:38:11 -0700 (PDT)
Date:   Fri, 29 Mar 2019 16:38:08 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     Stanimir Varbanov <svarbanov@mm-sol.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        PCI <linux-pci@vger.kernel.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>
Subject: Re: [PATCH v5] PCI: qcom: Use default config space read function
Message-ID: <20190329163808.GB8768@e107981-ln.cambridge.arm.com>
References: <29664b43-535c-c4b1-a93d-18f49687f929@linaro.org>
 <b0e0dc68-4be9-1b0f-7528-fb7d143fea2b@free.fr>
 <9c5a7620-e9ed-82d6-0708-34fe33e39030@linaro.org>
 <29d33e81-fe8d-7fd9-843d-cc53ea6c9586@free.fr>
 <a53911a5-198a-5073-59cf-a61ba067bfd8@free.fr>
 <eb1d808e-00aa-5411-be03-2a1a8c8d655a@mm-sol.com>
 <8cd24928-54d0-c320-b53f-08332d434477@free.fr>
 <f142da4d-303a-89f3-ba5a-b6800d613e15@free.fr>
 <df27f753-9464-02c0-b621-d5d7b54a3403@mm-sol.com>
 <66ae38dc-1c0c-5a76-be23-fb87db90b327@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66ae38dc-1c0c-5a76-be23-fb87db90b327@free.fr>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 25, 2019 at 04:42:55PM +0100, Marc Gonzalez wrote:
> Move the device class fudge to a proper fixup function, and remove
> qcom_pcie_rd_own_conf() which has become useless.
> 
> NB: dw_pcie_setup_rc() already did the right thing, but it's broken
> on older qcom chips, such as 8064.
> 
> Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
> ---
> Changes from v4 to v5: Apply fixup to all qcom chips, the same way it was before
> (thus the code remains functionally equivalent)
> Drop Srinivas' Tested-by tag because of the change
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 23 ++++++-----------------
>  1 file changed, 6 insertions(+), 17 deletions(-)

Applied to pci/dwc for v5.2, thanks.

Lorenzo

> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index a7f703556790..0ed235d560e3 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1129,25 +1129,8 @@ static int qcom_pcie_host_init(struct pcie_port *pp)
>  	return ret;
>  }
>  
> -static int qcom_pcie_rd_own_conf(struct pcie_port *pp, int where, int size,
> -				 u32 *val)
> -{
> -	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> -
> -	/* the device class is not reported correctly from the register */
> -	if (where == PCI_CLASS_REVISION && size == 4) {
> -		*val = readl(pci->dbi_base + PCI_CLASS_REVISION);
> -		*val &= 0xff;	/* keep revision id */
> -		*val |= PCI_CLASS_BRIDGE_PCI << 16;
> -		return PCIBIOS_SUCCESSFUL;
> -	}
> -
> -	return dw_pcie_read(pci->dbi_base + where, size, val);
> -}
> -
>  static const struct dw_pcie_host_ops qcom_pcie_dw_ops = {
>  	.host_init = qcom_pcie_host_init,
> -	.rd_own_conf = qcom_pcie_rd_own_conf,
>  };
>  
>  /* Qcom IP rev.: 2.1.0	Synopsys IP rev.: 4.01a */
> @@ -1309,6 +1292,12 @@ static const struct of_device_id qcom_pcie_match[] = {
>  	{ }
>  };
>  
> +static void qcom_fixup_class(struct pci_dev *dev)
> +{
> +	dev->class = PCI_CLASS_BRIDGE_PCI << 8;
> +}
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_QCOM, PCI_ANY_ID, qcom_fixup_class);
> +
>  static struct platform_driver qcom_pcie_driver = {
>  	.probe = qcom_pcie_probe,
>  	.driver = {
> -- 
> 2.17.1
