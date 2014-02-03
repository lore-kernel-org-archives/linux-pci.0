Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e39.co.us.ibm.com ([32.97.110.160]:39504 "EHLO
	e39.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752816AbaBCPWy (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 3 Feb 2014 10:22:54 -0500
Received: from /spool/local
	by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <brking@linux.vnet.ibm.com>;
	Mon, 3 Feb 2014 08:22:54 -0700
Message-ID: <52EFB447.2080608@linux.vnet.ibm.com>
Date: Mon, 03 Feb 2014 09:22:47 -0600
From: Brian King <brking@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Alexander Gordeev <agordeev@redhat.com>
CC: linux-scsi@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wendy Xiong <wenxiong@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 2/2] ipr: Use pci_enable_msi_range() and pci_enable_msix_range()
References: <cover.1389904166.git.agordeev@redhat.com> <eb0b62be65c050533f2565fcf3f1d673770dfd67.1389904166.git.agordeev@redhat.com> <20140128095441.GA6951@dhcp-26-207.brq.redhat.com> <52E7CCAD.5070008@linux.vnet.ibm.com> <20140129132651.GA27764@dhcp-26-207.brq.redhat.com> <20140130140630.GA32349@dhcp-26-207.brq.redhat.com> <20140130141031.GC32349@dhcp-26-207.brq.redhat.com>
In-Reply-To: <20140130141031.GC32349@dhcp-26-207.brq.redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Acked-by: Brian King <brking@linux.vnet.ibm.com>

-- 
Brian King
Power Linux I/O
IBM Linux Technology Center


