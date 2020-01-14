Return-Path: <SRS0=eZdz=3D=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49BA0C33C9E
	for <linux-pci@archiver.kernel.org>; Tue, 14 Jan 2020 18:21:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2736A2072B
	for <linux-pci@archiver.kernel.org>; Tue, 14 Jan 2020 18:21:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbgANSVx (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 14 Jan 2020 13:21:53 -0500
Received: from ale.deltatee.com ([207.54.116.67]:34860 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726491AbgANSVx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 14 Jan 2020 13:21:53 -0500
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1irQp2-0000uf-3U; Tue, 14 Jan 2020 11:21:49 -0700
To:     Kelvin.Cao@microchip.com, helgaas@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        epilmore@gigaio.com, dmeyer@gigaio.com
References: <20200108213337.GA210184@google.com>
 <302aff9f-ff12-027c-80c8-2af2afca8359@deltatee.com>
 <BY5PR11MB4354178CD58A467995EC22F88D340@BY5PR11MB4354.namprd11.prod.outlook.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <a1ec69e8-624a-8e35-9a9e-3f8193fe9f68@deltatee.com>
Date:   Tue, 14 Jan 2020 11:21:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <BY5PR11MB4354178CD58A467995EC22F88D340@BY5PR11MB4354.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: dmeyer@gigaio.com, epilmore@gigaio.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, helgaas@kernel.org, Kelvin.Cao@microchip.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH 03/12] PCI/switchtec: Add support for new events
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Bjorn,

On 2020-01-13 7:07 p.m., Kelvin.Cao@microchip.com wrote:
> 'InterComm' is the spelling in the latest datasheet, it's short for "Inter Fabric Manager Communication". Thanks.

I noticed you fixed up the spelling in your branch but the IOCTL define
is still spelled INTERCOM, which is arguably the most important seeing
it's a userspace interface.

Thanks,

Logan



diff --git a/include/uapi/linux/switchtec_ioctl.h
b/include/uapi/linux/switchtec_ioctl.h
index c912b5a678e4..902fffa9e0f5 100644
--- a/include/uapi/linux/switchtec_ioctl.h
+++ b/include/uapi/linux/switchtec_ioctl.h
@@ -98,7 +98,9 @@ struct switchtec_ioctl_event_summary {
 #define SWITCHTEC_IOCTL_EVENT_CREDIT_TIMEOUT           27
 #define SWITCHTEC_IOCTL_EVENT_LINK_STATE               28
 #define SWITCHTEC_IOCTL_EVENT_GFMS                     29
-#define SWITCHTEC_IOCTL_MAX_EVENTS                     30
+#define SWITCHTEC_IOCTL_EVENT_INTERCOM_REQ_NOTIFY      30
+#define SWITCHTEC_IOCTL_EVENT_UEC                      31
+#define SWITCHTEC_IOCTL_MAX_EVENTS                     32

 #define SWITCHTEC_IOCTL_EVENT_LOCAL_PART_IDX -1
 #define SWITCHTEC_IOCTL_EVENT_IDX_ALL -2

