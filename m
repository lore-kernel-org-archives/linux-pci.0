Return-Path: <SRS0=wh2u=NR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7069C0044C
	for <linux-pci@archiver.kernel.org>; Tue,  6 Nov 2018 02:24:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6778A20866
	for <linux-pci@archiver.kernel.org>; Tue,  6 Nov 2018 02:24:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GaDUAtE+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6778A20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729016AbeKFLrE (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 6 Nov 2018 06:47:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:58758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726092AbeKFLrD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 6 Nov 2018 06:47:03 -0500
Received: from [10.70.68.164] (unknown [131.107.174.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB1522081D;
        Tue,  6 Nov 2018 02:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541471054;
        bh=wOYZpQHNNs/cYaP2v2OZN13hjgaYJY4NccI016Li4IE=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=GaDUAtE+HG/imt9C+xAdNDRWgiG/uJGMOJRJW1UxEYXmv8/JC+8zQCeWCcsJdMnuz
         7KaHUFSkAl6S5q1mUjjGOmx7Le4fVhwXb9SYZ1w09Oo1tJP8PStFsziRGFHbCI2PJb
         eRB4lqlKorI5UPr6UCK3YhtB8vOj796zOvEZxuFw=
Subject: Re: [PATCH 2/2] nvme: add quirk to not call disable function when
 suspending
To:     AceLan Kao <acelan.kao@canonical.com>,
        Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
References: <20181106020402.21120-1-acelan.kao@canonical.com>
 <20181106020402.21120-2-acelan.kao@canonical.com>
From:   Sinan Kaya <okaya@kernel.org>
Message-ID: <733fc135-dfef-f70e-b854-3ad553c67e9b@kernel.org>
Date:   Mon, 5 Nov 2018 18:24:14 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181106020402.21120-2-acelan.kao@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/5/2018 6:04 PM, AceLan Kao wrote:
> +	{ PCI_DEVICE(0x1c5c, 0x1527),   /* Sk Hynix */
> +		.driver_data = NVME_QUIRK_NO_DISABLE, },

Now that you added PCI_VENDOR_ID_SK_HYNIX to pci_ids.h, you
could use PCI_VENDOR_ID_SK_HYNIX above instead of 0x1c5c.
