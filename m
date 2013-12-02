Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay0032.hostedemail.com ([216.40.44.32]:50911 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750938Ab3LBXwP (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 2 Dec 2013 18:52:15 -0500
Message-ID: <1386028330.15309.13.camel@joe-AO722>
Subject: Re: [PATCH 38/39] PCI: remove DEFINE_PCI_DEVICE_TABLE macro
From: Joe Perches <joe@perches.com>
To: Jingoo Han <jg1.han@samsung.com>
Cc: 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	'Bjorn Helgaas' <bhelgaas@google.com>,
	linux-pci@vger.kernel.org
Date: Mon, 02 Dec 2013 15:52:10 -0800
In-Reply-To: <003b01ceefb6$bca43ed0$35ecbc70$%han@samsung.com>
References: <001501ceefb1$69c96820$3d5c3860$%han@samsung.com>
	 <003b01ceefb6$bca43ed0$35ecbc70$%han@samsung.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 2013-12-03 at 08:32 +0900, Jingoo Han wrote:
> Don't use DEFINE_PCI_DEVICE_TABLE macro, because this macro
> is not preferred. Also, the definition of DEFINE_PCI_DEVICE_TABLE
> macro is removed.

These sorts of treewide conversions are almost never
applied wholesale.

This patch is not appropriate until there are no more
uses of DEFINE_PCI_DEVICE_TABLE in Linus' tree.

Just marking the function as deprecated in the
documentation and the pci.h file is probably good
enough for now.

see:  http://lkml.org/lkml/2013/12/2/400


