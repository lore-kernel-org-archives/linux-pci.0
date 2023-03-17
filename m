Return-Path: <linux-pci-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C809AC7618A
	for <linux-pci@archiver.kernel.org>; Fri, 17 Mar 2023 16:38:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbjCQQi3 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 17 Mar 2023 12:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbjCQQi0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Mar 2023 12:38:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F217B6043F;
        Fri, 17 Mar 2023 09:38:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7C46160B85;
        Fri, 17 Mar 2023 16:38:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B856C433EF;
        Fri, 17 Mar 2023 16:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679071093;
        bh=eqZUPeBX8BKdMjF5mwS63K8f+ED3apV6bCXS9iPYiZQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tT2m/l/VZVW04GVsyt5LF3puq+zDlTtYsG+nbi0sgboS9phZAzuwK5Yllo5HjlUqR
         fhrXMmSmXFZYNcnaJ9CHstgvjuyg0MthA4ejRXCllBXCKmiTpjM+cSQHLujbWJovpQ
         PBnyIBbyTBxLjFVs6RMb8j6r6/3pM0dyFpeUr0+ApoITg7IIoK4daOS5e8rAO9/dLI
         WS1pf7eYAfw0549GJa5H6E0+/9qbgh1pGjV+2Y8ARZABdijlHq0qRcQSxJ4p4NiQ+m
         IUotYlMrhTKglYPy1bvLfGF3ppVkNGdigDOlopoEDjwYtpUrdA1idBW6JNLH1bAQLW
         YXuju28VYx8NQ==
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     helgaas@kernel.org, Frank Li <Frank.Li@nxp.com>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        alok.a.tiwari@oracle.com, bhelgaas@google.com, frank.li@nxp.com,
        imx@lists.linux.dev, kw@linux.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        minghuan.lian@nxp.com, mingkai.hu@nxp.com, robh@kernel.org,
        roy.zang@nxp.com
Subject: Re: [PATCH v3 1/1] PCI: layerscape: Add EP mode support for ls1028a
Date:   Fri, 17 Mar 2023 17:38:05 +0100
Message-Id: <167907106433.509815.4523416530064745117.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230209151050.233973-1-Frank.Li@nxp.com>
References: <20230209151050.233973-1-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 09 Feb 2023 10:10:50 -0500, Frank Li wrote:
> Add PCIe EP mode support for ls1028a.
> 
> 

Applied to controller/layerscape, thanks!

[1/1] PCI: layerscape: Add EP mode support for ls1028a
      https://git.kernel.org/pci/pci/c/be567c6cbc08

Thanks,
Lorenzo
