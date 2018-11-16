Return-Path: <SRS0=UeAH=N3=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5836DC43441
	for <linux-pci@archiver.kernel.org>; Fri, 16 Nov 2018 02:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F31021780
	for <linux-pci@archiver.kernel.org>; Fri, 16 Nov 2018 02:50:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rgKG51Od"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F31021780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbeKPNAn (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 16 Nov 2018 08:00:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:38900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726714AbeKPNAn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 16 Nov 2018 08:00:43 -0500
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 39F41208E7;
        Fri, 16 Nov 2018 02:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542336609;
        bh=wcje9mRODaARS3pY5DDvUjbhEoCmXhDzSeeuZFDpZ8U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rgKG51Od4MtTM1OhNQv2/HkNJqHhvcH9Mt2J2dNNWzQZtR0ISqdmdujchrL186/nz
         lZ2gyc1n36dtDYbcIVcCiiLxKadf1mR6Yh7NIUYPqBVEkLP+1+8fj/Sy5TU0uuAhuh
         iRN6M4U9+xMA2ObBK4DvRw6BR/1Uq4OHNn0aBBLs=
Date:   Fri, 16 Nov 2018 10:49:49 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Xiaowei Bao <xiaowei.bao@nxp.com>
Cc:     bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        leoyang.li@nxp.com, kishon@ti.com, lorenzo.pieralisi@arm.com,
        arnd@arndb.de, gregkh@linuxfoundation.org, minghuan.Lian@nxp.com,
        mingkai.hu@nxp.com, roy.zang@nxp.com, kstewart@linuxfoundation.org,
        cyrille.pitchen@free-electrons.com, pombredanne@nexb.com,
        shawn.lin@rock-chips.com, niklas.cassel@axis.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCHv2 1/6] arm64: dts: Add the status property disable PCIe
Message-ID: <20181116024947.GD5829@dragon>
References: <20181105084653.26597-1-xiaowei.bao@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181105084653.26597-1-xiaowei.bao@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 05, 2018 at 04:46:48PM +0800, Xiaowei Bao wrote:
> From: Bao Xiaowei <xiaowei.bao@nxp.com>
> 
> Add the status property disable the PCIe, the property will be enable
> by bootloader.
> 
> Signed-off-by: Bao Xiaowei <xiaowei.bao@nxp.com>

Changed prefix to 'arm64: dts: fsl: ...' and applied the patch.

Shawn
