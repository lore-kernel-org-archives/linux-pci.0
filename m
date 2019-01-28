Return-Path: <SRS0=Vy8e=QE=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C35C282C8
	for <linux-pci@archiver.kernel.org>; Mon, 28 Jan 2019 17:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F7F421741
	for <linux-pci@archiver.kernel.org>; Mon, 28 Jan 2019 17:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548694856;
	bh=Jk7CdARShVfogLU/rEJ8yyXtfl1a1Y79xDHWBxklTx0=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=PFVxTQvFYCClFNKdnFEMVGMu1zqwOxsErszrjJa6bAiW8jnP6pdwI+5ni8voMntxS
	 3IyUEiBOFxRlTG4Ffjw9034FTFzPstJnpyyZvG9EXKHNs4Qf8vEWAqo1yXjAbvDHy8
	 4J2FNJaKd6mkXft0drujdjgg6cDaDX0vISbeqWlc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388117AbfA1RAu (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:00:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:45496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387780AbfA1QP1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 28 Jan 2019 11:15:27 -0500
Received: from [10.84.151.15] (unknown [167.220.148.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED24C21741;
        Mon, 28 Jan 2019 16:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548692126;
        bh=Jk7CdARShVfogLU/rEJ8yyXtfl1a1Y79xDHWBxklTx0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=TBUQ71V+A77gMo7FCHCIoP2FWc2QJypn++9ZKfOGn3KGRam5oGBiBFncFZdINtFlx
         qOvJHZl3ERmNV9doPrfgQXzOPLUFuNFQ+LmdEfsEFPd+mb+6ctEoqvlUtM7aF3v74V
         PgtipZfaj7d8XMnc5Eagnm+UESK75PB9/zCP0bNI=
Subject: Re: [PATCH] PCI/ERR: Fix run error recovery callbacks for all
 affected devices
To:     Dongdong Liu <liudongdong3@huawei.com>,
        Keith Busch <keith.busch@intel.com>
Cc:     "helgaas@kernel.org" <helgaas@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        tanxiaofei <tanxiaofei@huawei.com>
References: <1548337810-69892-1-git-send-email-liudongdong3@huawei.com>
 <ea302148-7778-d295-4fca-cec436b64e28@kernel.org>
 <20190124213701.GA9882@localhost.localdomain>
 <5d58ea17-115f-139d-93db-fe6e9ce573cb@huawei.com>
 <20190125171713.GB11210@localhost.localdomain>
 <bbe67d36-103c-1cda-4186-128a155e8c0e@kernel.org>
 <f1d8845c-68fc-e0bf-67ed-7348b933eda1@kernel.org>
 <2623f4f8-a832-c517-e5a5-7df2af57bc07@huawei.com>
 <7a2ee482-9f77-0295-6540-e41d85b04297@kernel.org>
From:   Sinan Kaya <okaya@kernel.org>
Message-ID: <5ebaed2e-7331-2b41-a956-1cb9c584192e@kernel.org>
Date:   Mon, 28 Jan 2019 11:15:24 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <7a2ee482-9f77-0295-6540-e41d85b04297@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 1/28/2019 10:47 AM, Sinan Kaya wrote:
>> also have different PFs (device numbers are different) under the same bus.
>> This case do not need to brodcast all the devices under the same bus.
> 
> Even if OS was to call pcie_do_recovery() for other devices, nothing should
> happen because the expectation for other devices' AER status register to report
> no errors. This is the case we want you to validate. If this is not true, you
> are looking at a firmware/HW bug.

Slight clarification about the statement above. Based on quick code scan,
pcie_do_recovery() should only be called if there is an outstanding AER error
for the first AER device in non-FF (non-firmware-first) scenario.

Whereas it gets called per AER device on FF scenario and this is where the
conflict is.

I think your argument is that "if there is a non-fatal error on the parent,
should it be broadcasted to all children devices in pcie_do_recovery()?"

IMO, I think the answer is yes only if the children's AER status reports a
problem and I don't see this check in the code.

Code needs to be refactored to follow a similar pattern to FF scenario and
pci_walk_bus() calls should be removed from the NON-FATAL path.

