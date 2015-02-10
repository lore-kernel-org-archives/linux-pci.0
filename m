Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp09.au.ibm.com ([202.81.31.142]:55736 "EHLO
	e23smtp09.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756535AbbBJA1U (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 9 Feb 2015 19:27:20 -0500
Received: from /spool/local
	by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <benh@au1.ibm.com>;
	Tue, 10 Feb 2015 10:27:18 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
	by d23dlp01.au.ibm.com (Postfix) with ESMTP id A96902CE8052
	for <linux-pci@vger.kernel.org>; Tue, 10 Feb 2015 11:27:16 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t1A0R8wQ43253784
	for <linux-pci@vger.kernel.org>; Tue, 10 Feb 2015 11:27:16 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
	by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t1A0QggA024136
	for <linux-pci@vger.kernel.org>; Tue, 10 Feb 2015 11:26:43 +1100
Message-ID: <1423527979.4924.67.camel@au1.ibm.com>
Subject: Re: [PATCH V11 02/17] PCI/IOV: add VF enable/disable hook
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Cc: bhelgaas@google.com, gwshan@linux.vnet.ibm.com,
	linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Tue, 10 Feb 2015 11:26:19 +1100
In-Reply-To: <1421288887-7765-3-git-send-email-weiyang@linux.vnet.ibm.com>
References: <20150113180502.GC2776@google.com>
	 <1421288887-7765-1-git-send-email-weiyang@linux.vnet.ibm.com>
	 <1421288887-7765-3-git-send-email-weiyang@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 2015-01-15 at 10:27 +0800, Wei Yang wrote:
> +       if ((retval = pcibios_sriov_enable(dev, initial))) {
> +               dev_err(&dev->dev, "Failure %d from
> pcibios_sriov_setup()\n",
> +                       retval);
> +               return retval;
> +       }
> +

Don't we want pcibios_sriov_enable() to be able to crop the number
of VFs or do we think any resource limits have been applied
already ?

Ben.


