Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ns.horizon.com ([71.41.210.147]:33236 "HELO ns.horizon.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750990AbaEWB3g (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 22 May 2014 21:29:36 -0400
Date: 22 May 2014 21:29:33 -0400
Message-ID: <20140523012933.7078.qmail@ns.horizon.com>
From: "George Spelvin" <linux@horizon.com>
To: alex.williamson@redhat.com, iommu@lists.linux-foundation.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 05/16] PCI: quirk dma_alias_devfn for Marvell devices
Cc: acooks@gmail.com, bhelgaas@google.com, eddy0596@gmail.com,
	linux-kernel@vger.kernel.org, linux@horizon.com
In-Reply-To: <20140522230755.2856.19714.stgit@bling.home>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Tested-by: George Spelvin <linux@horizon.com>

(I'm running the whole series, but 1b4b:9172 are the devices I have.)
