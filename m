Return-Path: <SRS0=lIFx=RP=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7393EC43381
	for <linux-pci@archiver.kernel.org>; Tue, 12 Mar 2019 12:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4290B206BA
	for <linux-pci@archiver.kernel.org>; Tue, 12 Mar 2019 12:42:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mm-sol.com header.i=@mm-sol.com header.b="OuvbnS/Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbfCLMmw (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 12 Mar 2019 08:42:52 -0400
Received: from ns.mm-sol.com ([37.157.136.199]:37519 "EHLO extserv.mm-sol.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725957AbfCLMmw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 12 Mar 2019 08:42:52 -0400
Received: from [192.168.27.209] (unknown [37.157.136.206])
        by extserv.mm-sol.com (Postfix) with ESMTPSA id 05188CE28;
        Tue, 12 Mar 2019 14:42:49 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mm-sol.com; s=201706;
        t=1552394569; bh=XuDKOdFZ35K3ZnPCJITHm6krw2gbYBRCmyJSsNPuA8o=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=OuvbnS/Yf1Aa11Mtn6WEwzs7oSuUM/2g08KPfivpySQH2Guc+8DlV6nPU4qDzDvL8
         ZtxTuhnbv27+XTQYXWIT6rf01j/lwdUUnA+qXC5wntmAnkIj/Fe3q2DoqDUL48u7bI
         sugMCih2UHw4Uca8geEmDHV2kY66wmb8lBxu2OtEwpO3rJAD1vBTYaAmlvsHW+Ui3w
         aAUdrXihzBmZtXUibigEGBpW4L01ji2o6T2juVqbFy+SvW/6zFODKMr3ODt57npN6t
         CFFFf6xkZprcdvR3JuM5NrLvqmKinRd9bwIloNU2Jz3+N2Xu6cR4p3DqF7DzWQhYRr
         9vWZVro9hGq1A==
Subject: Re: [RFC PATCH v1] PCI: qcom: Use quirk to override incorrect device
 class
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        PCI <linux-pci@vger.kernel.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>
References: <94bb3f22-c5a7-1891-9d89-42a520e9a592@free.fr>
From:   Stanimir Varbanov <svarbanov@mm-sol.com>
Message-ID: <65321fe3-ca29-c454-63ae-98a46c2e5158@mm-sol.com>
Date:   Tue, 12 Mar 2019 14:42:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <94bb3f22-c5a7-1891-9d89-42a520e9a592@free.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Marc,

Thanks for the patch!

On 3/11/19 4:56 PM, Marc Gonzalez wrote:
> Some chips report an incorrect device class. Override the incorrect
> value using a quirk, instead of code in the read function.
> 
> Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
> ---
> FWIW, this quirk is no longer required on recent chips:
> msm8996 (tested by Stanimir), msm8998 (tested by me), sdm845 (untested) are unaffected
> apq/ipq8064 is affected => what is the device ID for these chips?
> others?
> 
> Stanimir added: "this will become a real problem (now we use the driver as RC)
> when someone decide to use it as an endpoint"
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 3de5510fd3d5..94da2c9c2ad5 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1136,17 +1136,15 @@ static int qcom_pcie_rd_own_conf(struct pcie_port *pp, int where, int size,
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>  
> -	/* the device class is not reported correctly from the register */
> -	if (where == PCI_CLASS_REVISION && size == 4) {
> -		*val = readl(pci->dbi_base + PCI_CLASS_REVISION);
> -		*val &= 0xff;	/* keep revision id */
> -		*val |= PCI_CLASS_BRIDGE_PCI << 16;
> -		return PCIBIOS_SUCCESSFUL;
> -	}
> -

once you dropped the above snippet this function becomes absolutely
useless so please delete it at all and also from qcom_pcie_dw_ops.

>  	return dw_pcie_read(pci->dbi_base + where, size, val);
>  }
>  
> +static void qcom_fixup_class(struct pci_dev *dev)
> +{
> +	dev->class = PCI_CLASS_BRIDGE_PCI << 8;
> +}
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_QCOM, PCI_ANY_ID, qcom_fixup_class);

I wonder, in case that dw_pcie_setup_rc() already has a write to
PCI_CLASS_DEVICE configuration register to set it as a bridge do we
still need to do the above fixup?

-- 
regards,
Stan
