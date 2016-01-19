Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from xspv0103.northgrum.com ([134.223.120.78]:44992 "EHLO
	xspv0103.northgrum.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932533AbcASTgY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 19 Jan 2016 14:36:24 -0500
From: "Tang, Jason (ES)" <Jason.Tang2@ngc.com>
To: Bruno Santos <bsantos@ipfn.ist.utl.pt>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v0 00/13] PCI: Static Enumeration
Date: Tue, 19 Jan 2016 19:23:43 +0000
Message-ID: <a232674379bb4ae1aeeb3c40aa1972c3@XCGVAG27.northgrum.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> From: linux-pci-owner@vger.kernel.org [mailto:linux-pci-
> owner@vger.kernel.org] On Behalf Of Bruno Santos
> Sent: Tuesday, January 19, 2016 13:31
> To: linux-pci@vger.kernel.org
> Subject: Re: [PATCH v0 00/13] PCI: Static Enumeration
> 
> 
> 
> Hello Jason,
> Where I can get the source code and examples to test in RHEL 6.5?

The source code to my enumeration changes can be found in the mailing list archives. The original patches are at http://www.spinics.net/lists/linux-pci/msg41689.html, the second (hotplug-based) version is at http://www.spinics.net/lists/linux-pci/msg44721.html.

You will need to recompile your kernel with the patches applied. However, RHEL 6.5 is based upon the 2.6.32 kernel, and my work is based upon 4.0+ kernels. It is unlikely that my changes will work on such an old kernel version.

