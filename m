Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D238C433E9
	for <linux-pci@archiver.kernel.org>; Fri, 26 Feb 2021 19:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3B8364F29
	for <linux-pci@archiver.kernel.org>; Fri, 26 Feb 2021 19:21:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbhBZTVo (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 26 Feb 2021 14:21:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:43620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230231AbhBZTVl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 26 Feb 2021 14:21:41 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 526D064ED2;
        Fri, 26 Feb 2021 19:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614367260;
        bh=vzH3Me+LHIo8JCm3dGDHzL3yDONG+P0UzLulsz5oymA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ORZ20mtIF+Gy/RQ6d0BYEnEtHHuIHchZlPsB/gCD84oqL38U2KKtihVXMZV2DCFr1
         1cHHHpfWf6WNeYXLYOn3YbfrJfoSHGzftuv50vitELxIsBnKGAx6zzr+3wadqcMKa+
         nWSKMlMAnos8gjdpgZ4O2GbW333RqvASKlO5UIsFXd6GwrNTDDKoVa6hMDV5VL5A5X
         95lJ+3vGcTiDzW/uKiN9v/GNSJQFNuZfumNClUKgUGbCaFfjpLdAw7qs2+HCD4XuLk
         Jk4xss8CRF/x2s158C99oCTshHNvAuYausLRhkVEEVuEABQtTxgl3JxiCWAUmLVCld
         0ePDAdbBJb97g==
Date:   Fri, 26 Feb 2021 20:20:55 +0100
From:   Robert Richter <rric@kernel.org>
To:     Dejin Zheng <zhengdejin5@gmail.com>
Cc:     corbet@lwn.net, jarkko.nikula@linux.intel.com,
        andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com,
        bhelgaas@google.com, wsa@kernel.org, linux-doc@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/4] Introduce pcim_alloc_irq_vectors()
Message-ID: <YDlKF1MP0p7l8vxb@rric.localdomain>
References: <20210226155056.1068534-1-zhengdejin5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210226155056.1068534-1-zhengdejin5@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 26.02.21 23:50:52, Dejin Zheng wrote:
> Introduce pcim_alloc_irq_vectors(), a device-managed version of
> pci_alloc_irq_vectors(), In some i2c drivers, If pcim_enable_device()
> has been called before, then pci_alloc_irq_vectors() is actually a
> device-managed function. It is used as a device-managed function, So
> replace it with pcim_alloc_irq_vectors().

For the whole series:

Reviewed-by: Robert Richter <rric@kernel.org>

Thanks.
