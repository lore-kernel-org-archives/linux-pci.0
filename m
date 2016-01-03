Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from nikam.ms.mff.cuni.cz ([195.113.20.16]:59709 "EHLO
	nikam.ms.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751037AbcACOOZ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 3 Jan 2016 09:14:25 -0500
Received: from camelot.kam.mff.cuni.cz (camelot.kam.mff.cuni.cz [195.113.17.209])
	by nikam.ms.mff.cuni.cz (Postfix) with ESMTP id 2C36F544102
	for <linux-pci@vger.kernel.org>; Sun,  3 Jan 2016 15:14:24 +0100 (CET)
Date: Sun, 3 Jan 2016 15:14:24 +0100
From: Martin Mares <mj@ucw.cz>
To: David Daney <ddaney.cavm@gmail.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	"Sean O. Stalley" <sean.stalley@intel.com>,
	David Daney <david.daney@cavium.com>
Subject: Re: [PATCH v4] Add lspci support for Enhanced Allocation Capability.
Message-ID: <mj+md-20160103.141410.57066.camelot@ucw.cz>
References: <1450830831-3965-1-git-send-email-ddaney.cavm@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1450830831-3965-1-git-send-email-ddaney.cavm@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi!

> From: David Daney <david.daney@cavium.com>
> 
> The PCISIG recently added the Enhanced Allocation Capability.  Decode
> it in lspci.
> ---
> The specification is currently located here:
> 
> https://pcisig.com/sites/default/files/specification_documents/ECN_Enhanced_Allocation_23_Oct_2014_Final.pdf
> 
> Bjorn Helgaas recently merged Linux kernel support for EA, and Cavium
> ThunderX processors have implemented it.  This patch gives us a pretty
> view of the capability structure.
> 
> Changes from v1: Add and use more symbolic names.  Use FLAG() macro
> where appropiate.  Read subordinate bus number from proper offset.
> 
> Changes from v2: Reword and reformat some messages.
> 
> Changes from v3: Add tests/cap-ea-1, rebased.

Thanks, applied.

				Have a nice fortnight
-- 
Martin `MJ' Mares                          <mj@ucw.cz>   http://mj.ucw.cz/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
Homo homini lupus, frater fratri lupior, bohemus bohemo lupissimus.
