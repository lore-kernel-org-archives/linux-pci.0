Return-Path: <SRS0=UcfF=MX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1149CC677FF
	for <linux-pci@archiver.kernel.org>; Thu, 11 Oct 2018 16:36:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D59DE2098A
	for <linux-pci@archiver.kernel.org>; Thu, 11 Oct 2018 16:36:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D59DE2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729950AbeJLAEr (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 11 Oct 2018 20:04:47 -0400
Received: from ale.deltatee.com ([207.54.116.67]:59194 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729148AbeJLAEr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 11 Oct 2018 20:04:47 -0400
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1gAdx4-0001Wd-8l; Thu, 11 Oct 2018 10:36:43 -0600
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Wesley Sheng <wesley.sheng@microchip.com>
Cc:     bhelgaas@google.com, corbet@lwn.net, kurt.schwemmer@microsemi.com,
        linux-ntb@googlegroups.com, linux-pci@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wesley Yung <wesley.yung@microchip.com>,
        Kelvin Cao <kelvin.cao@microchip.com>,
        Jon Mason <jdmason@kudzu.us>
References: <1539182575-26851-1-git-send-email-wesley.sheng@microchip.com>
 <20181011162747.GP5906@bhelgaas-glaptop.roam.corp.google.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <f601ab82-7bcc-01cf-70d5-67c4de6a5abb@deltatee.com>
Date:   Thu, 11 Oct 2018 10:36:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181011162747.GP5906@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: jdmason@kudzu.us, kelvin.cao@microchip.com, wesley.yung@microchip.com, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-pci@vger.kernel.org, linux-ntb@googlegroups.com, kurt.schwemmer@microsemi.com, corbet@lwn.net, bhelgaas@google.com, wesley.sheng@microchip.com, helgaas@kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v3] NTB: switchtec_ntb: Update switchtec documentation
 with pre-requisites for NTB
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2018-10-11 10:27 a.m., Bjorn Helgaas wrote:
> I'm not sure who should really own this file:
> 
>   $ ./scripts/get_maintainer.pl -f Documentation/switchtec.txt
>   Kurt Schwemmer <kurt.schwemmer@microsemi.com> (maintainer:PCI DRIVER FOR MICROSEMI SWITCHTEC)
>   Logan Gunthorpe <logang@deltatee.com> (maintainer:PCI DRIVER FOR MICROSEMI SWITCHTEC)
>   Jonathan Corbet <corbet@lwn.net> (maintainer:DOCUMENTATION)
>   linux-pci@vger.kernel.org (open list:PCI DRIVER FOR MICROSEMI SWITCHTEC)
>   linux-doc@vger.kernel.org (open list:DOCUMENTATION)
>   linux-kernel@vger.kernel.org (open list)
> 
> and Jon (NTB driver core maintainer) has applied recent updates
> to it.
> 
> But in the interest of forward progress, I applied this patch with
> Logan's ack to pci/misc for v4.20.

Thanks. I'm not really sure what's going on in the NTB tree these days
as Jon hasn't picked up anything in a while so it's probably better this
went through PCI. It was originally created through the PCI tree, there
shouldn't be any conflicts, and I can't see anyone else objecting.

Logan
