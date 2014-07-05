Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f176.google.com ([209.85.213.176]:41928 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754286AbaGESED (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 5 Jul 2014 14:04:03 -0400
Received: by mail-ig0-f176.google.com with SMTP id c1so9559821igq.3
        for <linux-pci@vger.kernel.org>; Sat, 05 Jul 2014 11:04:02 -0700 (PDT)
Date: Sat, 5 Jul 2014 12:03:59 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Phil Edworthy <phil.edworthy@renesas.com>
Cc: linux-pci@vger.kernel.org, linux-sh@vger.kernel.org,
	Simon Horman <horms@verge.net.au>,
	Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v2 0/3] PCI: host: pcie-rcar: minor clean ups
Message-ID: <20140705180359.GA28871@google.com>
References: <1404114864-17330-1-git-send-email-phil.edworthy@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1404114864-17330-1-git-send-email-phil.edworthy@renesas.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jun 30, 2014 at 08:54:21AM +0100, Phil Edworthy wrote:
> Relatively minor clean up patches for the pcie-rcar driver. These
> are on top of Sergei's recent patch "pcie-rcar: kill duplicate checks".
> 
> Thanks to Sergei for point these out.
> 
> v2:
>  - break out replacing function arg with local var into separate patch
> 
> Phil Edworthy (3):
>   PCI: host: pcie-rcar: Use correct initial HW settings
>   PCI: host: pcie-rcar: Style and formatting changes.
>   PCI: host: pcie-rcar: Replace arg passed into a func with local var
> 
>  drivers/pci/host/pcie-rcar.c | 146 +++++++++++++++++++++----------------------
>  1 file changed, 71 insertions(+), 75 deletions(-)

Applied with Simon's acks to pci/host-rcar for v3.17 thanks!
