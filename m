Return-Path: <SRS0=qE/B=CR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20296C2BC11
	for <linux-pci@archiver.kernel.org>; Tue,  8 Sep 2020 19:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D78F52166E
	for <linux-pci@archiver.kernel.org>; Tue,  8 Sep 2020 19:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599594736;
	bh=mULXzfnS3APhi3N2dq0E+DMdisvzv4rccw8WftfDozc=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=CdIQGt/p4GZpAHoKszBlvag8IJdj6u1JXBquYBn62Uk8QgTcCo7LN9MWRndqPOakU
	 nipqaUkPUQ8CnSwXP3AruwE9UIyB+TRAtS8ALcr9dSvP7cWCpDBNDCOCorNqoqpFi7
	 sEn5XHyemNzYCODUFGN543OtdI5GhloO8lSAQpdw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730734AbgIHTwP (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 8 Sep 2020 15:52:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:49720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730939AbgIHTwA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 8 Sep 2020 15:52:00 -0400
Received: from localhost (35.sub-72-107-115.myvzw.com [72.107.115.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8F1920658;
        Tue,  8 Sep 2020 19:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599594720;
        bh=mULXzfnS3APhi3N2dq0E+DMdisvzv4rccw8WftfDozc=;
        h=Date:From:To:Cc:Subject:From;
        b=hxURh5O0P4g+eHQp8b16ufLINfkIVcrcQUFePC3Ih4y9mTLErRy86vq2Y3v1qTJv1
         54ZYMeKGJ7zEMlbeWGA3ekdK62dhkpShdS9+YsN8sn6ImdGNJiRZ+pWljyHvzxajlf
         um371hDpe8iS2DkUxVKGUfnwNEz3FoNIfh08eG88=
Date:   Tue, 8 Sep 2020 14:51:58 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-pci@vger.kernel.org
Subject: pci-epf-test.c sparse warnings
Message-ID: <20200908195158.GA627339@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

FYI, got these warnings with "make C=2 drivers/pci/":

  CHECK   drivers/pci/endpoint/functions/pci-epf-test.c
drivers/pci/endpoint/functions/pci-epf-test.c:288:24: warning: incorrect type in argument 1 (different address spaces)
drivers/pci/endpoint/functions/pci-epf-test.c:288:24:    expected void *to
drivers/pci/endpoint/functions/pci-epf-test.c:288:24:    got void [noderef] __iomem *[assigned] dst_addr
drivers/pci/endpoint/functions/pci-epf-test.c:288:34: warning: incorrect type in argument 2 (different address spaces)
drivers/pci/endpoint/functions/pci-epf-test.c:288:34:    expected void const *from
drivers/pci/endpoint/functions/pci-epf-test.c:288:34:    got void [noderef] __iomem *[assigned] src_addr

This is on my "next" branch, but I don't think this file has changed
since v5.9-rc1.

Bjorn
