Return-Path: <SRS0=4GJS=N7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05076C32788
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 22:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 270E62148E
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 22:28:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gc7gNaqj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 270E62148E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726001AbeKUJAR (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 21 Nov 2018 04:00:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:53490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725913AbeKUJAQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 21 Nov 2018 04:00:16 -0500
Received: from [10.80.45.159] (unknown [71.69.156.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9BF52147A;
        Tue, 20 Nov 2018 22:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542752932;
        bh=amiAQZivvLb+0E+qyHlyj7WCS/LfqxES6RuASc64Ck8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Gc7gNaqjdr1jq9VQyC9TxfnZ5sh9BF2XHE4/DyL1I5SWXvyuordTu+vC9kvHIsX0z
         weO795ZUmkOqG7w3y8yHonZprPjrFc5Kk55HPZb7VeE5WWiekyZOUKVPAHl5WcpPEm
         ghpkvrqWo+yKkSii6t02aSXmCqu/3XJuLvgbp/Xw=
Subject: Re: [PATCH 0/2] PCI/AER: Consistently use _OSC to determine who owns
 AER
To:     Keith Busch <keith.busch@intel.com>
Cc:     Alex_Gagniuc@Dellteam.com, mr.nuke.me@gmail.com,
        baicar.tyler@gmail.com, Austin.Bolen@dell.com, Shyam.Iyer@dell.com,
        lukas@wunner.de, bhelgaas@google.com, rjw@rjwysocki.net,
        lenb@kernel.org, ruscur@russell.cc, sbobroff@linux.ibm.com,
        oohall@gmail.com, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
References: <20181119181051.GA26707@localhost.localdomain>
 <c0d6535f-324b-557a-3d0e-ccec070459a7@kernel.org>
 <3f923367-2cc1-c0d6-bca6-bf9a03d1b9ca@gmail.com>
 <ef6b19de-dd18-850f-4db9-8ab71b975e94@kernel.org>
 <bb575cfdcd0a4c50b489fb16eccfbff2@ausx13mps321.AMER.DELL.COM>
 <84013a8a-287d-d700-6710-91cc35f507c8@kernel.org>
 <9c9531c7efb846438f03f744b9afc466@ausx13mps321.AMER.DELL.COM>
 <3b18a9fa-7bdd-0fb4-285d-4efb454be50a@kernel.org>
 <e86f04ef8c054d61969862a6e7b72d0d@ausx13mps321.AMER.DELL.COM>
 <314e59da-48e1-545b-3ee9-6e5056b90fd9@kernel.org>
 <20181120214243.GG26707@localhost.localdomain>
From:   Sinan Kaya <okaya@kernel.org>
Message-ID: <bace940c-70d9-6631-9818-43338d194327@kernel.org>
Date:   Tue, 20 Nov 2018 17:28:49 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181120214243.GG26707@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/20/2018 4:42 PM, Keith Busch wrote:
> How does that work? If the OS takes control, it sets up MSIs that FW don't
> react to, and disables system errors through PCIe Root Control. Aren't
> those sys errs the mechanism FW knows it has something to do, which
> means the OS can effectively fence it off?

I think this is all implementation detail and doesn't necessarily apply
to all firmware-first implementation flavors.

Assumptions are:
1. both FW and OS are listening to MSI interrupts
2. FW monitors the system errors

Some FF implementation could route the AER interrupt to a higher privilege
level. Some other implementation could use INTx or a side-band channel interrupt
for firmware-interrupt too.

I have seen all 3 except MSI :) and also firmware never monitored the system
error bits. I was curious if anybody ever used those legacy bits. Now, I know
someone is using it.


