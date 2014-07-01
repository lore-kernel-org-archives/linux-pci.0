Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:51813 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755335AbaGARX1 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 1 Jul 2014 13:23:27 -0400
Date: Tue, 1 Jul 2014 11:27:46 +0900
From: Simon Horman <horms@verge.net.au>
To: Phil Edworthy <phil.edworthy@renesas.com>
Cc: linux-pci@vger.kernel.org, linux-sh@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v2 0/3] PCI: host: pcie-rcar: minor clean ups
Message-ID: <20140701022746.GA13917@verge.net.au>
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

Thanks Phil,

Acked-by: Simon Horman <horms+renesas@verge.net.au>

