Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-db3on0099.outbound.protection.outlook.com ([157.55.234.99]:16243
	"EHLO emea01-db3-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752460AbbAZS4e (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 26 Jan 2015 13:56:34 -0500
Message-ID: <54C685C3.6030207@ezchip.com>
Date: Mon, 26 Jan 2015 13:21:55 -0500
From: Chris Metcalf <cmetcalf@ezchip.com>
MIME-Version: 1.0
To: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	<linux-pci@vger.kernel.org>
Subject: Re: [PATCH 3/5] tile: use PCI define for max read request size
References: <1422291922-12324-1-git-send-email-zajec5@gmail.com> <1422291972-12412-1-git-send-email-zajec5@gmail.com>
In-Reply-To: <1422291972-12412-1-git-send-email-zajec5@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 1/26/2015 12:06 PM, Rafał Miłecki wrote:
> Signed-off-by: Rafał Miłecki <zajec5@gmail.com>
> ---
>   arch/tile/kernel/pci.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Acked-by: Chris Metcalf <cmetcalf@ezchip.com>

-- 
Chris Metcalf, EZChip Semiconductor
http://www.ezchip.com

