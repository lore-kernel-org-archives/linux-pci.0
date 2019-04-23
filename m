Return-Path: <SRS0=Emu/=SZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	TVD_PH_BODY_ACCOUNTS_PRE autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18949C10F03
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 17:59:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF46420685
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 17:59:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sf+ltzFK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728333AbfDWR7a (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 23 Apr 2019 13:59:30 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:52960 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727656AbfDWR7a (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Apr 2019 13:59:30 -0400
Received: by mail-it1-f193.google.com with SMTP id x132so1686790itf.2;
        Tue, 23 Apr 2019 10:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gQfSvY288NvX5Y1XwWDqYoDWYQc1hyp+10tUEc7SHn8=;
        b=Sf+ltzFKPRmsGLVlqfmp10ivBVhDNycl1H4gfMc53WqLP/fgmiAV6WRJmyPBaYBFFQ
         5tfJhgEnQ5+tUrIYokenTj5bFH4SGmAx/WpXA2+rlquEE3xgID/ZToZWSiYfvexJRUrZ
         sdB0ML8Ke93LzjGmT8uHWdZVxHdYQ9QqkC78kohsgwH6Wm/mcc9BcvGdcK87X3BlDrYz
         7W8hsHt6cUPQfhIOEtgp+AbXW3NTKwoDYy5zRFoYmtzeGEebRsmn8MysMUYiHDbNH/Q3
         OZk9gkUKA6QLkYFCGZO9SFHgxCJGDt/O1vo/lnCMyvjDgVP8RHiYX3wxoAqsD73iWtLJ
         gP5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gQfSvY288NvX5Y1XwWDqYoDWYQc1hyp+10tUEc7SHn8=;
        b=gXS9KDdIr4EeQ4nHKSpvJ8kwWZnOKA0ntDugF90Q8aBli6ihDGmZLAH924lgcFtvWh
         sqCuL1WqozPD8o1A4xwX5oVTEgiE5WIO7QGWCv5KaPApPatRvqD5R+pC8uHSz4AJNwus
         wk95Xl7F4Os2PfbuMB1jCO2D6IFjE3rw4noe+fO0D8cuLAGItknPehqP73KIfHWjhsgX
         LUkundtf6PGxVb1Brka9k1WUfhKaF53DjCdB5k+EwjP1S8S7RTtAll8oysMyXgVtlvNY
         gMhLZYT+4IZQ9tJgq13W2QkxTgmMDOhJqGCv7SrFSPULFulAAZ/kEPm0oEISszOiF5EM
         wNIg==
X-Gm-Message-State: APjAAAXEynQvbMD9LrJE7SgJxE3Cij4KCdp5Jgo3lGUWW0q/EG+ZJ7gd
        f/OX1kY2pHZV7pENInYcUfqdfXEUE88=
X-Google-Smtp-Source: APXvYqz14/dOj17RXKWR3kLpXR/jkR8ILqigTNpOw1PPnJFbHypFLf63qysZ59TE4avYogBMn9GFRQ==
X-Received: by 2002:a24:7350:: with SMTP id y77mr2693321itb.52.1556042368981;
        Tue, 23 Apr 2019 10:59:28 -0700 (PDT)
Received: from nukespec.gtech ([2601:2c1:8501:182d::6fe])
        by smtp.gmail.com with ESMTPSA id k11sm7398516itk.25.2019.04.23.10.59.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 10:59:28 -0700 (PDT)
Subject: Re: [PATCH] PCI/LINK: Account for BW notification in vector
 calculation
To:     Alex Williamson <alex.williamson@redhat.com>, bhelgaas@google.com,
        helgaas@kernel.org, linux-pci@vger.kernel.org
Cc:     austin_bolen@dell.com, alex_gagniuc@dellteam.com,
        keith.busch@intel.com, Shyam_Iyer@Dell.com, lukas@wunner.de,
        okaya@kernel.org, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <155597243666.19387.1205950870601742062.stgit@gimli.home>
From:   Alex G <mr.nuke.me@gmail.com>
Message-ID: <abe311e9-85e6-27a6-e6ad-d7e8e103578f@gmail.com>
Date:   Tue, 23 Apr 2019 12:59:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <155597243666.19387.1205950870601742062.stgit@gimli.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 4/22/19 5:43 PM, Alex Williamson wrote:
> On systems that don't support any PCIe services other than bandwidth
> notification, pcie_message_numbers() can return zero vectors, causing
> the vector reallocation in pcie_port_enable_irq_vec() to retry with
> zero, which fails, resulting in fallback to INTx (which might be
> broken) for the bandwidth notification service.  This can resolve
> spurious interrupt faults due to this service on some systems.
> 
> Fixes: e8303bb7a75c ("PCI/LINK: Report degraded links via link bandwidth notification")
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> ---

+1
Tested on some Dell servers. Everything works as expected. I don't have 
a system with a device that only supports bandwidth notification.

Alex
