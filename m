Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0C24C433FE
	for <linux-pci@archiver.kernel.org>; Wed, 11 May 2022 13:04:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243131AbiEKNEs (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 11 May 2022 09:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243148AbiEKNEl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 May 2022 09:04:41 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7D4702375C0
        for <linux-pci@vger.kernel.org>; Wed, 11 May 2022 06:04:39 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2C976ED1;
        Wed, 11 May 2022 06:04:39 -0700 (PDT)
Received: from e123427-lin.arm.com (unknown [10.57.1.148])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6C8743F66F;
        Wed, 11 May 2022 06:04:37 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     bhelgaas@google.com, Conor Dooley <conor.dooley@microchip.com>,
        helgaas@kernel.org, Daire.McNamara@microchip.com
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, robh@kernel.org,
        linux-pci@vger.kernel.org, maz@kernel.org,
        david.abdurachmanov@gmail.com, Cyril.Jean@microchip.com,
        Conor.Dooley@microchip.com
Subject: Re: [PATCH] PCI: microchip: add missing chained_irq enter/exit calls
Date:   Wed, 11 May 2022 14:04:30 +0100
Message-Id: <165227425974.18998.13959802523186659255.b4-ty@arm.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220511095504.2273799-1-conor.dooley@microchip.com>
References: <20220511095504.2273799-1-conor.dooley@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 11 May 2022 10:55:05 +0100, Conor Dooley wrote:
> Bjorn spotted that two of the chained irq handlers were missing their
> chained_irq_enter()/chained_irq_exit() calls, so add them in to avoid
> potentially lost interrupts.
> 
> Reported by: Bjorn Helgaas <bhelgaas@google.com>
> 
> 
> [...]

Applied to pci/microchip, thanks!

[1/1] PCI: microchip: add missing chained_irq enter/exit calls
      https://git.kernel.org/lpieralisi/pci/c/30097efa33

Thanks,
Lorenzo
