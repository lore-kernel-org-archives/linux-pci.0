Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from nikam.ms.mff.cuni.cz ([195.113.20.16]:41451 "EHLO
	nikam.ms.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751977AbcENJYe (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 14 May 2016 05:24:34 -0400
Received: from camelot.kam.mff.cuni.cz (camelot.kam.mff.cuni.cz [195.113.17.209])
	by nikam.ms.mff.cuni.cz (Postfix) with ESMTP id 435B35452AD
	for <linux-pci@vger.kernel.org>; Sat, 14 May 2016 11:24:31 +0200 (CEST)
Date: Sat, 14 May 2016 11:24:31 +0200
From: Martin Mares <mj@ucw.cz>
To: "Yong, Jonathan" <jonathan.yong@intel.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com
Subject: Re: [PATCH] lspci: Decode Precision Time Measurement capabiltity
Message-ID: <mj+md-20160514.092404.57632.camelot@ucw.cz>
References: <1462850155-13790-1-git-send-email-jonathan.yong@intel.com>
 <1462850155-13790-2-git-send-email-jonathan.yong@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1462850155-13790-2-git-send-email-jonathan.yong@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello!

> Section 7.32 Precision Time Management (or Measurement) from the
> PCI Express Base 3.1 specification is an optional Extended Capability
> for discovering and controlling the distribution of a PTM Hierarchy.

Thanks, applied.

Could you please provide a test case, similar to those in tests/* ?

				Have a nice fortnight
-- 
Martin `MJ' Mares                          <mj@ucw.cz>   http://mj.ucw.cz/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
Weather forecast for tonight: dark.
