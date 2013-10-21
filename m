Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37161 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752274Ab3JUN2X (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 21 Oct 2013 09:28:23 -0400
Message-ID: <52652BF1.4040507@ti.com>
Date: Mon, 21 Oct 2013 18:58:17 +0530
From: Kishon Vijay Abraham I <kishon@ti.com>
MIME-Version: 1.0
To: Jingoo Han <jg1.han@samsung.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: [QUERY] Number of address translation regions in designware
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

Currently I see in pcie-designware.c we use only 2 ATU regions. We re-use
INDEX0 for mem outbound and cfg0, and INDEX1 for cfg1 and io. So I'd like to
know if in your platform, do you have only 2 address translation regions? In
DRA7xx we have 16 outbound regions and 4 inbound regions.

Also the same designware IP can be used as a EP also no? Shouldn't we move it
out of drivers/pci/host and allow it to be configured as EP also?

Thanks
Kishon
