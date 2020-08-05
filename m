Return-Path: <SRS0=Z6n5=BP=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0500DC433E0
	for <linux-pci@archiver.kernel.org>; Wed,  5 Aug 2020 17:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD0B322CA1
	for <linux-pci@archiver.kernel.org>; Wed,  5 Aug 2020 17:57:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729076AbgHER53 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 5 Aug 2020 13:57:29 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2583 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729067AbgHER52 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 5 Aug 2020 13:57:28 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 8BF9FA9C28E1B99876D7;
        Wed,  5 Aug 2020 18:56:16 +0100 (IST)
Received: from localhost (10.52.120.30) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Wed, 5 Aug 2020
 18:56:15 +0100
Date:   Wed, 5 Aug 2020 18:54:50 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Sean V Kelley <sean.v.kelley@intel.com>
CC:     <bhelgaas@google.com>, <rjw@rjwysocki.net>, <ashok.raj@intel.com>,
        <tony.luck@intel.com>,
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Subject: Re: [PATCH V2 9/9] PCI/AER: Add RCEC AER error injection support
Message-ID: <20200805185450.0000512d@Huawei.com>
In-Reply-To: <20200804194052.193272-10-sean.v.kelley@intel.com>
References: <20200804194052.193272-1-sean.v.kelley@intel.com>
        <20200804194052.193272-10-sean.v.kelley@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.120.30]
X-ClientProxiedBy: lhreml744-chm.china.huawei.com (10.201.108.194) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 4 Aug 2020 12:40:52 -0700
Sean V Kelley <sean.v.kelley@intel.com> wrote:

> From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> 
> The Root Complex Event Collectors(RCEC) appear as peers to Root Ports
> and also have the AER capability. So add RCEC support to the current AER
> error injection driver.
> 
> Co-developed-by: Sean V Kelley <sean.v.kelley@intel.com>
> Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>

Silly English subtlety inline.

> ---
>  drivers/pci/pcie/aer_inject.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pcie/aer_inject.c b/drivers/pci/pcie/aer_inject.c
> index c2cbf425afc5..2077dc826fdf 100644
> --- a/drivers/pci/pcie/aer_inject.c
> +++ b/drivers/pci/pcie/aer_inject.c
> @@ -333,8 +333,11 @@ static int aer_inject(struct aer_error_inj *einj)
>  	if (!dev)
>  		return -ENODEV;
>  	rpdev = pcie_find_root_port(dev);
> +	/* If Root port not found, try to find an RCEC */
> +	if (!rpdev)
> +		rpdev = dev->rcec;
>  	if (!rpdev) {
> -		pci_err(dev, "Root port not found\n");
> +		pci_err(dev, "Root port or RCEC not found\n");

That is a bit confusing, could be

RP | !RCEC

"Neither root port nor RCEC found\n" perhaps?


>  		ret = -ENODEV;
>  		goto out_put;
>  	}


