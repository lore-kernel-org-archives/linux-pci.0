Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from nikam.ms.mff.cuni.cz ([195.113.20.16]:43502 "EHLO
	nikam.ms.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751197AbcENKCl (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 14 May 2016 06:02:41 -0400
Received: from camelot.kam.mff.cuni.cz (camelot.kam.mff.cuni.cz [195.113.17.209])
	by nikam.ms.mff.cuni.cz (Postfix) with ESMTP id DD90B54546A
	for <linux-pci@vger.kernel.org>; Sat, 14 May 2016 12:02:36 +0200 (CEST)
Date: Sat, 14 May 2016 12:02:36 +0200
From: Martin Mares <mj@ucw.cz>
To: Keith Busch <keith.busch@intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCHv2] Add support for Downstream Port Containment
Message-ID: <mj+md-20160514.100230.61709.camelot@ucw.cz>
References: <1461710957-316-1-git-send-email-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1461710957-316-1-git-send-email-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello!

> The PCI SIG added the Downstream Port Containment capability. This patch
> decodes this for lspci, and defines the extended capability for setpci.

Thanks, applied.

				Have a nice fortnight
-- 
Martin `MJ' Mares                          <mj@ucw.cz>   http://mj.ucw.cz/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
Only dead fish swim with the stream.
