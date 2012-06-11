Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:43841 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751110Ab2FKTkN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 11 Jun 2012 15:40:13 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glp-linux-pci@m.gmane.org>)
	id 1SeATB-0008F9-AC
	for linux-pci@vger.kernel.org; Mon, 11 Jun 2012 21:40:09 +0200
Received: from dsl001-168-162.bos1.dsl.speakeasy.net ([72.1.168.162])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-pci@vger.kernel.org>; Mon, 11 Jun 2012 21:40:09 +0200
Received: from tkcarr03873 by dsl001-168-162.bos1.dsl.speakeasy.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-pci@vger.kernel.org>; Mon, 11 Jun 2012 21:40:09 +0200
To: linux-pci@vger.kernel.org
From: Tom Carr <tkcarr03873@gmail.com>
Subject: Re: PCIe rescan not working
Date: Mon, 11 Jun 2012 19:37:29 +0000 (UTC)
Message-ID: <loom.20120611T213534-574@post.gmane.org>
References: <loom.20120607T194858-986@post.gmane.org> <CAE9FiQWau+ko4JiEEjM=2xSH_7FPBr_ZYOm8YGpin2p97=12PQ@mail.gmail.com> <loom.20120611T205954-871@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

 Sorry, I said /sys/bus/pci/remove. I meant to say 
/sys/bus/pci/devices/0000:00:01.2/remove



