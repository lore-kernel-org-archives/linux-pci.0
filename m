Return-Path: <SRS0=zVIF=MH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBD7FC43382
	for <linux-pci@archiver.kernel.org>; Tue, 25 Sep 2018 20:52:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66A5620880
	for <linux-pci@archiver.kernel.org>; Tue, 25 Sep 2018 20:52:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="oW1TZGWH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66A5620880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbeIZDCF (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 25 Sep 2018 23:02:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:40012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726173AbeIZDCF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 25 Sep 2018 23:02:05 -0400
Received: from [10.80.45.152] (unknown [71.69.156.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D34D020877;
        Tue, 25 Sep 2018 20:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537908762;
        bh=5THTFwQPcunYlqVeyto3LgT/A/ULrIyo26zYUNzDyYc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=oW1TZGWHa76Sh4tzz+QaAVOUq4vdPSh4lFIpuhrnTAVwdWZrR4nmYQfeimsJSyRIC
         FgIu5fIwRixW8X8iE1YoI7DNqOtSHnrREEWACWF3rVXwzTNyrw/SViNog1sE5f5yh0
         CB015xynyvrxv9Og+0XayBQ2p90l8cx1zckJm0lw=
Subject: Re: [PATCH v4 2/6] PCI: Expose reset_type to users of
 pci_reset_function()
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, alex.williamson@redhat.com,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Frank Haverkamp <haver@linux.vnet.ibm.com>,
        "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Harish Patil <harish.patil@cavium.com>,
        Manish Chopra <manish.chopra@cavium.com>,
        Dept-GELinuxNICDev@cavium.com,
        "David S. Miller" <davem@davemloft.net>,
        Solarflare linux maintainers <linux-net-drivers@solarflare.com>,
        Edward Cree <ecree@solarflare.com>,
        Bert Kenward <bkenward@solarflare.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Anton Vasilyev <vasilyev@ispras.ru>
References: <20180919163037.13497-1-okaya@kernel.org>
 <20180919163037.13497-3-okaya@kernel.org>
 <20180925204632.GC80129@bhelgaas-glaptop.roam.corp.google.com>
From:   Sinan Kaya <okaya@kernel.org>
Message-ID: <1fdf239a-1928-9270-cb43-cde84715192b@kernel.org>
Date:   Tue, 25 Sep 2018 16:52:38 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180925204632.GC80129@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 9/25/2018 4:46 PM, Bjorn Helgaas wrote:
>> Looking to have more control between the users of the API vs. what the API
>> can do internally. The new reset_type tells the PCI core about the bounds
>> of the request.
> I'd like to know why you chose PCI_RESET_ANY for these drivers.
> 

PCI_RESET_ANY was chosen to match the existing behavior in the code.

Current pci_reset_function() tries all reset types one by one until
it returns 0. By specifying PCI_RESET_ANY, we get the same thing.
