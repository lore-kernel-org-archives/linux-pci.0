Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDD5BC4332F
	for <linux-pci@archiver.kernel.org>; Tue, 15 Feb 2022 05:30:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234075AbiBOFaa (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 15 Feb 2022 00:30:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234090AbiBOFa1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Feb 2022 00:30:27 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A23B128DE5;
        Mon, 14 Feb 2022 21:30:16 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JyV6H0F2Lz4y4l;
        Tue, 15 Feb 2022 16:30:15 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Mamatha Inamdar <mamatha4@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org
Cc:     bhelgaas@google.com, mpe@ellerman.id.au, tyreld@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org
In-Reply-To: <20200924051343.16052.9571.stgit@localhost.localdomain>
References: <20200924051343.16052.9571.stgit@localhost.localdomain>
Subject: Re: [PATCH] rpadlpar_io:Add MODULE_DESCRIPTION entries to kernel modules
Message-Id: <164490279831.270256.12994910096465371651.b4-ty@ellerman.id.au>
Date:   Tue, 15 Feb 2022 16:26:38 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 24 Sep 2020 10:44:16 +0530, Mamatha Inamdar wrote:
> This patch adds a brief MODULE_DESCRIPTION to rpadlpar_io kernel modules
> (descriptions taken from Kconfig file)
> 
> 

Applied to powerpc/next.

[1/1] rpadlpar_io:Add MODULE_DESCRIPTION entries to kernel modules
      https://git.kernel.org/powerpc/c/be7be1c6c6f8bd348f0d83abe7a8f0e21bdaeac8

cheers
