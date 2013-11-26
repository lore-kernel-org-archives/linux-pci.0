Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:6064 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751193Ab3KZFvU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 26 Nov 2013 00:51:20 -0500
Message-ID: <52943422.1090402@intel.com>
Date: Tue, 26 Nov 2013 13:39:46 +0800
From: Lan Tianyu <tianyu.lan@intel.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Chang Liu <cl91tp@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Khalid Aziz <khalid.aziz@oracle.com>,
	Konstantin Khlebnikov <khlebnikov@openvz.org>,
	Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
	Takao Indoh <indou.takao@jp.fujitsu.com>,
	Jility <jility09@gmail.com>, Florian Otti <f.otti@gmx.at>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI: add a quirk for keeping Bus Master bit on shutdown
References: <1384285203-642-1-git-send-email-cl91tp@gmail.com> <CAErSpo5E4584zgTt4ySPSEFhtwdHDOyrrowirp=SmtmJjDyHgg@mail.gmail.com>
In-Reply-To: <CAErSpo5E4584zgTt4ySPSEFhtwdHDOyrrowirp=SmtmJjDyHgg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2013年11月26日 11:33, Bjorn Helgaas wrote:
> Lan, do you have access to any Lynx Point boxes?  Can you test and see
> whether they hang on power-off also?  I suspect this might be something
> specific to the Acer box, not a generic Lynx Point issue.

Sure. I just get one such prototype laptop and power off works normally
on it.

-- 
Best regards
Tianyu Lan
