Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from stargate.chelsio.com ([67.207.112.58]:14779 "EHLO
	stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752932AbbCFFYR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 6 Mar 2015 00:24:17 -0500
From: Hariprasad S <hariprasad@chelsio.com>
To: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: PCIE link reset in older kernels < 2.6.33
Date: Fri, 6 Mar 2015 05:24:12 +0000
Message-ID: <26E3F92EC670BD429DB5CB319D773C13C9E62D@nice.asicdesigners.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Alex,

I am a newbie to PCIE driver. 
How can we achieve PCIE link reset in older kernels?

I do see that in newer kernels we can achieve it by pci_try_reset_slot(). Is there a similar API available for older kernels.

Thanks,
Hariprasad
