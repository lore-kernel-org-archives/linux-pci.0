Return-Path: <SRS0=2i2g=4M=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF31CC35670
	for <linux-pci@archiver.kernel.org>; Mon, 24 Feb 2020 01:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99B742067D
	for <linux-pci@archiver.kernel.org>; Mon, 24 Feb 2020 01:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582507759;
	bh=uZkT34d6dn8NI6fV5wBHUlsvKm6dzl4F1u8gl0GTubM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Wpe1ItrUs39qXxGBKjD6e2ZAp57sxOhcFS6Y+dJbO5kniEhxCwJDvQAcLyvv8IDxu
	 w/r2iFqRC1bTE8rcUo5W0YR2oEIGQdBDRuDEyPqz3lOoqP+CNNPtX/3w6Zm1TRymCS
	 zg9BcdU9WH+OO9rn8RRXg1qPHkhFmvbA9kAnvNVE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbgBXB3P (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 23 Feb 2020 20:29:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:47214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727151AbgBXB3O (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 23 Feb 2020 20:29:14 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0DA22067D;
        Mon, 24 Feb 2020 01:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582507754;
        bh=uZkT34d6dn8NI6fV5wBHUlsvKm6dzl4F1u8gl0GTubM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qfyhZ+8sUkR8XfTwu8yGmRgaNaGMMDl88owv0hung6LssD3VgCnuiLtBhbToQ2KYP
         CgtgTJv4vSIUx2f+11a2yDEEImmhkcu4Ik/tvg//axjEhaRD8mtlz5J68VyJZrzGjm
         0WCtyY0csLYfZ94YY7NBdbr851bW4GCqSZd5mW/k=
Date:   Mon, 24 Feb 2020 09:29:07 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com, robh+dt@kernel.org, andrew.murray@arm.com,
        arnd@arndb.de, mark.rutland@arm.com, l.subrahmanya@mobiveil.co.in,
        m.karthikeyan@mobiveil.co.in, leoyang.li@nxp.com,
        lorenzo.pieralisi@arm.com, catalin.marinas@arm.com,
        will.deacon@arm.com, Mingkai.Hu@nxp.com, Minghuan.Lian@nxp.com,
        Xiaowei.Bao@nxp.com
Subject: Re: [PATCHv10 13/13] arm64: defconfig: Enable
 CONFIG_PCIE_LAYERSCAPE_GEN4
Message-ID: <20200224012907.GC14331@dragon>
References: <20200213040644.45858-1-Zhiqiang.Hou@nxp.com>
 <20200213040644.45858-14-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213040644.45858-14-Zhiqiang.Hou@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Feb 13, 2020 at 12:06:44PM +0800, Zhiqiang Hou wrote:
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> Enable the PCIe Gen4 controller driver for Layerscape SoCs.
> 
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> Reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>

Applied, thanks.
