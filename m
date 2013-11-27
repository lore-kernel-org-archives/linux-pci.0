Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:40858 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754595Ab3K0Vx7 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 27 Nov 2013 16:53:59 -0500
Date: Wed, 27 Nov 2013 21:53:09 +0000
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Khalid Aziz <khalid.aziz@oracle.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>, bhelgaas@google.com,
	cl91tp@gmail.com, tianyu.lan@intel.com, khlebnikov@openvz.org,
	gnomes@lxorguk.ukuu.org.uk, indou.takao@jp.fujitsu.com,
	jility09@gmail.com, f.otti@gmx.at, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] PCI: Clear Bus Master bit only on kexec reboot
Message-ID: <20131127215309.GA15320@srcf.ucam.org>
References: <1385579908-24608-1-git-send-email-khalid.aziz@oracle.com>
 <87ob55my8z.fsf@xmission.com>
 <52964F2C.1020803@oracle.com>
 <20131127212227.GA31237@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20131127212227.GA31237@kroah.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Nov 27, 2013 at 01:22:27PM -0800, Greg KH wrote:

> Then fix the drivers please.  It's not as if you don't have access to
> the source for them all...

Define "fix". It's clearly wrong to disable busmastering at shutdown on 
some devices, otherwise we wouldn't be having this discussion at all.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
