Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from jabberwock.ucw.cz ([46.255.230.98]:44295 "EHLO
	jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751212AbaKAQZa (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 1 Nov 2014 12:25:30 -0400
Received: from albireo.burrow.ucw.cz (albireo.ucw.cz [89.239.2.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "albireo.ucw.cz", Issuer "ucw.cz" (verified OK))
	by jabberwock.ucw.cz (Postfix) with ESMTPS id 695AD1C0146
	for <linux-pci@vger.kernel.org>; Sat,  1 Nov 2014 17:25:29 +0100 (CET)
Date: Sat, 1 Nov 2014 17:25:28 +0100
From: Martin Mares <mj@ucw.cz>
To: Matthew Wilcox <willy@linux.intel.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH] lspci: Add ability to filter by class code
Message-ID: <mj+md-20141101.161931.20316.albireo@ucw.cz>
References: <1412099436-18899-1-git-send-email-matthew.r.wilcox@intel.com>
 <20140930180252.GD5098@wil.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20140930180252.GD5098@wil.cx>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello!

> From: Matthew Wilcox <matthew.r.wilcox@intel.com>
> Date: Tue, 30 Sep 2014 13:41:07 -0400
> Subject: [PATCH] lspci: Add ability to filter by class code
> 
> Extend the 'filter by device ID' functionality to allow optional
> specification of a device ID.  For example, to list all USB controllers
> in the system made by Intel, specify:
> 
> lspci -d 8086::0c03

I like the idea, but I see a couple of issues with the actual
implementation:

  •  I wonder if it could be useful to filter by prog-if in addition
     to the class, or only on the class without its sub-class?

  •  Extending struct pci_filter breaks ABI (my fault in designing
     the API years ago -- it would have been much better if the struct
     were allocated by the library instead of the caller). Could you
     please add symbol versioning for pci_filter_(init|match|parse_id)?

				Have a nice fortnight
-- 
Martin `MJ' Mares                          <mj@ucw.cz>   http://mj.ucw.cz/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
Q: Who invented the first airplane that did not fly?  A: The Wrong Brothers.
