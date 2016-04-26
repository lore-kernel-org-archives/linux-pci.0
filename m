Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from nikam.ms.mff.cuni.cz ([195.113.20.16]:38317 "EHLO
	nikam.ms.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752510AbcDZUyn (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 26 Apr 2016 16:54:43 -0400
Date: Tue, 26 Apr 2016 22:49:01 +0200
From: Martin Mares <mj@ucw.cz>
To: Keith Busch <keith.busch@intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] Add support for Downstream Port Containment
Message-ID: <mj+md-20160426.204835.23574.nikam@ucw.cz>
References: <1461703673-29363-1-git-send-email-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1461703673-29363-1-git-send-email-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi!

> The PCI SIG added the Downstream Port Containment capability. This patch
> decodes this for lspci and defines the extended capability for setpci.

Yes, that looks good.

Could you please add a test case to tests/ ?

				Have a nice fortnight
-- 
Martin `MJ' Mares                          <mj@ucw.cz>   http://mj.ucw.cz/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
int random(void) { return 4; /* Random number chosen by a fair dice roll. */ }
