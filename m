Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:36996 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932451Ab3LDXgX (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 4 Dec 2013 18:36:23 -0500
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MXB00KO02WM2980@mailout1.samsung.com> for
 linux-pci@vger.kernel.org; Thu, 05 Dec 2013 08:36:22 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: 'Jason Cooper' <jason@lakedaemon.net>,
	'Andrew Lunn' <andrew@lunn.ch>
Cc: 'Thomas Petazzoni' <thomas.petazzoni@free-electrons.com>,
	'Bjorn Helgaas' <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	'Jason Gunthorpe' <jgunthorpe@obsidianresearch.com>,
	'Jingoo Han' <jg1.han@samsung.com>
References: <1386178241-10453-1-git-send-email-andrew@lunn.ch>
 <20131204202738.GO29282@titan.lakedaemon.net>
In-reply-to: <20131204202738.GO29282@titan.lakedaemon.net>
Subject: Re: [PATCH] PCI: MVEBU: Remove duplicate clock get
Date: Thu, 05 Dec 2013 08:36:21 +0900
Message-id: <004c01cef149$a39942c0$eacbc840$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday, December 05, 2013 5:28 AM, Jason Cooper wrote:
>On Wed, Dec 04, 2013 at 06:30:41PM +0100, Andrew Lunn wrote:
>> Probably due to a merge conflict resolution gone bad, the pci clock is
>> got twice. Remove the second redundent of_clk_get_by_name().
>>
>> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
>> ---
>>  drivers/pci/host/pci-mvebu.c | 8 --------
>>  1 file changed, 8 deletions(-)
>
> Acked-by: Jason Cooper <jason@lakedaemon.net>

(+cc Jason Gunthorpe)

Yes, right. :-)
Original patch did not include the redundent of_clk_get_by_name().

Reviewed-by: Jingoo Han <jg1.han@samsung.com>

Best regards,
Jingoo Han

