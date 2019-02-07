Return-Path: <SRS0=HpDZ=QO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ABC8C282C2
	for <linux-pci@archiver.kernel.org>; Thu,  7 Feb 2019 20:38:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF4D221721
	for <linux-pci@archiver.kernel.org>; Thu,  7 Feb 2019 20:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549571918;
	bh=/QrUWMnlPhDZry0BZpKT23dvFMMvIJcUjgvzAPurDO0=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=sC+fI6qcbk86h57tATHAWXYT0LVC1S3S5XSTiL1KAgOZeeMq+/jVImUUi5Z3bfQvI
	 7q2rLUe5w7f4qyGoILfH4sV4xe8hrT+kcOfez8D7osRj20JASr4HYDFatLNNbuXBsC
	 9kH/2pkPv+TpBIJvYLZw2OgN4O4XNRlf6BRPkVW0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726914AbfBGUii (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 7 Feb 2019 15:38:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:53550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726781AbfBGUii (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 7 Feb 2019 15:38:38 -0500
Received: from [10.84.150.46] (unknown [167.220.148.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 83F4820663;
        Thu,  7 Feb 2019 20:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549571917;
        bh=/QrUWMnlPhDZry0BZpKT23dvFMMvIJcUjgvzAPurDO0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=eSeKAq2cXml6PDtENy9JGfdITYnh6IM85Yox2GujePd6DpcZBG7C9e0PkoLgg5Tbk
         B+vFEoxrT5K6adGev+r/depnjMLw5eVkgLV4QOpmNuVaBcLV0+S1PQTjvFGHcD/PaR
         pCz5lKOcBnIhDyBjCZpKFxC+70GMGooRNLnzpxVI=
Subject: Re: [PATCH v1 1/2] PCI: ATS: Add function to check ATS page aligned
 request status.
To:     sathyanarayanan.kuppuswamy@linux.intel.com, bhelgaas@google.com,
        joro@8bytes.org, dwmw2@infradead.org
Cc:     linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Ashok Raj <ashok.raj@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Keith Busch <keith.busch@intel.com>
References: <cover.1549478584.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <91bfae8b1d4b424219e3ce3c1fc03559c73f1ae7.1549478584.git.sathyanarayanan.kuppuswamy@linux.intel.com>
From:   Sinan Kaya <okaya@kernel.org>
Message-ID: <5d55e369-355f-b710-0594-03465aa985da@kernel.org>
Date:   Thu, 7 Feb 2019 15:38:35 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <91bfae8b1d4b424219e3ce3c1fc03559c73f1ae7.1549478584.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 2/7/2019 1:41 PM, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> + * As per PCI spec, If page aligned request bit is set, it indicates
> + * the untranslated address is always aligned to a 4096 byte boundary.
> + */
> +int pci_ats_page_aligned(struct pci_dev *pdev)
> +{
> +	u16 cap;
> +
> +	if (!pdev->ats_cap)
> +		return 0;
> +
> +	pci_read_config_word(pdev, pdev->ats_cap + PCI_ATS_CAP, &cap);

If I remember this right, aligned request is only supported on ATS v1.1
but not supported on v1.0.

Can you please check the spec?
