Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF5CEC433B4
	for <linux-pci@archiver.kernel.org>; Mon,  3 May 2021 02:22:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FD7861249
	for <linux-pci@archiver.kernel.org>; Mon,  3 May 2021 02:22:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbhECCXV (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 2 May 2021 22:23:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:35368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232891AbhECCXP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 2 May 2021 22:23:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A321C61249;
        Mon,  3 May 2021 02:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620008542;
        bh=4wgS89+bSXEGi43PTIOuO6A5Ip3bXg0fPFRXRVxDd8Y=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=EmREiLOQwZTCcWOZgnghe9+CG/ANUqLg84w+iITE8jXyqX5gC200xVqF0mVfkVsE+
         eKiQ+yepmo0VGzkIk4wufSwqjL8BcJUSQmu0pP2EfxPMHOhuVQcXFOdbb/8ZTjH+fY
         FWpVTJ+nqaOT0War2hTFJLMwvF99QdJ9OE/3WSJ+dXeRd9a81CJRCzMArTUM+m57Xf
         5sBiDZW4vbr6lDeRtFj9AY2wJh1Nbpg/46NAEhFupydvnIbzQslG08FmPpPbYNfM73
         HAlBrSKOjqTAQfo0JwzTRkHWghi0sK39BNMpxIzT4ktmkp4NVITUTp1HTx7H2ltMwx
         +vyDi8WSEgOQg==
Subject: Re: [PATCH v5 2/2] PCI: Enable NO_BUS_RESET quirk for Nvidia GPUs
To:     Shanker Donthineni <sdonthineni@nvidia.com>,
        Alex Williamson <alex.williamson@redhat.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vikram Sethi <vsethi@nvidia.com>,
        Amey Narkhede <ameynarkhede03@gmail.com>
References: <20210430232624.25153-1-sdonthineni@nvidia.com>
 <20210430232624.25153-2-sdonthineni@nvidia.com>
From:   Sinan Kaya <okaya@kernel.org>
Message-ID: <cab1cbaf-1e20-bb0b-3709-94474d5ab06f@kernel.org>
Date:   Sun, 2 May 2021 22:22:20 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210430232624.25153-2-sdonthineni@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 4/30/2021 7:26 PM, Shanker Donthineni wrote:
> On select platforms, some Nvidia GPU devices do not work with SBR.
> Triggering SBR would leave the device inoperable for the current
> system boot. It requires a system hard-reboot to get the GPU device
> back to normal operating condition post-SBR. For the affected
> devices, enable NO_BUS_RESET quirk to fix the issue.
> 
> This issue will be fixed in the next generation of hardware.
> 
> Signed-off-by: Shanker Donthineni <sdonthineni@nvidia.com>

Reviewed-by: Sinan Kaya <okaya@kernel.org>
