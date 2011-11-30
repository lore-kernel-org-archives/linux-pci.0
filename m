Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:49205 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754651Ab1K3PkZ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 30 Nov 2011 10:40:25 -0500
Date: Wed, 30 Nov 2011 15:40:22 +0000
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Anand Kanaginhal <anand_dk@hotmail.com>
Cc: Linux PCI mailing <linux-pci@vger.kernel.org>,
	linux kernel mailing <linux-kernel@vger.kernel.org>,
	linux hotplug mailing <linux-hotplug@vger.kernel.org>
Subject: Re: PCIe Hotplugging not working
Message-ID: <20111130154022.GA1411@srcf.ucam.org>
References: <BAY163-W52E309F419E3588206D889FBB30@phx.gbl>
 <BAY163-W47DD39095DA3EB108AA3F2FBB30@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <BAY163-W47DD39095DA3EB108AA3F2FBB30@phx.gbl>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Make sure that you have CONFIG_HOTPLUG_PCI_ACPI=y and 
CONFIG_HOTPLUG_PCI_PCIE=y.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
