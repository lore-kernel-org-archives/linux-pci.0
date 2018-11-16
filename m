Return-Path: <SRS0=UeAH=N3=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF652C43441
	for <linux-pci@archiver.kernel.org>; Fri, 16 Nov 2018 01:49:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ED33214F1
	for <linux-pci@archiver.kernel.org>; Fri, 16 Nov 2018 01:49:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ef0W7qnB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ED33214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbeKPL7x (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 16 Nov 2018 06:59:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:48340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726518AbeKPL7x (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 16 Nov 2018 06:59:53 -0500
Received: from [172.30.63.234] (unknown [64.114.255.97])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A162E2146D;
        Fri, 16 Nov 2018 01:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542332969;
        bh=KjC34rPqd9W1miLB2rd4VATCNgsDuIF9QN8kpMDlUmI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Ef0W7qnBijmcpiPgeXwgB9jLIagUDTg//ztbUp6PFwWt9Owce2k2XbNmM9w68uJ1O
         9ZbcfghvC3Lc78tdtaBLfNSW51jcTsw7TzOUw0m2FP3VpZH8kIvKbmMr2Jd2NYpcDg
         V4pillgbhBhJ+7scFAUFNH8IqckS8ufos8xul1Wg=
Subject: Re: [PATCH 0/2] PCI/AER: Consistently use _OSC to determine who owns
 AER
To:     Alexandru Gagniuc <mr.nuke.me@gmail.com>, helgaas@google.com
Cc:     austin_bolen@dell.com, alex_gagniuc@dellteam.com,
        keith.busch@intel.com, Shyam_Iyer@Dell.com, lukas@wunner.de,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Russell Currey <ruscur@russell.cc>,
        Sam Bobroff <sbobroff@linux.ibm.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <20181115231605.24352-1-mr.nuke.me@gmail.com>
From:   Sinan Kaya <okaya@kernel.org>
Message-ID: <b9a739c8-80bd-e04c-ac19-97bc54f20eff@kernel.org>
Date:   Thu, 15 Nov 2018 17:49:28 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181115231605.24352-1-mr.nuke.me@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/15/2018 3:16 PM, Alexandru Gagniuc wrote:
> I've asked around a few people at Dell and they unanimously agree that
> _OSC is the correct way to determine ownership of AER. In linux, we
> use the result of _OSC to enable AER services, but we use HEST to
> determine AER ownership. That's inconsistent. This series drops the
> use of HEST in favor of _OSC.
> 
> [1]https://lkml.org/lkml/2018/11/15/62

This change breaks the existing systems that rely on the HEST table
telling the operating system about firmware first presence.

Besides, HEST table has much more granularity about which PCI component
needs firmware such as global/device/switch.

You should probably circulate these ideas for wider consumption in UEFI
forum as UEFI owns the HEST table definition.
