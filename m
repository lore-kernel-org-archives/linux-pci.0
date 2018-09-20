Return-Path: <SRS0=Tpvo=MC=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C5FC433F4
	for <linux-pci@archiver.kernel.org>; Thu, 20 Sep 2018 19:46:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 955E521533
	for <linux-pci@archiver.kernel.org>; Thu, 20 Sep 2018 19:46:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="IbyZIMxZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 955E521533
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388127AbeIUBbs (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 20 Sep 2018 21:31:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:54462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726582AbeIUBbs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 20 Sep 2018 21:31:48 -0400
Received: from [10.80.45.152] (unknown [71.69.156.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B6A02083A;
        Thu, 20 Sep 2018 19:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537472803;
        bh=PxKS86PpWtJ44Oc8+Ym4qthtpXTHP/vWsj4XkAIGnEs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=IbyZIMxZNIosvxKhUpj/byEMhuof0GXat36qorzoVOkq34B4Ns8+SJ5VtfMtkjON+
         HZ1o13VH4VoJOi6m4fDZN2mS8Z1Uxnscoe36ExstF9M7MjuF79M1J7llm6RhQ6fmUu
         bfdQFJiCBMLPOBg6CcDqsXYJQh7eW5KmonIUHCRE=
Subject: Re: [PATCHv4 03/12] PCI: DPC: Save and restore control state
To:     Keith Busch <keith.busch@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Thomas Tai <thomas.tai@oracle.com>, poza@codeaurora.org,
        Lukas Wunner <lukas@wunner.de>, Christoph Hellwig <hch@lst.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
References: <20180920162717.31066-1-keith.busch@intel.com>
 <20180920162717.31066-4-keith.busch@intel.com>
From:   Sinan Kaya <okaya@kernel.org>
Message-ID: <2f473676-d53e-08bb-97f5-3e3bf9841b61@kernel.org>
Date:   Thu, 20 Sep 2018 15:46:40 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180920162717.31066-4-keith.busch@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 9/20/2018 12:27 PM, Keith Busch wrote:
>   	/*
>   	 * DPC disables the Link automatically in hardware, so it has
>   	 * already been reset by the time we get here.
>   	 */
> -	devdpc = pcie_port_find_device(pdev, PCIE_PORT_SERVICE_DPC);
> -	pciedev = to_pcie_device(devdpc);
> -	dpc = get_service_data(pciedev);
> +	dpc = to_dpc_dev(pdev);

I thought that the struct pci_dev sent here is the bridge and we
need to locate the struct device of the DPC object here.

Isn't this change wrong now?
