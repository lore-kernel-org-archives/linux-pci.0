Return-Path: <SRS0=u0zl=SM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0F2FC10F11
	for <linux-pci@archiver.kernel.org>; Wed, 10 Apr 2019 08:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C3B92133D
	for <linux-pci@archiver.kernel.org>; Wed, 10 Apr 2019 08:33:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729103AbfDJIdP (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 10 Apr 2019 04:33:15 -0400
Received: from bmailout3.hostsharing.net ([176.9.242.62]:34211 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729024AbfDJIdO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 Apr 2019 04:33:14 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 41F50100EF4C1;
        Wed, 10 Apr 2019 10:33:13 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id DD23E2C56B5; Wed, 10 Apr 2019 10:33:12 +0200 (CEST)
Date:   Wed, 10 Apr 2019 10:33:12 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Micah Parrish <micah.parrish@hpe.com>
Cc:     helgaas@kernel.org, linux-pci@vger.kernel.org, linux@yadro.com,
        s.miroshnichenko@yadro.com
Subject: Re: [PATCH v2] PCI: pciehp: Fix re-enabling the slot marked for safe
 removal
Message-ID: <20190410083312.uvye5ira3w47cj2v@wunner.de>
References: <20190408195540.GF159318@google.com>
 <e11b4d88-f20d-9989-c249-2f235ef0dc28@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e11b4d88-f20d-9989-c249-2f235ef0dc28@hpe.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 09, 2019 at 05:41:24PM -0600, Micah Parrish wrote:
> Because this bug affects our Proliant nvme hardware, I would like to request
> the patch be merged to 5.1 and 4.19 longterm.
> 
> I have filed kernel BZ https://bugzilla.kernel.org/show_bug.cgi?id=203237

Thanks for the bug report and sorry for the breakage.

The patch has already been committed to Bjorn's pci/hotplug branch
and is marked for stable, hence will appear in the releases you've
mentioned above in about 5 weeks.  If you need it in mainline earlier
I guess Bjorn could cherry-pick the commit onto his for-linus branch
for inclusion in v5.1, that's his call.

Thanks,

Lukas
