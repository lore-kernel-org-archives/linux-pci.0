Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e8.ny.us.ibm.com ([32.97.182.138]:48077 "EHLO e8.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752382AbaBCPWP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 3 Feb 2014 10:22:15 -0500
Received: from /spool/local
	by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <brking@linux.vnet.ibm.com>;
	Mon, 3 Feb 2014 10:22:14 -0500
Message-ID: <52EFB3D8.3080706@linux.vnet.ibm.com>
Date: Mon, 03 Feb 2014 09:20:56 -0600
From: Brian King <brking@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Alexander Gordeev <agordeev@redhat.com>
CC: linux-scsi@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wendy Xiong <wenxiong@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 1/2] ipr: Get rid of superfluous call to pci_disable_msi/msix()
References: <cover.1389904166.git.agordeev@redhat.com> <eb0b62be65c050533f2565fcf3f1d673770dfd67.1389904166.git.agordeev@redhat.com> <20140128095441.GA6951@dhcp-26-207.brq.redhat.com> <52E7CCAD.5070008@linux.vnet.ibm.com> <20140129132651.GA27764@dhcp-26-207.brq.redhat.com> <20140130140630.GA32349@dhcp-26-207.brq.redhat.com> <20140130140906.GB32349@dhcp-26-207.brq.redhat.com>
In-Reply-To: <20140130140906.GB32349@dhcp-26-207.brq.redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Acked-by: Brian King <brking@linux.vnet.ibm.com>


-- 
Brian King
Power Linux I/O
IBM Linux Technology Center


