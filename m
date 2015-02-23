Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:62639 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751861AbbBWLXR (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 23 Feb 2015 06:23:17 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Phong Tran <tranmanphong@gmail.com>, tinamdar@apm.com,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: xgene: Fix the map_bus callback prototype
Date: Mon, 23 Feb 2015 12:23:03 +0100
Message-ID: <18992705.dPyaFqicRN@wuerfel>
In-Reply-To: <1424686899-7869-1-git-send-email-tranmanphong@gmail.com>
References: <1424686899-7869-1-git-send-email-tranmanphong@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Monday 23 February 2015 17:21:39 Phong Tran wrote:
> The return value should be void __iomem *.
> Tested by compile only.
> 
> Signed-off-by: Phong Tran <tranmanphong@gmail.com>
> 

Acked-by: Arnd Bergmann <arnd@arndb.de>

Thanks for the fix, I had noticed this in the build bot logs
but not yet reported on the list.

	Arnd
