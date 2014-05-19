Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from astoria.ccjclearline.com ([64.235.106.9]:44675 "EHLO
	astoria.ccjclearline.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752868AbaESHtZ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 19 May 2014 03:49:25 -0400
Received: from [99.240.204.5] (port=58016 helo=crashcourse.ca)
	by astoria.ccjclearline.com with esmtpsa (TLSv1:DHE-RSA-AES256-SHA:256)
	(Exim 4.80)
	(envelope-from <rpjday@crashcourse.ca>)
	id 1WmIK8-0004qv-Jm
	for linux-pci@vger.kernel.org; Mon, 19 May 2014 03:49:28 -0400
Date: Mon, 19 May 2014 03:47:03 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
To: Linux PCI mailing list <linux-pci@vger.kernel.org>
Subject: "help" info for CONFIG_PCIEAER_INJECT seems to have broken link
Message-ID: <alpine.LFD.2.11.1405190344460.1943@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


  "make *config" help info refers to the URL

http://www.kernel.org/pub/linux/utils/pci/aer-inject/

but there's nothing there. this *seems* to be the correct link:

https://www.kernel.org/pub/scm/linux/kernel/git/gong.chen/

but i'll leave it to someone else to resolve that.

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
