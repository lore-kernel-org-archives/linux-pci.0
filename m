Return-Path: <SRS0=ex/N=MK=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91C0AC43382
	for <linux-pci@archiver.kernel.org>; Fri, 28 Sep 2018 13:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56472216FA
	for <linux-pci@archiver.kernel.org>; Fri, 28 Sep 2018 13:58:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="BOaVEn0Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56472216FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbeI1UWZ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 28 Sep 2018 16:22:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:56774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726121AbeI1UWZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 28 Sep 2018 16:22:25 -0400
Received: from [10.80.45.152] (unknown [71.69.156.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 846E721546;
        Fri, 28 Sep 2018 13:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538143110;
        bh=Deu93XPZfuEJ9mpfV/Oq5EYyF8dFSBBGdahp/kPxwN4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=BOaVEn0Y3qZuDKsLQRL7FWKJ7iU8NjUZcHpIdfMeAHWr1UO4OKoUAYlnm6OjRfIK2
         eA2KqvyQGloiKfHvJ/SpT8NTqGo/gV6ipsmxhoejXrvFPywzDi2zxxf8GT7kRci43A
         CDD7PgzU7mQ5rmDIYU9W6TWQJKw3/LBnfPH6xDeg=
Subject: Re: [PATCH] PCI/AER: Clear uncorrectable error status for device
To:     poza@codeaurora.org, Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-pci@vger.kernel.org, Keith Busch <keith.busch@intel.com>,
        Wei Zhang <wzhang@fb.com>, linux-kernel@vger.kernel.org,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
References: <1537258829-15763-1-git-send-email-poza@codeaurora.org>
 <20180926220848.GK28024@bhelgaas-glaptop.roam.corp.google.com>
 <605a3c5d65ae2f42237c7258a6c3e21b@codeaurora.org>
From:   Sinan Kaya <okaya@kernel.org>
Message-ID: <e7b35f31-c684-ddac-7393-435640c6af39@kernel.org>
Date:   Fri, 28 Sep 2018 09:58:27 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <605a3c5d65ae2f42237c7258a6c3e21b@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 9/28/2018 6:24 AM, poza@codeaurora.org wrote:
> 1) Does that seem like the right place?
> 

IMO, I think best is to call after driver callback in PCI core.
A driver specific action can cause some of these errors.
We don't want to return with outstanding errors.

> 2) I guess all we need now would be to remove the calls from the
>     drivers?
> 

yes

> 3) If we remove all the calls from the drivers, we should remove the
>     declaration from include/linux/aer.h, too.
> 

makes sense

> I can take care of these updates if we agree they're the right thing
> to do.



