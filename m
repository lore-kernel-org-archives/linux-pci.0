Return-Path: <SRS0=eYAu=NK=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77839C2BC61
	for <linux-pci@archiver.kernel.org>; Tue, 30 Oct 2018 13:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B00F2081B
	for <linux-pci@archiver.kernel.org>; Tue, 30 Oct 2018 13:22:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="k+8XoeKG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B00F2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727760AbeJ3WQA (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 30 Oct 2018 18:16:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:50642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725853AbeJ3WP7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 30 Oct 2018 18:15:59 -0400
Received: from localhost (173-25-171-118.client.mchsi.com [173.25.171.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 77C30205F4;
        Tue, 30 Oct 2018 13:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540905753;
        bh=25ucqojyfC70GmvwUeOb5tjCN27kRMoedKdCdKasCmU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k+8XoeKGsit9tzrFo5AUZOcIG9eYw3wmilmnBMGsFZkiHUm6OWWG/7mnCPHSAO1rf
         WszcaozZAzrnrsAjNaG42TBdtSWMQBUrXztCo50btk8dfzDetKaQWSOWI7CpHa1ZBL
         GQCewrADaGFSy/iLet454sfyxBgku+Trh7LUqzTg=
Date:   Tue, 30 Oct 2018 08:22:32 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Suganath Prabu <suganath-prabu.subramani@broadcom.com>
Cc:     lukas@wunner.de, linux-scsi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        benh@kernel.crashing.org, ruscur@russell.cc,
        sbobroff@linux.ibm.com, oohall@gmail.com,
        andy.shevchenko@gmail.com, Sathya.Prakash@broadcom.com,
        sreekanth.reddy@broadcom.com
Subject: Re: [v6 1/4] mpt3sas: Separate out
 mpt3sas_wait_for_ioc_to_operational
Message-ID: <20181030132232.GA41022@google.com>
References: <1540290081-15827-1-git-send-email-suganath-prabu.subramani@broadcom.com>
 <1540290081-15827-2-git-send-email-suganath-prabu.subramani@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1540290081-15827-2-git-send-email-suganath-prabu.subramani@broadcom.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 23, 2018 at 03:51:18PM +0530, Suganath Prabu wrote:
> No functional changes. This section of code
>  "wait for IOC to be operational" is used in many places
>  across the driver, and hence moved this code in to
>  a function "mpt3sas_wait_for_ioc_to_operational()"
> 
> Signed-off-by: Suganath Prabu <suganath-prabu.subramani@broadcom.com>

I'm not really a reviewer of mpt3sas, but since I commented earlier,
I took a quick look at this.  Minor comments:

  - Remove leading spaces from changelog and reformat to use the whole
    width, e.g.,

      No functional changes. This section of code "wait for IOC to be
      operational" is used in many places across the driver.  Factor
      this code out into a new mpt3sas_wait_for_ioc_to_operational().

  - "mpt3sas_wait_for_ioc_to_operational" isn't really grammatical in
    English; maybe "mpt3sas_wait_for_ioc" would be better?

  - It would be slightly easier to review this if it were split into three
    patches: (1) add and use the IOC_OPERATIONAL_WAIT_COUNT #define, (2)
    factor out mpt3sas_wait_for_ioc() using the exact same code structure
    (the while loop), and (3) convert mpt3sas_wait_for_ioc() to use the do
    loop instead of the while.  The idea is that each individual patch is
    simpler and more obvious because it only contains a single logical
    change.

Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>
