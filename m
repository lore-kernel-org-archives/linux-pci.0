Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from nikam.ms.mff.cuni.cz ([195.113.20.16]:42584 "EHLO
	nikam.ms.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932712AbbLVPeT (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 22 Dec 2015 10:34:19 -0500
Date: Tue, 22 Dec 2015 16:26:02 +0100
From: Martin Mares <mj@ucw.cz>
To: David Daney <ddaney.cavm@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	"Sean O. Stalley" <sean.stalley@intel.com>,
	David Daney <david.daney@cavium.com>
Subject: Re: [PATCH v3] Add lspci support for Enhanced Allocation Capability.
Message-ID: <mj+md-20151222.152501.98524.nikam@ucw.cz>
References: <1450217759-22063-1-git-send-email-ddaney.cavm@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1450217759-22063-1-git-send-email-ddaney.cavm@gmail.com>
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

I will merge this soon.

Could you please provide a hex dump of a config space with this
capability? (See the test cases in pciutils/tests/.)

				Have a nice fortnight
-- 
Martin `MJ' Mares                          <mj@ucw.cz>   http://mj.ucw.cz/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
Q: How many Prolog programmers does it take to change a light bulb?  A: No.
