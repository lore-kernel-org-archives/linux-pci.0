Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84A0FC4743E
	for <linux-pci@archiver.kernel.org>; Sun,  6 Jun 2021 13:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64CB261422
	for <linux-pci@archiver.kernel.org>; Sun,  6 Jun 2021 13:57:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbhFFN7E (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 6 Jun 2021 09:59:04 -0400
Received: from disco-boy.misterjones.org ([51.254.78.96]:48616 "EHLO
        disco-boy.misterjones.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbhFFN7D (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 6 Jun 2021 09:59:03 -0400
X-Greylist: delayed 1842 seconds by postgrey-1.27 at vger.kernel.org; Sun, 06 Jun 2021 09:59:02 EDT
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <maz@misterjones.org>)
        id 1lpsnB-005lcJ-9b; Sun, 06 Jun 2021 14:26:17 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Sun, 06 Jun 2021 14:26:17 +0100
From:   Marc Zyngier <maz@misterjones.org>
To:     Sandor Bodo-Merle <sbodomerle@gmail.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Subject: Re: [PATCH 1/2] PCI: iproc: fix the base vector number allocation for
 multi-MSI
In-Reply-To: <20210606123044.31250-1-sbodomerle@gmail.com>
References: <20210606123044.31250-1-sbodomerle@gmail.com>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <473f3d7dd4252f14629be63dc220cd7e@misterjones.org>
X-Sender: maz@misterjones.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: sbodomerle@gmail.com, lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com, bhelgaas@google.com, rjui@broadcom.com, sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, pali@kernel.org
X-SA-Exim-Mail-From: maz@misterjones.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2021-06-06 13:30, Sandor Bodo-Merle wrote:
> Commit fc54bae28818 ("PCI: iproc: Allow allocation of multiple MSIs")
> introduced multi-MSI support with a broken allocation mechanism (it 
> failed
> to reserve the proper number of bits from the inner domain).  Natural
> alignment of the base vector number was also not guaranteed.
> 
> Fixes: fc54bae28818 ("PCI: iproc: Allow allocation of multiple MSIs")
> Reported-by: Pali Rohár <pali@kernel.org>
> Signed-off-by: Sandor Bodo-Merle <sbodomerle@gmail.com>

Acked-by: Marc Zyngier <maz@kernel.org>

         M.
-- 
Who you jivin' with that Cosmik Debris?
