Return-Path: <SRS0=bcLC=Y4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDADECA9EB5
	for <linux-pci@archiver.kernel.org>; Mon,  4 Nov 2019 13:07:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F796222C1
	for <linux-pci@archiver.kernel.org>; Mon,  4 Nov 2019 13:07:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mm-sol.com header.i=@mm-sol.com header.b="mEF8S8HH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbfKDNHf (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 4 Nov 2019 08:07:35 -0500
Received: from ns.mm-sol.com ([37.157.136.199]:49179 "EHLO extserv.mm-sol.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727663AbfKDNHf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 4 Nov 2019 08:07:35 -0500
X-Greylist: delayed 443 seconds by postgrey-1.27 at vger.kernel.org; Mon, 04 Nov 2019 08:07:33 EST
Received: from [192.168.27.209] (unknown [37.157.136.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by extserv.mm-sol.com (Postfix) with ESMTPSA id EF598CF18;
        Mon,  4 Nov 2019 15:00:08 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mm-sol.com; s=201706;
        t=1572872408; bh=oVopT+MD93ZbAJmCMweF+pEr53zTDaEbQfDd0ZNB/VY=;
        h=Subject:To:Cc:From:Date:From;
        b=mEF8S8HHPDZ4Yz8rH6fPfjO+5QXGkvNenzKvUBrtzVnGYxll8RDR8RLs1sEE/RgI+
         8y6tEHwCkxYX/a2xdLiUTNfs34XxncrjdWtHcv6MIzv6DXmbQXOu4PCsNNxusIovHP
         mEAZVpGaV2f+GnqYBXFTEUABHbtuL+ixIASObQp/WTdaFSP6uaOdrJ2gT60iRELVH6
         JuNjXKNBhECAgGOLBkrp6nEqvduwYBxDvBP4HwU9EgITLnJv5xzCp1B0unta7V4dnU
         lLPbASTID05k2P4U+F72ic3OurussykFH3KXzC6biVaUIcvMYBsWNWSX1+qGhZKzMm
         25ikT+RZgT+Iw==
Subject: Re: [PATCH] PCI: qcom: Fix the fixup of PCI_VENDOR_ID_QCOM
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20191102002420.4091061-1-bjorn.andersson@linaro.org>
From:   Stanimir Varbanov <svarbanov@mm-sol.com>
Message-ID: <f1e89dcc-4d5f-cc1f-8036-dcb062645cb0@mm-sol.com>
Date:   Mon, 4 Nov 2019 15:00:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191102002420.4091061-1-bjorn.andersson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

Thanks for the fix!

On 11/2/19 2:24 AM, Bjorn Andersson wrote:
> There exists non-bridge PCIe devices with PCI_VENDOR_ID_QCOM, so limit
> the fixup to only affect the PCIe 2.0 (0x106) and PCIe 3.0 (0x107)
> bridges.

Are you sure that this will not break ops_1_0_0 (Qcom IP rev.: 1.0.0
Synopsys IP rev.: 4.11a) i.e. apq8084 ?

> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 3 ++-
>  include/linux/pci_ids.h                | 2 ++
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 35f4980480bb..b91abf4d4905 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1441,7 +1441,8 @@ static void qcom_fixup_class(struct pci_dev *dev)
>  {
>  	dev->class = PCI_CLASS_BRIDGE_PCI << 8;
>  }
> -DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_QCOM, PCI_ANY_ID, qcom_fixup_class);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_QCOM, PCIE_DEVICE_ID_QCOM_PCIE20, qcom_fixup_class);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_QCOM, PCIE_DEVICE_ID_QCOM_PCIE30, qcom_fixup_class);
>  
>  static struct platform_driver qcom_pcie_driver = {
>  	.probe = qcom_pcie_probe,
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 21a572469a4e..3d0724ee4d2f 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -2413,6 +2413,8 @@
>  #define PCI_VENDOR_ID_LENOVO		0x17aa
>  
>  #define PCI_VENDOR_ID_QCOM		0x17cb
> +#define PCIE_DEVICE_ID_QCOM_PCIE20	0x0106
> +#define PCIE_DEVICE_ID_QCOM_PCIE30	0x0107
>  
>  #define PCI_VENDOR_ID_CDNS		0x17cd
>  
> 

-- 
regards,
Stan
