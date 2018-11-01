Return-Path: <SRS0=Nkm2=NM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39536C0044C
	for <linux-pci@archiver.kernel.org>; Thu,  1 Nov 2018 20:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D99432082E
	for <linux-pci@archiver.kernel.org>; Thu,  1 Nov 2018 20:06:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0S3uhZAe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D99432082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727546AbeKBFKq (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 2 Nov 2018 01:10:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:54450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727429AbeKBFKp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 2 Nov 2018 01:10:45 -0400
Received: from [10.80.45.159] (unknown [71.69.156.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 46FAD20657;
        Thu,  1 Nov 2018 20:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541102778;
        bh=E8VNqHypYHg9FhlWrmNKMJK3fumZ/IHB6BuymbCgvSM=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=0S3uhZAeYIMkjW08LkWsnRmF0a5sQgibN587gc4gEc2nz6TMmrLq6YtF7V8d5j1Zc
         TSuQhvo7Rr8xtHDWl4+pUj95v/uZRWaXUb+lR25e+N+jKTfLPxlqJ9lcWDdOfqemON
         ZYjaWiRCIOgfYLydBFCBTs7D02o4ZfiMmEVLc++Q=
Subject: Re: [PATCH 1/1] PCI/ASPM: Add a fix for an erratum of the
 PI7C9X111SLB PCI-to-PCIe bridge
To:     =?UTF-8?Q?Stefan_M=c3=a4tje?= <stefan.maetje@esd.eu>,
        bhelgaas@google.com, linux-pci@vger.kernel.org
References: <20181101192229.48352-1-stefan.maetje@esd.eu>
 <20181101192229.48352-2-stefan.maetje@esd.eu>
From:   Sinan Kaya <okaya@kernel.org>
Message-ID: <626f2816-5f2b-b611-6177-d393ef0cdd0e@kernel.org>
Date:   Thu, 1 Nov 2018 16:06:16 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181101192229.48352-2-stefan.maetje@esd.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/1/2018 3:22 PM, Stefan Mätje wrote:
> + b/drivers/pci/pcie/aspm.c
> @@ -268,6 +268,15 @@ static void pcie_aspm_configure_common_clock(struct pcie_link_state *link)
>   	/* Retrain link */
>   	reg16 |= PCI_EXP_LNKCTL_RL;
>   	pcie_capability_write_word(parent, PCI_EXP_LNKCTL, reg16);
> +	if (0x12d8 == parent->vendor && 0xe111 == parent->device) {
> +		/*
> +		 * Due to an erratum in the Pericom PI7C9X111SLB bridge in
> +		 * reverse mode the retrain link bit needs to be cleared
> +		 * again manually to allow the link training to succeed.
> +		 */
> +		reg16 &= ~PCI_EXP_LNKCTL_RL;
> +		pcie_capability_write_word(parent, PCI_EXP_LNKCTL, reg16);
> +	}

The typical model is to abstract quirk work into quirks.c and add some
callbacks from the actual code.
