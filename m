Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:46231 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751061AbaDXXn3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 24 Apr 2014 19:43:29 -0400
From: "Rustad, Mark D" <mark.d.rustad@intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
CC: "Kirsher, Jeffrey T" <jeffrey.t.kirsher@intel.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Netdev <netdev@vger.kernel.org>
Subject: Re: [PATCH] pci: Use designated initialization in PCI_VDEVICE
Date: Thu, 24 Apr 2014 23:43:27 +0000
Message-ID: <8514B09D-4F10-4B14-940D-9237425C32BB@intel.com>
References: <1396303119-16766-1-git-send-email-jeffrey.t.kirsher@intel.com>
 <5339E746.4030503@cogentembedded.com> <20140424212246.GG29593@google.com>
 <512BF6D5-D529-4605-B1AB-A6DB7D153E14@intel.com>
In-Reply-To: <512BF6D5-D529-4605-B1AB-A6DB7D153E14@intel.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Apr 24, 2014, at 4:15 PM, Rustad, Mark D <mark.d.rustad@intel.com> wrote:

<snip>
> Adding the missing field in all of those places would also silence the message, but it seemed reasonable to have require that.

I meant "it seemed reasonable to *not* have to require that". Hopefully that helps it make some sense.

-- 
Mark Rustad, Networking Division, Intel Corporation

