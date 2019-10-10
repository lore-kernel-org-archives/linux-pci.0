Return-Path: <SRS0=QRx0=YD=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65A6EECE58E
	for <linux-pci@archiver.kernel.org>; Thu, 10 Oct 2019 14:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4980E206B6
	for <linux-pci@archiver.kernel.org>; Thu, 10 Oct 2019 14:01:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbfJJOB1 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 10 Oct 2019 10:01:27 -0400
Received: from verein.lst.de ([213.95.11.211]:58372 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726038AbfJJOB1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 10 Oct 2019 10:01:27 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id E1F5468C65; Thu, 10 Oct 2019 16:01:21 +0200 (CEST)
Date:   Thu, 10 Oct 2019 16:01:21 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sagi Grimberg <sagi@grimberg.me>,
        Mario Limonciello <Mario.Limonciello@dell.com>,
        Keith Busch <keith.busch@intel.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Rajat Jain <rajatja@google.com>,
        Christoph Hellwig <hch@lst.de>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 1/1] PCI/ASPM: Remove pcie_aspm_enabled() unnecessary
 locking
Message-ID: <20191010140121.GA31701@lst.de>
References: <20191010124746.2882-1-helgaas@kernel.org> <20191010124746.2882-2-helgaas@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191010124746.2882-2-helgaas@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 10, 2019 at 07:47:46AM -0500, Bjorn Helgaas wrote:
> +	return bridge->link_state ? !!bridge->link_state->aspm_enabled : false;

Can we unobsfucated this while we're at it?

	if (!bridge->link_state)
		return false;
	return bridge->link_state->aspm_enabled;
