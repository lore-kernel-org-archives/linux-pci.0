Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:35129 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752118AbbKPICH (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 16 Nov 2015 03:02:07 -0500
Received: by pacej9 with SMTP id ej9so60746550pac.2
        for <linux-pci@vger.kernel.org>; Mon, 16 Nov 2015 00:02:05 -0800 (PST)
Subject: Re: [PATCH v7 12/50] powerpc/powernv: Track M64 segment consumption
To: Gavin Shan <gwshan@linux.vnet.ibm.com>,
	linuxppc-dev@lists.ozlabs.org
References: <1446642770-4681-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1446642770-4681-13-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	benh@kernel.crashing.org, mpe@ellerman.id.au, bhelgaas@google.com,
	grant.likely@linaro.org, robherring2@gmail.com,
	panto@antoniou-consulting.com, frowand.list@gmail.com
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <56498D77.2060101@ozlabs.ru>
Date: Mon, 16 Nov 2015 19:01:59 +1100
MIME-Version: 1.0
In-Reply-To: <1446642770-4681-13-git-send-email-gwshan@linux.vnet.ibm.com>
Content-Type: text/plain; charset=koi8-r; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 11/05/2015 12:12 AM, Gavin Shan wrote:
> As we track M32 segment consumption, this introduces an array to
> the PHB to track the mapping between M64 segment and PE number.
> The information is going to be used to find M64 segment from the
> PE number during PCI unplugging time in subsequent patches.


It would not hurt to put a few words about how we managed to live without 
such a mapping for M64 before but we needed mapping for M32.




-- 
Alexey
