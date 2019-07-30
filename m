Return-Path: <SRS0=at4K=V3=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 769A4C31E40
	for <linux-pci@archiver.kernel.org>; Tue, 30 Jul 2019 13:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48F4C206B8
	for <linux-pci@archiver.kernel.org>; Tue, 30 Jul 2019 13:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564494474;
	bh=Xu4PP27fkOExOXZ91jKqOFfiFWcud7AAA12IFEJ3dIA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rGrvdYuiKqkv9IMTnINi1XmeCPoRyJX8KbKvKuzfbidLB7bYh9vijnBOnjTyFP6Fo
	 Y1f+1FlKrqLhZVkNHCzD8e6IYNhjPIM+LlVtVvRE8ydMx3jJgDjdVDUVeX+MU6OoDt
	 n4tCSXstXq2FO4HOE0Ofb5U6R7ZA3zxN8a0IyAik=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727647AbfG3Nrx (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 30 Jul 2019 09:47:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:55680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726903AbfG3Nrx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 30 Jul 2019 09:47:53 -0400
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F274206B8;
        Tue, 30 Jul 2019 13:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564494472;
        bh=Xu4PP27fkOExOXZ91jKqOFfiFWcud7AAA12IFEJ3dIA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bO6WslM/NB7k5BZfKjQI0wnX0jW3JE/hDNzXrOtSLQ5weZTbxaQvGxc6vunRjLIWJ
         7JgP5ECG0o+BMEF/G+sMgWyJrGmao4KJ6Mrdnr9SdvDmllGPozKLDlirSQYlvMGiYv
         jeEYA26gRjxLLwKfpXjVRdA0I5dwhpUO8Y4QRW+w=
Date:   Tue, 30 Jul 2019 08:47:51 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kelsey Skunberg <skunberg.kelsey@gmail.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [Linux-kernel-mentees] [PATCH v2 00/11] Hide PCI symbols that
 don't need to be global
Message-ID: <20190730134751.GH203187@google.com>
References: <20190711222341.111556-1-skunberg.kelsey@gmail.com>
 <20190724233848.73327-1-skunberg.kelsey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190724233848.73327-1-skunberg.kelsey@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 24, 2019 at 05:38:37PM -0600, Kelsey Skunberg wrote:
> The include/linux/pci.h header file defines several symbols that are used
> only in drivers/pci/. These symbols do not need to be visible to the rest
> of the kernel. Move PCI symbols that are only used in drivers/pci/ to
> drivers/pci/pci.h.
> 
> Changes in v2:
>         - Built patches to work with v5.3-rc1
>         - Changed line lengths on commit logs to stay below 80 characters
> 	- Changed cover-letter log to better explain patch series
> 
> 
> Kelsey Skunberg (11):
>   PCI: Move #define PCI_PM_* lines to drivers/pci/pci.h
>   PCI: Move PME declarations to drivers/pci/pci.h
>   PCI: Move *_host_bridge_device() declarations to drivers/pci.pci.h
>   PCI: Move PCI Virtual Channel declarations to drivers/pci/pci.h
>   PCI: Move pci_hotplug_*_size declarations to drivers/pci/pci.h
>   PCI: Move pci_bus_* declarations to drivers/pci/pci.h
>   PCI: Move pcie_update_link_speed() to drivers/pci/pci.h
>   PCI: Move pci_ats_init() to drivers/pci/pci.h
>   PCI: Move ECRC declarations to drivers/pci/pci.h
>   PCI: Move PTM declaration to drivers/pci/pci.h
>   PCI: Move pci_*_node() declarations to drivers/pci/pci.h
> 
>  drivers/pci/pci.h   | 48 ++++++++++++++++++++++++++++++++++++++++++---
>  include/linux/pci.h | 47 --------------------------------------------
>  2 files changed, 45 insertions(+), 50 deletions(-)

Applied to pci/encapsulate for v5.4, thanks a lot!
