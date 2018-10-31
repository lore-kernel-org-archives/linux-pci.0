Return-Path: <SRS0=lbet=NL=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9390BECDE44
	for <linux-pci@archiver.kernel.org>; Wed, 31 Oct 2018 06:09:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59E0720840
	for <linux-pci@archiver.kernel.org>; Wed, 31 Oct 2018 06:09:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="yea8tfg8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59E0720840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728323AbeJaPG0 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 31 Oct 2018 11:06:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:60438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726754AbeJaPGZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 31 Oct 2018 11:06:25 -0400
Received: from tiger (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D1F520821;
        Wed, 31 Oct 2018 06:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540966184;
        bh=jtf9nTI6FcpZ7DsK1y9SCkoJ/MxMyltxTcn/jLPKSdE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yea8tfg8WYY2s96/2bMyxkEgpc4ARLxG+Gf4fNpE0+ZAkZFN7xUsbL8Qe4D35829/
         wIGvByWefGTvYo2org9p8NkWUV6faZCQLkA274tpV7c9bCsTXLbx9aJOx/jeHReLfD
         qVKiNlKslsyf3T4DEjvNMu//Rxq7My1ztIqJvcvg=
Date:   Wed, 31 Oct 2018 14:09:18 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Stefan Agner <stefan@agner.ch>, Marek Vasut <marex@denx.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/4] soc: imx: gpc: Increase GPC_CLK_MAX to 7
Message-ID: <20181031060916.GA10386@tiger>
References: <cover.1539020938.git.leonard.crestez@nxp.com>
 <be94b872b63e6e0ac6f65ea41a69322d958f4a93.1539020938.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be94b872b63e6e0ac6f65ea41a69322d958f4a93.1539020938.git.leonard.crestez@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 08, 2018 at 06:06:19PM +0000, Leonard Crestez wrote:
> The DISPLAY power domain on imx6sx has 7 clocks.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>

Applied, thanks.
