Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3EAEC433DB
	for <linux-pci@archiver.kernel.org>; Wed, 24 Mar 2021 16:35:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A363A619E4
	for <linux-pci@archiver.kernel.org>; Wed, 24 Mar 2021 16:35:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235832AbhCXQfJ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 24 Mar 2021 12:35:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:39032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234741AbhCXQez (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 24 Mar 2021 12:34:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E15CB619E4;
        Wed, 24 Mar 2021 16:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616603695;
        bh=hUOBLPPbTSZw0MdksqtVo7DW9tnlNyx/Ii6rWxq74mA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=p8pYM0SNfVF9Zl28f0ktwPKzyr9TJCwcW1ZyyKMR18Sp4l2/jjj7jcBkhw3uyepkd
         VSnjPiYccSarkQH5C/XpD+nYYFqXMjcXpsDdsImgLvTUlN6x0+/aXz52gWXBNGlgSI
         QMxY3ScjWMjhV9uDJaTj+OR3xbL/AUKYrvJs7ORYJj/AS7KJlAg279P220x7rrqM1F
         uEuMeNPkwjrC1ysHatS9HVV6q9T/jmLsHAF1NDTJ4F0DClwYRSkrXaWWoFHa8IguVY
         6+R/xCbKHNFht2Yh/n7QsgKavxDsv5aG7euxILjOTASDLUQyvRE9FgwkjNjDuuWbC7
         JNxzdIO01PEGQ==
Date:   Wed, 24 Mar 2021 11:34:53 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Simon Xue <xxm@rock-chips.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        Johan Jonker <jbx6244@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH v5 2/2] PCI: rockchip: Add DesignWare based PCIe
 controller
Message-ID: <20210324163453.GA695478@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210222071828.30120-1-xxm@rock-chips.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Also, please make the subject line more specific, e.g.,

  PCI: rockchip: Add Rockchip RK356X host controller driver

On Mon, Feb 22, 2021 at 03:18:28PM +0800, Simon Xue wrote:
> Add driver for DesignWare based PCIe controller found on RK356X.
> The already existed driver pcie-rockchip-host is only used for
> Rockchip designed IP found on RK3399.

  Add a driver for the DesignWare-based PCIe controller found on
  RK356X.  The existing pcie-rockchip-host driver is only used for
  the Rockchip-designed IP found on RK3399.
