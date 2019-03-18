Return-Path: <SRS0=G860=RV=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABBD9C43381
	for <linux-pci@archiver.kernel.org>; Mon, 18 Mar 2019 16:35:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DF8A213F2
	for <linux-pci@archiver.kernel.org>; Mon, 18 Mar 2019 16:35:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mm-sol.com header.i=@mm-sol.com header.b="G4ryAm9H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbfCRQfi (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 18 Mar 2019 12:35:38 -0400
Received: from ns.mm-sol.com ([37.157.136.199]:55087 "EHLO extserv.mm-sol.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726808AbfCRQfi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 18 Mar 2019 12:35:38 -0400
Received: from [192.168.27.209] (unknown [37.157.136.206])
        by extserv.mm-sol.com (Postfix) with ESMTPSA id 8AFEACE2F;
        Mon, 18 Mar 2019 18:35:34 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mm-sol.com; s=201706;
        t=1552926934; bh=Ex+bvQnn3N8ObKZHxEH7aCjGf6wu/IabshZFiQUe4WY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=G4ryAm9HLd42iCwtO24qyH9OJO2a/c975lDbOqdWwADxkLY3gg3u5pzGumFw/Q56w
         kAJQDbhpzBcSrOskTJCxDEonxN6CLIe0VFIUNjrQka+moCGwfEkJcoBQl4ZmtZrV+l
         OOZcKipPlx3Bk1EPul0nMS7E++OhB4x2tpWc5JH91+boAUUmAhF2pod7HRTEtpkTec
         aBPBF2hSaHVTlX0bdrm+GlYL9vN9FivOlpUZOM2jB56DZvbTYMDGO0R5HLiPdKDmw4
         19cH/+aAiKkLrFRn6tbR9lbYijcLA7vd2V3FKbSs0+w3u1tJOwbaRTfQl0BUBhu8M1
         bDVv/IRglhbKg==
Subject: Re: [PATCH v3] PCI: qcom: Use default config space read function
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        PCI <linux-pci@vger.kernel.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>
References: <94bb3f22-c5a7-1891-9d89-42a520e9a592@free.fr>
 <65321fe3-ca29-c454-63ae-98a46c2e5158@mm-sol.com>
 <1205cbfb-ac06-63a5-9401-75d4e68b15b5@free.fr>
 <38ad143b-3b07-4d19-8ccd-ca39fb51e53d@free.fr>
 <7d3d788a-d6a3-a70b-adab-6c65771cacc4@free.fr>
 <3c76613e-e60d-94b8-dd6f-b8f4e1928263@linaro.org>
 <2f901228-52db-7661-8257-ca8fd2ff2a46@free.fr>
 <29664b43-535c-c4b1-a93d-18f49687f929@linaro.org>
 <b0e0dc68-4be9-1b0f-7528-fb7d143fea2b@free.fr>
 <9c5a7620-e9ed-82d6-0708-34fe33e39030@linaro.org>
 <29d33e81-fe8d-7fd9-843d-cc53ea6c9586@free.fr>
 <a53911a5-198a-5073-59cf-a61ba067bfd8@free.fr>
From:   Stanimir Varbanov <svarbanov@mm-sol.com>
Message-ID: <eb1d808e-00aa-5411-be03-2a1a8c8d655a@mm-sol.com>
Date:   Mon, 18 Mar 2019 18:35:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <a53911a5-198a-5073-59cf-a61ba067bfd8@free.fr>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Marc,

Thanks for the patch!

On 3/18/19 4:28 PM, Marc Gonzalez wrote:
> We don't need to fudge the device class in qcom_pcie_rd_own_conf()
> because dw_pcie_setup_rc() already does the right thing:
> 
> 	/* Program correct class for RC */
> 	dw_pcie_wr_own_conf(pp, PCI_CLASS_DEVICE, 2, PCI_CLASS_BRIDGE_PCI);
> 
> However, the above has no effect on 8064, thus a fixup is required.
> 
> Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
> ---
> Changes from v2 to v3: Add fixup for 8064 quirk
> Changes from v1 to v2: Completely drop qcom_pcie_rd_own_conf
> 
> Stanimir, could you test this submission and send a Tested-by if it works?
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 23 ++++++-----------------
>  1 file changed, 6 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index d185ea5fe996..6fefff106b87 100644
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
> @@ -1299,6 +1282,12 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>  	return ret;
>  }
>  
> +static void qcom_fixup_class(struct pci_dev *dev)
> +{
> +	dev->class = PCI_CLASS_BRIDGE_PCI << 8;
> +}
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_QCOM, 0x0101, qcom_fixup_class); // 8064

Please make 0x101 a define, and drop //

I will try to find device IDs for ipq8064 and ipq4019.

-- 
regards,
Stan
