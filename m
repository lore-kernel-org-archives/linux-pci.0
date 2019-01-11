Return-Path: <SRS0=/dOL=PT=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F43C43387
	for <linux-pci@archiver.kernel.org>; Fri, 11 Jan 2019 07:30:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29AB42146F
	for <linux-pci@archiver.kernel.org>; Fri, 11 Jan 2019 07:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547191843;
	bh=fzSZSFiP4VR+dmAh+cdvz597Uc/jfSi2xf908v063sk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gdokQRRHhae9c1DpPXQwxmczfQtwspCzF6gFbTeHoP1/l42I7qEzpwbqEYQCYVfie
	 tv226h6Ud28SgevbsYGV8Dp2G7tZqRJNyuVDRkD5Xg7xZ8itVHKH30K+kCC+mvQiLv
	 MHIxfb+6+9GVyeImC/GfR9pMxUX2LSQb7R/qRA9c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730873AbfAKHam (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 11 Jan 2019 02:30:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:49526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727723AbfAKHam (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 11 Jan 2019 02:30:42 -0500
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A41F2084C;
        Fri, 11 Jan 2019 07:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547191841;
        bh=fzSZSFiP4VR+dmAh+cdvz597Uc/jfSi2xf908v063sk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XvQBDYewI2FrGtNHurTzb9vl6bp6Q5v/fK/u4W5XQkcLO+JSVytdFfGLH6uw8Af8P
         0FG8S15i34RxMWs6Zt/IHmEA2rraKf1ER2KRS0vO+soe4MKsCf1ud4aC/glNte0tzC
         BrjRK0TQxYX1pSJSyGYREG4+6WEpmkcQ9qdkcLrA=
Date:   Fri, 11 Jan 2019 15:30:28 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     "Z.q. Hou" <zhiqiang.hou@nxp.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        Leo Li <leoyang.li@nxp.com>, Roy Zang <roy.zang@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>
Subject: Re: [PATCHv3 2/5] arm64: dts: layerscape: add num-viewport property
 for PCIe DT nodes
Message-ID: <20190111073026.GE32649@dragon>
References: <20181218041956.41809-1-Zhiqiang.Hou@nxp.com>
 <20181218041956.41809-3-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181218041956.41809-3-Zhiqiang.Hou@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 18, 2018 at 04:19:32AM +0000, Z.q. Hou wrote:
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> Add num-viewport property for PCIe DT nodes to specify how many
> viewports are implemented.
> 
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Applied, thanks.
