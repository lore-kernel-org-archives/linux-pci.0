Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CD18C433EF
	for <linux-pci@archiver.kernel.org>; Wed, 18 May 2022 16:17:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239981AbiERQRW (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 18 May 2022 12:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239971AbiERQRV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 May 2022 12:17:21 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 354E8163F64
        for <linux-pci@vger.kernel.org>; Wed, 18 May 2022 09:17:21 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F182123A;
        Wed, 18 May 2022 09:17:20 -0700 (PDT)
Received: from e123427-lin.arm.com (unknown [10.57.1.97])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 500113F718;
        Wed, 18 May 2022 09:17:19 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     daire.mcnamara@microchip.com
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, robh@kernel.org,
        cyril.jean@microchip.com, maz@kernel.org,
        david.abdurachmanov@gmail.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, helgaas@kernel.org,
        conor.dooley@microchip.com
Subject: Re: [PATCH v2] PCI: microchip: Fix potential race in interrupt handling
Date:   Wed, 18 May 2022 17:17:09 +0100
Message-Id: <165289060838.16898.13367280524445395261.b4-ty@arm.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220517141622.145581-1-daire.mcnamara@microchip.com>
References: <20220517141622.145581-1-daire.mcnamara@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 17 May 2022 15:16:22 +0100, daire.mcnamara@microchip.com wrote:
> From: Daire McNamara <daire.mcnamara@microchip.com>
> 
> Clear the MSI bit in ISTATUS_LOCAL register after reading it, but
> before reading and handling individual MSI bits from the ISTATUS_MSI
> register. This avoids a potential race where new MSI bits may be set
> on the ISTATUS_MSI register after it was read and be missed when the
> MSI bit in the ISTATUS_LOCAL register is cleared.
> 
> [...]

Applied to pci/microchip, thanks!

[1/1] PCI: microchip: Fix potential race in interrupt handling
      https://git.kernel.org/lpieralisi/pci/c/7013654af6

Thanks,
Lorenzo
