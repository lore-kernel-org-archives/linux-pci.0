Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:50763 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754622Ab3K0Tin (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 27 Nov 2013 14:38:43 -0500
Date: Wed, 27 Nov 2013 11:39:32 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Khalid Aziz <khalid.aziz@oracle.com>
Cc: bhelgaas@google.com, cl91tp@gmail.com, tianyu.lan@intel.com,
	khlebnikov@openvz.org, gnomes@lxorguk.ukuu.org.uk,
	indou.takao@jp.fujitsu.com, jility09@gmail.com, f.otti@gmx.at,
	ebiederm@xmission.com, mjg59@srcf.ucam.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org, stable@vger.kernel.org
Subject: Re: [PATCH] PCI: Clear Bus Master bit only on kexec reboot
Message-ID: <20131127193932.GA16431@kroah.com>
References: <1385579908-24608-1-git-send-email-khalid.aziz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1385579908-24608-1-git-send-email-khalid.aziz@oracle.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Nov 27, 2013 at 12:18:28PM -0700, Khalid Aziz wrote:
> +/* flag to track if kexec reboot is in progress */
> +extern unsigned long kexec_in_progress;

"unsigned long" for a "flag"?

