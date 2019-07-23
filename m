Return-Path: <SRS0=S0fB=VU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0607C76186
	for <linux-pci@archiver.kernel.org>; Tue, 23 Jul 2019 23:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7C732238C
	for <linux-pci@archiver.kernel.org>; Tue, 23 Jul 2019 23:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563923229;
	bh=pp3VeEKDhtsJD2D+h2rq5js+joCttLYr+igNbqENd4k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XheOcbjIdUDBUF9Hct3xs2J/QPBKXwNsq8JkGG8tRovapG4gj1py6gNBUSvWXwAGZ
	 76TVBlHaB1ID/1A8K7/loFM00+17SO8p9BRTrDSXmV/3KkpnqCnEyOlAjnvN8TVA+K
	 iXrz/CFnDC8UuZGdkiQVqXEfKBLekGGBErWA1s1I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbfGWXHE (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 23 Jul 2019 19:07:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:34602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726323AbfGWXHD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 23 Jul 2019 19:07:03 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC0CD2238C;
        Tue, 23 Jul 2019 23:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563923223;
        bh=pp3VeEKDhtsJD2D+h2rq5js+joCttLYr+igNbqENd4k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e7W+2qpIRb1joAjtfWlNBJt/KSOtXyWnBvuA8+0Q7F1Oq+WLZRZP8dK4gGOVmPlYj
         abs7IEOWcH4Z/ohf4Ne+Wi6o8APJuPEs+F/ubqOSUpXTVC8MvfW6gCqj7NztM9C57u
         aoJqKu6PGegI5vf3zrlMe5SIJYnJEOa1dL68TZJw=
Date:   Tue, 23 Jul 2019 18:07:01 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kelsey Skunberg <skunberg.kelsey@gmail.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH 00/11] PCI: Move symbols to drivers/pci/pci.h
Message-ID: <20190723230701.GA47047@google.com>
References: <20190711222341.111556-1-skunberg.kelsey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190711222341.111556-1-skunberg.kelsey@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 11, 2019 at 04:23:30PM -0600, Kelsey Skunberg wrote:
> Move symbols defined in include/linux/pci.h that are only used in
> drivers/pci/ to drivers/pci/pci.h.
> 
> Symbols only used in drivers/pci/ do not need to be visible to the rest of
> the kernel.
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

Hi Kelsey,

I didn't get these applied before v5.3-rc1, so now they don't apply
cleanly.  Would you mind refreshing them and posting a v2 that does
apply to my "master" branch (v5.3-rc1)?

Bjorn
