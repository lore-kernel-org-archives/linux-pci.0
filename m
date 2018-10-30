Return-Path: <SRS0=eYAu=NK=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EA72C6786F
	for <linux-pci@archiver.kernel.org>; Tue, 30 Oct 2018 13:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D917D205F4
	for <linux-pci@archiver.kernel.org>; Tue, 30 Oct 2018 13:32:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="IP0WEFJw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D917D205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728742AbeJ3W0K (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 30 Oct 2018 18:26:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:54894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728657AbeJ3W0K (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 30 Oct 2018 18:26:10 -0400
Received: from localhost (173-25-171-118.client.mchsi.com [173.25.171.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C0BF205F4;
        Tue, 30 Oct 2018 13:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540906360;
        bh=Jkj1rwjCmq2w6IYlbcm7iP2/WCQqMaV+RPcaYaJUB68=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IP0WEFJwddWKgn931IhESZ30Gpf0yA//QGcgPi1lVPqMESboi+4iS1eGz2IIfhr6E
         j/7Ypju3+3EPVkfpNUOt/zlrQ2g/EtX5KrF3bN77R/zgiJJrja8puAEI3hABa+EL/o
         LkigY/U9G8Jz4va4UjAaMTWjv8myra6IgNSbljRQ=
Date:   Tue, 30 Oct 2018 08:32:39 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Suganath Prabu <suganath-prabu.subramani@broadcom.com>
Cc:     lukas@wunner.de, linux-scsi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        benh@kernel.crashing.org, ruscur@russell.cc,
        sbobroff@linux.ibm.com, oohall@gmail.com,
        andy.shevchenko@gmail.com, Sathya.Prakash@broadcom.com,
        sreekanth.reddy@broadcom.com
Subject: Re: [v6 2/4] mpt3sas: Fix Sync cache command failure during driver
 unload
Message-ID: <20181030133239.GB41022@google.com>
References: <1540290081-15827-1-git-send-email-suganath-prabu.subramani@broadcom.com>
 <1540290081-15827-3-git-send-email-suganath-prabu.subramani@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1540290081-15827-3-git-send-email-suganath-prabu.subramani@broadcom.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 23, 2018 at 03:51:19PM +0530, Suganath Prabu wrote:
> This is to fix Sync cache and start stop command
>  failures with DID_NO_CONNECT during driver unload.
> 
> 1) Release drives first from SML, then remove internally
> in driver.
> 2) And allow sync cache and Start stop commands to firmware,
> even when remove_host flag is set

This looks like it should be two or maybe even three patches: (1) call
sas_remove_host() before releasing volumes and ports, (2) skipping
sas_port_delete_phy() and sas_port_delete() when ioc->remove_host (I'm not
sure if this is logically part of the sas_remove_host() change), and (3)
add _scsih_allow_scmd_to_device() -- this is purely mpt3sas-specific thing
independent of the SCSI midlayer.

Bjorn
