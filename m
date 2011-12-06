Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from nikam.ms.mff.cuni.cz ([195.113.20.16]:48672 "EHLO
	nikam.ms.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752942Ab1LFUCQ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 6 Dec 2011 15:02:16 -0500
Date: Tue, 6 Dec 2011 20:53:54 +0100
From: Martin Mares <mj@ucw.cz>
To: Mike Miller <mike.miller@hp.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/1] pciutils: add 8TB/s to link capabilities
Message-ID: <mj+md-20111206.195256.30852.nikam@ucw.cz>
References: <20111206191605.GA11235@beardog.cce.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20111206191605.GA11235@beardog.cce.hp.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello!

> Right now lspci shows "Speed unknown" for PCIe Gen3 links. This two liner
> adds 8GT/s to fix that. I don't think the next link rate has yet been
> decided. So I only go to Gen3.

I already have this one in my current Git tree (also available on kernel.org).
It seems I really should push out a new release :-)

		Thanks anyway
					Martin
