Return-Path: <linux-pci-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DDE2C001B0
	for <linux-pci@archiver.kernel.org>; Wed, 14 Jun 2023 10:42:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235964AbjFNKma (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 14 Jun 2023 06:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235505AbjFNKm0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Jun 2023 06:42:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A8D19B3;
        Wed, 14 Jun 2023 03:42:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 08F806407F;
        Wed, 14 Jun 2023 10:42:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83FAFC433C0;
        Wed, 14 Jun 2023 10:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686739341;
        bh=X7yfHlvVllPkKbahx8vTZCjY01wqQ4qFTmrfD100fbU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fhb+KPzasSVEQteouKqtKKg6l14tpSw3XjTGRH6HEQz5cu/1ekwL/tG+5qkz7oQf/
         gI7WgUwhk567cA+p+1nMsgCsf/QaVnnhsefB8LqDT6x1YskRmIZdU6y8VLW6vtBlWT
         ciNbEn3SD3XP1sRCMlx4iYnDSjapIx8hOtuP2TSxS8N7TJQgcJMUMdbKwsIKuWxWZ4
         HnysOe6FomncdQ4BsJvGTH7MHuErOp/chaCfmVpEE4gLvRrq+QMm/rr0V1qw1TAdt+
         Be67bJ47Lyp9R9iBiTY8o++5GswRkOzrD6M1IMpKsvmxYxcHDXYy8AM2F94Tyf08AV
         Vxk4RZk8aw3sg==
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Manivannan Sadhasivam <mani@kernel.org>,
        Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Damien Le Moal <dlemoal@kernel.org>, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI: endpoint: Check correct variable in __pci_epf_mhi_alloc_map()
Date:   Wed, 14 Jun 2023 12:42:15 +0200
Message-Id: <168673929458.230348.14392570748400558563.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <258e8de1-abff-4024-89e0-1c8df761d790@moroto.mountain>
References: <258e8de1-abff-4024-89e0-1c8df761d790@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 09 Jun 2023 13:49:33 +0300, Dan Carpenter wrote:
> This was intended to check "*vaddr" instead of "vaddr" (without an
> asterisk).
> 
> 

Squashed in the commit they are fixing, thanks !!

Thanks,
Lorenzo
