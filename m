Return-Path: <SRS0=UcfF=MX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B79F5C677FC
	for <linux-pci@archiver.kernel.org>; Thu, 11 Oct 2018 16:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F50020659
	for <linux-pci@archiver.kernel.org>; Thu, 11 Oct 2018 16:04:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jt4fH73N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F50020659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbeJKXbu (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:31:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:59104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729014AbeJKXES (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 11 Oct 2018 19:04:18 -0400
Received: from [10.17.91.149] (rrcs-70-63-152-218.midsouth.biz.rr.com [70.63.152.218])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9A0E2098A;
        Thu, 11 Oct 2018 15:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539272196;
        bh=R3qhMeefPckeezMNaUMD3aX1mAzYtwjaxH3gl9/nZC4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=jt4fH73NmcklzzhRZiqQxdtANilE8zjBr4jAAXjvIz71NDiwQ7qy0H5P7MK45LfB7
         JdECBe8xB2uXfGtyjtemNUMB4DlK6KU4qMeL5EN9oIc38o8O3OWAPuDw2WcUNQ9R+Z
         kX6etCPcQpX+iEkDzfYxQvdgYeptbHRHeDvHn1FU=
Subject: Re: [PATCH v5 06/11] PCI: Expose reset type to users of
 pci_reset_bus()
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Peter Xu <peterx@redhat.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
References: <20181011045008.32212-1-okaya@kernel.org>
 <20181011045008.32212-6-okaya@kernel.org> <20181011093344.76725f36@w520.home>
From:   Sinan Kaya <okaya@kernel.org>
Message-ID: <4a42a7ca-62b9-8138-2029-7bcf20356351@kernel.org>
Date:   Thu, 11 Oct 2018 11:36:34 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181011093344.76725f36@w520.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/11/2018 11:33 AM, Alex Williamson wrote:
> Having three cases here still seems strange.  The below still has some
> duplicate probing but doesn't it do the same thing with less redundancy?
> 
> if ((reset_type & PCI_RESET_SLOT) && !pci_probe_reset_slot(pdev->slot))
> 	return __pci_reset_slot(pdev->slot);
> 
> if ((reset_type & PCI_RESET_BUS) && !pci_probe_reset_bus(pdev->slot))
> 	return __pci_reset_bus(pdev->bus);

I agree this looks cleaner. I'll fold it in on the next rev.
