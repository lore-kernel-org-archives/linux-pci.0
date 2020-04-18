Return-Path: <SRS0=EUoI=6C=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D17ABC2BA19
	for <linux-pci@archiver.kernel.org>; Sat, 18 Apr 2020 08:35:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEB1721D82
	for <linux-pci@archiver.kernel.org>; Sat, 18 Apr 2020 08:35:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725891AbgDRIfv (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 18 Apr 2020 04:35:51 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:2116 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725856AbgDRIfu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 18 Apr 2020 04:35:50 -0400
Received: from DGGEMM401-HUB.china.huawei.com (unknown [172.30.72.55])
        by Forcepoint Email with ESMTP id 5DEE12D4E3CD8E2115F8;
        Sat, 18 Apr 2020 16:35:48 +0800 (CST)
Received: from dggeme758-chm.china.huawei.com (10.3.19.104) by
 DGGEMM401-HUB.china.huawei.com (10.3.20.209) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Sat, 18 Apr 2020 16:35:48 +0800
Received: from [127.0.0.1] (10.40.49.11) by dggeme758-chm.china.huawei.com
 (10.3.19.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Sat, 18
 Apr 2020 16:35:47 +0800
Subject: Re: [PATCH v5 2/2] pciutils: Decode Compute eXpress Link DVSEC
To:     Sean V Kelley <sean.v.kelley@linux.intel.com>, <mj@ucw.cz>,
        <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>, huangdaode <huangdaode@hisilicon.com>
References: <20200415004751.2103963-1-sean.v.kelley@linux.intel.com>
 <20200415004751.2103963-3-sean.v.kelley@linux.intel.com>
From:   Jay Fang <f.fangjian@huawei.com>
Message-ID: <54a9a3f3-aa30-aa2f-1660-15c70ea7dc54@huawei.com>
Date:   Sat, 18 Apr 2020 16:36:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200415004751.2103963-3-sean.v.kelley@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.49.11]
X-ClientProxiedBy: dggeme711-chm.china.huawei.com (10.1.199.107) To
 dggeme758-chm.china.huawei.com (10.3.19.104)
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2020/4/15 8:47, Sean V Kelley wrote:

> 
> [1] https://www.computeexpresslink.org/
> 
> Signed-off-by: Sean V Kelley <sean.v.kelley@linux.intel.com>
> ---
>  lib/header.h        |  20 +++

> +
> +static int
> +is_cxl_cap(struct device *d, int where)
> +{
> +  u32 hdr;
> +  u16 w;
> +
> +  if (!config_fetch(d, where + PCI_DVSEC_HEADER1, 8))
> +    return 0;
> +
> +  /* Check for supported Vendor */
> +  hdr = get_conf_long(d, where + PCI_DVSEC_HEADER1);
> +  w = BITS(hdr, 0, 16);
> +  if (w != PCI_VENDOR_ID_INTEL)
I don't think here checking is quite right. Does only Intel support CXL?
Other Vendors should also be considered.

Thanks
> +    return 0;
> +
> +  /* Check for Designated Vendor-Specific ID */
> +  hdr = get_conf_long(d, where + PCI_DVSEC_HEADER2);
> +  w = BITS(hdr, 0, 16);
> +  if (w == PCI_DVSEC_ID)
> +    return 1;
> +
> +  return 0;
> +}
> +
>  static void
>  cap_dvsec(struct device *d, int where)
>  {
> @@ -947,7 +998,10 @@ show_ext_caps(struct device *d, int type)
>  	    printf("Readiness Time Reporting <?>\n");
>  	    break;
>  	  case PCI_EXT_CAP_ID_DVSEC:
> -	    cap_dvsec(d, where);
> +	    if (is_cxl_cap(d, where))
> +	      cap_cxl(d, where);
> +	    else
> +	      cap_dvsec(d, where);
>  	    break;
>  	  case PCI_EXT_CAP_ID_VF_REBAR:
>  	    printf("VF Resizable BAR <?>\n");
> diff --git a/tests/cap-dvsec-cxl b/tests/cap-dvsec-cxl
> new file mode 100644
> index 0000000..e5d2745
> --- /dev/null
> +++ b/tests/cap-dvsec-cxl
> @@ -0,0 +1,340 @@
> +6b:00.0 Unassigned class [ff00]: Intel Corporation Device 0d93
> +        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx-

