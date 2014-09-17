Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from nbfkord-smmo04.seg.att.com ([209.65.160.86]:54079 "EHLO
	nbfkord-smmo04.seg.att.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754870AbaIQQBG (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 17 Sep 2014 12:01:06 -0400
Message-ID: <5419AE97.4040803@solarflare.com>
Date: Wed, 17 Sep 2014 16:53:59 +0100
From: Robert Stonehouse <rstonehouse@solarflare.com>
MIME-Version: 1.0
To: Alex Williamson <alex.williamson@redhat.com>,
	<linux-pci@vger.kernel.org>, <bhelgaas@google.com>
CC: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pci: quirks: Add ACS quirk for Solarflare SFC9120 & SFC9140
References: <20140917145838.19243.14630.stgit@gimli.home>
In-Reply-To: <20140917145838.19243.14630.stgit@gimli.home>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 17/09/14 15:59, Alex Williamson wrote:
> Solarflare confirms that these devices do not allow peer-to-peer
> between functions.  Quirk them to allow IOMMU grouping to expose this
> isolation.
>
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> Cc: Robert Stonehouse <rstonehouse@solarflare.com>

Acked-by: Robert Stonehouse <rstonehouse@solarflare.com>



