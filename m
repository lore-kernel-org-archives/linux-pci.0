Return-Path: <SRS0=pqED=WI=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54D8CC433FF
	for <linux-pci@archiver.kernel.org>; Mon, 12 Aug 2019 20:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23EDF20684
	for <linux-pci@archiver.kernel.org>; Mon, 12 Aug 2019 20:40:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbfHLUk1 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 12 Aug 2019 16:40:27 -0400
Received: from bmailout1.hostsharing.net ([83.223.95.100]:56027 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbfHLUk1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Aug 2019 16:40:27 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 32D7330000CF7;
        Mon, 12 Aug 2019 22:40:25 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 0786210A7C; Mon, 12 Aug 2019 22:40:24 +0200 (CEST)
Date:   Mon, 12 Aug 2019 22:40:24 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     sathyanarayanan kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Denis Efremov <efremov@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] PCI: pciehp: Add pciehp_set_indicators() to
 jointly set LED indicators
Message-ID: <20190812204024.r54ihfwdcbwdj563@wunner.de>
References: <20190811195944.23765-1-efremov@linux.com>
 <20190811195944.23765-2-efremov@linux.com>
 <925a00be-c2b6-697d-d46b-a279856105b4@linux.intel.com>
 <d243b4e7-acd9-790f-9332-2654a908cf6e@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d243b4e7-acd9-790f-9332-2654a908cf6e@linux.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 12, 2019 at 11:49:23AM -0700, sathyanarayanan kuppuswamy wrote:
> > On 8/11/19 12:59 PM, Denis Efremov wrote:
> > > +    if ((!PWR_LED(ctrl)  || pwr  == PWR_NONE) &&
> > > +        (!ATTN_LED(ctrl) || attn == ATTN_NONE))
> > > +        return;
> 
> Also I think this condition needs to expand to handle the case whether pwr
> != PWR_NONE and !PWR_LED(ctrl) is true.
> 
> you need to return for case, pwr = PWR_ON, !PWR_LED(ctrl)=true ,
> !ATTN_LED(ctrl)=false, attn=on

Why should we return in that case?  We need to update the Attention
Indicator Control to On.

Thanks,

Lukas
