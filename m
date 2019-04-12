Return-Path: <SRS0=vi1x=SO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8307C10F0E
	for <linux-pci@archiver.kernel.org>; Fri, 12 Apr 2019 15:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CD442171F
	for <linux-pci@archiver.kernel.org>; Fri, 12 Apr 2019 15:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555083521;
	bh=v56LeXwr7t1ja6o1KqBeXKluPpjZCaLuijouKb5IvAo=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=nA3NA19UscP25mrAq8M+1hFmSUV4xbsFQcuWDbJeotNlDPY6GvJCOyPh46V7sm+zV
	 exlCGR3hkrja0ErS0et0IE7SAlfvlbMKq2mXPHPFnpnWZvsPhqH5bbYBqD2ZKYUDMD
	 MkXSM9WoVk3ZbWEl3tlN1J0WzD1dCFwfU83Navmk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbfDLPil (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 12 Apr 2019 11:38:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:58352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726711AbfDLPil (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 12 Apr 2019 11:38:41 -0400
Received: from localhost (173-25-63-173.client.mchsi.com [173.25.63.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 358D82082E;
        Fri, 12 Apr 2019 15:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555083520;
        bh=v56LeXwr7t1ja6o1KqBeXKluPpjZCaLuijouKb5IvAo=;
        h=Date:From:To:Cc:Subject:From;
        b=NNKs4SO6zl+yCoT6q9KpzemVDSE2woCeNiIQ5+cyRpR5PRxBXk3wdvX9vVL3x8iSU
         DzP0seJF1f0re/LJGN9ZUu6OeyAcmywBk8+W4YX0FW1DQtgPdFlEy0E+sF0ZtOWYCJ
         XayxeWYCIidFbaX5yvu11zudEy6ncRmZKvaWfAoA=
Date:   Fri, 12 Apr 2019 10:38:38 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sergey Miroshnichenko <s.miroshnichenko@yadro.com>,
        Lukas Wunner <lukas@wunner.de>,
        Micah Parrish <micah.parrish@hpe.com>,
        Andre Przywara <andre.przywara@arm.com>
Subject: [GIT PULL] PCI fixes for v5.1
Message-ID: <20190412153838.GA126710@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCI fixes:

  - Add a DMA alias quirk for another Marvell SATA device (Andre Przywara)

  - Fix a pciehp regression that broke safe removal of devices (Sergey
    Miroshnichenko)


The following changes since commit 0fa635aec9abd718bd18c0bda2261351a0811efc:

  PCI/LINK: Deduplicate bandwidth reports for multi-function devices (2019-03-25 17:59:07 -0500)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.1-fixes-2

for you to fetch changes up to 3943af9d01e94330d0cfac6fccdbc829aad50c92:

  PCI: pciehp: Ignore Link State Changes after powering off a slot (2019-04-10 16:06:43 -0500)

----------------------------------------------------------------
pci-v5.1-fixes-2

----------------------------------------------------------------
Andre Przywara (1):
      PCI: Add function 1 DMA alias quirk for Marvell 9170 SATA controller

Sergey Miroshnichenko (1):
      PCI: pciehp: Ignore Link State Changes after powering off a slot

 drivers/pci/hotplug/pciehp_ctrl.c | 4 ++++
 drivers/pci/quirks.c              | 2 ++
 2 files changed, 6 insertions(+)
