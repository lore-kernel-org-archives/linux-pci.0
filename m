Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yh0-f41.google.com ([209.85.213.41]:52092 "EHLO
	mail-yh0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752823AbaBSMw7 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 19 Feb 2014 07:52:59 -0500
Received: by mail-yh0-f41.google.com with SMTP id f73so321987yha.0
        for <linux-pci@vger.kernel.org>; Wed, 19 Feb 2014 04:52:58 -0800 (PST)
MIME-Version: 1.0
Date: Wed, 19 Feb 2014 18:22:58 +0530
Message-ID: <CAD6G_RRUjWLYkzR_=EFwO_tx1aJOqqn-jqixhj4tnnqpamv92g@mail.gmail.com>
Subject: pci_reset_bus() usage in rc drivers
From: Jagan Teki <jagannadh.teki@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

One of the functionality of pci_reset_bus could reset the secondary bus
as described in the configuration space - pci_reset_bridge_secondary_bus()

Does this reset require in the part of enumeration, what is usage of
this in root complex
driver perspective.

Any help!

thanks!
-- 
Jagan.
