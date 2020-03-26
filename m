Return-Path: <SRS0=laK2=5L=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25F88C43331
	for <linux-pci@archiver.kernel.org>; Thu, 26 Mar 2020 12:06:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0945C20714
	for <linux-pci@archiver.kernel.org>; Thu, 26 Mar 2020 12:06:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbgCZMGx (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 26 Mar 2020 08:06:53 -0400
Received: from ozlabs.org ([203.11.71.1]:37829 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728296AbgCZMGw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 26 Mar 2020 08:06:52 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 48p3cp1sr7z9sSb; Thu, 26 Mar 2020 23:06:49 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 9475af081ec1fb6cc794a17ae90f2c01aa8a7993
In-Reply-To: <20200312140412.32373-1-chenzhou10@huawei.com>
To:     Chen Zhou <chenzhou10@huawei.com>, <paulus@samba.org>,
        <tyreld@linux.ibm.com>, <bhelgaas@google.com>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     chenzhou10@huawei.com, linux-pci@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] PCI: rpaphp: remove set but not used variable 'value'
Message-Id: <48p3cp1sr7z9sSb@ozlabs.org>
Date:   Thu, 26 Mar 2020 23:06:49 +1100 (AEDT)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 2020-03-12 at 14:04:12 UTC, Chen Zhou wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/pci/hotplug/rpaphp_core.c: In function is_php_type:
> drivers/pci/hotplug/rpaphp_core.c:291:16: warning:
> 	variable value set but not used [-Wunused-but-set-variable]
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/9475af081ec1fb6cc794a17ae90f2c01aa8a7993

cheers
