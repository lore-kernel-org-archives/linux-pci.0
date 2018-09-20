Return-Path: <SRS0=Tpvo=MC=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE566ECE566
	for <linux-pci@archiver.kernel.org>; Thu, 20 Sep 2018 20:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5923821534
	for <linux-pci@archiver.kernel.org>; Thu, 20 Sep 2018 20:00:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="O8uTQLUU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5923821534
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388165AbeIUBpO (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 20 Sep 2018 21:45:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:56770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388159AbeIUBpO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 20 Sep 2018 21:45:14 -0400
Received: from [10.80.45.152] (unknown [71.69.156.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25419208A3;
        Thu, 20 Sep 2018 20:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537473607;
        bh=GiU2Wt8LoUPPJUnAZzwH4oQyzUv/oJaAGJQ7yqUXIfk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=O8uTQLUUoy/eqp3XO2/F0ZnQjVkztGKAmXi4uw2Pv8LuaAQNp1PM39SNVXNkMd4im
         5YzyGWGidjPKhM68QnImAmMAMN+oIpqPjNxtZkuH8+j8AfGqzhOgmYwKUqJl1C2lqw
         PM3LqSUrDXqYWr1opy78qs1bKl9jDdv1/Aagin2w=
Subject: Re: [PATCHv4 00/12] pci error handling fixes
To:     Keith Busch <keith.busch@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Thomas Tai <thomas.tai@oracle.com>, poza@codeaurora.org,
        Lukas Wunner <lukas@wunner.de>, Christoph Hellwig <hch@lst.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
References: <20180920162717.31066-1-keith.busch@intel.com>
From:   Sinan Kaya <okaya@kernel.org>
Message-ID: <1fc29116-ca9a-99b4-1dd6-08aa9094fabe@kernel.org>
Date:   Thu, 20 Sep 2018 16:00:04 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180920162717.31066-1-keith.busch@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 9/20/2018 12:27 PM, Keith Busch wrote:
> Changes since v3 are:
> 
>    Initialize port services directly from port driver (suggested by
>    Bjorn)
> 
>    Updated changelogs to match local style
> 
>    Added documentation update for ERR_FATAL behavior
> 
>    Included DPC save/restore state fix that was missing from previous
> 
>    Included AER upstream port fix that was mistakenly added to a
>    different patch set
> 
> Keith Busch (12):
>    PCI: portdrv: Initialize service drivers directly
>    PCI: portdrv: Restore pci state on slot reset
>    PCI: DPC: Save and restore control state
>    PCI: AER: Take reference on error devices
>    PCI: AER: Don't read upstream ports below fatal errors
>    PCI: ERR: Use slot reset if available
>    PCI: ERR: Handle fatal error recovery
>    PCI: ERR: Always use the first downstream port
>    PCI: ERR: Simplify broadcast callouts
>    PCI: ERR: Report current recovery status for udev
>    PCI: Unify device inaccessible
>    PCI: Make link active reporting detection generic

Reviewed-by: Sinan Kaya <okaya@kernel.org>

