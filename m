Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:35896 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751939AbbFFBXD (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 5 Jun 2015 21:23:03 -0400
From: Marek Vasut <marex@denx.de>
To: Troy Kisky <troy.kisky@boundarydevices.com>
Subject: Re: [PATCH 1/1] pci-imx6: add speed change timeout message
Date: Sat, 6 Jun 2015 02:03:20 +0200
Cc: bhelgaas@google.com, festevam@gmail.com, linux-pci@vger.kernel.org,
	r65037@freescale.com, l.stach@pengutronix.de, tharvey@gateworks.com
References: <1433543864-7252-1-git-send-email-troy.kisky@boundarydevices.com>
In-Reply-To: <1433543864-7252-1-git-send-email-troy.kisky@boundarydevices.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201506060203.20854.marex@denx.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Saturday, June 06, 2015 at 12:37:44 AM, Troy Kisky wrote:
> Currently, the timeout is never detected as count
> has a value of -1 if a timeout happens, but the code is checking
> for 0. Also, this patch removes the unneeded final wait
> if a timeout occurs.
> 
> Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>

Acked-by: Marek Vasut <marex@denx.de>

Best regards,
Marek Vasut
