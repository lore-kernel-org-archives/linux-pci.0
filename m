Return-Path: <SRS0=cO2L=CL=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72467C433E7
	for <linux-pci@archiver.kernel.org>; Wed,  2 Sep 2020 22:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B8D0207D3
	for <linux-pci@archiver.kernel.org>; Wed,  2 Sep 2020 22:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599084473;
	bh=ntdBgUCdPt/2RWSSt3H2PeJklgTkOWgF88Cq4uej3KE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=Pwid5U3tSZhHWuSQQC7ByC1qkI25XddggxS/2JkvdJ9ZkCY2Nax0Ox4KFwQYT5PYk
	 GR7Tq8T9xEamIUcnwY6EywEVcW0rmK09Zbaj818xRq1IPzc8ywsffpIl9oQjU+83LR
	 dujcgNQVZi+VD9UFQ/Tgc/+C0v12C0hQE03FS8tc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbgIBWHw (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 2 Sep 2020 18:07:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:50494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726226AbgIBWHw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 2 Sep 2020 18:07:52 -0400
Received: from localhost (47.sub-72-107-117.myvzw.com [72.107.117.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6FC320767;
        Wed,  2 Sep 2020 22:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599084472;
        bh=ntdBgUCdPt/2RWSSt3H2PeJklgTkOWgF88Cq4uej3KE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=dAKobmUHyEDygb3Qws6xA4fXIdPQQ228nmyvq/YXQ6E4wtygeRk8fTuMx2Hw1UMFI
         EdtmiYYiaHRCvJG72/Yn+j1Y0Ug11yAqRCJRfvRbH6LGAtzhKxlcPi8lzRbRxhax+4
         UUN4V1j+r0VR4MdIoAoyBgvSK96xVpJwGPlkd2MI=
Date:   Wed, 2 Sep 2020 17:07:50 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Cc:     amd-gfx@lists.freedesktop.org,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        linux-pci@vger.kernel.org, alexander.deucher@amd.com,
        nirmodas@amd.com, Dennis.Li@amd.com, christian.koenig@amd.com,
        luben.tuikov@amd.com, bhelgaas@google.com
Subject: Re: [PATCH v4 2/8] drm/amdgpu: Block all job scheduling activity
 during DPC recovery
Message-ID: <20200902220750.GA272406@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1599072130-10043-3-git-send-email-andrey.grodzovsky@amd.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 02, 2020 at 02:42:04PM -0400, Andrey Grodzovsky wrote:
> DPC recovery involves ASIC reset just as normal GPU recovery so block
> SW GPU schedulers and wait on all concurrent GPU resets.

> +		 * Cancel and wait for all TDRs in progress if failing to
> +		 * set  adev->in_gpu_reset in amdgpu_device_lock_adev

OCD typo, s/set  adev/set adev/ (two spaces)
