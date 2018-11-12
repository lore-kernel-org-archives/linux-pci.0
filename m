Return-Path: <SRS0=qbZn=NX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FA21C43441
	for <linux-pci@archiver.kernel.org>; Mon, 12 Nov 2018 21:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDB7922506
	for <linux-pci@archiver.kernel.org>; Mon, 12 Nov 2018 21:32:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDB7922506
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729564AbeKMH1w (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 13 Nov 2018 02:27:52 -0500
Received: from nikam.ms.mff.cuni.cz ([195.113.20.16]:44484 "EHLO
        nikam.ms.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbeKMH1w (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Nov 2018 02:27:52 -0500
X-Greylist: delayed 314 seconds by postgrey-1.27 at vger.kernel.org; Tue, 13 Nov 2018 02:27:51 EST
Received: by nikam.ms.mff.cuni.cz (Postfix, from userid 2587)
        id EC328281A64; Mon, 12 Nov 2018 22:27:35 +0100 (CET)
Date:   Mon, 12 Nov 2018 22:27:35 +0100
From:   Martin =?utf-8?B?TWFyZcWh?= <mj@ucw.cz>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: Re: [PATCH 0/2] lspci: Decode Multicast capability
Message-ID: <mj+md-20181112.212725.12721.nikam@ucw.cz>
References: <154154102296.78911.760432131801074864.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <154154102296.78911.760432131801074864.stgit@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

> Here's some decoding for the Multicast capability and some new capability
> names for setpci.  These are based on a42aea906410 ("Add a couple of
> missing va_end's").

thanks, applied.

				Martin
