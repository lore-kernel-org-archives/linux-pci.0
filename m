Return-Path: <SRS0=XHdA=MO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7835C43143
	for <linux-pci@archiver.kernel.org>; Tue,  2 Oct 2018 14:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF3AD2082A
	for <linux-pci@archiver.kernel.org>; Tue,  2 Oct 2018 14:04:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="I9MNIAZW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF3AD2082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729261AbeJBUsT (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:48:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:40408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726625AbeJBUsS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 2 Oct 2018 16:48:18 -0400
Received: from localhost (117.sub-174-234-10.myvzw.com [174.234.10.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CEC292064A;
        Tue,  2 Oct 2018 14:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538489086;
        bh=GV37GvLDCGWsviIS5SsrFnOXoJbF3FiVqYH11HIIGKA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I9MNIAZWQYjoWUi7jyxTcV2VVRMvv3XbODhHwh3OtQGYA1XBDN8gaOSzm06dYZ1FL
         y+LrMFhsutTCCZYCkLoLVYko6USntBM0HmmEvzVWpzzYFQON0V9AAAlwcBEy0nthPf
         V8xSGg/CW4ZYZ15Cy7gSuHiSiTc0MFIaALJqyb1g=
Date:   Tue, 2 Oct 2018 09:04:43 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>
Cc:     lukas@wunner.de, linux-scsi@vger.kernel.org,
        linux-pci@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Sathya Prakash <Sathya.Prakash@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        linux-kernel@vger.kernel.org, benh@kernel.crashing.org,
        ruscur@russell.cc, sbobroff@linux.ibm.com, oohall@gmail.com
Subject: Re: [PATCH v4 1/6] mpt3sas: Introduce
 mpt3sas_base_pci_device_is_available
Message-ID: <20181002140443.GA120535@bhelgaas-glaptop.roam.corp.google.com>
References: <1537935759-14754-1-git-send-email-suganath-prabu.subramani@broadcom.com>
 <1537935759-14754-2-git-send-email-suganath-prabu.subramani@broadcom.com>
 <20180926213241.GI28024@bhelgaas-glaptop.roam.corp.google.com>
 <20180927070327.wvl5glb4c7gtjoa3@wunner.de>
 <20180927184746.GM28024@bhelgaas-glaptop.roam.corp.google.com>
 <20180927190959.dio4qwti3i4accjm@wunner.de>
 <CA+RiK64EdoSngTzDMUP4xXNcZQa6KfyucsRw42+DUo3s+JPmVQ@mail.gmail.com>
 <20181001204051.GD142872@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181001204051.GD142872@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 01, 2018 at 03:40:51PM -0500, Bjorn Helgaas wrote:
> I think the names "pci_device_is_present()" and
> "mpt3sas_base_pci_device_is_available()" contribute to the problem
> because they make promises that can't be kept -- all we can say is
> that the device *was* present, but we know whether it is *still*
> present.

Oops, I meant "we DON'T know whether it is still present."

> I think it would be better if the interfaces were something
> like "pci_device_is_absent()" because that gives a result we can rely
> on.  If that returns true, we know the device is definitely gone.
> 
> Bjorn
