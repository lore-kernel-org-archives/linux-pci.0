Return-Path: <SRS0=v2Vw=SP=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1E41C282CE
	for <linux-pci@archiver.kernel.org>; Sat, 13 Apr 2019 15:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B94F721721
	for <linux-pci@archiver.kernel.org>; Sat, 13 Apr 2019 15:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555171094;
	bh=NPlMfukL68lBnLITQ2nI6JsKH136/WiYYSnO7H8WiN0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UXgezJdL98GsJqBqDTUF3dYmXop7x9WOik3YsHYg5jqbJLrj9F0+XFXHnCtYypf7Q
	 BK8jdd/ESigmHZRe1WgFB6UKHrsqXNv+yExze/U6ddMFnr7z1gyE6jYuXItLhfVsfy
	 a51iCdmL83RQFD+xiBG0L6sa6PDvY5wPnucpD4b0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbfDMP6H (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 13 Apr 2019 11:58:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:50938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726973AbfDMP6H (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 13 Apr 2019 11:58:07 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E030D2084D;
        Sat, 13 Apr 2019 15:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555171086;
        bh=NPlMfukL68lBnLITQ2nI6JsKH136/WiYYSnO7H8WiN0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A1oDY7NkvqrD4N4zmnHHrEQNB6uYf1GIyTT8yINSQKjYCypIMpHgJBaoZPmEJpA58
         rCY8NlNpkqkrvKxgZF59gGhbSpZneDhoI0Tf+dgCt5XXI3Xl4wMIAC15z0I34ZmMyA
         bbwJyL2rAVRQFJ/1YC30pn0ULHk3rq2t+xUBD2AA=
Date:   Sat, 13 Apr 2019 10:58:04 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-kernel@axis.com,
        Minghuan Lian <minghuan.Lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>
Subject: Re: [PATCH v3 24/26] PCI: designware-ep: Use aligned ATU window for
 raising MSI interrupts
Message-ID: <20190413155804.GH126710@google.com>
References: <20190325093947.32633-1-kishon@ti.com>
 <20190325093947.32633-25-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190325093947.32633-25-kishon@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 25, 2019 at 03:09:45PM +0530, Kishon Vijay Abraham I wrote:
> Certain platforms like K2G reguires the outbound ATU window to be

s/reguires/require/ (note two changes: "g->q" and drop s)

