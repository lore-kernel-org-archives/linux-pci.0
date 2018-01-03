Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from nikam.ms.mff.cuni.cz ([195.113.20.16]:46176 "EHLO
        nikam.ms.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750928AbeACXNi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 Jan 2018 18:13:38 -0500
Date: Thu, 4 Jan 2018 00:04:42 +0100
From: Martin Mares <mj@ucw.cz>
To: Veerasenareddy Burru <vburru@caviumnetworks.com>
Cc: linux-pci@vger.kernel.org, satananda.burla@cavium.com,
        mpanicker@caviumnetworks.com
Subject: Re: [PATCH] pciutils: Extend pci_generic_scan() to scan all 256
 buses.
Message-ID: <mj+md-20180103.230249.89710.nikam@ucw.cz>
References: <1515018604-13008-1-git-send-email-vburru@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1515018604-13008-1-git-send-email-vburru@caviumnetworks.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello!

> Currently, pci_generic_scan() scans only bus 0 and its subordinate buses.

This is intentional. Some machines decode bus numbers only partially,
so scanning all buses leads to many "ghost devices" found. I am not sure
if such devices are still around, though.

Feel free to add a switch for that.

				Have a nice fortnight
-- 
Martin `MJ' Mares                          <mj@ucw.cz>   http://mj.ucw.cz/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
How an engineer writes a program: Start by debugging an empty file...
