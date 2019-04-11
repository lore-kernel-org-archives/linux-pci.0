Return-Path: <SRS0=+gKf=SN=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5404C10F13
	for <linux-pci@archiver.kernel.org>; Thu, 11 Apr 2019 12:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C4872073F
	for <linux-pci@archiver.kernel.org>; Thu, 11 Apr 2019 12:38:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbfDKMik (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 11 Apr 2019 08:38:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:36942 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726096AbfDKMik (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 11 Apr 2019 08:38:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 004CDAC57;
        Thu, 11 Apr 2019 12:38:38 +0000 (UTC)
Date:   Thu, 11 Apr 2019 14:38:37 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Nikolai Kostrigin <nickel@altlinux.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND 1/1] PCI: Add ATS-disable quirk for AMD Radeon R7
 GPUs
Message-ID: <20190411123837.GF3349@suse.de>
References: <20190408103725.30426-1-nickel@altlinux.org>
 <20190408103725.30426-2-nickel@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190408103725.30426-2-nickel@altlinux.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Apr 08, 2019 at 01:37:25PM +0300, Nikolai Kostrigin wrote:
> ATS is broken on this hardware (at least for Stoney Ridge
> based laptop) and causes IOMMU stalls and
> system failure. Disable ATS on these devices to make them
> usable again with IOMMU enabled
> Thanks to Joerg Roedel <jroedel@suse.de> for help.
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=194521
> 
> Signed-off-by: Nikolai Kostrigin <nickel@altlinux.org>

Acked-by: Joerg Roedel <jroedel@suse.de>

I helped Nikolai with tracking this issue down to ATS handling and
suggested adding the quirk.

