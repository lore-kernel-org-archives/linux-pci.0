Return-Path: <SRS0=PTHP=RO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C25B3C43381
	for <linux-pci@archiver.kernel.org>; Mon, 11 Mar 2019 14:08:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9317F2084F
	for <linux-pci@archiver.kernel.org>; Mon, 11 Mar 2019 14:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552313292;
	bh=5+tTAdH/IpVERTeDQh4CEt/Kxxc0Jb5E8/8Ocfrcc8Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=F5qqYlYC5CqH0hNfErZ2EnqigiEiUl3NBq7X/yKzRHp2iLbP+eHc9SxB6YeazEvTL
	 rjhqQdQvlvymjSFPyJ/nlkNPYzJiDUDrxvt5lKPOTK0Y7SKK8XgKJrUMSkOpCyKE65
	 foywlkltEipWnfHPTTFOIDRTcbB7ix1mtFgpdDmI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbfCKOIH (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 11 Mar 2019 10:08:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:55944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727485AbfCKOIH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 11 Mar 2019 10:08:07 -0400
Received: from localhost (50-82-46-41.client.mchsi.com [50.82.46.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1833F20657;
        Mon, 11 Mar 2019 14:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552313286;
        bh=5+tTAdH/IpVERTeDQh4CEt/Kxxc0Jb5E8/8Ocfrcc8Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mRRJ4+UWOMmxwMiGaLZCzc8n7iI2a3tpsuESYtjnOGppjSB2Zg81U4iqXHZkyu5ln
         FAVwkIwx+UdCN4Yhd3P1+jDWrkN6mWfSUSlflvDkLNbyXPki2fls4Imwb8SF0UAmgM
         +GKkorgfwucdApD+fDmsX5ZXKhybJ58gdM/sD5h0=
Date:   Mon, 11 Mar 2019 09:08:03 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Z.q. Hou" <zhiqiang.hou@nxp.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "l.subrahmanya@mobiveil.co.in" <l.subrahmanya@mobiveil.co.in>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        Xiaowei Bao <xiaowei.bao@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>
Subject: Re: [PATCHv4 10/28] PCI: mobiveil: fix the INTx process error
Message-ID: <20190311140803.GF214730@google.com>
References: <20190311093130.7209-1-Zhiqiang.Hou@nxp.com>
 <20190311093130.7209-11-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190311093130.7209-11-Zhiqiang.Hou@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 11, 2019 at 09:31:16AM +0000, Z.q. Hou wrote:
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> In the loop block, there is not code change the loop key,
> this patch updated the loop key by re-read the INTx status
> register.
> 
> This patch also change to clear the handled INTx status.
> 
> Note: Need MV to test this fix.
> 
> Fixes: 9af6bcb11e12 ("PCI: mobiveil: Add Mobiveil PCIe Host
> Bridge IP driver")

The "Fixes:" line should be all on one line, without a newline in the
middle, even if it exceeds 80 columns.  That's just to make it easier for
programs to parse the logs.
