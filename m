Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from nikam.ms.mff.cuni.cz ([195.113.20.16]:50399 "EHLO
	nikam.ms.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753539Ab2LEUpw (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 5 Dec 2012 15:45:52 -0500
Date: Wed, 5 Dec 2012 21:36:03 +0100
From: Martin Mares <mj@ucw.cz>
To: "Dr. David Alan Gilbert" <dave@treblig.org>
Cc: linux-pci@vger.kernel.org
Subject: Re: pciutils pci_open seg with invalid arg to -i
Message-ID: <mj+md-20121205.203547.16418.nikam@ucw.cz>
References: <20121204142008.GB6117@gallifrey>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20121204142008.GB6117@gallifrey>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello!

> The reporter had called lspci -vvii    which ends up trying to open the
> file 'i' as the pci-id and seg faults.

The function looks wrong, I will fix it soon.

				Have a nice fortnight
-- 
Martin `MJ' Mares                          <mj@ucw.cz>   http://mj.ucw.cz/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
Hi! I'm a .signature virus! Copy me into your ~/.signature to help me spread!
