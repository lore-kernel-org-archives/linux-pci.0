Return-Path: <linux-pci-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 987A4C77B73
	for <linux-pci@archiver.kernel.org>; Thu, 27 Apr 2023 17:52:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243708AbjD0Rws (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 27 Apr 2023 13:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244039AbjD0Rws (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 Apr 2023 13:52:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6688B35BD;
        Thu, 27 Apr 2023 10:52:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EC54B63EDC;
        Thu, 27 Apr 2023 17:52:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F7CDC433EF;
        Thu, 27 Apr 2023 17:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682617966;
        bh=xkU2AxBp2cbLfWG1K4LLB2Ca1SteiY+51uE8jz1bWrA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=kKcDZn/T+nclBpGkLojCKhUXmmsC1cLCya0LHePqG3NifX0AER6TEP4W0p4XXljMB
         mpIyNM/P9rgu63Hnp+rdVLv2HhWGRGSqdQICFSgeFRy/3jstP09jFDiIbdkKz+LyIG
         zyWjnXdq6Csu1oXhTM/8kd3dxLeAr6bP1xBjZgc6MDzsVAv0MoGCyRJbpCVE62JKrN
         6mXyx5UN84bPPXmqeHtsInENRxLJePawXrkjBLojzPVJGv0z5tVa83xt9mx23Ax/6S
         thPo4fiOlWzrdjXlItb+A8Pfh/zbaCoDEY56z8LqCAu3XhdBASlyfgHjXnOVF1yb1s
         ya3JEpBPvzoXA==
Date:   Thu, 27 Apr 2023 12:52:44 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Shunsuke Mie <mie@igel.co.jp>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>, linux-pci@vger.kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>,
        Frank Li <Frank.Li@nxp.com>, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Ren Zhijie <renzhijie2@huawei.com>,
        Jon Mason <jdmason@kudzu.us>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [RFC PATCH v2 0/3] Introduce a PCIe endpoint virtio console
Message-ID: <20230427175244.GA261197@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230427104428.862643-1-mie@igel.co.jp>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 27, 2023 at 07:44:25PM +0900, Shunsuke Mie wrote:
> ...
>   PCI: endpoint: introduce a helper to implement pci ep virtio function
>   virtio_pci: add a definition of queue flag in ISR
>   PCI: endpoint: Add EP function driver to provide virtio-console
>     functionality

Capitalize the first word consistently to match history ("Introduce",
"Add").

Capitalize "PCI" in English text.

Capitalize "EP" since it's sort of an acronym (you did once, but do it
both places :))

Bjorn
