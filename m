Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from jabberwock.ucw.cz ([46.255.230.98]:47480 "EHLO
	jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751968Ab3FKHuZ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 11 Jun 2013 03:50:25 -0400
Received: from albireo.burrow.ucw.cz (albireo.ucw.cz [89.239.2.32])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "albireo.ucw.cz", Issuer "ucw.cz" (verified OK))
	by jabberwock.ucw.cz (Postfix) with ESMTPS id 114D91C00AD
	for <linux-pci@vger.kernel.org>; Tue, 11 Jun 2013 09:50:24 +0200 (CEST)
Date: Tue, 11 Jun 2013 09:50:23 +0200
From: Martin Mares <mj@ucw.cz>
To: "David E. Box" <david.e.box@linux.intel.com>
Cc: kristen.c.accardi@intel.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3] lspci: Add L1 PM Substate capability reporting
Message-ID: <mj+md-20130611.075009.6973.albireo@ucw.cz>
References: <mj+md-20130610.130955.16386.albireo@ucw.cz>
 <1370912999-11261-1-git-send-email-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1370912999-11261-1-git-send-email-david.e.box@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello!

> From: David Box <david.e.box@linux.intel.com>
> 
> Expose available L1 substate capabilities that can enable lower power
> consumption when a PCIe Link is idle.

Thanks, applied.

				Martin
