Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from 82-68-191-81.dsl.posilan.com ([82.68.191.81]:51293 "EHLO
	rainbowdash.ducie.codethink.co.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754695AbaA1KHD (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 28 Jan 2014 05:07:03 -0500
From: Ben Dooks <ben.dooks@codethink.co.uk>
To: linux-kernel@lists.codethink.co.uk
Cc: linux-sh@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Simon Horman <horms@verge.net.au>,
	Valentine Barshak <valentine.barshak@cogentembedded.com>,
	linux-pci@vger.kernel.org
Subject: PCI fixes for Renesas RCar 
Date: Tue, 28 Jan 2014 10:06:53 +0000
Message-Id: <1390903616-8073-1-git-send-email-ben.dooks@codethink.co.uk>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This is a small set of patches that fix a couple of issues with
the rcar-gen2 pci driver and add error interrupt support for
debugging.

Fixes from v1:
	- remove debugging code
	- fix patch title on bridge config accesses

