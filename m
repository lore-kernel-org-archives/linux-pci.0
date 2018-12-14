Return-Path: <SRS0=mLR+=OX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB23FC67839
	for <linux-pci@archiver.kernel.org>; Fri, 14 Dec 2018 11:27:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DB2920892
	for <linux-pci@archiver.kernel.org>; Fri, 14 Dec 2018 11:27:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="P9j+H+sj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DB2920892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728612AbeLNL1Y (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 14 Dec 2018 06:27:24 -0500
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:47542 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727634AbeLNL1Y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Dec 2018 06:27:24 -0500
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 13DA424E209C;
        Fri, 14 Dec 2018 03:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1544786844; bh=EdMlHrxwoSEOY9JaJRiZtzOYY78qbQTXhhvLBj3U3z8=;
        h=To:CC:From:Subject:Date:From;
        b=P9j+H+sjSM7SJmTtJjJJNzdTtWvpuKClZi8Hup6wjX9HMjCFqQFtL7YRLZKmY+kSo
         E2PsyU9Z1+STYwp14TQpGh+aQLoz+VmFyY+MEIfknGFUrXObbk0chhWw9sSYHElQNV
         d52RKtqr9HbWb6/+DWD8DmFwla9pcehD4Rs3CzVKvsptOVQeGoFy+mRp3RrC8Qz+2d
         jt7FYruHNGWjhgCDf+c8fjxj8xtfGBE7z6vYCmTGkTsvhYC1qx/lZP9Vw4A0eSXhig
         9WVEi3o6FzGrYhfpWbLl/dDuOEAKpajD1+0r1XJTsNIsDA+ryN406CuRYHPJIf4zDI
         BJ3krcWrfQPPA==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        by mailhost.synopsys.com (Postfix) with ESMTP id 07F6632D8;
        Fri, 14 Dec 2018 03:27:24 -0800 (PST)
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 US01WXQAHTC1.internal.synopsys.com (10.12.238.230) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 14 Dec 2018 03:27:23 -0800
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.92) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 14 Dec 2018 12:27:22 +0100
Received: from [10.0.2.15] (10.107.19.21) by DE02WEHTCB.internal.synopsys.com
 (10.225.19.80) with Microsoft SMTP Server (TLS) id 14.3.408.0; Fri, 14 Dec
 2018 12:27:21 +0100
To:     <linux-pci@vger.kernel.org>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From:   Jose Abreu <jose.abreu@synopsys.com>
Subject: PCI: pcim_iomap_regions() is not managed without pcim_enable_device()
 ?
Message-ID: <ef7616dc-2b73-2e65-7819-baac44528e9f@synopsys.com>
Date:   Fri, 14 Dec 2018 11:27:19 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.107.19.21]
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

pcim_iomap_regions() is suposed to be managed but without a call
to pcim_enable_device() the regions will not be freed upon a
driver removal.

Is this a design choice ?

Currently, I need to use the non-managed pci_enable_device()
because I have custom calls to .suspend() and .resume(), but I
would expect that pcim_iounmap_regions() would not be needed ...

Thanks and Best Regards,
Jose Miguel Abreu
