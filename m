Return-Path: <SRS0=pUIZ=NJ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB542C0044C
	for <linux-pci@archiver.kernel.org>; Mon, 29 Oct 2018 16:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 906C62084A
	for <linux-pci@archiver.kernel.org>; Mon, 29 Oct 2018 16:31:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dt8on3PR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 906C62084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727552AbeJ3BU0 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 29 Oct 2018 21:20:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:52318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727461AbeJ3BU0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 29 Oct 2018 21:20:26 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F06BB20664;
        Mon, 29 Oct 2018 16:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540830666;
        bh=+cW1NqGs06sngliJYUZRVVvB2IkmXQYCnCzHPgqcFcU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dt8on3PRcy9gA1l/YfK4W7cMus5vB3eWFM/GUIclAcrJEMloBUTaojCpaXoiUcCrw
         pyNh1do/wxmxJQ3SfQKLYpKJB7jeiJYuCO5X2USWT/GxUDi1TJyZv82aNn26Q/nnZ6
         Q+FbeWeUrkT1dyffrz8t/B7QIGSWdouG92spTkGU=
Date:   Mon, 29 Oct 2018 11:31:02 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Z.q. Hou" <zhiqiang.hou@nxp.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        Roy Zang <roy.zang@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>
Subject: Re: [PATCH] PCI/Layerscape: fix wrongly invoking of outbound window
 disable accessor
Message-ID: <20181029163102.GA13681@bhelgaas-glaptop.roam.corp.google.com>
References: <20181025085323.8819-1-Zhiqiang.Hou@nxp.com>
 <20181025134522.GE214775@bhelgaas-glaptop.roam.corp.google.com>
 <AM3PR04MB121709BD837D4E5EA3E28B1A84F00@AM3PR04MB1217.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM3PR04MB121709BD837D4E5EA3E28B1A84F00@AM3PR04MB1217.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 26, 2018 at 02:20:21AM +0000, Z.q. Hou wrote:
> > From: Bjorn Helgaas <helgaas@kernel.org>

> > Holy cow, this has been broken since v4.14.  If fixing this makes
> > a difference, you might want to tag it for stable.
> 
> How can I tag it for stable?

https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/stable-kernel-rules.rst
