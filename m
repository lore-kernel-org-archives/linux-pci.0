Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-db3lp0079.outbound.protection.outlook.com ([213.199.154.79]:38729
	"EHLO emea01-db3-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751656AbaGHPx6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 8 Jul 2014 11:53:58 -0400
From: Igor Bezukh <Igor@galilsoft.com>
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: A question about PCI suspend-resume functionallity
Date: Tue, 8 Jul 2014 15:39:25 +0000
Message-ID: <1404833913010.27399@galilsoft.com>
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,


We are testing Intel Gigabit adapter driver (igb) under Fedora 20, kernel 3.14.4 for the following use-case:

(*) Adapter is connected to the PCIE slot
(*) We put the system under suspend by running pm-suspend from user-space
(*) Remove the adapter from the PCIE slot
(*) Wake up the system

Currenlty, we got kernel panics and the system got stuck.

My question is - does the PCI subsystem logic calls the driver remove function when driver resume function returns with error code?

Or should I implement the call to igb_remove from igb_resume in the Intel driver?

Thanks,
Igor Bezukh
