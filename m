Return-Path: <SRS0=eYAu=NK=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8572FC6786F
	for <linux-pci@archiver.kernel.org>; Tue, 30 Oct 2018 13:34:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EFAF20838
	for <linux-pci@archiver.kernel.org>; Tue, 30 Oct 2018 13:34:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="knwr3fYf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EFAF20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728257AbeJ3W2N (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 30 Oct 2018 18:28:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:55590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727750AbeJ3W2N (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 30 Oct 2018 18:28:13 -0400
Received: from localhost (173-25-171-118.client.mchsi.com [173.25.171.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6607D205F4;
        Tue, 30 Oct 2018 13:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540906483;
        bh=w2fIw8gviP+4peuZbmW4Tc0h04KLRmJDwAhYrkSLOTE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=knwr3fYfRiIWFWglIOV+fNc9gYhDYJNdBFJ7/wVL79ahpL3WGve7rscsknxWfEUyQ
         yyh1UWnLziGPCMdnWqs9euVUypjuZWtj9hKQtaJav1Hgf52OQvRlEXtmrHytw5CZjG
         dxHPKdnK836Glt3FJnQg/50DIYVeD+7gP/tImrCU=
Date:   Tue, 30 Oct 2018 08:34:42 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Suganath Prabu <suganath-prabu.subramani@broadcom.com>
Cc:     lukas@wunner.de, linux-scsi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        benh@kernel.crashing.org, ruscur@russell.cc,
        sbobroff@linux.ibm.com, oohall@gmail.com,
        andy.shevchenko@gmail.com, Sathya.Prakash@broadcom.com,
        sreekanth.reddy@broadcom.com
Subject: Re: [v6 3/4] mpt3sas:Fix driver modifying persistent data.
Message-ID: <20181030133442.GC41022@google.com>
References: <1540290081-15827-1-git-send-email-suganath-prabu.subramani@broadcom.com>
 <1540290081-15827-4-git-send-email-suganath-prabu.subramani@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1540290081-15827-4-git-send-email-suganath-prabu.subramani@broadcom.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 23, 2018 at 03:51:20PM +0530, Suganath Prabu wrote:
> * If EEDPTagMode field in manufacturing page11 is set,
> unset it. This is needed to fix a hardware bug
> in SAS3/SAS2 cards, So, skipping EEDPTagMode changes
> in Manufacturing page11 for SAS35 controllers.
> 
> * Fix driver modifying NVRAM/persistent data in
> Manufacturing page11 along with current copy. Driver should
> change only current copy of Manufacturing page11.

These *look* like two separate changes that should be in separate patches.

Also, fix your subject line so "git log --oneline drivers/scsi/mpt3sas"
looks nice  This subject line is missing a space in "mpt3sas:Fix"

Bjorn
