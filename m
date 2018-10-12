Return-Path: <SRS0=mL0v=MY=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 680B5C6787C
	for <linux-pci@archiver.kernel.org>; Fri, 12 Oct 2018 17:30:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38584205F4
	for <linux-pci@archiver.kernel.org>; Fri, 12 Oct 2018 17:30:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38584205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lwn.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbeJMBEP (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 12 Oct 2018 21:04:15 -0400
Received: from ms.lwn.net ([45.79.88.28]:51164 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725854AbeJMBEP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 12 Oct 2018 21:04:15 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 0FABC2E5;
        Fri, 12 Oct 2018 17:30:42 +0000 (UTC)
Date:   Fri, 12 Oct 2018 11:30:40 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Wesley Sheng <wesleyshenggit@sina.com>
Cc:     kurt.schwemmer@microsemi.com, logang@deltatee.com,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, bhelgaas@google.com,
        linux-ntb@googlegroups.com,
        Wesley Yung <wesley.yung@microchip.com>,
        Kelvin Cao <kelvin.cao@microchip.com>
Subject: Re: [PATCH v3] NTB: switchtec_ntb: Update switchtec documentation
 with pre-requisites for NTB
Message-ID: <20181012113040.52bfff58@lwn.net>
In-Reply-To: <1539174788-25878-1-git-send-email-wesleyshenggit@sina.com>
References: <1539174788-25878-1-git-send-email-wesleyshenggit@sina.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 10 Oct 2018 20:33:08 +0800
Wesley Sheng <wesleyshenggit@sina.com> wrote:

> The ntb_hw_switchtec driver has requirements on kernel configuration
> so we add these notes to the documentation and also clean up a few 
> other sentences in the documentation.
> 
> Signed-off-by: Wesley Yung <wesley.yung@microchip.com>
> Signed-off-by: Kelvin Cao <kelvin.cao@microchip.com>
> Signed-off-by: Wesley Sheng <wesleyshenggit@sina.com>

So why all of these signoffs for such a small patch?  Who is the actual
author of the patch?

Thanks,

jon
