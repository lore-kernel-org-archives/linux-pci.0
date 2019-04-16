Return-Path: <SRS0=aMvC=SS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F013CC10F13
	for <linux-pci@archiver.kernel.org>; Tue, 16 Apr 2019 23:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA3E620872
	for <linux-pci@archiver.kernel.org>; Tue, 16 Apr 2019 23:34:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="U2+Z7O+6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730161AbfDPXel (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 16 Apr 2019 19:34:41 -0400
Received: from mail-pl1-f169.google.com ([209.85.214.169]:46261 "EHLO
        mail-pl1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730149AbfDPXek (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Apr 2019 19:34:40 -0400
Received: by mail-pl1-f169.google.com with SMTP id y6so11065228pll.13
        for <linux-pci@vger.kernel.org>; Tue, 16 Apr 2019 16:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=cXhRzMWstiyquLiUcEh0ti+11QngL9wxXsoPsmb9Svg=;
        b=U2+Z7O+6ZFV+R5f/f1H35b78AZbnWt3iNVBiIJjho+2twVhvC2arwjT0KifBFvp3u4
         EJpf9PS8FtX1kyvEaXr/VBcAQLl0Xf38NzIaXJcBVPLkyikvXNB3fbyafdZtFP6jB6cZ
         2xGFTbWClVlgqUQRtaJgFgxlPyilbp+FaefXA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=cXhRzMWstiyquLiUcEh0ti+11QngL9wxXsoPsmb9Svg=;
        b=Oi4vXKjbMwx1+PsGAUpFd/fp9rfgRpRja7jGAzsNMs09/hOePGkww+NJAqw9ilSqxn
         yCn+gUhe3PbJgsuM38rDuPV/VmPjy6QTMKgcXEjhdw9FTj9OIdXy3JIz+rfPU1/Q3sGx
         g/IfEBTRWfly2Lx3JAOadXwVxsmDR/cDxeqHtYEhqIw87EVLIeavwKfF7DYdwG0xZ2Jf
         oxA1z73aUMyt7FD0vjsGdt6H/LSlWy82ncdKrmh8+gSPjIOfOypIdYFYOkgf8wHV+6uu
         eNoBXQCSZzy2WMG0y6Sf1BTHJnnZupxgdY+S88nysyBK/EUXC2OkoiMEiLcqPhb5Rg3Z
         +4Lw==
X-Gm-Message-State: APjAAAVC/AJQgJjQHzlVxDye/chA2U7zJeadjcpHaYbthqs82AJ89Spi
        De4vz+XsGKpKwfzULKpwCKrPNxtzBphV2g==
X-Google-Smtp-Source: APXvYqxPIUi8dMnPKmNaPGu33ptwRR/yAhLDx/c6f2V8/idlfL/ghVXF7hIhz39nHiICEYyB1hsJYw==
X-Received: by 2002:a17:902:2bc9:: with SMTP id l67mr68120079plb.237.1555457679381;
        Tue, 16 Apr 2019 16:34:39 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id j62sm59965228pfg.6.2019.04.16.16.34.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 16:34:38 -0700 (PDT)
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc:     bcm-kernel-feedback-list@broadcom.com
From:   Scott Branden <scott.branden@broadcom.com>
Subject: Linux pci card forcing a remove and restore
Message-ID: <3399add0-39da-3711-2614-80f611c2d5db@broadcom.com>
Date:   Tue, 16 Apr 2019 16:34:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

I have a possibly simple or may be more involved question:

I have a PCI device that the hardware boots up and enumerates in GEN2 mode.

Once the linux device driver is loaded we can download new firmware to 
the card that may reinitialize the PCIe PHY in GEN3 mode and resizing 
the BARs.

We can have the device re-enumerated via user space:

echo 1 > /sys/bus/pci/devices/0000\:01\:00.0/remove

echo 1 > /sys/bus/pci/rescan

But, is it possible to do this inside the kernel device driver after it 
has downloaded the new firmware instead?

Before I start trying to play with pci_stop_and_remove_bus_device 
followed by pci_rescan_bus I would like to know if what I'm trying to do 
is a correct approach?

Thanks,

  Scott


